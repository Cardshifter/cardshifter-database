START TRANSACTION;
--DROP SCHEMA IF EXISTS replays CASCADE; /* This WILL delete the schema and all related tables */
CREATE SCHEMA replays;
DROP ROLE IF EXISTS admins;
CREATE ROLE admins WITH
    PASSWORD 'changeme'; /*** MAKE SURE TO CHANGE THIS! */
GRANT SELECT ON ALL TABLES IN SCHEMA replays TO PUBLIC;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA replays TO admins;
COMMIT;

START TRANSACTION;
SET search_path TO replays; 
CREATE TABLE player (
    id SERIAL PRIMARY KEY UNIQUE,
    name TEXT NOT NULL,
    password TEXT NULL,
    create_time TIMESTAMP NOT NULL DEFAULT NOW(),
    last_seen_time TIMESTAMP NULL DEFAULT NULL
);
CREATE TABLE game (
    id SERIAL PRIMARY KEY UNIQUE,
    create_time TIMESTAMP NOT NULL DEFAULT NOW(),
    mod TEXT,
    replay JSON
);
CREATE TABLE player_game (
    id SERIAL PRIMARY KEY UNIQUE,
    game_id INTEGER NOT NULL,
      FOREIGN KEY (game_id) REFERENCES game(id),
    player_id INTEGER NOT NULL,
      FOREIGN KEY (player_id) REFERENCES player(id),
    win_result INTEGER NULL
);
COMMIT;

SELECT
    tables.table_schema,
    tables.table_name,
    columns.column_name,
    columns.ordinal_position,
    columns.is_nullable,
    columns.data_type
FROM information_schema.tables AS tables
    INNER JOIN information_schema.columns AS columns
        ON tables.table_name = columns.table_name
WHERE 
    tables.table_schema = 'replays'
ORDER BY 
    tables.table_name ASC,
    columns.ordinal_position ASC;
