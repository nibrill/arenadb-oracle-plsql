-- =========================================
-- 00_drop.sql
-- ARENADB - LIMPIEZA (re-ejecutable)
-- Elimina todos los objetos del proyecto para poder
-- reinstalar desde cero. Si es la primera vez, no pasa nada:
-- los objetos que no existen simplemente se ignoran.
-- =========================================

BEGIN
    -- Paquete, vistas y rutinas
    FOR o IN (
        SELECT object_name, object_type
        FROM user_objects
        WHERE (object_type = 'PACKAGE'   AND object_name = 'PKG_TORNEO')
           OR (object_type = 'VIEW'      AND object_name IN ('VW_TABLA_POSICIONES', 'VW_RANKING_EQUIPOS', 'VW_RESUMEN_TORNEOS'))
           OR (object_type = 'FUNCTION'  AND object_name IN ('FN_TOTAL_VICTORIAS_EQUIPO', 'FN_TOTAL_PUNTOS_EQUIPO', 'FN_CATEGORIA_PREMIO'))
           OR (object_type = 'PROCEDURE' AND object_name IN ('SP_ACTUALIZAR_ESTADO_TORNEO', 'SP_ACTUALIZAR_ESTADO_PARTIDA',
                                                             'SP_REGISTRAR_GANADOR_PARTIDA', 'SP_RANKING_EQUIPOS'))
    ) LOOP
        EXECUTE IMMEDIATE 'DROP ' || o.object_type || ' ' || o.object_name;
    END LOOP;

    -- Tablas (los triggers asociados se eliminan con ellas)
    FOR t IN (
        SELECT table_name
        FROM user_tables
        WHERE table_name IN ('PUNTAJES', 'PARTIDAS', 'JUGADORES_EQUIPOS',
                             'TORNEOS', 'EQUIPOS', 'JUGADORES', 'AUDITORIA_PARTIDAS')
    ) LOOP
        EXECUTE IMMEDIATE 'DROP TABLE ' || t.table_name || ' CASCADE CONSTRAINTS PURGE';
    END LOOP;
END;
/
