CREATE TABLE jugadores (
    jugador_id NUMBER GENERATED ALWAYS AS IDENTITY,
    nickname VARCHAR2(50) NOT NULL,
    nombre_real VARCHAR2(60) NOT NULL,
    apellido_real VARCHAR2(60),
    correo VARCHAR2(100) NOT NULL,
    pais VARCHAR2(50) NOT NULL,
    fecha_nacimiento DATE,
    genero VARCHAR2(20),
    fecha_registro DATE DEFAULT SYSDATE NOT NULL,
    estado VARCHAR2(20) DEFAULT 'ACTIVO' NOT NULL,
    CONSTRAINT tg_pk_jugadores PRIMARY KEY (jugador_id),
    CONSTRAINT tg_uq_jugadores_nickname UNIQUE (nickname),
    CONSTRAINT tg_uq_jugadores_correo UNIQUE (correo),
    CONSTRAINT tg_ck_jugadores_genero CHECK (genero IN ('MASCULINO', 'FEMENINO', 'OTRO')),
    CONSTRAINT tg_ck_jugadores_estado CHECK (estado IN ('ACTIVO', 'INACTIVO', 'SUSPENDIDO'))
);

CREATE TABLE equipos (
    equipo_id NUMBER GENERATED ALWAYS AS IDENTITY,
    nombre_equipo VARCHAR2(100) NOT NULL,
    tag_equipo VARCHAR2(10) NOT NULL,
    fecha_creacion DATE DEFAULT SYSDATE NOT NULL,
    capitan_jugador_id NUMBER,
    region VARCHAR2(50),
    estado VARCHAR2(20) DEFAULT 'ACTIVO' NOT NULL,
    ranking_global NUMBER DEFAULT 0 NOT NULL,
    CONSTRAINT tg_pk_equipos PRIMARY KEY (equipo_id),
    CONSTRAINT tg_uq_equipos_nombre UNIQUE (nombre_equipo),
    CONSTRAINT tg_uq_equipos_tag UNIQUE (tag_equipo),
    CONSTRAINT tg_ck_equipos_estado CHECK (estado IN ('ACTIVO', 'INACTIVO', 'DISUELTO')),
    CONSTRAINT tg_ck_equipos_ranking CHECK (ranking_global >= 0)
);

CREATE TABLE torneos (
    torneo_id NUMBER GENERATED ALWAYS AS IDENTITY,
    nombre_torneo VARCHAR2(120) NOT NULL,
    juego VARCHAR2(80) NOT NULL,
    plataforma VARCHAR2(40) NOT NULL,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE,
    premio_total NUMBER(12,2) DEFAULT 0 NOT NULL,
    modalidad VARCHAR2(30) NOT NULL,
    cantidad_equipos NUMBER NOT NULL,
    estado VARCHAR2(20) DEFAULT 'PENDIENTE' NOT NULL,
    CONSTRAINT tg_pk_torneos PRIMARY KEY (torneo_id),
    CONSTRAINT tg_uq_torneos_nombre UNIQUE (nombre_torneo),
    CONSTRAINT tg_ck_torneos_premio CHECK (premio_total >= 0),
    CONSTRAINT tg_ck_torneos_cantidad CHECK (cantidad_equipos > 1),
    CONSTRAINT tg_ck_torneos_modalidad CHECK (modalidad IN ('SOLO', 'DUO', 'SQUAD', '5V5')),
    CONSTRAINT tg_ck_torneos_estado CHECK (estado IN ('PENDIENTE', 'EN_CURSO', 'FINALIZADO', 'CANCELADO')),
    CONSTRAINT tg_ck_torneos_fechas CHECK (fecha_fin IS NULL OR fecha_fin >= fecha_inicio)
);

CREATE TABLE jugadores_equipos (
    jugador_equipo_id NUMBER GENERATED ALWAYS AS IDENTITY,
    jugador_id NUMBER NOT NULL,
    equipo_id NUMBER NOT NULL,
    rol VARCHAR2(30) DEFAULT 'JUGADOR' NOT NULL,
    fecha_union DATE DEFAULT SYSDATE NOT NULL,
    fecha_salida DATE,
    estado VARCHAR2(20) DEFAULT 'ACTIVO' NOT NULL,
    CONSTRAINT tg_pk_jugadores_equipos PRIMARY KEY (jugador_equipo_id),
    CONSTRAINT tg_fk_je_jugador FOREIGN KEY (jugador_id)
        REFERENCES jugadores(jugador_id),
    CONSTRAINT tg_fk_je_equipo FOREIGN KEY (equipo_id)
        REFERENCES equipos(equipo_id),
    CONSTRAINT tg_uq_jugador_equipo UNIQUE (jugador_id, equipo_id),
    CONSTRAINT tg_ck_je_rol CHECK (rol IN ('CAPITAN', 'JUGADOR', 'SUPLENTE', 'COACH')),
    CONSTRAINT tg_ck_je_estado CHECK (estado IN ('ACTIVO', 'INACTIVO', 'RETIRADO')),
    CONSTRAINT tg_ck_je_fechas CHECK (fecha_salida IS NULL OR fecha_salida >= fecha_union)
);

