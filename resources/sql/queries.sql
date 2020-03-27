-- PostgreSQL re-play manip.sql
-- Tobias Hodges for Indoor Goals

-- Implementing CRUD functionalities.

-- CREATE Functionality

-- Sessions
-- :name new-session :i!
-- :doc insert a new session into a database
INSERT INTO sessions (session_name) VALUES
  (:session_name_input) ;
-- ;;
-- Divisions
-- :name create-division :i!
-- :doc create a new division into a session
INSERT INTO divisions (division_name, session_id) VALUES
  (:division_name_input, :session_id_input) ;
-- ;;
-- Teams
-- :name create-team :i!
-- :doc create a new team into a division
INSERT INTO teams (team_name, team_win, team_loss, team_draw, team_otl, division_id) VALUES
  (:team_name_input, DEFAULT, DEFAULT, DEFAULT, DEFAULT, :division_id_input) ;
-- ;;
-- Players
-- :name create-player :i!
-- :doc create a new player into a team
INSERT INTO players (player_firstname, player_lastname, player_number, player_rating, team_id) VALUES
  (:player_firstname_input, :player_lastname_input, :player_number_input, DEFAULT, :team_id_input) ;
-- ;;
-- Games
-- :name create-game :i!
-- :doc create a new game as two teams
INSERT INTO games (hometeam_id, awayteam_id, game_timestamp) VALUES
  (:hometeam_id_imput, :awayteam_id_input, :game_timestamp_input) ;
-- ;;
-- Goals
-- :name create-goal :i!
-- :doc create a new goal as a game and one to three players
INSERT INTO goals (game_id, scoring_player_id, assist1_player_id, assist2_player_id, goal_strength, goal_minute) VALUES
  (:game_id_input, :scoring_player_id_input, :assist1_player_id_input, :assist2_player_id_input, :goal_strength_input, :goal_minute_input) ;
-- ;;
-- Keepers
-- :name create-keeper :i!
-- :doc create a new keeper as a player and a game
INSERT INTO keepers (player_id, game_id, keeper_saves, keeper_shotsagainst, keeper_minutes) VALUES
  (:player_id_input, :game_id_input, DEFAULT, DEFAULT, DEFAULT) ;
-- ;;
-- Penalties
-- :name create-penalty :i!
-- :doc create a new penalty into a database
INSERT INTO penalties (penalty_name, penalty_type) VALUES
  (:penalty_name_input, :penalty_type_input) ;
-- ;;
-- Infractions
-- :name create-infraction :i!
-- :doc create a new infraction as a player and a penalty
INSERT INTO infractions (player_id, penalty_id, game_id, infraction_minute) VALUES
  (:player_id_input, :penalty_id_input, :game_id_input, :infraction_minute_input) ;


-- READ Functionality

-- Sessions
-- :name read-sessions :? :*
-- :doc read all sessions
SELECT session_name
FROM sessions ;
-- ;;
-- Divisions
-- :name read-divisions :? :*
-- :doc read all divisions by session
SELECT division_name
FROM divisions
WHERE session_id = :session_id_input
ORDER BY session_id ASC ;
-- ;;
-- Teams
-- :name read-teams :? :*
-- :doc read all team names and statistics by division
SELECT team_name, team_win, team_loss, team_draw, team_otl
FROM teams
WHERE division_id = :division_id_input
ORDER BY division_id ASC ;
-- ;;
-- Players
-- :name read-players :? :*
-- :doc read all player names, numbers, and ratings by team
SELECT player_number, player_firstname, player_lastname, player_rating
FROM players
WHERE team_id = :team_id_input
ORDER BY player_number DESC ;
-- ;;
-- Games
-- :name read-games :? :*
-- :doc read all game times by team
SELECT game_timestamp
FROM games
WHERE hometeam_id = :team_id_input OR awayteam_id = :team_id_input
ORDER BY game_timestamp DESC ;
-- ;;
-- Goals
-- :name read-goals :? :*
-- :doc read all goals by player
SELECT scoring_player_id, assist1_player_id, assist2_player_id, goal_strength
FROM goals
WHERE scoring_player_id = :player_id_input OR assist1_player_id = :player_id_input OR assist2_player_id = :player_id_input
ORDER BY goal_id DESC ;
-- ;;
-- Keepers
-- :name read-keepers :? :*
-- :doc read all keepers saves, shots against, and minutes by team
SELECT player_number, keeper_saves, keeper_shotsagainst, keeper_minutes
FROM keepers
  LEFT JOIN players ON keepers.player_id = players.player_id
  LEFT JOIN teams ON players.team_id = team.team_id
