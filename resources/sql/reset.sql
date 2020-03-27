-- PostgreSQL re-play reset-db.sql
-- Tobias Hodges for Indoor Goals

-- Flush existing schemas with the given names.
--DROP SCHEMA IF EXISTS operator ;

-- Flush existing tables with the given names.
DROP TABLE IF EXISTS infractions ;
-- ;;
DROP TABLE IF EXISTS penalties ;
-- ;;
DROP TABLE IF EXISTS keepers ;
-- ;;
DROP TABLE IF EXISTS goals ;
-- ;;
DROP TABLE IF EXISTS games ;
-- ;;
DROP TABLE IF EXISTS players ;
-- ;;
DROP TABLE IF EXISTS teams ;
-- ;;
DROP TABLE IF EXISTS divisions ;
-- ;;
DROP TABLE IF EXISTS sessions ;
-- ;;

-- Flush existing types with the given names.
DROP TYPE IF EXISTS strength ;
-- ;;
DROP TYPE IF EXISTS severity ;
-- ;;
