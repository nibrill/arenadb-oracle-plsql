-- =========================================
-- 02_data.sql
-- ARENADB - DATOS DE PRUEBA
-- =========================================

-- =========================================
-- JUGADORES (20)
-- =========================================
INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('ShadowX', 'Carlos', 'Vega', 'shadowx@mail.com', 'Chile', DATE '2001-05-10', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('NovaFire', 'Matias', 'Rojas', 'novafire@mail.com', 'Chile', DATE '2000-08-21', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('DarkWolf', 'Diego', 'Silva', 'darkwolf@mail.com', 'Argentina', DATE '1999-11-03', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('IceQueen', 'Valentina', 'Morales', 'icequeen@mail.com', 'Chile', DATE '2002-02-14', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Phantom', 'Lucas', 'Perez', 'phantom@mail.com', 'Peru', DATE '1998-07-09', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('VenomStrike', 'Javier', 'Torres', 'venomstrike@mail.com', 'Chile', DATE '2001-09-30', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Blaze', 'Camila', 'Fuentes', 'blaze@mail.com', 'Chile', DATE '2003-01-25', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Titan', 'Sebastian', 'Lopez', 'titan@mail.com', 'Colombia', DATE '1997-04-18', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Raptor', 'Nicolas', 'Castro', 'raptor@mail.com', 'Chile', DATE '2000-12-01', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('LunaAim', 'Fernanda', 'Soto', 'lunaaim@mail.com', 'Chile', DATE '2002-06-11', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Storm', 'Andres', 'Gutierrez', 'storm@mail.com', 'Mexico', DATE '1999-03-15', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Viper', 'Ignacio', 'Ramirez', 'viper@mail.com', 'Chile', DATE '2001-10-20', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('CyberGirl', 'Paula', 'Reyes', 'cybergirl@mail.com', 'Chile', DATE '2004-02-09', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('ZeroLag', 'Cristobal', 'Araya', 'zerolag@mail.com', 'Chile', DATE '2000-07-07', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('NeoShot', 'Tomas', 'Herrera', 'neoshot@mail.com', 'Argentina', DATE '1998-05-22', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Echo', 'Martina', 'Diaz', 'echo@mail.com', 'Uruguay', DATE '2003-08-08', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Pulse', 'Benjamin', 'Navarro', 'pulse@mail.com', 'Chile', DATE '2002-09-17', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('NightFox', 'Felipe', 'Mendez', 'nightfox@mail.com', 'Peru', DATE '1999-01-31', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Astra', 'Daniela', 'Vargas', 'astra@mail.com', 'Chile', DATE '2001-04-27', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Kraken', 'Rodrigo', 'Salinas', 'kraken@mail.com', 'Chile', DATE '1997-12-19', 'MASCULINO', 'ACTIVO');

-- =========================================
-- EQUIPOS (20)
-- =========================================
INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Dragons Elite', 'DREL', (SELECT jugador_id FROM jugadores WHERE nickname = 'ShadowX'), 'Chile', 'ACTIVO', 1200);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Phantom Squad', 'PHSQ', (SELECT jugador_id FROM jugadores WHERE nickname = 'NovaFire'), 'Chile', 'ACTIVO', 1180);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Dark Ravens', 'DRVN', (SELECT jugador_id FROM jugadores WHERE nickname = 'DarkWolf'), 'Argentina', 'ACTIVO', 1150);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Ice Legends', 'ICLG', (SELECT jugador_id FROM jugadores WHERE nickname = 'IceQueen'), 'Chile', 'ACTIVO', 1100);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Night Raiders', 'NTRA', (SELECT jugador_id FROM jugadores WHERE nickname = 'Phantom'), 'Peru', 'ACTIVO', 1080);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Venom Force', 'VNFC', (SELECT jugador_id FROM jugadores WHERE nickname = 'VenomStrike'), 'Chile', 'ACTIVO', 1070);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Blaze Reborn', 'BLRB', (SELECT jugador_id FROM jugadores WHERE nickname = 'Blaze'), 'Chile', 'ACTIVO', 1060);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Titan Core', 'TNCR', (SELECT jugador_id FROM jugadores WHERE nickname = 'Titan'), 'Colombia', 'ACTIVO', 1050);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Raptor Zone', 'RPZN', (SELECT jugador_id FROM jugadores WHERE nickname = 'Raptor'), 'Chile', 'ACTIVO', 1040);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Lunar Aim', 'LNAM', (SELECT jugador_id FROM jugadores WHERE nickname = 'LunaAim'), 'Chile', 'ACTIVO', 1030);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Storm Breakers', 'STBK', (SELECT jugador_id FROM jugadores WHERE nickname = 'Storm'), 'Mexico', 'ACTIVO', 1020);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Viper Unit', 'VPUN', (SELECT jugador_id FROM jugadores WHERE nickname = 'Viper'), 'Chile', 'ACTIVO', 1010);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Cyber Queens', 'CYQN', (SELECT jugador_id FROM jugadores WHERE nickname = 'CyberGirl'), 'Chile', 'ACTIVO', 1000);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Zero Gravity', 'ZRGR', (SELECT jugador_id FROM jugadores WHERE nickname = 'ZeroLag'), 'Chile', 'ACTIVO', 990);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Neo Hunters', 'NEOH', (SELECT jugador_id FROM jugadores WHERE nickname = 'NeoShot'), 'Argentina', 'ACTIVO', 980);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Echo Pulse', 'ECPU', (SELECT jugador_id FROM jugadores WHERE nickname = 'Echo'), 'Uruguay', 'ACTIVO', 970);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Pulse Rush', 'PLRU', (SELECT jugador_id FROM jugadores WHERE nickname = 'Pulse'), 'Chile', 'ACTIVO', 960);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Fox Killers', 'FXKL', (SELECT jugador_id FROM jugadores WHERE nickname = 'NightFox'), 'Peru', 'ACTIVO', 950);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Astra Nova', 'ASNV', (SELECT jugador_id FROM jugadores WHERE nickname = 'Astra'), 'Chile', 'ACTIVO', 940);

