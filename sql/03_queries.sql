-- =========================================
-- 03_queries.sql
-- TORNEO GAMER - CONSULTAS SQL
-- =========================================

-- 1) Listar jugadores con su equipo y rol
SELECT j.jugador_id,
       j.nickname,
       j.nombre_real || ' ' || j.apellido_real AS nombre_completo,
       e.nombre_equipo,
       je.rol,
       je.estado
FROM jugadores j
JOIN jugadores_equipos je
    ON j.jugador_id = je.jugador_id
JOIN equipos e
    ON je.equipo_id = e.equipo_id
ORDER BY e.nombre_equipo, j.nickname;

-- 2) Mostrar equipos con su capitán y ranking
SELECT e.equipo_id,
       e.nombre_equipo,
       e.tag_equipo,
       j.nickname AS capitan,
       e.region,
       e.ranking_global
FROM equipos e
LEFT JOIN jugadores j
    ON e.capitan_jugador_id = j.jugador_id
ORDER BY e.ranking_global DESC;

-- 3) Listar torneos con fechas formateadas y premio
SELECT torneo_id,
       nombre_torneo,
       juego,
       plataforma,
       TO_CHAR(fecha_inicio, 'DD/MM/YYYY') AS fecha_inicio,
       TO_CHAR(fecha_fin, 'DD/MM/YYYY') AS fecha_fin,
       TO_CHAR(premio_total, 'FM$999G999G999D00') AS premio_total,
       modalidad,
       cantidad_equipos,
       estado
FROM torneos
ORDER BY fecha_inicio;

-- 4) Mostrar partidas jugadas con local, visitante y ganador
SELECT p.partida_id,
       t.nombre_torneo,
       el.nombre_equipo AS equipo_local,
       ev.nombre_equipo AS equipo_visitante,
       TO_CHAR(p.fecha_partida, 'DD/MM/YYYY') AS fecha_partida,
       p.ronda,
       p.mapa,
       p.estado,
       eg.nombre_equipo AS ganador
FROM partidas p
JOIN torneos t
    ON p.torneo_id = t.torneo_id
JOIN equipos el
    ON p.equipo_local_id = el.equipo_id
JOIN equipos ev
    ON p.equipo_visitante_id = ev.equipo_id
LEFT JOIN equipos eg
    ON p.ganador_equipo_id = eg.equipo_id
WHERE p.estado = 'JUGADA'
ORDER BY p.fecha_partida;

-- 5) Listar partidas pendientes de jugar
SELECT p.partida_id,
       t.nombre_torneo,
       el.nombre_equipo AS equipo_local,
       ev.nombre_equipo AS equipo_visitante,
       TO_CHAR(p.fecha_partida, 'DD/MM/YYYY') AS fecha_partida,
       p.ronda,
       p.mapa,
       p.estado
FROM partidas p
JOIN torneos t
    ON p.torneo_id = t.torneo_id
JOIN equipos el
    ON p.equipo_local_id = el.equipo_id
JOIN equipos ev
    ON p.equipo_visitante_id = ev.equipo_id
WHERE p.estado = 'PROGRAMADA'
ORDER BY p.fecha_partida;

-- 6) Ranking de equipos por puntaje total acumulado
SELECT e.nombre_equipo,
       SUM(pt.puntos_obtenidos) AS total_puntos
FROM puntajes pt
JOIN equipos e
    ON pt.equipo_id = e.equipo_id
GROUP BY e.nombre_equipo
ORDER BY total_puntos DESC, e.nombre_equipo;

-- 7) Equipo con más kills acumuladas
SELECT e.nombre_equipo,
       SUM(pt.kills) AS total_kills
FROM puntajes pt
JOIN equipos e
    ON pt.equipo_id = e.equipo_id
GROUP BY e.nombre_equipo
ORDER BY total_kills DESC, e.nombre_equipo;

-- 8) Promedio de puntos por equipo
SELECT e.nombre_equipo,
       ROUND(AVG(pt.puntos_obtenidos), 2) AS promedio_puntos
FROM puntajes pt
JOIN equipos e
    ON pt.equipo_id = e.equipo_id
GROUP BY e.nombre_equipo
ORDER BY promedio_puntos DESC, e.nombre_equipo;

-- 9) Cantidad de partidas por torneo
SELECT t.nombre_torneo,
       COUNT(p.partida_id) AS cantidad_partidas
FROM torneos t
LEFT JOIN partidas p
    ON t.torneo_id = p.torneo_id
GROUP BY t.nombre_torneo
ORDER BY cantidad_partidas DESC, t.nombre_torneo;

-- 10) Equipos ganadores en partidas jugadas
SELECT e.nombre_equipo,
       COUNT(*) AS victorias
FROM partidas p
JOIN equipos e
    ON p.ganador_equipo_id = e.equipo_id
WHERE p.estado = 'JUGADA'
GROUP BY e.nombre_equipo
ORDER BY victorias DESC, e.nombre_equipo;

