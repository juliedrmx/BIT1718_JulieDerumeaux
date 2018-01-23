-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`gene` (
  `idgene` INT NOT NULL,
  `gene_description` VARCHAR(45) NULL,
  PRIMARY KEY (`idgene`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mutations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mutations` (
  `idmutations` INT NOT NULL,
  `gene_name` VARCHAR(45) NULL,
  `start` VARCHAR(45) NULL,
  `end` VARCHAR(45) NULL,
  `chromosome` VARCHAR(45) NULL,
  `gene_id` INT NOT NULL,
  PRIMARY KEY (`idmutations`, `gene_id`),
  INDEX `fk_mutations_gene1_idx` (`gene_id` ASC),
  CONSTRAINT `mutations_gene`
    FOREIGN KEY (`gene_id`)
    REFERENCES `mydb`.`gene` (`idgene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`patient` (
  `idpatient` INT NOT NULL,
  `patient_name` VARCHAR(45) NULL,
  `patient_syndrome` VARCHAR(45) NULL,
  `patient_gender` ENUM('Female', 'Male') NULL,
  `patient_age_at_diagnosis` DATE NULL,
  PRIMARY KEY (`idpatient`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`syndrome` (
  `idsyndrome` INT NOT NULL,
  `syndrome_description` VARCHAR(45) NULL,
  `idpatient` INT NOT NULL,
  PRIMARY KEY (`idsyndrome`, `idpatient`),
  INDEX `fk_syndrome_patient1_idx` (`idpatient` ASC),
  CONSTRAINT `syndrome_patient`
    FOREIGN KEY (`idpatient`)
    REFERENCES `mydb`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mutations_patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mutations_patient` (
  `idmutations` INT NOT NULL,
  `idpatient` INT NOT NULL,
  PRIMARY KEY (`idmutations`, `idpatient`),
  INDEX `fk_mutations_has_patient_patient1_idx` (`idpatient` ASC),
  INDEX `fk_mutations_has_patient_mutations_idx` (`idmutations` ASC),
  CONSTRAINT `patient_mutations`
    FOREIGN KEY (`idmutations`)
    REFERENCES `mydb`.`mutations` (`idmutations`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `mutationsID`
    FOREIGN KEY (`idpatient`)
    REFERENCES `mydb`.`patient` (`idpatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
