-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema sistemas
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sistemas
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sistemas` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `sistemas` ;

-- -----------------------------------------------------
-- Table `sistemas`.`caixa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemas`.`caixa` (
  `ID` VARCHAR(36) NOT NULL,
  `NUMERO_DOC` VARCHAR(20) NOT NULL,
  `DESCRICAO` VARCHAR(200) NOT NULL,
  `VALOR` DECIMAL(18,2) NOT NULL,
  `TIPO` VARCHAR(1) NOT NULL,
  `DATA_CADASTRO` DATE NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemas`.`contas_pagar`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemas`.`contas_pagar` (
  `ID` VARCHAR(36) NOT NULL,
  `NUMERO_DOC` VARCHAR(20) NOT NULL,
  `DESCRICAO` VARCHAR(200) NOT NULL,
  `PARCELA` INT NOT NULL,
  `VALOR_PARCELA` DECIMAL(18,2) NOT NULL,
  `VALOR_COMPRA` DECIMAL(18,2) NOT NULL,
  `VALOR_ABATIDO` DECIMAL(18,2) NOT NULL,
  `DATA_COMPRA` DATE NOT NULL,
  `DATA_PAGAMENTO` DATE NULL DEFAULT NULL,
  `DATA_VENCIMENTO` DATE NOT NULL,
  `STATUS` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemas`.`contas_pagar_detalhes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemas`.`contas_pagar_detalhes` (
  `ID` VARCHAR(36) NOT NULL,
  `ID_CONTAS_PAGAR` VARCHAR(36) NOT NULL,
  `DETALHES` VARCHAR(200) NOT NULL,
  `VALOR` DECIMAL(18,2) NOT NULL,
  `DATA` DATE NOT NULL,
  `USUARIO` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `PK_CONTAS_PAGAR_DETALHES` (`ID_CONTAS_PAGAR` ASC) VISIBLE,
  CONSTRAINT `PK_CONTAS_PAGAR_DETALHES`
    FOREIGN KEY (`ID_CONTAS_PAGAR`)
    REFERENCES `sistemas`.`contas_pagar` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemas`.`contas_receber`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemas`.`contas_receber` (
  `ID` VARCHAR(36) NOT NULL,
  `NUMERO_DOC` VARCHAR(20) NOT NULL,
  `DESCRICAO` VARCHAR(200) NOT NULL,
  `PARCELA` INT NOT NULL,
  `VALOR_PARCELA` DECIMAL(18,2) NOT NULL,
  `VALOR_VENDA` DECIMAL(18,2) NOT NULL,
  `VALOR_ABATIDO` DECIMAL(18,2) NOT NULL,
  `DATA_VENDA` DATE NOT NULL,
  `DATA_RECEBIMENTO` DATE NULL DEFAULT NULL,
  `DATA_VENCIMENTO` DATE NOT NULL,
  `STATUS` VARCHAR(1) NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemas`.`contas_receber_detalhes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemas`.`contas_receber_detalhes` (
  `ID` VARCHAR(36) NOT NULL,
  `ID_CONTAS_RECEBER` VARCHAR(36) NOT NULL,
  `DETALHES` VARCHAR(200) NOT NULL,
  `VALOR` DECIMAL(18,2) NOT NULL,
  `DATA` DATE NOT NULL,
  `USUARIO` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `PK_CONTAS_RECEBER_DETALHES` (`ID_CONTAS_RECEBER` ASC) VISIBLE,
  CONSTRAINT `PK_CONTAS_RECEBER_DETALHES`
    FOREIGN KEY (`ID_CONTAS_RECEBER`)
    REFERENCES `sistemas`.`contas_receber` (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `sistemas`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `sistemas`.`usuarios` (
  `ID` VARCHAR(36) NOT NULL,
  `NOME` VARCHAR(50) NOT NULL,
  `LOGIN` VARCHAR(20) NOT NULL,
  `SENHA` VARCHAR(20) NOT NULL,
  `STATUS` VARCHAR(1) NOT NULL,
  `DATA_CADASTRO` DATE NOT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