INSERT INTO equipos (nombre_equipo, tag_equipo, capitan_jugador_id, region, estado, ranking_global)
VALUES ('Kraken Army', 'KRAR', (SELECT jugador_id FROM jugadores WHERE nickname = 'Kraken'), 'Chile', 'ACTIVO', 930);

-- =========================================
-- TORNEOS (20)
-- =========================================
INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Copa Valorant 2026', 'Valorant', 'PC', DATE '2026-04-10', DATE '2026-04-20', 500000, '5V5', 16, 'EN_CURSO');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Liga Apex Masters', 'Apex Legends', 'PC', DATE '2026-05-01', DATE '2026-05-12', 650000, 'SQUAD', 20, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Clash of Fighters', 'Street Fighter 6', 'PS5', DATE '2026-06-05', DATE '2026-06-06', 300000, 'SOLO', 32, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Rocket Arena Cup', 'Rocket League', 'PC', DATE '2026-04-15', DATE '2026-04-18', 280000, 'DUO', 12, 'EN_CURSO');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Battle Royale Pro', 'Fortnite', 'PC', DATE '2026-07-01', DATE '2026-07-03', 450000, 'SQUAD', 24, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Legends LAN Finals', 'League of Legends', 'PC', DATE '2026-08-10', DATE '2026-08-15', 900000, '5V5', 10, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Overwatch Supreme', 'Overwatch 2', 'PC', DATE '2026-05-20', DATE '2026-05-25', 550000, '5V5', 8, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Warzone Elite Series', 'Call of Duty Warzone', 'PC', DATE '2026-06-20', DATE '2026-06-22', 700000, 'SQUAD', 18, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Mortal Kombat Clash', 'Mortal Kombat 1', 'PS5', DATE '2026-09-02', DATE '2026-09-03', 250000, 'SOLO', 20, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Rainbow Siege Open', 'Rainbow Six Siege', 'PC', DATE '2026-04-22', DATE '2026-04-26', 620000, '5V5', 12, 'EN_CURSO');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Tekken Thunder', 'Tekken 8', 'PS5', DATE '2026-10-10', DATE '2026-10-11', 320000, 'SOLO', 24, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('FIFA Champions Latam', 'EA Sports FC 26', 'PS5', DATE '2026-11-05', DATE '2026-11-07', 480000, 'SOLO', 30, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('PUBG Tactical Cup', 'PUBG', 'PC', DATE '2026-06-01', DATE '2026-06-04', 510000, 'SQUAD', 16, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Smash Universe', 'Super Smash Bros Ultimate', 'Switch', DATE '2026-07-18', DATE '2026-07-19', 260000, 'SOLO', 28, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('CS Global Challenge', 'Counter-Strike 2', 'PC', DATE '2026-12-01', DATE '2026-12-05', 1000000, '5V5', 16, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Halo Arena', 'Halo Infinite', 'Xbox', DATE '2026-05-08', DATE '2026-05-10', 340000, 'SQUAD', 10, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Free Fire Stars', 'Free Fire', 'Mobile', DATE '2026-08-01', DATE '2026-08-03', 420000, 'SQUAD', 20, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Dota Ancient Cup', 'Dota 2', 'PC', DATE '2026-09-12', DATE '2026-09-16', 850000, '5V5', 12, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('Brawl Arena', 'Brawl Stars', 'Mobile', DATE '2026-10-20', DATE '2026-10-21', 210000, 'DUO', 14, 'PENDIENTE');

INSERT INTO torneos (nombre_torneo, juego, plataforma, fecha_inicio, fecha_fin, premio_total, modalidad, cantidad_equipos, estado)
VALUES ('eFootball Storm Cup', 'eFootball 2026', 'PS5', DATE '2026-11-20', DATE '2026-11-22', 390000, 'SOLO', 22, 'PENDIENTE');

-- =========================================
-- JUGADORES_EQUIPOS (20)
-- =========================================
INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'ShadowX'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DREL'),
    'CAPITAN',
    DATE '2026-01-10',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'NovaFire'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PHSQ'),
    'CAPITAN',
    DATE '2026-01-10',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'DarkWolf'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DRVN'),
    'CAPITAN',
    DATE '2026-01-11',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'IceQueen'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ICLG'),
    'CAPITAN',
    DATE '2026-01-11',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Phantom'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NTRA'),
    'CAPITAN',
    DATE '2026-01-12',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'VenomStrike'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VNFC'),
    'CAPITAN',
    DATE '2026-01-12',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Blaze'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'BLRB'),
    'CAPITAN',
    DATE '2026-01-13',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Titan'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'TNCR'),
    'CAPITAN',
    DATE '2026-01-13',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Raptor'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'RPZN'),
    'CAPITAN',
    DATE '2026-01-14',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'LunaAim'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'LNAM'),
    'CAPITAN',
    DATE '2026-01-14',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Storm'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'STBK'),
    'CAPITAN',
    DATE '2026-01-15',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Viper'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VPUN'),
    'CAPITAN',
    DATE '2026-01-15',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'CyberGirl'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'CYQN'),
    'CAPITAN',
    DATE '2026-01-16',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'ZeroLag'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ZRGR'),
    'CAPITAN',
    DATE '2026-01-16',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'NeoShot'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NEOH'),
    'CAPITAN',
    DATE '2026-01-17',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Echo'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ECPU'),
    'CAPITAN',
    DATE '2026-01-17',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Pulse'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PLRU'),
    'CAPITAN',
    DATE '2026-01-18',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'NightFox'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'FXKL'),
    'CAPITAN',
    DATE '2026-01-18',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Astra'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ASNV'),
    'CAPITAN',
    DATE '2026-01-19',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Kraken'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'KRAR'),
    'CAPITAN',
    DATE '2026-01-19',
    'ACTIVO'
);