CREATE TABLE partidas (
    partida_id NUMBER GENERATED ALWAYS AS IDENTITY,
    torneo_id NUMBER NOT NULL,
    equipo_local_id NUMBER NOT NULL,
    equipo_visitante_id NUMBER NOT NULL,
    fecha_partida DATE NOT NULL,
    ronda VARCHAR2(50) NOT NULL,
    mapa VARCHAR2(50),
    estado VARCHAR2(20) DEFAULT 'PROGRAMADA' NOT NULL,
    ganador_equipo_id NUMBER,
    observaciones VARCHAR2(300),
    CONSTRAINT tg_pk_partidas PRIMARY KEY (partida_id),
    CONSTRAINT tg_fk_partidas_torneo FOREIGN KEY (torneo_id)
        REFERENCES torneos(torneo_id),
    CONSTRAINT tg_fk_partidas_local FOREIGN KEY (equipo_local_id)
        REFERENCES equipos(equipo_id),
    CONSTRAINT tg_fk_partidas_visitante FOREIGN KEY (equipo_visitante_id)
        REFERENCES equipos(equipo_id),
    CONSTRAINT tg_fk_partidas_ganador FOREIGN KEY (ganador_equipo_id)
        REFERENCES equipos(equipo_id),
    CONSTRAINT tg_ck_partidas_estado CHECK (estado IN ('PROGRAMADA', 'JUGADA', 'CANCELADA')),
    CONSTRAINT tg_ck_partidas_equipos CHECK (equipo_local_id <> equipo_visitante_id),
    CONSTRAINT tg_ck_partidas_ronda CHECK (ronda IN ('GRUPOS', 'OCTAVOS', 'CUARTOS', 'SEMIFINAL', 'FINAL'))
);

CREATE TABLE puntajes (
    puntaje_id NUMBER GENERATED ALWAYS AS IDENTITY,
    partida_id NUMBER NOT NULL,
    equipo_id NUMBER NOT NULL,
    puntos_obtenidos NUMBER DEFAULT 0 NOT NULL,
    kills NUMBER DEFAULT 0 NOT NULL,
    deaths NUMBER DEFAULT 0 NOT NULL,
    asistencias NUMBER DEFAULT 0 NOT NULL,
    resultado VARCHAR2(20) NOT NULL,
    CONSTRAINT tg_pk_puntajes PRIMARY KEY (puntaje_id),
    CONSTRAINT tg_fk_puntajes_partida FOREIGN KEY (partida_id)
        REFERENCES partidas(partida_id),
    CONSTRAINT tg_fk_puntajes_equipo FOREIGN KEY (equipo_id)
        REFERENCES equipos(equipo_id),
    CONSTRAINT tg_uq_puntaje UNIQUE (partida_id, equipo_id),
    CONSTRAINT tg_ck_puntajes_valores CHECK (
        puntos_obtenidos >= 0 AND
        kills >= 0 AND
        deaths >= 0 AND
        asistencias >= 0
    ),
    CONSTRAINT tg_ck_puntajes_resultado CHECK (resultado IN ('GANADOR', 'PERDEDOR', 'EMPATE'))
);

ALTER TABLE equipos
ADD CONSTRAINT tg_fk_equipos_capitan
FOREIGN KEY (capitan_jugador_id)
REFERENCES jugadores(jugador_id);

-- =========================================
-- TABLA DE AUDITORIA (la llena el trigger de partidas)
-- =========================================
CREATE TABLE auditoria_partidas (
    auditoria_id NUMBER GENERATED ALWAYS AS IDENTITY,
    partida_id NUMBER NOT NULL,
    estado_anterior VARCHAR2(20),
    estado_nuevo VARCHAR2(20),
    ganador_anterior NUMBER,
    ganador_nuevo NUMBER,
    usuario VARCHAR2(60) DEFAULT USER NOT NULL,
    fecha_cambio TIMESTAMP DEFAULT SYSTIMESTAMP NOT NULL,
    CONSTRAINT tg_pk_auditoria_partidas PRIMARY KEY (auditoria_id)
);

-- =========================================
-- INDICES sobre claves foráneas
-- (Oracle no los crea automáticamente; aceleran JOINs y evitan
--  bloqueos al borrar/actualizar filas padre)
-- =========================================
CREATE INDEX tg_ix_equipos_capitan   ON equipos(capitan_jugador_id);
CREATE INDEX tg_ix_je_equipo         ON jugadores_equipos(equipo_id);
CREATE INDEX tg_ix_partidas_torneo   ON partidas(torneo_id);
CREATE INDEX tg_ix_partidas_local    ON partidas(equipo_local_id);
CREATE INDEX tg_ix_partidas_visit    ON partidas(equipo_visitante_id);
CREATE INDEX tg_ix_partidas_ganador  ON partidas(ganador_equipo_id);
CREATE INDEX tg_ix_partidas_estado   ON partidas(estado);
CREATE INDEX tg_ix_puntajes_equipo   ON puntajes(equipo_id);

-- =========================================
-- COMENTARIOS (documentación dentro de la propia BD)
-- =========================================
COMMENT ON TABLE jugadores         IS 'Jugadores registrados en la plataforma';
COMMENT ON TABLE equipos           IS 'Equipos competitivos; ranking_global es un puntaje tipo ELO';
COMMENT ON TABLE torneos           IS 'Torneos de videojuegos con premio, modalidad y estado';
COMMENT ON TABLE jugadores_equipos IS 'Relación N:M entre jugadores y equipos (con rol)';
COMMENT ON TABLE partidas          IS 'Enfrentamientos entre dos equipos dentro de un torneo';
COMMENT ON TABLE puntajes          IS 'Estadísticas de cada equipo en cada partida (2 filas por partida jugada)';
COMMENT ON TABLE auditoria_partidas IS 'Historial de cambios de estado/ganador en partidas';
