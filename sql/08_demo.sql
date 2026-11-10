-- =========================================
-- 08_demo.sql
-- TORNEO GAMER - DEMO DE LA LÓGICA DE NEGOCIO
--
-- Muestra el paquete y los triggers en acción. Al final hace
-- ROLLBACK, así que la base queda exactamente como estaba y
-- puedes ejecutarlo todas las veces que quieras.
-- =========================================

SET SERVEROUTPUT ON;

PROMPT
PROMPT === 1) Registrar el resultado de la partida 11 (Dragons Elite vs Dark Ravens) ===
DECLARE
    v_local pkg_torneo.t_stats;
    v_visit pkg_torneo.t_stats;
BEGIN
    v_local.puntos := 13; v_local.kills := 24; v_local.deaths := 14; v_local.asistencias := 9;
    v_visit.puntos := 10; v_visit.kills := 17; v_visit.deaths := 24; v_visit.asistencias := 6;

    pkg_torneo.registrar_resultado(11, v_local, v_visit);
END;
/

PROMPT
PROMPT === 2) El ranking global se movió (+25 al ganador, -15 al perdedor) ===
SELECT nombre_equipo, ranking_global
FROM equipos
WHERE equipo_id IN (SELECT equipo_local_id FROM partidas WHERE partida_id = 11
                    UNION SELECT equipo_visitante_id FROM partidas WHERE partida_id = 11);

PROMPT
PROMPT === 3) Intentar registrar la MISMA partida otra vez => error controlado ===
DECLARE
    v_s pkg_torneo.t_stats;
BEGIN
    v_s.puntos := 1; v_s.kills := 0; v_s.deaths := 0; v_s.asistencias := 0;
    pkg_torneo.registrar_resultado(11, v_s, v_s);
EXCEPTION
    WHEN pkg_torneo.e_partida_no_programada THEN
        DBMS_OUTPUT.PUT_LINE('Rechazado: ' || SQLERRM);
END;
/

PROMPT
PROMPT === 4) Tabla de posiciones del torneo "Copa Valorant 2026" (BULK COLLECT) ===
BEGIN
    pkg_torneo.imprimir_posiciones(1);
END;
/

PROMPT
PROMPT === 5) Trigger: un ganador que no jugó la partida es rechazado ===
BEGIN
    UPDATE partidas SET ganador_equipo_id = 20, estado = 'JUGADA' WHERE partida_id = 12;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Rechazado: ' || SQLERRM);
END;
/

PROMPT
PROMPT === 6) Trigger: un torneo cerrado no puede reabrirse ===
BEGIN
    UPDATE torneos SET estado = 'FINALIZADO' WHERE torneo_id = 4;
    UPDATE torneos SET estado = 'EN_CURSO'   WHERE torneo_id = 4;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Rechazado: ' || SQLERRM);
END;
/

PROMPT
PROMPT === 7) No se puede cerrar un torneo con partidas programadas ===
BEGIN
    pkg_torneo.cerrar_torneo(2);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Rechazado: ' || SQLERRM);
END;
/

PROMPT
PROMPT === 8) Auditoría generada por el trigger ===
SELECT partida_id, estado_anterior, estado_nuevo, ganador_anterior, ganador_nuevo
FROM auditoria_partidas
ORDER BY auditoria_id;

-- Deja la base intacta
ROLLBACK;
PROMPT
PROMPT (ROLLBACK hecho: los datos quedaron como estaban)
