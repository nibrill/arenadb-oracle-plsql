-- =========================================
-- 04_plsql.sql
-- ARENADB - FUNCIONES, PROCEDIMIENTOS Y BLOQUES PL/SQL
--
-- Este script solo CREA objetos y ejecuta pruebas de LECTURA,
-- así que puedes correrlo las veces que quieras sin alterar datos.
-- Las pruebas que modifican datos están en 08_demo.sql.
-- =========================================

SET SERVEROUTPUT ON;

-- =====================================================
-- FUNCIÓN 1: total de victorias de un equipo
-- =====================================================
CREATE OR REPLACE FUNCTION fn_total_victorias_equipo (
    p_equipo_id IN equipos.equipo_id%TYPE
) RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    -- COUNT(*) siempre devuelve una fila (0 si no hay coincidencias),
    -- por eso no hace falta manejar NO_DATA_FOUND.
    SELECT COUNT(*)
    INTO v_total
    FROM partidas
    WHERE ganador_equipo_id = p_equipo_id
      AND estado = 'JUGADA';

    RETURN v_total;
END fn_total_victorias_equipo;
/

-- =====================================================
-- FUNCIÓN 2: total de puntos acumulados por un equipo
-- =====================================================
CREATE OR REPLACE FUNCTION fn_total_puntos_equipo (
    p_equipo_id IN equipos.equipo_id%TYPE
) RETURN NUMBER
IS
    v_total NUMBER;
BEGIN
    SELECT NVL(SUM(puntos_obtenidos), 0)
    INTO v_total
    FROM puntajes
    WHERE equipo_id = p_equipo_id;

    RETURN v_total;
END fn_total_puntos_equipo;
/

-- =====================================================
-- FUNCIÓN 3: clasificar un torneo según premio
--   BAJO  : menos de 300.000
--   MEDIO : de 300.000 a 700.000
--   ALTO  : más de 700.000
-- DETERMINISTIC: mismo input => mismo output, así Oracle puede
-- cachear el resultado y usarla en índices basados en funciones.
-- =====================================================
CREATE OR REPLACE FUNCTION fn_categoria_premio (
    p_premio IN torneos.premio_total%TYPE
) RETURN VARCHAR2 DETERMINISTIC
IS
BEGIN
    IF p_premio IS NULL THEN
        RETURN NULL;
    ELSIF p_premio < 300000 THEN
        RETURN 'BAJO';
    ELSIF p_premio <= 700000 THEN
        RETURN 'MEDIO';
    ELSE
        RETURN 'ALTO';
    END IF;
END fn_categoria_premio;
/

-- =====================================================
-- PROCEDIMIENTO 1: cambiar estado de un torneo
-- Lanza un error de aplicación si el torneo no existe
-- (así el llamador puede reaccionar, en vez de que el
-- mensaje se pierda en DBMS_OUTPUT).
-- =====================================================
CREATE OR REPLACE PROCEDURE sp_actualizar_estado_torneo (
    p_torneo_id     IN torneos.torneo_id%TYPE,
    p_nuevo_estado  IN torneos.estado%TYPE
)
IS
BEGIN
    UPDATE torneos
    SET estado = p_nuevo_estado
    WHERE torneo_id = p_torneo_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No se encontró el torneo con ID ' || p_torneo_id);
    END IF;

    DBMS_OUTPUT.PUT_LINE('Torneo ' || p_torneo_id || ' -> ' || p_nuevo_estado);
END sp_actualizar_estado_torneo;
/

-- =====================================================
-- PROCEDIMIENTO 2: cambiar estado de una partida
-- =====================================================
CREATE OR REPLACE PROCEDURE sp_actualizar_estado_partida (
    p_partida_id     IN partidas.partida_id%TYPE,
    p_nuevo_estado   IN partidas.estado%TYPE
)
IS
BEGIN
    UPDATE partidas
    SET estado = p_nuevo_estado
    WHERE partida_id = p_partida_id;

    IF SQL%ROWCOUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'No existe la partida con ID ' || p_partida_id);
    END IF;

    DBMS_OUTPUT.PUT_LINE('Partida ' || p_partida_id || ' -> ' || p_nuevo_estado);
END sp_actualizar_estado_partida;
/

-- =====================================================
-- PROCEDIMIENTO 3: registrar ganador de una partida
-- Valida que el ganador sea uno de los dos equipos que jugaron.
-- =====================================================
CREATE OR REPLACE PROCEDURE sp_registrar_ganador_partida (
    p_partida_id         IN partidas.partida_id%TYPE,
    p_ganador_equipo_id  IN partidas.ganador_equipo_id%TYPE
)
IS
    v_local     partidas.equipo_local_id%TYPE;
    v_visitante partidas.equipo_visitante_id%TYPE;