-- =========================================
-- PARTIDAS (20)
-- =========================================
INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Copa Valorant 2026'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DREL'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PHSQ'),
    DATE '2026-04-11',
    'GRUPOS',
    'Ascent',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DREL'),
    'Partida intensa de fase de grupos'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Copa Valorant 2026'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DRVN'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ICLG'),
    DATE '2026-04-12',
    'GRUPOS',
    'Bind',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ICLG'),
    'Buen comeback del visitante'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Copa Valorant 2026'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NTRA'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VNFC'),
    DATE '2026-04-13',
    'GRUPOS',
    'Haven',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VNFC'),
    'Dominio total en defensa'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Rocket Arena Cup'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'BLRB'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'TNCR'),
    DATE '2026-04-16',
    'CUARTOS',
    'DFH Stadium',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'TNCR'),
    'Serie muy cerrada'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Rocket Arena Cup'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'RPZN'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'LNAM'),
    DATE '2026-04-16',
    'CUARTOS',
    'Champions Field',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'RPZN'),
    'Gol en overtime'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Rainbow Siege Open'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'STBK'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VPUN'),
    DATE '2026-04-23',
    'GRUPOS',
    'Club House',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'STBK'),
    'Ataque sólido'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Rainbow Siege Open'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'CYQN'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ZRGR'),
    DATE '2026-04-24',
    'GRUPOS',
    'Oregon',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'CYQN'),
    'Buen control del objetivo'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Liga Apex Masters'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NEOH'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ECPU'),
    DATE '2026-05-02',
    'GRUPOS',
    'World''s Edge',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NEOH'),
    'Mayor cantidad de eliminaciones'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Liga Apex Masters'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PLRU'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'FXKL'),
    DATE '2026-05-03',
    'GRUPOS',
    'Storm Point',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'FXKL'),
    'Final muy ajustado'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Liga Apex Masters'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ASNV'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'KRAR'),
    DATE '2026-05-04',
    'GRUPOS',
    'Olympus',
    'JUGADA',
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'KRAR'),
    'Victoria por rotación'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Overwatch Supreme'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DREL'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DRVN'),
    DATE '2026-05-21',
    'SEMIFINAL',
    'King''s Row',
    'PROGRAMADA',
    NULL,
    'Pendiente de jugar'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Overwatch Supreme'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ICLG'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VNFC'),
    DATE '2026-05-22',
    'SEMIFINAL',
    'Route 66',
    'PROGRAMADA',
    NULL,
    'Pendiente de jugar'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Warzone Elite Series'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'BLRB'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'RPZN'),
    DATE '2026-06-21',
    'GRUPOS',
    'Verdansk',
    'PROGRAMADA',
    NULL,
    'Programada para la tarde'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Warzone Elite Series'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'STBK'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'CYQN'),
    DATE '2026-06-21',
    'GRUPOS',
    'Rebirth Island',
    'PROGRAMADA',
    NULL,
    'Pendiente'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'PUBG Tactical Cup'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ZRGR'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NEOH'),
    DATE '2026-06-02',
    'GRUPOS',
    'Erangel',
    'PROGRAMADA',
    NULL,
    'Pendiente de confirmación'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'PUBG Tactical Cup'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ECPU'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PLRU'),
    DATE '2026-06-03',
    'GRUPOS',
    'Miramar',
    'PROGRAMADA',
    NULL,
    'Pendiente de confirmación'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'CS Global Challenge'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'FXKL'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ASNV'),
    DATE '2026-12-02',
    'OCTAVOS',
    'Mirage',
    'PROGRAMADA',
    NULL,
    'Próxima llave'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'CS Global Challenge'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'KRAR'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DREL'),
    DATE '2026-12-02',
    'OCTAVOS',
    'Inferno',
    'PROGRAMADA',
    NULL,
    'Próxima llave'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Dota Ancient Cup'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PHSQ'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DRVN'),
    DATE '2026-09-13',
    'CUARTOS',
    'Ancient Arena',
    'PROGRAMADA',
    NULL,
    'Pendiente'
);

