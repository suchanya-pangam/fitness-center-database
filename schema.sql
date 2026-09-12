-- Fitness Center Management System
-- MySQL 8.0+ portfolio implementation of the trainer and equipment management scope.

CREATE DATABASE IF NOT EXISTS fitness_center_db
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE fitness_center_db;

CREATE TABLE IF NOT EXISTS equipment_category (
    category_id VARCHAR(10) PRIMARY KEY,
    category_name VARCHAR(100) NOT NULL UNIQUE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS equipment (
    equipment_id VARCHAR(10) PRIMARY KEY,
    category_id VARCHAR(10) NOT NULL,
    equipment_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    equipment_status ENUM('Available', 'Damaged', 'Under Maintenance') NOT NULL,
    CONSTRAINT chk_equipment_quantity CHECK (quantity >= 0),
    CONSTRAINT fk_equipment_category
        FOREIGN KEY (category_id) REFERENCES equipment_category(category_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS trainer (
    trainer_id VARCHAR(10) PRIMARY KEY,
    trainer_name VARCHAR(150) NOT NULL,
    contact_info VARCHAR(150) NOT NULL
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS trainer_specialty (
    trainer_id VARCHAR(10) NOT NULL,
    specialty VARCHAR(100) NOT NULL,
    PRIMARY KEY (trainer_id, specialty),
    CONSTRAINT fk_specialty_trainer
        FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS workshop (
    workshop_number VARCHAR(10) PRIMARY KEY,
    member_id VARCHAR(10) NOT NULL,
    total_hours DECIMAL(5, 2) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    fee DECIMAL(10, 2) NOT NULL,
    CONSTRAINT chk_workshop_total_hours CHECK (total_hours > 0),
    CONSTRAINT chk_workshop_fee CHECK (fee >= 0),
    CONSTRAINT chk_workshop_dates CHECK (end_date >= start_date)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS workshop_detail (
    workshop_number VARCHAR(10) NOT NULL,
    workshop_datetime DATETIME NOT NULL,
    trainer_id VARCHAR(10) NOT NULL,
    duration_minutes INT NOT NULL,
    PRIMARY KEY (workshop_number, workshop_datetime),
    CONSTRAINT chk_detail_duration CHECK (duration_minutes > 0),
    CONSTRAINT fk_detail_workshop
        FOREIGN KEY (workshop_number) REFERENCES workshop(workshop_number),
    CONSTRAINT fk_detail_trainer
        FOREIGN KEY (trainer_id) REFERENCES trainer(trainer_id)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS workshop_detail_equipment (
    workshop_number VARCHAR(10) NOT NULL,
    workshop_datetime DATETIME NOT NULL,
    equipment_id VARCHAR(10) NOT NULL,
    PRIMARY KEY (workshop_number, workshop_datetime, equipment_id),
    CONSTRAINT fk_usage_workshop_detail
        FOREIGN KEY (workshop_number, workshop_datetime)
        REFERENCES workshop_detail(workshop_number, workshop_datetime),
    CONSTRAINT fk_usage_equipment
        FOREIGN KEY (equipment_id) REFERENCES equipment(equipment_id)
) ENGINE = InnoDB;
