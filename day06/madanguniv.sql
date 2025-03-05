-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema madanguniv
-- -----------------------------------------------------
-- 마당대학교 모델링

-- -----------------------------------------------------
-- Schema madanguniv
--
-- 마당대학교 모델링
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `madanguniv` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci ;
USE `madanguniv` ;

-- -----------------------------------------------------
-- Table `madanguniv`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`Professor` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `age` INT NULL,
  `rank` VARCHAR(20) NOT NULL,
  `speciality` VARCHAR(40) NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`Dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`Dept` (
  `dno` INT NOT NULL,
  `dname` VARCHAR(45) NOT NULL,
  `office` VARCHAR(45) NULL,
  `runProfessorssn` INT NOT NULL,
  PRIMARY KEY (`dno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`Graduate`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`Graduate` (
  `ssn` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `age` INT NULL,
  `deg_grog` VARCHAR(45) NULL,
  `dno` INT NOT NULL,
  `graduatessn` INT NOT NULL,
  PRIMARY KEY (`ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`Project`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`Project` (
  `pid` INT NOT NULL,
  `pname` VARCHAR(50) NOT NULL,
  `sponsor` VARCHAR(45) NULL,
  `start_date` DATE NULL,
  `end_date` DATE NULL,
  `budget` INT NULL,
  `managessn` INT NOT NULL,
  PRIMARY KEY (`pid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`work_dept`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`work_dept` (
  `pct_time` INT NOT NULL COMMENT '교수참여백분율',
  `Professor_ssn` INT NOT NULL,
  `dno` INT NOT NULL,
  PRIMARY KEY (`Professor_ssn`, `dno`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`work_in`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`work_in` (
  `professorssn` INT NOT NULL,
  `pid` INT NOT NULL,
  PRIMARY KEY (`professorssn`, `pid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `madanguniv`.`work_prog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `madanguniv`.`work_prog` (
  `pid` INT NOT NULL,
  `graduatessn` INT NOT NULL,
  PRIMARY KEY (`pid`, `graduatessn`))
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