INSERT INTO partidas (torneo_id, equipo_local_id, equipo_visitante_id, fecha_partida, ronda, mapa, estado, ganador_equipo_id, observaciones)
VALUES (
    (SELECT torneo_id FROM torneos WHERE nombre_torneo = 'Dota Ancient Cup'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ICLG'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NTRA'),
    DATE '2026-09-14',
    'CUARTOS',
    'Ancient Arena',
    'PROGRAMADA',
    NULL,
    'Pendiente'
);

-- =========================================
-- PUNTAJES (20) -> 2 por cada una de las primeras 10 partidas
-- =========================================
INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    1,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DREL'),
    13, 22, 15, 8, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    1,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PHSQ'),
    9, 15, 22, 5, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    2,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DRVN'),
    10, 18, 20, 6, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    2,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ICLG'),
    13, 21, 17, 9, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    3,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NTRA'),
    8, 12, 19, 4, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    3,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VNFC'),
    13, 23, 11, 10, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    4,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'BLRB'),
    2, 4, 7, 2, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    4,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'TNCR'),
    4, 7, 4, 3, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    5,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'RPZN'),
    5, 8, 6, 4, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    5,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'LNAM'),
    3, 6, 8, 2, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    6,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'STBK'),
    7, 10, 6, 5, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    6,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VPUN'),
    4, 6, 10, 3, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    7,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'CYQN'),
    7, 11, 7, 5, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    7,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ZRGR'),
    5, 8, 11, 2, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    8,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NEOH'),
    15, 26, 18, 11, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    8,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ECPU'),
    11, 20, 26, 7, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    9,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PLRU'),
    12, 19, 21, 8, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    9,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'FXKL'),
    14, 24, 18, 9, 'GANADOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    10,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ASNV'),
    10, 17, 20, 6, 'PERDEDOR'
);

