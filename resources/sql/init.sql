-- PostgreSQL re-play init-db.sql
-- Tobias Hodges for Indoor Goals

-- Create new types.
CREATE TYPE strength AS ENUM (
  'EV', -- even strength
  'PP', -- power play
  'SH', -- short handed
  'EN', -- empty net
  'PS', -- penalty shot
  'SO'  -- shootout
) ;
-- ;;

CREATE TYPE severity AS ENUM (
  'minor',            -- 2 pim
  'bench minor',      -- 2 pim
  'major',            -- 5 pim
  'misconduct',       -- 10 pim
  'game misconduct',  -- 10 pim
  'match',            -- 10 pim
  'penalty shot',     -- ? pim
  'awarded goal'      -- ? pim
) ;
-- ;;

-- Create new tables.
CREATE TABLE sessions (
  session_id SERIAL PRIMARY KEY,
  session_name VARCHAR (31) UNIQUE NOT NULL
) ;
-- ;;

CREATE TABLE divisions (
  division_id SERIAL PRIMARY KEY,
  division_name VARCHAR (31) NOT NULL,
  session_id INTEGER NOT NULL,
  FOREIGN KEY (session_id) REFERENCES sessions (session_id) ON DELETE CASCADE
) ;
-- ;;

CREATE TABLE teams (
  team_id SERIAL PRIMARY KEY,
  team_name VARCHAR (63) NOT NULL,
  team_win SMALLINT DEFAULT 0,
  team_loss SMALLINT DEFAULT 0,
  team_draw SMALLINT DEFAULT 0,
  team_otl SMALLINT DEFAULT 0,
  division_id INTEGER NOT NULL,
  FOREIGN KEY (division_id) REFERENCES divisions (division_id) ON DELETE CASCADE
) ;
-- ;;

CREATE TABLE players (
  player_id SERIAL PRIMARY KEY,
  player_firstname VARCHAR (31) NOT NULL,
  player_lastname VARCHAR (31) NOT NULL,
  player_number SMALLINT NOT NULL,
  player_rating SMALLINT NOT NULL DEFAULT 0,
  team_id INTEGER NOT NULL,
  FOREIGN KEY (team_id) REFERENCES teams (team_id) ON DELETE CASCADE
) ;
-- ;;

CREATE TABLE games (
  game_id SERIAL PRIMARY KEY,
  hometeam_id INTEGER NOT NULL,
  awayteam_id INTEGER NOT NULL,
  game_timestamp TIMESTAMP UNIQUE NOT NULL,
  FOREIGN KEY (hometeam_id) REFERENCES teams (team_id) ON DELETE CASCADE
) ;
-- ;;

CREATE TABLE goals (
  goal_id SERIAL PRIMARY KEY,
  game_id INTEGER NOT NULL,
  scoring_player_id INTEGER NOT NULL,
  assist1_player_id INTEGER,
  assist2_player_id INTEGER,
  goal_strength strength NOT NULL DEFAULT 'EV',
  goal_mintue SMALLINT NOT NULL,
  FOREIGN KEY (game_id) REFERENCES games (game_id) ON DELETE CASCADE,
  FOREIGN KEY (scoring_player_id) REFERENCES players (player_id) ON DELETE CASCADE,
  FOREIGN KEY (assist1_player_id) REFERENCES players (player_id) ON DELETE CASCADE,
  FOREIGN KEY (assist2_player_id) REFERENCES players (player_id) ON DELETE CASCADE
) ;
-- ;;

CREATE TABLE keepers (
  keeper_id SERIAL PRIMARY KEY,
  player_id INTEGER NOT NULL,
  game_id INTEGER NOT NULL,
  keeper_saves SMALLINT DEFAULT 0,
  keeper_shotsagainst SMALLINT DEFAULT 0,
  keeper_minutes SMALLINT DEFAULT 0,
  FOREIGN KEY (player_id) REFERENCES players (player_id) ON DELETE CASCADE,
  FOREIGN KEY (game_id) REFERENCES games (game_id) ON DELETE CASCADE
) ;
-- ;;

CREATE TABLE penalties (
  penalty_id SERIAL PRIMARY KEY,
  penalty_name VARCHAR (63) NOT NULL,
  penalty_type severity NOT NULL
) ;
-- ;;

CREATE TABLE infractions (
  infraction_id SERIAL PRIMARY KEY,
  player_id INTEGER NOT NULL,
  penalty_id INTEGER NOT NULL,
  game_id INTEGER NOT NULL,
  infraction_minute SMALLINT NOT NULL,
  FOREIGN KEY (player_id) REFERENCES players (player_id) ON DELETE CASCADE,
  FOREIGN KEY (penalty_id) REFERENCES penalties (penalty_id) ON DELETE CASCADE,
  FOREIGN KEY (game_id) REFERENCES games (game_id) ON DELETE CASCADE
) ;
-- ;;
