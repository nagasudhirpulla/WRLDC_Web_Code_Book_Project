-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema Web_Code_Book_Project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Web_Code_Book_Project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Web_Code_Book_Project` DEFAULT CHARACTER SET utf8 ;
USE `Web_Code_Book_Project` ;

-- -----------------------------------------------------
-- Table `Web_Code_Book_Project`.`catagories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Web_Code_Book_Project`.`catagories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Web_Code_Book_Project`.`elements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Web_Code_Book_Project`.`elements` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Web_Code_Book_Project`.`codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Web_Code_Book_Project`.`codes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` INT NOT NULL,
  `description` VARCHAR(250) NULL,
  `element_id` INT NULL,
  `is_cancelled` BIT NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `category_id_idx` (`category_id` ASC),
  INDEX `element_id_idx` (`element_id` ASC),
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `Web_Code_Book_Project`.`catagories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `element_id`
    FOREIGN KEY (`element_id`)
    REFERENCES `Web_Code_Book_Project`.`elements` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Web_Code_Book_Project`.`rldcs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Web_Code_Book_Project`.`rldcs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Web_Code_Book_Project`.`optional_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Web_Code_Book_Project`.`optional_codes` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'unique - code_id, rldc_id',
  `code_id` INT NOT NULL,
  `rldc_id` INT NOT NULL,
  `code` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `code_id_idx` (`code_id` ASC),
  INDEX `rldc_id_idx` (`rldc_id` ASC),
  CONSTRAINT `code_id`
    FOREIGN KEY (`code_id`)
    REFERENCES `Web_Code_Book_Project`.`codes` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `rldc_id`
    FOREIGN KEY (`rldc_id`)
    REFERENCES `Web_Code_Book_Project`.`rldcs` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `uc_code_rldc_id` UNIQUE (`code_id`,`rldc_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Web_Code_Book_Project`.`times`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Web_Code_Book_Project`.`times` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code_id` INT NOT NULL,
  `time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `code_id_idx` (`code_id` ASC),
  CONSTRAINT `code_id1`
    FOREIGN KEY (`code_id`)
    REFERENCES `Web_Code_Book_Project`.`codes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