-- 11) Puntajes detallados por partida
SELECT pt.partida_id,
       e.nombre_equipo,
       pt.puntos_obtenidos,
       pt.kills,
       pt.deaths,
       pt.asistencias,
       pt.resultado
FROM puntajes pt
JOIN equipos e
    ON pt.equipo_id = e.equipo_id
ORDER BY pt.partida_id, pt.puntos_obtenidos DESC;

-- 12) Jugadores registrados por país
SELECT pais,
       COUNT(*) AS cantidad_jugadores
FROM jugadores
GROUP BY pais
ORDER BY cantidad_jugadores DESC, pais;

-- 13) Torneos pendientes o en curso
SELECT nombre_torneo,
       juego,
       estado,
       TO_CHAR(fecha_inicio, 'DD/MM/YYYY') AS fecha_inicio
FROM torneos
WHERE estado IN ('PENDIENTE', 'EN_CURSO')
ORDER BY fecha_inicio;

-- 14) Equipos con ranking superior a 1000
SELECT equipo_id,
       nombre_equipo,
       tag_equipo,
       region,
       ranking_global
FROM equipos
WHERE ranking_global > 1000
ORDER BY ranking_global DESC;

-- 15) Resumen de rendimiento por equipo
SELECT e.nombre_equipo,
       COUNT(pt.partida_id) AS partidas_con_puntaje,
       SUM(pt.puntos_obtenidos) AS puntos_totales,
       SUM(pt.kills) AS kills_totales,
       SUM(pt.asistencias) AS asistencias_totales
FROM equipos e
LEFT JOIN puntajes pt
    ON e.equipo_id = pt.equipo_id
GROUP BY e.nombre_equipo
ORDER BY puntos_totales DESC NULLS LAST, e.nombre_equipo;

-- =========================================
-- CONSULTAS AVANZADAS
-- =========================================

-- 16) Tabla de posiciones por torneo (vista con RANK() OVER)
SELECT nombre_torneo, posicion, nombre_equipo, pj, pg, pe, pp, puntos_liga
FROM vw_tabla_posiciones
ORDER BY nombre_torneo, posicion;

-- 17) KDA por equipo: (kills + asistencias) / deaths
SELECT nombre_equipo, kills, deaths, asistencias, kda
FROM vw_ranking_equipos
WHERE partidas_jugadas > 0
ORDER BY kda DESC;

-- 18) Equipos que todavía no han ganado ninguna partida (NOT EXISTS)
SELECT e.nombre_equipo, e.region, e.ranking_global
FROM equipos e
WHERE NOT EXISTS (
    SELECT 1 FROM partidas p
    WHERE p.ganador_equipo_id = e.equipo_id
)
ORDER BY e.ranking_global DESC;

-- 19) Porcentaje de victorias por equipo (solo equipos con partidas jugadas)
SELECT nombre_equipo,
       partidas_jugadas,
       victorias,
       ROUND(100 * victorias / partidas_jugadas, 1) AS pct_victorias
FROM vw_ranking_equipos
WHERE partidas_jugadas > 0
ORDER BY pct_victorias DESC, victorias DESC, nombre_equipo;

-- 20) Avance de cada torneo (vista) con categoría de premio (función PL/SQL)
SELECT nombre_torneo,
       estado,
       fn_categoria_premio(premio_total) AS categoria_premio,
       partidas_jugadas || '/' || partidas_totales AS avance,
       avance_pct
FROM vw_resumen_torneos
WHERE partidas_totales > 0
ORDER BY avance_pct DESC, nombre_torneo;

-- 21) Equipos con más de un integrante activo (HAVING)
SELECT e.nombre_equipo,
       COUNT(*) AS integrantes,
       LISTAGG(j.nickname || ' (' || je.rol || ')', ', ') WITHIN GROUP (ORDER BY je.rol, j.nickname) AS plantilla
FROM equipos e
JOIN jugadores_equipos je ON e.equipo_id = je.equipo_id AND je.estado = 'ACTIVO'
JOIN jugadores j          ON je.jugador_id = j.jugador_id
GROUP BY e.nombre_equipo
HAVING COUNT(*) > 1
ORDER BY integrantes DESC, e.nombre_equipo;

-- 22) Mejor partida de cada torneo (la de más puntos anotados por un equipo) con ROW_NUMBER
SELECT nombre_torneo, nombre_equipo, puntos_obtenidos, ronda
FROM (
    SELECT t.nombre_torneo, e.nombre_equipo, pt.puntos_obtenidos, p.ronda,
           ROW_NUMBER() OVER (PARTITION BY t.torneo_id ORDER BY pt.puntos_obtenidos DESC) AS rn
    FROM puntajes pt
    JOIN partidas p ON pt.partida_id = p.partida_id
    JOIN torneos  t ON p.torneo_id   = t.torneo_id
    JOIN equipos  e ON pt.equipo_id  = e.equipo_id
)
WHERE rn = 1
ORDER BY puntos_obtenidos DESC;
