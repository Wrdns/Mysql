-- MySQL Script generated by MySQL Workbench
-- Sat Dec 17 19:47:27 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`groups`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`groups` (
  `groupid` INT NOT NULL,
  `date` DATE NOT NULL,
  `persnumber` INT NOT NULL,
  PRIMARY KEY (`groupid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`student`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`student` (
  `StID` INT NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  `btdate` DATE NOT NULL,
  `sex` VARCHAR(8) NOT NULL,
  `passeria` VARCHAR(5) NOT NULL,
  `passnumber` VARCHAR(7) NOT NULL,
  `issued` VARCHAR(100) NOT NULL,
  `registration` VARCHAR(100) NOT NULL,
  `number` VARCHAR(20) NOT NULL,
  `groupfk` INT NOT NULL,
  PRIMARY KEY (`StID`, `groupfk`),
  INDEX `fk_Ученики_Группы1_idx` (`groupfk` ASC) VISIBLE,
  CONSTRAINT `fk_Ученики_Группы1`
    FOREIGN KEY (`groupfk`)
    REFERENCES `mydb`.`groups` (`groupid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`administration`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`administration` (
  `admid` INT NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  `dtdate` DATE NOT NULL,
  `sex` VARCHAR(8) NOT NULL,
  `passeria` VARCHAR(5) NOT NULL,
  `passnumber` VARCHAR(7) NOT NULL,
  `issued` VARCHAR(100) NOT NULL,
  `registration` VARCHAR(100) NOT NULL,
  `number` VARCHAR(20) NOT NULL,
  `post` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`admid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`cars`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`cars` (
  `carid` INT NOT NULL AUTO_INCREMENT,
  `vendor` TEXT(20) NOT NULL,
  `model` TEXT(20) NOT NULL,
  `btdate` YEAR NOT NULL,
  `transmission` TEXT(20) NOT NULL,
  `engcap` FLOAT NOT NULL,
  `wheelloc` TEXT(10) NOT NULL,
  `body` TEXT(10) NOT NULL,
  `doornumb` SMALLINT(1) NOT NULL,
  `regnumb` VARCHAR(6) NOT NULL,
  `regnumbreg` VARCHAR(3) NOT NULL,
  PRIMARY KEY (`carid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`instructors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`instructors` (
  `mpovid` INT NOT NULL AUTO_INCREMENT,
  `lastname` VARCHAR(45) NOT NULL,
  `firstname` VARCHAR(45) NOT NULL,
  `patronymic` VARCHAR(45) NULL,
  `dtdate` VARCHAR(10) NOT NULL,
  `sex` VARCHAR(8) NOT NULL,
  `passeria` VARCHAR(5) NOT NULL,
  `passnumber` VARCHAR(7) NOT NULL,
  `issued` VARCHAR(100) NOT NULL,
  `registration` VARCHAR(100) NOT NULL,
  `number` VARCHAR(20) NOT NULL,
  `post` VARCHAR(20) NOT NULL,
  `administratorsfk` INT NOT NULL,
  `carfk` INT NOT NULL,
  PRIMARY KEY (`mpovid`, `administratorsfk`, `carfk`),
  INDEX `fk_МПОВ_Администрация1_idx` (`administratorsfk` ASC) VISIBLE,
  INDEX `fk_instructors_cars1_idx` (`carfk` ASC) VISIBLE,
  CONSTRAINT `fk_МПОВ_Администрация1`
    FOREIGN KEY (`administratorsfk`)
    REFERENCES `mydb`.`administration` (`admid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_instructors_cars1`
    FOREIGN KEY (`carfk`)
    REFERENCES `mydb`.`cars` (`carid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`payed`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`payed` (
  `payid` INT NOT NULL AUTO_INCREMENT,
  `paydate` DATETIME(6) NOT NULL,
  `paysize` SMALLINT(6) NOT NULL,
  `studentfk` INT NOT NULL,
  PRIMARY KEY (`payid`, `studentfk`),
  INDEX `fk_Учет оплаты_Ученики1_idx` (`studentfk` ASC) VISIBLE,
  CONSTRAINT `fk_Учет оплаты_Ученики1`
    FOREIGN KEY (`studentfk`)
    REFERENCES `mydb`.`student` (`StID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paycode`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paycode` (
  `paycodeid` INT NOT NULL,
  `payname` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paycodeid`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`needpay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`needpay` (
  `selpayid` INT NOT NULL AUTO_INCREMENT,
  `selpaysize` SMALLINT(6) NOT NULL,
  `studentfk` INT NOT NULL,
  `paycodefk` INT NOT NULL,
  PRIMARY KEY (`selpayid`, `studentfk`, `paycodefk`),
  INDEX `fk_Назначение платежа_Ученики1_idx` (`studentfk` ASC) VISIBLE,
  INDEX `fk_требование платежа_коды1_idx` (`paycodefk` ASC) VISIBLE,
  CONSTRAINT `fk_Назначение платежа_Ученики1`
    FOREIGN KEY (`studentfk`)
    REFERENCES `mydb`.`student` (`StID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_требование платежа_коды1`
    FOREIGN KEY (`paycodefk`)
    REFERENCES `mydb`.`paycode` (`paycodeid`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`lesinf`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`lesinf` (
  `idlesinf` INT NOT NULL AUTO_INCREMENT,
  `lesstype` VARCHAR(20) NOT NULL,
  `lessdate` VARCHAR(15) NOT NULL,
  `place` VARCHAR(45) NOT NULL,
  `student_StID` INT NOT NULL,
  `student_groupfk` INT NOT NULL,
  `instructors_mpovid` INT NOT NULL,
  `instructors_administratorsfk` INT NOT NULL,
  `instructors_carfk` INT NOT NULL,
  PRIMARY KEY (`idlesinf`, `student_StID`, `student_groupfk`, `instructors_carfk`, `instructors_mpovid`),
  INDEX `fk_lesinf_student1_idx` (`student_StID` ASC, `student_groupfk` ASC) VISIBLE,
  INDEX `fk_lesinf_instructors1_idx` (`instructors_mpovid` ASC, `instructors_administratorsfk` ASC, `instructors_carfk` ASC) VISIBLE,
  CONSTRAINT `fk_lesinf_student1`
    FOREIGN KEY (`student_StID` , `student_groupfk`)
    REFERENCES `mydb`.`student` (`StID` , `groupfk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lesinf_instructors1`
    FOREIGN KEY (`instructors_mpovid` , `instructors_administratorsfk` , `instructors_carfk`)
    REFERENCES `mydb`.`instructors` (`mpovid` , `administratorsfk` , `carfk`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
