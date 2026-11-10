-- =========================================
-- 06_package.sql
-- ARENADB - PAQUETE pkg_torneo
--
-- Agrupa la lógica de negocio del torneo:
--   * registrar_resultado : cierra una partida (con SAVEPOINT/ROLLBACK)
--   * tabla_posiciones    : REF CURSOR con la tabla de un torneo
--   * imprimir_posiciones : BULK COLLECT + DBMS_OUTPUT
--   * cerrar_torneo       : finaliza un torneo si no quedan partidas pendientes
-- =========================================

SET SERVEROUTPUT ON;

CREATE OR REPLACE PACKAGE pkg_torneo AS

    -- Constantes de negocio (un solo lugar para ajustar el sistema de ranking)
    c_puntos_ranking_victoria CONSTANT NUMBER := 25;
    c_puntos_ranking_derrota  CONSTANT NUMBER := 15;

    -- Excepciones propias
    e_partida_inexistente EXCEPTION;
    e_partida_no_programada EXCEPTION;
    e_torneo_inexistente EXCEPTION;
    e_partidas_pendientes EXCEPTION;
    PRAGMA EXCEPTION_INIT(e_partida_inexistente,   -20101);
    PRAGMA EXCEPTION_INIT(e_partida_no_programada, -20102);
    PRAGMA EXCEPTION_INIT(e_torneo_inexistente,    -20103);
    PRAGMA EXCEPTION_INIT(e_partidas_pendientes,   -20104);

    -- Estadísticas de un equipo en una partida
    TYPE t_stats IS RECORD (
        puntos      puntajes.puntos_obtenidos%TYPE,
        kills       puntajes.kills%TYPE,
        deaths      puntajes.deaths%TYPE,
        asistencias puntajes.asistencias%TYPE
    );

    /** Registra el resultado completo de una partida:
        inserta los 2 puntajes, fija ganador/estado y mueve el ranking global.
        Es atómico: si algo falla, no queda nada a medias. */
    PROCEDURE registrar_resultado (
        p_partida_id IN partidas.partida_id%TYPE,
        p_local      IN t_stats,
        p_visitante  IN t_stats
    );

    /** Devuelve la tabla de posiciones de un torneo como cursor. */
    FUNCTION tabla_posiciones (
        p_torneo_id IN torneos.torneo_id%TYPE
    ) RETURN SYS_REFCURSOR;

    /** Imprime la tabla de posiciones usando BULK COLLECT. */
    PROCEDURE imprimir_posiciones (
        p_torneo_id IN torneos.torneo_id%TYPE
    );

    /** Marca el torneo como FINALIZADO si ya no tiene partidas programadas. */
    PROCEDURE cerrar_torneo (
        p_torneo_id IN torneos.torneo_id%TYPE
    );

END pkg_torneo;
/