WHERE team_id = :team_id_input
ORDER BY keeper_minutes ASC ;
-- ;;
-- Penalties
-- :name read-penalties :? :*
-- :doc read all penalties
SELECT penalty_name, penalty_type
FROM penalties
ORDER BY penalty_name ;
-- ;;
-- Infractions
-- :name read-infractions :? :*
-- :doc read all infractions by a player
SELECT player_number, penalty_name, penalty_type
FROM infractions
  LEFT JOIN players ON infractions.player_id = players.player_id
  LEFT JOIN penalties ON infractions.penalty_id = penalties.penalty_id
WHERE player_id = :player_id_input
ORDER BY penalty_type ;
-- ;;

-- UPDATE Functionality

-- Session Name
-- :name update-session-name :! :n
-- :doc update session name with id
UPDATE sessions
SET session_name = :session_name_input
WHERE session_id = :session_id_input ;
-- ;;
-- Division Name
-- :name update-division-name :! :n
-- :doc update division name with id
UPDATE divisions
SET division_name = :division_name_input
WHERE divison_id = :division_id_input ;
-- ;;
-- Division Session
-- :name update-division-session :! :n
-- :doc update division session with id
UPDATE divisions
SET session_id = :session_id_input
WHERE division_id = :division_id_input ;
-- ;;
-- Team Name
-- :name update-team-name :! :n
-- :doc update team name with id
UPDATE teams
SET team_name = :team_name_input
WHERE team_id = :team_id_input ;
-- ;;
-- Team Win
-- :name update-team-win :! :n
-- :doc update team win with id
UPDATE teams
SET team_win = :team_win_input
WHERE team_id = :team_id_input ;
-- ;;
-- Team Loss
-- :name update-team-loss :! :n
-- :doc update team loss with id
UPDATE teams
SET team_loss = :team_loss_input
WHERE team_id = :team_id_input ;
-- ;;
-- Team Draw
-- :name update-team-draw :! :n
-- :doc update team draw with id
UPDATE teams
SET team_draw = :team_draw_input
WHERE team_id = :team_id_input ;
-- ;;
-- Team OTL
-- :name update-team-otl :! :n
-- :doc update team OTL with id
UPDATE teams
SET team_otl = :team_otl_input
WHERE team_id = :team_id_input ;
-- ;;
-- Team Division
-- :name update-team-division :! :*
-- :doc update team division with id
UPDATE teams
SET division_id = :division_id_input
WHERE team_id = :team_id_input ;
-- ;;
-- Player Firstname
-- :name update-player-firstname :! :n
-- :doc update player first name with id
UPDATE players
SET player_firstname = :player_firstname_input
WHERE player_id = :player_id_input ;
-- ;;
-- Player Lastname
-- :name update-player-lastname :! :n
-- :doc update player last name with id
UPDATE players
SET player_lastname = :player_lastname_input
WHERE player_id = :player_id_input ;
-- ;;
-- Player Number
-- :name update-player-number :! :n
-- :doc update player number with id
UPDATE players
SET player_number = :player_number_input
WHERE player_id = :player_id_input ;
-- ;;
-- Games Hometeam
-- :name update-game-hometeam :! :n
-- :doc update game hometeam with id
UPDATE games
SET hometeam_id = :hometeam_id_imput
WHERE game_id = :game_id_input ;
-- ;;
-- Games Awayteam
-- :name update-game-awayteam :! :n
-- :doc update game awayteam with id
UPDATE games
SET awayteam_id = :awayteam_id_input
WHERE game_id = :game_id_input ;
-- ;;
-- Games Timestamp
-- :name update-game-timestamp :! :n
-- :doc update game timestamp with id
UPDATE games
SET game_timestamp = :game_timestamp_input
WHERE game_id = :game_id_input ;
-- ;;
-- Goals Minute
-- :name update-goal-minute :! :n
-- :doc update goal minute with id
UPDATE goals
SET goal_minute = :goal_minute_input
WHERE goal_id = :goal_id_input ;
-- ;;
-- Goals Strength
-- :name update-goal-strength :! :n
-- :doc update goal strength with id
UPDATE goals
SET goal_strength = :goal_strength_input
WHERE goal_id = :goal_id_input ;
-- ;;
-- Keepers Saves
-- :name update-keeper-saves :! :n
-- :doc update keeper saves with id
UPDATE keepers
SET keeper_saves = :keeper_saves_input
WHERE keeper_id = :keeper_id_input ;
-- ;;
-- Keepers Minutes
-- :name update-keeper-minutes :! :n
-- :doc update keeper minutes with id
UPDATE keepers
SET keeper_minutes = :keeper_minutes_input
WHERE keeper_id = :keeper_id_input ;
-- ;;
-- Keepers Shotsagainst
-- :name update-keeper-shotsagainst :! :n
-- :doc update keeper shots against with id
UPDATE keepers
SET keeper_shotsagainst = :keeper_shotsagainst_input
WHERE keeper_id = :keeper_id_input;
-- ;;
-- Penalties Type
-- :name update-penalty-type :! :n
-- :doc update penalty type with id
UPDATE penalties
SET penalty_type = :penalty_type_input
WHERE penalty_id = :penalty_id_input ;
-- ;;
-- Penalties Severity
-- :name update-penalty-severity :! :n
-- :doc update penalty severity with id
UPDATE penalties
SET penalty_severity = :penalty_severity_input
WHERE penalty_id = :penalty_id_input ;
-- ;;
-- Infractions Penalty
-- :name update-infraction-penalty :! :n
-- :doc update infraction penalty with id
UPDATE infractions
SET penalty_id = :penalty_id_input
WHERE infraction_id = :infraction_id_input ;
-- ;;
-- Infractions Player
-- :name update-infraction-penalty :! :n
-- :doc update infraction penalty with id
UPDATE infractions
SET player_id = :player_id_input
WHERE infraction_id = :infraction_id_input ;
-- ;;