INSERT INTO puntajes (partida_id, equipo_id, puntos_obtenidos, kills, deaths, asistencias, resultado)
VALUES (
    10,
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'KRAR'),
    13, 22, 17, 8, 'GANADOR'
);

-- =========================================
-- JUGADORES ADICIONALES (20) + sus membresías
-- Cada equipo suma un integrante más (jugador, suplente o coach)
-- =========================================
INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('PixelKnight', 'Joaquin', 'Bravo', 'pixelknight@mail.com', 'Chile', DATE '1996-01-05', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('SilentArrow', 'Antonia', 'Pizarro', 'silentarrow@mail.com', 'Chile', DATE '1997-02-06', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('CrimsonFang', 'Emilio', 'Paredes', 'crimsonfang@mail.com', 'Argentina', DATE '1998-03-07', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('FrostByte', 'Isidora', 'Campos', 'frostbyte@mail.com', 'Chile', DATE '1999-04-08', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Wraith', 'Mateo', 'Quispe', 'wraith@mail.com', 'Peru', DATE '2000-05-09', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('ToxicRain', 'Gabriel', 'Soto', 'toxicrain@mail.com', 'Chile', DATE '2001-06-10', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('EmberGirl', 'Javiera', 'Lagos', 'embergirl@mail.com', 'Chile', DATE '2002-07-11', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Colossus', 'Santiago', 'Rios', 'colossus@mail.com', 'Colombia', DATE '2003-08-12', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Talon', 'Vicente', 'Mella', 'talon@mail.com', 'Chile', DATE '1996-09-13', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('MoonShot', 'Catalina', 'Ortiz', 'moonshot@mail.com', 'Chile', DATE '1997-10-14', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Thunder', 'Alejandro', 'Cruz', 'thunder@mail.com', 'Mexico', DATE '1998-11-15', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Cobra', 'Martin', 'Bustos', 'cobra@mail.com', 'Chile', DATE '1999-12-16', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('GlitchQueen', 'Sofia', 'Munoz', 'glitchqueen@mail.com', 'Chile', DATE '2000-01-17', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Gravity', 'Agustin', 'Pino', 'gravity@mail.com', 'Chile', DATE '2001-02-18', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Hunter', 'Lautaro', 'Ibarra', 'hunter@mail.com', 'Argentina', DATE '2002-03-19', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Sonar', 'Lucia', 'Acosta', 'sonar@mail.com', 'Uruguay', DATE '2003-04-20', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Rusher', 'Dante', 'Figueroa', 'rusher@mail.com', 'Chile', DATE '1996-05-21', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Shade', 'Renzo', 'Villanueva', 'shade@mail.com', 'Peru', DATE '1997-06-22', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Nebula', 'Trinidad', 'Espinoza', 'nebula@mail.com', 'Chile', DATE '1998-07-23', 'FEMENINO', 'ACTIVO');

INSERT INTO jugadores (nickname, nombre_real, apellido_real, correo, pais, fecha_nacimiento, genero, estado)
VALUES ('Leviathan', 'Bastian', 'Carrasco', 'leviathan@mail.com', 'Chile', DATE '1999-08-24', 'MASCULINO', 'ACTIVO');

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'PixelKnight'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DREL'),
    'JUGADOR',
    DATE '2026-02-01',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'SilentArrow'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PHSQ'),
    'JUGADOR',
    DATE '2026-02-02',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'CrimsonFang'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'DRVN'),
    'JUGADOR',
    DATE '2026-02-03',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'FrostByte'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ICLG'),
    'SUPLENTE',
    DATE '2026-02-04',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Wraith'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NTRA'),
    'JUGADOR',
    DATE '2026-02-05',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'ToxicRain'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VNFC'),
    'JUGADOR',
    DATE '2026-02-06',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'EmberGirl'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'BLRB'),
    'JUGADOR',
    DATE '2026-02-07',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Colossus'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'TNCR'),
    'COACH',
    DATE '2026-02-08',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Talon'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'RPZN'),
    'JUGADOR',
    DATE '2026-02-09',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'MoonShot'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'LNAM'),
    'JUGADOR',
    DATE '2026-02-10',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Thunder'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'STBK'),
    'SUPLENTE',
    DATE '2026-02-11',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Cobra'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'VPUN'),
    'JUGADOR',
    DATE '2026-02-12',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'GlitchQueen'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'CYQN'),
    'JUGADOR',
    DATE '2026-02-13',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Gravity'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ZRGR'),
    'COACH',
    DATE '2026-02-14',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Hunter'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'NEOH'),
    'JUGADOR',
    DATE '2026-02-15',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Sonar'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ECPU'),
    'JUGADOR',
    DATE '2026-02-16',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Rusher'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'PLRU'),
    'JUGADOR',
    DATE '2026-02-17',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Shade'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'FXKL'),
    'SUPLENTE',
    DATE '2026-02-18',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Nebula'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'ASNV'),
    'JUGADOR',
    DATE '2026-02-19',
    'ACTIVO'
);

INSERT INTO jugadores_equipos (jugador_id, equipo_id, rol, fecha_union, estado)
VALUES (
    (SELECT jugador_id FROM jugadores WHERE nickname = 'Leviathan'),
    (SELECT equipo_id FROM equipos WHERE tag_equipo = 'KRAR'),
    'JUGADOR',
    DATE '2026-02-20',
    'ACTIVO'
);


COMMIT;