CREATE OR REPLACE PACKAGE BODY pkg_torneo AS

    -- -------------------------------------------------
    -- Privado: ajusta el ranking global de un equipo (nunca baja de 0)
    -- -------------------------------------------------
    PROCEDURE ajustar_ranking (
        p_equipo_id IN equipos.equipo_id%TYPE,
        p_delta     IN NUMBER
    ) IS
    BEGIN
        UPDATE equipos
        SET ranking_global = GREATEST(0, ranking_global + p_delta)
        WHERE equipo_id = p_equipo_id;
    END ajustar_ranking;

    -- -------------------------------------------------
    PROCEDURE registrar_resultado (
        p_partida_id IN partidas.partida_id%TYPE,
        p_local      IN t_stats,
        p_visitante  IN t_stats
    ) IS
        v_partida   partidas%ROWTYPE;
        v_ganador   partidas.ganador_equipo_id%TYPE;
        v_res_local puntajes.resultado%TYPE;
        v_res_visit puntajes.resultado%TYPE;
        v_savepoint_activo BOOLEAN := FALSE;
    BEGIN
        -- Bloquea la fila para que nadie más cierre la misma partida a la vez
        BEGIN
            SELECT * INTO v_partida
            FROM partidas
            WHERE partida_id = p_partida_id
            FOR UPDATE;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20101, 'No existe la partida ' || p_partida_id);
        END;

        IF v_partida.estado <> 'PROGRAMADA' THEN
            RAISE_APPLICATION_ERROR(-20102,
                'La partida ' || p_partida_id || ' está en estado ' || v_partida.estado ||
                ' y no admite resultado');
        END IF;

        -- Decide ganador por puntos (empate => sin ganador)
        IF p_local.puntos > p_visitante.puntos THEN
            v_ganador := v_partida.equipo_local_id;
            v_res_local := 'GANADOR';  v_res_visit := 'PERDEDOR';
        ELSIF p_local.puntos < p_visitante.puntos THEN
            v_ganador := v_partida.equipo_visitante_id;
            v_res_local := 'PERDEDOR'; v_res_visit := 'GANADOR';
        ELSE
            v_ganador := NULL;
            v_res_local := 'EMPATE';   v_res_visit := 'EMPATE';
        END IF;

        SAVEPOINT antes_de_resultado;
        v_savepoint_activo := TRUE;

        INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
        VALUES (p_partida_id, v_partida.equipo_local_id,
                p_local.puntos, p_local.kills, p_local.deaths, p_local.asistencias, v_res_local);

        INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
        VALUES (p_partida_id, v_partida.equipo_visitante_id,
                p_visitante.puntos, p_visitante.kills, p_visitante.deaths, p_visitante.asistencias, v_res_visit);

        UPDATE partidas
        SET estado = 'JUGADA',
            ganador_equipo_id = v_ganador
        WHERE partida_id = p_partida_id;

        IF v_ganador IS NOT NULL THEN
            ajustar_ranking(v_ganador, c_puntos_ranking_victoria);
            ajustar_ranking(
                CASE WHEN v_ganador = v_partida.equipo_local_id
                     THEN v_partida.equipo_visitante_id
                     ELSE v_partida.equipo_local_id END,
                -c_puntos_ranking_derrota);
        END IF;

        DBMS_OUTPUT.PUT_LINE('Resultado registrado en partida ' || p_partida_id ||
                             ' (' || p_local.puntos || ' - ' || p_visitante.puntos || ')');
    EXCEPTION
        WHEN OTHERS THEN
            -- Deshace SOLO lo hecho por esta llamada y propaga el error.
            -- La bandera evita volver a un SAVEPOINT de una llamada anterior
            -- (los savepoints sobreviven hasta el COMMIT/ROLLBACK de la sesión).
            IF v_savepoint_activo THEN
                ROLLBACK TO antes_de_resultado;
            END IF;
            RAISE;
    END registrar_resultado;

    -- -------------------------------------------------
    FUNCTION tabla_posiciones (
        p_torneo_id IN torneos.torneo_id%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_cur SYS_REFCURSOR;
    BEGIN
        OPEN v_cur FOR
            SELECT posicion, nombre_equipo, pj, pg, pe, pp, puntos_anotados, puntos_liga
            FROM vw_tabla_posiciones
            WHERE torneo_id = p_torneo_id
            ORDER BY posicion, nombre_equipo;
        RETURN v_cur;
    END tabla_posiciones;

    -- -------------------------------------------------
    PROCEDURE imprimir_posiciones (
        p_torneo_id IN torneos.torneo_id%TYPE
    ) IS
        TYPE t_filas IS TABLE OF vw_tabla_posiciones%ROWTYPE;
        v_filas  t_filas;
        v_nombre torneos.nombre_torneo%TYPE;
    BEGIN
        BEGIN
            SELECT nombre_torneo INTO v_nombre FROM torneos WHERE torneo_id = p_torneo_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE_APPLICATION_ERROR(-20103, 'No existe el torneo ' || p_torneo_id);
        END;

        -- Una sola ida a SQL trae todas las filas (más rápido que fila a fila)
        SELECT * BULK COLLECT INTO v_filas
        FROM vw_tabla_posiciones
        WHERE torneo_id = p_torneo_id
        ORDER BY posicion, nombre_equipo;

        DBMS_OUTPUT.PUT_LINE('== ' || v_nombre || ' ==');
        IF v_filas.COUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('(sin partidas jugadas todavía)');
            RETURN;
        END IF;

        DBMS_OUTPUT.PUT_LINE(RPAD('#', 4) || RPAD('EQUIPO', 20) ||
                             LPAD('PJ', 4) || LPAD('PG', 4) || LPAD('PE', 4) || LPAD('PP', 4) || LPAD('PTS', 6));
        FOR i IN 1 .. v_filas.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(
                RPAD(v_filas(i).posicion, 4) || RPAD(v_filas(i).nombre_equipo, 20) ||
                LPAD(v_filas(i).pj, 4) || LPAD(v_filas(i).pg, 4) ||
                LPAD(v_filas(i).pe, 4) || LPAD(v_filas(i).pp, 4) ||
                LPAD(v_filas(i).puntos_liga, 6));
        END LOOP;
    END imprimir_posiciones;

    -- -------------------------------------------------
    PROCEDURE cerrar_torneo (
        p_torneo_id IN torneos.torneo_id%TYPE
    ) IS
        v_pendientes NUMBER;
        v_existe     NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_existe FROM torneos WHERE torneo_id = p_torneo_id;
        IF v_existe = 0 THEN
            RAISE_APPLICATION_ERROR(-20103, 'No existe el torneo ' || p_torneo_id);
        END IF;

        SELECT COUNT(*) INTO v_pendientes
        FROM partidas
        WHERE torneo_id = p_torneo_id AND estado = 'PROGRAMADA';

        IF v_pendientes > 0 THEN
            RAISE_APPLICATION_ERROR(-20104,
                'El torneo ' || p_torneo_id || ' aún tiene ' || v_pendientes || ' partida(s) programada(s)');
        END IF;

        UPDATE torneos SET estado = 'FINALIZADO' WHERE torneo_id = p_torneo_id;
        DBMS_OUTPUT.PUT_LINE('Torneo ' || p_torneo_id || ' finalizado.');
    END cerrar_torneo;

END pkg_torneo;
/
