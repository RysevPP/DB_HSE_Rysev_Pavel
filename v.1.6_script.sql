-- MySQL Script generated by MySQL Workbench
-- Sat Dec 16 20:09:44 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema university
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `university` DEFAULT CHARACTER SET utf8 ;
USE `university` ;

-- -----------------------------------------------------
-- Table `university`.`group`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`group` (
  `idgroup` INT NOT NULL AUTO_INCREMENT,
  `number` VARCHAR(45) NOT NULL,
  `yearadmission` DATE NOT NULL,
  `idelder` INT NULL,
  `direction` VARCHAR(45) NOT NULL,
  `specialization` VARCHAR(100) NOT NULL,
  UNIQUE INDEX `idgroup_UNIQUE` (`idgroup` ASC) VISIBLE,
  PRIMARY KEY (`idgroup`),
  UNIQUE INDEX `name_UNIQUE` (`number` ASC) VISIBLE,
  CONSTRAINT `FK_group_student`
    FOREIGN KEY (`idelder`)
    REFERENCES `university`.`student` (`idstud`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`department`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`department` (
  `iddep` INT NOT NULL AUTO_INCREMENT,
  `fullname` VARCHAR(200) NOT NULL,
  `shortname` VARCHAR(45) NOT NULL,
  `idheaddep` INT NULL,
  `office` INT NOT NULL,
  `tel` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`iddep`),
  UNIQUE INDEX `iddepartment_UNIQUE` (`iddep` ASC) VISIBLE,
  UNIQUE INDEX `fullname_UNIQUE` (`fullname` ASC) VISIBLE,
  UNIQUE INDEX `shortname_UNIQUE` (`shortname` ASC) VISIBLE,
  INDEX `FK_department_teacher_idx` (`idheaddep` ASC) VISIBLE,
  CONSTRAINT `FK_department_teacher`
    FOREIGN KEY (`idheaddep`)
    REFERENCES `university`.`teacher` (`idteacher`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`teacher`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`teacher` (
  `idteacher` INT NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `surname` VARCHAR(64) NOT NULL,
  `patronymic` VARCHAR(64) NULL,
  `birthday` DATE NOT NULL,
  `tel` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  `iddep` INT NULL,
  `office` INT NULL,
  `zip` INT NOT NULL,
  `region` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `street_house` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idteacher`),
  UNIQUE INDEX `idteacher_UNIQUE` (`idteacher` ASC) VISIBLE,
  INDEX `iddepartment_idx` (`iddep` ASC) VISIBLE,
  CONSTRAINT `FK_teacher_department`
    FOREIGN KEY (`iddep`)
    REFERENCES `university`.`department` (`iddep`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`faculty`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`faculty` (
  `idfaculty` INT NOT NULL AUTO_INCREMENT,
  `fullname` VARCHAR(200) NOT NULL,
  `shortname` VARCHAR(45) NOT NULL,
  `iddeanfaculty` INT NULL,
  `office` INT NOT NULL,
  `tel` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`idfaculty`),
  UNIQUE INDEX `idfaculty_UNIQUE` (`idfaculty` ASC) VISIBLE,
  UNIQUE INDEX `fullname_UNIQUE` (`fullname` ASC) VISIBLE,
  UNIQUE INDEX `shortname_UNIQUE` (`shortname` ASC) VISIBLE,
  INDEX `FK_faculty_teacher_idx` (`iddeanfaculty` ASC) VISIBLE,
  CONSTRAINT `FK_faculty_teacher`
    FOREIGN KEY (`iddeanfaculty`)
    REFERENCES `university`.`teacher` (`idteacher`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`student` (
  `idstud` INT NOT NULL,
  `name` VARCHAR(64) NOT NULL,
  `surname` VARCHAR(64) NOT NULL,
  `patronymic` VARCHAR(64) NULL,
  `birthday` DATE NOT NULL,
  `tel` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  `idgroup` INT NULL,
  `idfaculty` INT NULL,
  `zip` INT NOT NULL,
  `region` VARCHAR(45) NOT NULL,
  `district` VARCHAR(45) NULL,
  `city` VARCHAR(45) NOT NULL,
  `street_house` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`idstud`),
  UNIQUE INDEX `idstudent_UNIQUE` (`idstud` ASC) VISIBLE,
  INDEX `idgroup_idx` (`idgroup` ASC) VISIBLE,
  INDEX `idfaculty_idx` (`idfaculty` ASC) VISIBLE,
  CONSTRAINT `FK_student_group`
    FOREIGN KEY (`idgroup`)
    REFERENCES `university`.`group` (`idgroup`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_student_faculty`
    FOREIGN KEY (`idfaculty`)
    REFERENCES `university`.`faculty` (`idfaculty`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`subject`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`subject` (
  `idsubject` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(120) NOT NULL,
  `category` VARCHAR(64) NOT NULL,
  `idteacher` INT NULL,
  PRIMARY KEY (`idsubject`),
  UNIQUE INDEX `idsubject_UNIQUE` (`idsubject` ASC) VISIBLE,
  INDEX `idteacher_idx` (`idteacher` ASC) VISIBLE,
  CONSTRAINT `FK_subject_teacher`
    FOREIGN KEY (`idteacher`)
    REFERENCES `university`.`teacher` (`idteacher`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `university`.`assessment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `university`.`assessment` (
  `idassessment` INT NOT NULL AUTO_INCREMENT,
  `assessment` INT NULL,
  `offset` VARCHAR(20) NULL,
  `date` DATE NOT NULL,
  `idstud` INT NULL,
  `idteacher` INT NULL,
  `idsubject` INT NULL,
  PRIMARY KEY (`idassessment`),
  UNIQUE INDEX `idassessment_UNIQUE` (`idassessment` ASC) VISIBLE,
  INDEX `idstudent_idx` (`idstud` ASC) VISIBLE,
  INDEX `idteacher_idx` (`idteacher` ASC) VISIBLE,
  INDEX `idsubject_idx` (`idsubject` ASC) VISIBLE,
  CONSTRAINT `FK_assessment_student`
    FOREIGN KEY (`idstud`)
    REFERENCES `university`.`student` (`idstud`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_assessment_teacher`
    FOREIGN KEY (`idteacher`)
    REFERENCES `university`.`teacher` (`idteacher`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `FK_assessment_subject`
    FOREIGN KEY (`idsubject`)
    REFERENCES `university`.`subject` (`idsubject`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
KEY_BLOCK_SIZE = 1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;