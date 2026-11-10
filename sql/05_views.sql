-- =========================================
-- 05_views.sql
-- TORNEO GAMER - VISTAS
-- =========================================

-- Tabla de posiciones por torneo
-- Sistema de puntos: victoria = 3, empate = 1, derrota = 0
CREATE OR REPLACE VIEW vw_tabla_posiciones AS
SELECT t.torneo_id,
       t.nombre_torneo,
       e.equipo_id,
       e.nombre_equipo,
       COUNT(*)                                                   AS pj,
       SUM(CASE WHEN pt.resultado = 'GANADOR'  THEN 1 ELSE 0 END) AS pg,
       SUM(CASE WHEN pt.resultado = 'EMPATE'   THEN 1 ELSE 0 END) AS pe,
       SUM(CASE WHEN pt.resultado = 'PERDEDOR' THEN 1 ELSE 0 END) AS pp,
       SUM(pt.puntos_obtenidos)                                   AS puntos_anotados,
       SUM(pt.kills)                                              AS kills,
       3 * SUM(CASE WHEN pt.resultado = 'GANADOR' THEN 1 ELSE 0 END)
         + SUM(CASE WHEN pt.resultado = 'EMPATE'  THEN 1 ELSE 0 END) AS puntos_liga,
       RANK() OVER (
           PARTITION BY t.torneo_id
           ORDER BY 3 * SUM(CASE WHEN pt.resultado = 'GANADOR' THEN 1 ELSE 0 END)
                      + SUM(CASE WHEN pt.resultado = 'EMPATE'  THEN 1 ELSE 0 END) DESC,
                    SUM(pt.puntos_obtenidos) DESC
       )                                                          AS posicion
FROM puntajes pt
JOIN partidas p ON pt.partida_id = p.partida_id
JOIN torneos  t ON p.torneo_id   = t.torneo_id
JOIN equipos  e ON pt.equipo_id  = e.equipo_id
GROUP BY t.torneo_id, t.nombre_torneo, e.equipo_id, e.nombre_equipo;

-- Ranking global de equipos con estadísticas acumuladas
CREATE OR REPLACE VIEW vw_ranking_equipos AS
SELECT e.equipo_id,
       e.nombre_equipo,
       e.tag_equipo,
       e.region,
       e.ranking_global,
       NVL(SUM(CASE WHEN pt.resultado = 'GANADOR' THEN 1 ELSE 0 END), 0) AS victorias,
       COUNT(pt.puntaje_id)                                              AS partidas_jugadas,
       NVL(SUM(pt.puntos_obtenidos), 0)                                  AS puntos_totales,
       NVL(SUM(pt.kills), 0)                                             AS kills,
       NVL(SUM(pt.deaths), 0)                                            AS deaths,
       NVL(SUM(pt.asistencias), 0)                                       AS asistencias,
       ROUND((NVL(SUM(pt.kills), 0) + NVL(SUM(pt.asistencias), 0))
             / NULLIF(SUM(pt.deaths), 0), 2)                             AS kda,
       RANK() OVER (ORDER BY e.ranking_global DESC)                      AS posicion
FROM equipos e
LEFT JOIN puntajes pt ON e.equipo_id = pt.equipo_id
GROUP BY e.equipo_id, e.nombre_equipo, e.tag_equipo, e.region, e.ranking_global;

-- Resumen de cada torneo: cuántas partidas hay, cuántas se jugaron y avance
CREATE OR REPLACE VIEW vw_resumen_torneos AS
SELECT t.torneo_id,
       t.nombre_torneo,
       t.juego,
       t.estado,
       t.premio_total,
       COUNT(p.partida_id)                                          AS partidas_totales,
       NVL(SUM(CASE WHEN p.estado = 'JUGADA'     THEN 1 ELSE 0 END), 0) AS partidas_jugadas,
       NVL(SUM(CASE WHEN p.estado = 'PROGRAMADA' THEN 1 ELSE 0 END), 0) AS partidas_pendientes,
       ROUND(100 * NVL(SUM(CASE WHEN p.estado = 'JUGADA' THEN 1 ELSE 0 END), 0)
             / NULLIF(COUNT(p.partida_id), 0), 1)                   AS avance_pct
FROM torneos t
LEFT JOIN partidas p ON t.torneo_id = p.torneo_id
GROUP BY t.torneo_id, t.nombre_torneo, t.juego, t.estado, t.premio_total;
