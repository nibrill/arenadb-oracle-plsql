-- =========================================
-- 07_triggers.sql
-- ARENADB - TRIGGERS (reglas de negocio que un CHECK no puede expresar)
-- =========================================

-- 1) Valida el ganador de una partida y deja auditoría de los cambios
CREATE OR REPLACE TRIGGER trg_partidas_validar
BEFORE INSERT OR UPDATE ON partidas
FOR EACH ROW
BEGIN
    -- El ganador debe ser uno de los dos equipos de la partida
    IF :NEW.ganador_equipo_id IS NOT NULL
       AND :NEW.ganador_equipo_id NOT IN (:NEW.equipo_local_id, :NEW.equipo_visitante_id) THEN
        RAISE_APPLICATION_ERROR(-20010,
            'El ganador (equipo ' || :NEW.ganador_equipo_id || ') no participa en la partida');
    END IF;

    -- Una partida que no se ha jugado no puede tener ganador
    IF :NEW.estado <> 'JUGADA' AND :NEW.ganador_equipo_id IS NOT NULL THEN
        RAISE_APPLICATION_ERROR(-20011,
            'Solo una partida JUGADA puede tener ganador (estado actual: ' || :NEW.estado || ')');
    END IF;
END trg_partidas_validar;
/

CREATE OR REPLACE TRIGGER trg_partidas_auditoria
AFTER UPDATE OF estado, ganador_equipo_id ON partidas
FOR EACH ROW
BEGIN
    INSERT INTO auditoria_partidas (partida_id, estado_anterior, estado_nuevo, ganador_anterior, ganador_nuevo)
    VALUES (:OLD.partida_id, :OLD.estado, :NEW.estado, :OLD.ganador_equipo_id, :NEW.ganador_equipo_id);
END trg_partidas_auditoria;
/

-- 2) Un torneo FINALIZADO o CANCELADO ya no puede reabrirse
CREATE OR REPLACE TRIGGER trg_torneos_estado
BEFORE UPDATE OF estado ON torneos
FOR EACH ROW
BEGIN
    IF :OLD.estado IN ('FINALIZADO', 'CANCELADO') AND :NEW.estado <> :OLD.estado THEN
        RAISE_APPLICATION_ERROR(-20012,
            'El torneo "' || :OLD.nombre_torneo || '" está ' || :OLD.estado || ' y no puede cambiar de estado');
    END IF;
END trg_torneos_estado;
/

-- 3) Si un integrante pasa a RETIRADO y no trae fecha de salida, se completa sola
CREATE OR REPLACE TRIGGER trg_je_fecha_salida
BEFORE INSERT OR UPDATE ON jugadores_equipos
FOR EACH ROW
BEGIN
    -- Si el jugador se retira, se registra la fecha de salida automáticamente
    IF :NEW.estado = 'RETIRADO' AND :NEW.fecha_salida IS NULL THEN
        :NEW.fecha_salida := TRUNC(SYSDATE);
    END IF;
END trg_je_fecha_salida;
/
