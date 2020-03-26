-- PostgreSQL re-play manip.sql
-- Tobias Hodges for Indoor Goals

-- Implementing CRUD functionalities.

-- CREATE Functionality
-- Sessions
INSERT INTO sessions (session_name) VALUES
  (:session_name_input) ;
-- Divisions
INSERT INTO divisions (division_name, session_id) VALUES
  (:division_name_input, :session_id_input) ;
-- Teams
INSERT INTO teams (team_name, team_win, team_loss, team_draw, team_otl, division_id) VALUES
  (:team_name_input, DEFAULT, DEFAULT, DEFAULT, DEFAULT, :division_id_input) ;
-- Players
INSERT INTO players (player_firstname, player_lastname, player_number, player_rating) VALUES
  (:player_firstname_input, :player_lastname_input, :player_number_input, DEFAULT) ;
-- Games
INSERT INTO games (hometeam_id, awayteam_id, game_timestamp) VALUES
  (:hometeam_id_imput, :awayteam_id_input, :game_timestamp_input) ;
-- Goals
INSERT INTO goals (game_id, scoring_player_id, assist1_player_id, assist2_player_id, goal_strength, goal_minute) VALUES
  (:game_id_input, :scoring_player_id_input, :assist1_player_id_input, :assist2_player_id_input, :goal_strength_input, :goal_minute_input) ;
-- Keepers
INSERT INTO keepers (player_id, game_id, keeper_saves, keeper_shotsagainst, keeper_minutes) VALUES
  (:player_id_input, :game_id_input, DEFAULT, DEFAULT, DEFAULT) ;
-- Penalties
INSERT INTO penalties (penalty_name, penalty_type) VALUES
  (:penalty_name_input, :penalty_type_input) ;
-- Infractions
INSERT INTO infractions (player_id, penalty_id, game_id, infraction_minute) VALUES
  (:player_id_input, :penalty_id_input, :game_id_input, :infraction_minute_input) ;

-- READ Functionality
-- Sessions
SELECT session_name
FROM sessions
-- Divisions
SELECT division_name
FROM divisions
WHERE session_id = :session_id_input
ORDER BY session_id ASC ;
-- Teams
SELECT team_name, team_win, team_loss, team_draw, team_otl
FROM teams
WHERE division_id = :division_id_input
ORDER BY division_id ASC ;
-- Players
SELECT player_number, player_firstname, player_lastname, player_rating
FROM players
WHERE team_id = :team_id_input
ORDER BY player_number DESC ;
-- Games
SELECT game_timestamp
FROM games
WHERE hometeam_id = :team_id_input OR awayteam_id = :team_id_input
ORDER BY game_timestamp DESC ;
-- Goals
SELECT scoring_player_id, assist1_player_id, assist2_player_id, goal_strength
FROM goals
WHERE scoring_player_id = :player_id_input OR assist1_player_id = :player_id_input OR assist2_player_id = :player_id_input
ORDER BY goal_id DESC ;
-- Keepers
SELECT player_number, keeper_saves, keeper_shotsagainst, keeper_minutes
FROM keepers
  LEFT JOIN players ON keepers.player_id = players.player_id
  LEFT JOIN teams ON players.team_id = team.team_id
WHERE team_id = :team_id_input
ORDER BY keeper_minutes ASC ;
-- Penalties
SELECT penalty_name, penalty_type
FROM penalties
ORDER BY penalty_name ;
-- Infractions
SELECT player_number, penalty_name
FROM infractions
  LEFT JOIN players ON infractions.player_id = players.player_id
  LEFT JOIN penalties ON infractions.penalty_id = penalties.penalty_id
WHERE player_id = :player_id_input
ORDER BY penalty_type ;

-- UPDATE Functionality
-- Sessions
UPDATE sessions
SET session_name = :session_name_input
WHERE session_id = :session_id_input ;
-- Divisions
UPDATE divisions
SET division_name = :division_name_input
WHERE divison_id = :division_id_input ;
  -- set Session
UPDATE divisions
SET session_id = :session_id_input
WHERE division_id = :division_id_input ;
-- Teams
UPDATE teams
SET team_name = :team_name_input
WHERE team_id = :team_id_input ;
  -- Game won
UPDATE teams
SET team_win = team_win + 1
WHERE team_id = :team_id_input ;
  -- Game loss
UPDATE teams
SET team_loss = team_loss + 1
WHERE team_id = :team_id_input ;
  -- Game draw
UPDATE teams
SET team_draw = team_draw + 1
WHERE team_id = :team_id_input ;
  -- Game otl
UPDATE teams
SET team_otl = team_otl + 1
WHERE team_id = :team_id_input ;
  -- set Division
UPDATE teams
SET division_id = :division_id_input
WHERE team_id = :team_id_input ;
-- Players
UPDATE players
SET player_firstname = :player_firstname_input
WHERE player_id = :player_id_input ;
UPDATE players
SET player_lastname = :player_lastname_input
WHERE player_id = :player_id_input ;
UPDATE players
SET player_number = :player_number_input
WHERE player_id = :player_id_input ;
-- Games
UPDATE games
SET awayteam_id = :awayteam_id_input
WHERE game_id = :game_id_input ;
UPDATE games
SET hometeam_id = :hometeam_id_imput
WHERE game_id = :game_id_input ;
UPDATE games
SET game_timestamp = :game_timestamp_input
WHERE game_id = :game_id_input ;
-- Goals
UPDATE goals
SET goal_minute = :goal_minute_input
WHERE goal_id = :goal_id_input ;
UPDATE goals
SET goal_strength = :goal_strength_input
WHERE goal_id = :goal_id_input ;
-- Keepers
UPDATE keepers
SET keeper_saves = :keeper_saves_input
WHERE keeper_id = :keeper_id_input ;
UPDATE keepers
SET keeper_minutes = :keeper_minutes_input
WHERE keeper_id = :keeper_id_input ;
UPDATE keepers
SET keeper_shotsagainst = :keeper_shotsagainst_input
WHERE keeper_id = :keeper_id_input;
-- Penalties
UPDATE penalties
SET penalty_type = :penalty_type_input
WHERE penalty_id = :penalty_id_input ;
-- Infractions
UPDATE infractions
SET penalty_id = :penalty_id_input, player_id = :player_id_input
WHERE infraction_id = :infraction_id_input ;

-- DELETE Functionality
-- Sessions
-- Divisions
-- Teams
-- Players
-- Games
-- Goals
-- Keepers
-- Penalties
-- Infractions