BEGIN
    SELECT equipo_local_id, equipo_visitante_id
    INTO v_local, v_visitante
    FROM partidas
    WHERE partida_id = p_partida_id;

    IF p_ganador_equipo_id NOT IN (v_local, v_visitante) THEN
        RAISE_APPLICATION_ERROR(-20003,
            'El equipo ' || p_ganador_equipo_id || ' no participa en la partida ' || p_partida_id);
    END IF;

    UPDATE partidas
    SET ganador_equipo_id = p_ganador_equipo_id,
        estado = 'JUGADA'
    WHERE partida_id = p_partida_id;

    DBMS_OUTPUT.PUT_LINE('Ganador registrado: equipo ' || p_ganador_equipo_id || ' en partida ' || p_partida_id);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'No existe la partida con ID ' || p_partida_id);
END sp_registrar_ganador_partida;
/

-- =====================================================
-- PROCEDIMIENTO 4: ranking de equipos con cursor explícito
-- =====================================================
CREATE OR REPLACE PROCEDURE sp_ranking_equipos
IS
    CURSOR c_ranking IS
        SELECT e.equipo_id,
               e.nombre_equipo,
               NVL(SUM(p.puntos_obtenidos), 0) AS total_puntos
        FROM equipos e
        LEFT JOIN puntajes p
            ON e.equipo_id = p.equipo_id
        GROUP BY e.equipo_id, e.nombre_equipo
        ORDER BY total_puntos DESC, e.nombre_equipo;

    v_pos NUMBER := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE(RPAD('#', 4) || RPAD('EQUIPO', 22) || 'PUNTOS');
    DBMS_OUTPUT.PUT_LINE(RPAD('-', 36, '-'));

    FOR r IN c_ranking LOOP
        v_pos := v_pos + 1;
        DBMS_OUTPUT.PUT_LINE(RPAD(v_pos, 4) || RPAD(r.nombre_equipo, 22) || r.total_puntos);
    END LOOP;
END sp_ranking_equipos;
/

-- =====================================================
-- PRUEBAS (solo lectura)
-- =====================================================

-- BLOQUE 1: información de un jugador por nickname
DECLARE
    v_nickname jugadores.nickname%TYPE := 'ShadowX';
    v_nombre   jugadores.nombre_real%TYPE;
    v_apellido jugadores.apellido_real%TYPE;
    v_pais     jugadores.pais%TYPE;
BEGIN
    SELECT nombre_real, apellido_real, pais
    INTO v_nombre, v_apellido, v_pais
    FROM jugadores
    WHERE nickname = v_nickname;

    DBMS_OUTPUT.PUT_LINE('Jugador: ' || v_nombre || ' ' || v_apellido || ' | País: ' || v_pais);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe jugador con nickname ' || v_nickname);
END;
/

-- BLOQUE 2: torneos y su categoría de premio (FOR sobre cursor implícito)
BEGIN
    FOR t IN (SELECT nombre_torneo, premio_total
              FROM torneos
              ORDER BY premio_total DESC
              FETCH FIRST 8 ROWS ONLY) LOOP
        DBMS_OUTPUT.PUT_LINE(
            RPAD(t.nombre_torneo, 24) ||
            LPAD(TO_CHAR(t.premio_total, 'FM999G999G999'), 10) ||
            '  ' || fn_categoria_premio(t.premio_total)
        );
    END LOOP;
END;
/

-- BLOQUE 3: estadísticas de un equipo usando las funciones
DECLARE
    v_equipo_id equipos.equipo_id%TYPE := 1;
    v_nombre    equipos.nombre_equipo%TYPE;
BEGIN
    SELECT nombre_equipo INTO v_nombre FROM equipos WHERE equipo_id = v_equipo_id;

    DBMS_OUTPUT.PUT_LINE('Equipo:            ' || v_nombre);
    DBMS_OUTPUT.PUT_LINE('Victorias:         ' || fn_total_victorias_equipo(v_equipo_id));
    DBMS_OUTPUT.PUT_LINE('Puntos acumulados: ' || fn_total_puntos_equipo(v_equipo_id));
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No existe el equipo con ID ' || v_equipo_id);
END;
/

-- BLOQUE 4: ranking completo
BEGIN
    sp_ranking_equipos;
END;
/
