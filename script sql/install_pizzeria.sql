SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Pizzeria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pizzeria` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pizzeria` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(25) NULL,
  `adresse` VARCHAR(45) NULL,
  `no_telephone` VARCHAR(20) NULL,
  `mot_de_passe` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Type` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Type` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `pizzeria _id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_pizzeria_idx` (`pizzeria _id` ASC),
  CONSTRAINT `fk_pizzeria`
    FOREIGN KEY (`pizzeria _id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pizza`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Pizza` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Pizza` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(25) NULL,
  `type_id` INT NOT NULL,
  `pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`id`, `type_id`, `pizzeria_id`),
  INDEX `fk_Pizza_Taille1_idx` (`type_id` ASC),
  INDEX `fk_Pizza_Pizzeria1_idx` (`pizzeria_id` ASC),
  CONSTRAINT `fk_Pizza_Taille1`
    FOREIGN KEY (`type_id`)
    REFERENCES `mydb`.`Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_Pizzeria1`
    FOREIGN KEY (`pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Client`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Client` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Client` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `Pizzeria_id` INT NOT NULL,
  `nom` VARCHAR(25) NULL,
  `prenom` VARCHAR(25) NULL,
  `mot_de_passe` VARCHAR(45) NULL,
  `adresse` VARCHAR(45) NULL,
  `no_telephone` VARCHAR(20) NULL,
  `email` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Client_Pizzeria1_idx` (`Pizzeria_id` ASC),
  CONSTRAINT `fk_Client_Pizzeria1`
    FOREIGN KEY (`Pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Commande` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Commande` (
  `id` INT NOT NULL,
  `no_commande` INT NOT NULL,
  `Client_id` INT NOT NULL,
  `Pizza_id` INT NOT NULL,
  `Pizzeria_id` INT NOT NULL,
  `date_commande` DATETIME NOT NULL,
  `heure_livraison` TIME NULL,
  `livraison` TINYINT(1) NULL,
  PRIMARY KEY (`id`, `Client_id`, `Pizza_id`, `Pizzeria_id`),
  INDEX `fk_Client_has_Pizza_Pizza1_idx` (`Pizza_id` ASC, `Pizzeria_id` ASC),
  INDEX `fk_Client_has_Pizza_Client1_idx` (`Client_id` ASC),
  CONSTRAINT `fk_Client_has_Pizza_Client1`
    FOREIGN KEY (`Client_id`)
    REFERENCES `mydb`.`Client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Client_has_Pizza_Pizza1`
    FOREIGN KEY (`Pizza_id` , `Pizzeria_id`)
    REFERENCES `mydb`.`Pizza` (`id` , `pizzeria_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Categorie`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Categorie` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Categorie` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Ingredients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Ingredients` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Ingredients` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `Categorie_id` INT NOT NULL,
  `Pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Categorie_id`, `Pizzeria_id`),
  INDEX `fk_Integredients_Categorie1_idx` (`Categorie_id` ASC),
  INDEX `fk_Ingredients_Pizzeria1_idx` (`Pizzeria_id` ASC),
  CONSTRAINT `fk_Integredients_Categorie1`
    FOREIGN KEY (`Categorie_id`)
    REFERENCES `mydb`.`Categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Ingredients_Pizzeria1`
    FOREIGN KEY (`Pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Composition`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Composition` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Composition` (
  `Pizza_id` INT NOT NULL,
  `Integredients_id` INT NOT NULL,
  PRIMARY KEY (`Pizza_id`, `Integredients_id`),
  INDEX `fk_Pizza_has_Integredients_Integredients1_idx` (`Integredients_id` ASC),
  INDEX `fk_Pizza_has_Integredients_Pizza1_idx` (`Pizza_id` ASC),
  CONSTRAINT `fk_Pizza_has_Integredients_Pizza1`
    FOREIGN KEY (`Pizza_id`)
    REFERENCES `mydb`.`Pizza` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pizza_has_Integredients_Integredients1`
    FOREIGN KEY (`Integredients_id`)
    REFERENCES `mydb`.`Ingredients` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historique_commande`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Historique_commande` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Historique_commande` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_histo` DATETIME NOT NULL,
  `no_commande` INT NOT NULL,
  `date_commande` DATETIME NULL,
  `client_id` INT NOT NULL,
  `pizzeria_id` INT NOT NULL,
  `livraison` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`, `date_histo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Erreurs`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Erreurs` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Erreurs` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `erreur` VARCHAR(255) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Produits`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Produits` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Produits` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nom` VARCHAR(45) NULL,
  `Categorie_id` INT NOT NULL,
  `Pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`id`, `Categorie_id`, `Pizzeria_id`),
  INDEX `fk_Produits_Categorie1_idx` (`Categorie_id` ASC),
  INDEX `fk_Produits_Pizzeria1_idx` (`Pizzeria_id` ASC),
  CONSTRAINT `fk_Produits_Categorie1`
    FOREIGN KEY (`Categorie_id`)
    REFERENCES `mydb`.`Categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Produits_Pizzeria1`
    FOREIGN KEY (`Pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Commande_Extra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Commande_Extra` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Commande_Extra` (
  `Commande_id` INT NOT NULL,
  `Produits_id` INT NOT NULL,
  PRIMARY KEY (`Commande_id`, `Produits_id`),
  INDEX `fk_Commande_has_Produits_Produits1_idx` (`Produits_id` ASC),
  INDEX `fk_Commande_has_Produits_Commande1_idx` (`Commande_id` ASC),
  CONSTRAINT `fk_Commande_has_Produits_Commande1`
    FOREIGN KEY (`Commande_id`)
    REFERENCES `mydb`.`Commande` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Commande_has_Produits_Produits1`
    FOREIGN KEY (`Produits_id`)
    REFERENCES `mydb`.`Produits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Archive`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Archive` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Archive` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `date_archive` DATETIME NULL,
  `no_commande` INT NULL,
  `date_commande` DATETIME NULL,
  `client_id` INT NULL,
  `pizzeria_id` INT NULL,
  `livraison` TINYINT(1) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prix`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`Prix` ;

CREATE TABLE IF NOT EXISTS `mydb`.`Prix` (
  `idprix` INT NOT NULL,
  `prix` DECIMAL(10,0) NULL,
  `Produits_id` INT NULL,
  `Categorie_id` INT NULL,
  `Ingredients_id` INT NULL,
  `Ingredients_Categorie_id` INT NULL,
  `Type_id` INT NULL,
  `Pizzeria_id` INT NOT NULL,
  PRIMARY KEY (`idprix`, `Pizzeria_id`),
  INDEX `fk_prix_Produits1_idx` (`Produits_id` ASC),
  INDEX `fk_prix_Categorie1_idx` (`Categorie_id` ASC),
  INDEX `fk_prix_Ingredients1_idx` (`Ingredients_id` ASC, `Ingredients_Categorie_id` ASC),
  INDEX `fk_prix_Type1_idx` (`Type_id` ASC),
  INDEX `fk_prix_Pizzeria1_idx` (`Pizzeria_id` ASC),
  CONSTRAINT `fk_prix_Produits1`
    FOREIGN KEY (`Produits_id`)
    REFERENCES `mydb`.`Produits` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prix_Categorie1`
    FOREIGN KEY (`Categorie_id`)
    REFERENCES `mydb`.`Categorie` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prix_Ingredients1`
    FOREIGN KEY (`Ingredients_id` , `Ingredients_Categorie_id`)
    REFERENCES `mydb`.`Ingredients` (`id` , `Categorie_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prix_Type1`
    FOREIGN KEY (`Type_id`)
    REFERENCES `mydb`.`Type` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_prix_Pizzeria1`
    FOREIGN KEY (`Pizzeria_id`)
    REFERENCES `mydb`.`Pizzeria` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
