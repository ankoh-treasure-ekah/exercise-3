-- MySQL Script generated by MySQL Workbench
-- Wed Sep  6 14:39:50 2023
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
-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema restaurant
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `restaurant` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`category` (
  `category_id` INT NOT NULL,
  `name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`category_id`));

USE `restaurant` ;

-- -----------------------------------------------------
-- Table `restaurant`.`address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`address` (
  `city` VARCHAR(25) NULL DEFAULT NULL,
  `town` VARCHAR(25) NULL DEFAULT NULL,
  `quarter` VARCHAR(25) NULL DEFAULT NULL,
  `address_id` INT NOT NULL,
  PRIMARY KEY (`address_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`customers`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`customers` (
  `customer_id` INT NOT NULL,
  `first_name` VARCHAR(25) NULL DEFAULT NULL,
  `last_name` VARCHAR(25) NULL DEFAULT NULL,
  `address_address_id` INT NOT NULL,
  PRIMARY KEY (`customer_id`, `address_address_id`),
  INDEX `fk_customers_address1_idx` (`address_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_customers_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `restaurant`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`transer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`transer` (
  `transfer_date` DATE NULL DEFAULT NULL,
  `delivered_Date` DATE NULL DEFAULT NULL,
  `transfer_id` INT NOT NULL,
  PRIMARY KEY (`transfer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`orders` (
  `order_id` INT NOT NULL AUTO_INCREMENT,
  `customer` VARCHAR(25) NULL DEFAULT NULL,
  `waiter` VARCHAR(25) NULL DEFAULT NULL,
  `dishes` VARCHAR(25) NULL DEFAULT NULL,
  `customers_customer_id` INT NOT NULL,
  `customers_address_address_id` INT NOT NULL,
  PRIMARY KEY (`order_id`, `customers_customer_id`, `customers_address_address_id`),
  INDEX `fk_orders_customers1_idx` (`customers_customer_id` ASC, `customers_address_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_orders_customers1`
    FOREIGN KEY (`customers_customer_id` , `customers_address_address_id`)
    REFERENCES `restaurant`.`customers` (`customer_id` , `address_address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`dish`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`dish` (
  `name` VARCHAR(25) NULL DEFAULT NULL,
  `description` VARCHAR(25) NULL DEFAULT NULL,
  `category` VARCHAR(25) NULL DEFAULT NULL,
  `price` INT NULL DEFAULT NULL,
  `serial_number` INT NOT NULL,
  `prepared_date` DATE NULL DEFAULT NULL,
  `served_date` DATE NULL DEFAULT NULL,
  `transfered_date` DATE NULL DEFAULT NULL,
  `transer_transfer_id` INT NOT NULL,
  `orders_order_id` INT NOT NULL,
  `orders_customers_customer_id` INT NOT NULL,
  `orders_customers_address_address_id` INT NOT NULL,
  `category_category_id` INT NOT NULL,
  PRIMARY KEY (`serial_number`, `transer_transfer_id`, `orders_order_id`, `orders_customers_customer_id`, `orders_customers_address_address_id`, `category_category_id`),
  INDEX `fk_dish_transer1_idx` (`transer_transfer_id` ASC) VISIBLE,
  INDEX `fk_dish_orders1_idx` (`orders_order_id` ASC, `orders_customers_customer_id` ASC, `orders_customers_address_address_id` ASC) VISIBLE,
  INDEX `fk_dish_category1_idx` (`category_category_id` ASC) VISIBLE,
  CONSTRAINT `fk_dish_transer1`
    FOREIGN KEY (`transer_transfer_id`)
    REFERENCES `restaurant`.`transer` (`transfer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dish_orders1`
    FOREIGN KEY (`orders_order_id` , `orders_customers_customer_id` , `orders_customers_address_address_id`)
    REFERENCES `restaurant`.`orders` (`order_id` , `customers_customer_id` , `customers_address_address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_dish_category1`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `mydb`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`restaurant`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`restaurant` (
  `restaurant_id` INT NOT NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `restaurant`.`waiters`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `restaurant`.`waiters` (
  `waiter_id` INT NOT NULL AUTO_INCREMENT,
  `surname` VARCHAR(25) NULL DEFAULT NULL,
  `first_name` VARCHAR(25) NULL DEFAULT NULL,
  `fixed_salary` INT NULL DEFAULT NULL,
  `restaurant_restaurant_id` INT NOT NULL,
  `address_address_id` INT NOT NULL,
  PRIMARY KEY (`waiter_id`, `restaurant_restaurant_id`, `address_address_id`),
  INDEX `fk_waiters_restaurant1_idx` (`restaurant_restaurant_id` ASC) VISIBLE,
  INDEX `fk_waiters_address1_idx` (`address_address_id` ASC) VISIBLE,
  CONSTRAINT `fk_waiters_restaurant1`
    FOREIGN KEY (`restaurant_restaurant_id`)
    REFERENCES `restaurant`.`restaurant` (`restaurant_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_waiters_address1`
    FOREIGN KEY (`address_address_id`)
    REFERENCES `restaurant`.`address` (`address_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
