-- =========================================
-- install.sql
-- Instala todo el proyecto con un solo comando.
-- Ejecútalo DESDE la carpeta del repositorio:
--
--     sqlplus usuario/clave@servicio @sql/install.sql
--
-- (en SQL Developer: abre el archivo y presiona "Run Script", F5)
-- =========================================
WHENEVER SQLERROR CONTINUE
SET DEFINE OFF
SET SERVEROUTPUT ON

PROMPT >> 00 limpieza
@@00_drop.sql
PROMPT >> 01 esquema
@@01_schema.sql
PROMPT >> 02 datos
@@02_data.sql
PROMPT >> 04 funciones y procedimientos
@@04_plsql.sql
PROMPT >> 05 vistas
@@05_views.sql
PROMPT >> 06 paquete
@@06_package.sql
PROMPT >> 07 triggers
@@07_triggers.sql

PROMPT
PROMPT Instalación completa. Prueba:  @@08_demo.sql   y   @@03_queries.sql
