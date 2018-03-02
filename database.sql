-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema kida
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema kida
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `kida` DEFAULT CHARACTER SET utf8 ;
USE `kida` ;

-- -----------------------------------------------------
-- Table `kida`.`catalogSurveyType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`catalogSurveyType` ;

CREATE TABLE IF NOT EXISTS `kida`.`catalogSurveyType` (
  `idCatalogSurveyType` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `icon` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idCatalogSurveyType`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`catalog_choice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`catalog_choice` ;

CREATE TABLE IF NOT EXISTS `kida`.`catalog_choice` (
  `idCatalogChoice` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idCatalogChoice`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`catalog_surveys`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`catalog_surveys` ;

CREATE TABLE IF NOT EXISTS `kida`.`catalog_surveys` (
  `idCatalogSurvey` INT(11) NOT NULL AUTO_INCREMENT,
  `typeName` VARCHAR(50) NOT NULL,
  `status` TINYINT(1) NOT NULL,
  `catalogSurveyType_idCatalogSurveyType` INT(11) NOT NULL,
  PRIMARY KEY (`idCatalogSurvey`),
  INDEX `fk_catalog_surveys_catalogSurveyType1_idx` (`catalogSurveyType_idCatalogSurveyType` ASC),
  CONSTRAINT `fk_catalog_surveys_catalogSurveyType1`
    FOREIGN KEY (`catalogSurveyType_idCatalogSurveyType`)
    REFERENCES `kida`.`catalogSurveyType` (`idCatalogSurveyType`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`user` ;

CREATE TABLE IF NOT EXISTS `kida`.`user` (
  `idUser` INT(11) NOT NULL AUTO_INCREMENT,
  `uuid` CHAR(36) NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`idUser`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`form`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`form` ;

CREATE TABLE IF NOT EXISTS `kida`.`form` (
  `idForm` INT(11) NOT NULL AUTO_INCREMENT,
  `idFormVersion` INT(11) NOT NULL,
  `name` VARCHAR(50) NOT NULL,
  `uuid` CHAR(36) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `editedAt` DATETIME NOT NULL,
  `deleted` TINYINT(1) NOT NULL,
  `user_idUser` INT(11) NOT NULL,
  PRIMARY KEY (`idForm`),
  INDEX `fk_form_user1_idx` (`user_idUser` ASC),
  CONSTRAINT `fk_form_user1`
    FOREIGN KEY (`user_idUser`)
    REFERENCES `kida`.`user` (`idUser`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`form_version`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`form_version` ;

CREATE TABLE IF NOT EXISTS `kida`.`form_version` (
  `idFormVersion` INT(11) NOT NULL AUTO_INCREMENT,
  `form_idForm` INT(11) NOT NULL,
  PRIMARY KEY (`idFormVersion`),
  INDEX `fk_form_version_form1_idx` (`form_idForm` ASC),
  CONSTRAINT `fk_form_version_form1`
    FOREIGN KEY (`form_idForm`)
    REFERENCES `kida`.`form` (`idForm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`survey`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`survey` ;

CREATE TABLE IF NOT EXISTS `kida`.`survey` (
  `idSurvey` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `caption` TEXT NOT NULL,
  `hint` VARCHAR(50) NOT NULL,
  `defaultKey` TEXT NOT NULL,
  `required` TINYINT(1) NOT NULL,
  `relevance` VARCHAR(50) NOT NULL,
  `filterKey` VARCHAR(50) NOT NULL,
  `relevanceValue` TEXT NOT NULL,
  `filterValue` TEXT NOT NULL,
  `form_idForm` INT(11) NOT NULL,
  `form_version_idFormVersion` INT(11) NOT NULL,
  `catalog_surveys_idCatalogSurvey` INT(11) NOT NULL,
  PRIMARY KEY (`idSurvey`),
  INDEX `fk_survey_form1_idx` (`form_idForm` ASC),
  INDEX `fk_survey_form_version1_idx` (`form_version_idFormVersion` ASC),
  INDEX `fk_survey_catalog_surveys1_idx` (`catalog_surveys_idCatalogSurvey` ASC),
  CONSTRAINT `fk_survey_form1`
    FOREIGN KEY (`form_idForm`)
    REFERENCES `kida`.`form` (`idForm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_survey_form_version1`
    FOREIGN KEY (`form_version_idFormVersion`)
    REFERENCES `kida`.`form_version` (`idFormVersion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_survey_catalog_surveys1`
    FOREIGN KEY (`catalog_surveys_idCatalogSurvey`)
    REFERENCES `kida`.`catalog_surveys` (`idCatalogSurvey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`choice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`choice` ;

CREATE TABLE IF NOT EXISTS `kida`.`choice` (
  `idChoice` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NOT NULL,
  `caption` TEXT NOT NULL,
  `media` TEXT NOT NULL,
  `survey_idSurvey` INT(11) NOT NULL,
  `catalog_choice_idCatalogChoice` INT(11) NOT NULL,
  PRIMARY KEY (`idChoice`),
  INDEX `fk_choice_survey1_idx` (`survey_idSurvey` ASC),
  INDEX `fk_choice_catalog_choice1_idx` (`catalog_choice_idCatalogChoice` ASC),
  CONSTRAINT `fk_choice_survey1`
    FOREIGN KEY (`survey_idSurvey`)
    REFERENCES `kida`.`survey` (`idSurvey`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_choice_catalog_choice1`
    FOREIGN KEY (`catalog_choice_idCatalogChoice`)
    REFERENCES `kida`.`catalog_choice` (`idCatalogChoice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`permission`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`permission` ;

CREATE TABLE IF NOT EXISTS `kida`.`permission` (
  `form_idForm` INT(11) NOT NULL,
  PRIMARY KEY (`form_idForm`),
  CONSTRAINT `fk_permission_form1`
    FOREIGN KEY (`form_idForm`)
    REFERENCES `kida`.`form` (`idForm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`response`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`response` ;

CREATE TABLE IF NOT EXISTS `kida`.`response` (
  `idResponse` INT(11) NOT NULL AUTO_INCREMENT,
  `form_idForm` INT(11) NOT NULL,
  PRIMARY KEY (`idResponse`),
  INDEX `fk_response_form1_idx` (`form_idForm` ASC),
  CONSTRAINT `fk_response_form1`
    FOREIGN KEY (`form_idForm`)
    REFERENCES `kida`.`form` (`idForm`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `kida`.`response_choice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `kida`.`response_choice` ;

CREATE TABLE IF NOT EXISTS `kida`.`response_choice` (
  `idResponseChoice` INT(11) NOT NULL AUTO_INCREMENT,
  `value` JSON NOT NULL,
  `response_idResponse` INT(11) NOT NULL,
  `choice_idChoice` INT(11) NOT NULL,
  PRIMARY KEY (`idResponseChoice`),
  INDEX `fk_response_choice_response1_idx` (`response_idResponse` ASC),
  INDEX `fk_response_choice_choice1_idx` (`choice_idChoice` ASC),
  CONSTRAINT `fk_response_choice_response1`
    FOREIGN KEY (`response_idResponse`)
    REFERENCES `kida`.`response` (`idResponse`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_response_choice_choice1`
    FOREIGN KEY (`choice_idChoice`)
    REFERENCES `kida`.`choice` (`idChoice`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