-- DELETE Functionality

-- Sessions
-- :name delete-session :! :n
-- :doc delete session by id
DELETE FROM sessions
WHERE session_id = :session_id_input ;
-- ;;
-- Divisions
-- :name delete-division :! :n
-- :doc delete division by id
DELETE FROM divisions
WHERE division_id = :division_id_input ;
-- ;;
-- Teams
-- :name delete-team :! :n
-- :doc delete team by id
DELETE FROM teams
WHERE team_id = :team_id_input ;
-- ;;
-- Players
-- :name delete-player :! :n
-- :doc delete player by id
DELETE FROM players
WHERE player_id = :player_id_input ;
-- ;;
-- Games
-- :name delete-game :! :n
-- :doc delete game by id
DELETE FROM games
WHERE game_id = :game_id_input ;
-- ;;
-- Goals
-- :name delete-goals :! :n
-- :doc delete goals by id
DELETE FROM goals
WHERE goal_id = :goal_id_input ;
-- ;;
-- Keepers
-- :name delete-keeper :! :n
-- :doc delete keeper by id
DELETE FROM keepers
WHERE keeper_id = :keeper_id_input ;
-- ;;
-- Penalties
-- :name delete-penalty :! :n
-- :doc delete penalty by id
DELETE FROM penalties
WHERE penalty_id = :penalty_id_input ;
-- ;;
-- Infractions
-- :name delete-infraction :! :n
-- :doc delete infraction by id
DELETE FROM infractions
WHERE infraction_id = :infraction_id_input ;
-- ;;
