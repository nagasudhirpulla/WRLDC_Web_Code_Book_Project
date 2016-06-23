-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema wrldc_web_code_book_project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema wrldc_web_code_book_project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `wrldc_web_code_book_project` DEFAULT CHARACTER SET utf8 ;
USE `wrldc_web_code_book_project` ;

-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`catagories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`catagories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`elements`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`elements` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`codes` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `time` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `category_id` INT NOT NULL,
  `description` VARCHAR(250) NULL,
  `element_id` INT NULL,
  `is_cancelled` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `category_id_idx` (`category_id` ASC),
  INDEX `element_id_idx` (`element_id` ASC),
  CONSTRAINT `category_id`
    FOREIGN KEY (`category_id`)
    REFERENCES `wrldc_web_code_book_project`.`catagories` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `element_id`
    FOREIGN KEY (`element_id`)
    REFERENCES `wrldc_web_code_book_project`.`elements` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`rldcs`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`rldcs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`optional_codes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`optional_codes` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'unique - code_id, rldc_id',
  `code_id` INT NOT NULL,
  `rldc_id` INT NOT NULL,
  `code` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `code_id_idx` (`code_id` ASC),
  INDEX `rldc_id_idx` (`rldc_id` ASC),
  CONSTRAINT `code_id`
    FOREIGN KEY (`code_id`)
    REFERENCES `wrldc_web_code_book_project`.`codes` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `rldc_id`
    FOREIGN KEY (`rldc_id`)
    REFERENCES `wrldc_web_code_book_project`.`rldcs` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`times`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`times` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `code_id` INT NOT NULL,
  `time` DATETIME NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `code_id_idx` (`code_id` ASC),
  CONSTRAINT `code_id1`
    FOREIGN KEY (`code_id`)
    REFERENCES `wrldc_web_code_book_project`.`codes` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`regions`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`regions` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`entities`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`entities` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `region_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  INDEX `region_id_idx` (`region_id` ASC),
  CONSTRAINT `region_id`
    FOREIGN KEY (`region_id`)
    REFERENCES `wrldc_web_code_book_project`.`regions` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`associates`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`associates` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Unique element_id, entity_id',
  `element_id` INT NOT NULL,
  `entity_id` INT NOT NULL,
  `is_availed_by` TINYINT(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  INDEX `element_id_idx` (`element_id` ASC),
  INDEX `entity_id_idx` (`entity_id` ASC),
  CONSTRAINT `element_id1`
    FOREIGN KEY (`element_id`)
    REFERENCES `wrldc_web_code_book_project`.`elements` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `entity_id`
    FOREIGN KEY (`entity_id`)
    REFERENCES `wrldc_web_code_book_project`.`entities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `wrldc_web_code_book_project`.`code_requests`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `wrldc_web_code_book_project`.`code_requests` (
  `id` INT NOT NULL AUTO_INCREMENT COMMENT 'Unique code_id,entity_id',
  `entity_id` INT NOT NULL,
  `code_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `code_id2_idx` (`code_id` ASC),
  INDEX `entity_id1_idx` (`entity_id` ASC),
  CONSTRAINT `entity_id1`
    FOREIGN KEY (`entity_id`)
    REFERENCES `wrldc_web_code_book_project`.`entities` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `code_id2`
    FOREIGN KEY (`code_id`)
    REFERENCES `wrldc_web_code_book_project`.`codes` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
