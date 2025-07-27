        CREATE DATABASE  IF NOT EXISTS `hospitals` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
        USE `hospitals`;
        -- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
        --
        -- Host: 127.0.0.1    Database: hospitals
        -- ------------------------------------------------------
        -- Server version	9.2.0

        /*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
        /*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
        /*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
        /*!50503 SET NAMES utf8 */;
        /*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
        /*!40103 SET TIME_ZONE='+00:00' */;
        /*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
        /*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
        /*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
        /*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

        --
        -- Table structure for table `admission`
        --

        DROP TABLE IF EXISTS `admission`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `admission` (
          `admit_id` int NOT NULL,
          `appointment_id` int DEFAULT NULL,
          `room_id` int NOT NULL,
          `admission_date` datetime NOT NULL,
          `discharge_date` datetime DEFAULT NULL,
          PRIMARY KEY (`admit_id`),
          KEY `appointment_id` (`appointment_id`),
          KEY `room_id` (`room_id`),
          KEY `idx_admission_date` (`admission_date`),
          KEY `idx_discharge_date` (`discharge_date`),
          CONSTRAINT `admission_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
          CONSTRAINT `admission_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;
          
        --
        -- Table structure for table `appointment`
        --

        DROP TABLE IF EXISTS `appointment`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `appointment` (
          `appointment_id` int NOT NULL AUTO_INCREMENT,
          `patient_id` int NOT NULL,
          `department_id` int NOT NULL,
          `staff_id` int NOT NULL,
          `date` date NOT NULL,
          `start_time` time NOT NULL,
          `end_time` time NOT NULL,
          `room_id` int NOT NULL,
          `status` enum('scheduled','completed','cancelled','no-show') NOT NULL,
          PRIMARY KEY (`appointment_id`),
          KEY `patient_id` (`patient_id`),
          KEY `staff_id` (`staff_id`),
          KEY `room_id` (`room_id`),
          KEY `idx_appointment_department_date` (`department_id`,`date`),
          CONSTRAINT `appointment_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
          CONSTRAINT `appointment_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`),
          CONSTRAINT `appointment_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
          CONSTRAINT `appointment_ibfk_4` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `bill_line_item`
        --

        DROP TABLE IF EXISTS `bill_line_item`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `bill_line_item` (
          `bill_item_id` int NOT NULL,
          `bill_id` int NOT NULL,
          `item_type` enum('appointment','procedure','prescription') NOT NULL,
          `item_id` int NOT NULL,
          `amount` int NOT NULL,
          PRIMARY KEY (`bill_item_id`),
          KEY `idx_bill_item_bill_id` (`bill_id`),
          KEY `idx_bill_item_type_id` (`item_type`,`item_id`),
          CONSTRAINT `bill_line_item_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `billing` (`bill_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `billing`
        --

        DROP TABLE IF EXISTS `billing`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `billing` (
          `bill_id` int NOT NULL AUTO_INCREMENT,
          `patient_id` int NOT NULL,
          `total_amount` int NOT NULL,
          `paid_amount` int NOT NULL,
          `due_date` date NOT NULL,
          `payment_status` enum('pending','partial','completed','failed','refunded') NOT NULL,
          `billed_at` datetime NOT NULL,
          PRIMARY KEY (`bill_id`),
          KEY `patient_id` (`patient_id`),
          KEY `idx_billing_due_status` (`payment_status`,`due_date`),
          CONSTRAINT `billing_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `department`
        --

        DROP TABLE IF EXISTS `department`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `department` (
          `department_id` int NOT NULL AUTO_INCREMENT,
          `name` varchar(255) NOT NULL,
          PRIMARY KEY (`department_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `diagnosis`
        --

        DROP TABLE IF EXISTS `diagnosis`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `diagnosis` (
          `diagnosis_id` int NOT NULL AUTO_INCREMENT,
          `appointment_id` int NOT NULL,
          `diagnosis_code` int NOT NULL,
          `remarks` text,
          `recorded_by` int NOT NULL,
          `recorded_at` datetime NOT NULL,
          PRIMARY KEY (`diagnosis_id`),
          KEY `appointment_id` (`appointment_id`),
          KEY `recorded_by` (`recorded_by`),
          KEY `idx_diagnosis_code` (`diagnosis_code`),
          CONSTRAINT `diagnosis_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`),
          CONSTRAINT `diagnosis_ibfk_2` FOREIGN KEY (`recorded_by`) REFERENCES `staff` (`staff_id`),
          CONSTRAINT `diagnosis_ibfk_3` FOREIGN KEY (`diagnosis_code`) REFERENCES `diagnosis_catalog` (`diagnosis_code`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `diagnosis_catalog`
        --

        DROP TABLE IF EXISTS `diagnosis_catalog`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `diagnosis_catalog` (
          `diagnosis_code` int NOT NULL,
          `name` varchar(255) NOT NULL,
          PRIMARY KEY (`diagnosis_code`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `doctor`
        --

        DROP TABLE IF EXISTS `doctor`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `doctor` (
          `staff_id` int NOT NULL,
          `specialization_id` int NOT NULL,
          PRIMARY KEY (`staff_id`,`specialization_id`),
          KEY `specialization_id` (`specialization_id`),
          CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
          CONSTRAINT `doctor_ibfk_2` FOREIGN KEY (`specialization_id`) REFERENCES `specialization` (`specialization_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `insurance_claim`
        --

        DROP TABLE IF EXISTS `insurance_claim`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `insurance_claim` (
          `claim_id` int NOT NULL AUTO_INCREMENT,
          `bill_id` int NOT NULL,
          `insurance_provider` varchar(255) NOT NULL,
          `status` enum('pending','approved','denied') NOT NULL,
          `submitted_date` date NOT NULL,
          `approved_date` date DEFAULT NULL,
          `claim_amount` int NOT NULL,
          PRIMARY KEY (`claim_id`),
          KEY `bill_id` (`bill_id`),
          KEY `idx_insurance_claim_status` (`status`),
          CONSTRAINT `insurance_claim_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `billing` (`bill_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `medical_history`
        --

        DROP TABLE IF EXISTS `medical_history`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `medical_history` (
          `history_id` int NOT NULL AUTO_INCREMENT,
          `patient_id` int NOT NULL,
          `condition_name` varchar(255) NOT NULL,
          `notes` text,
          `recorded_at` datetime NOT NULL,
          PRIMARY KEY (`history_id`),
          KEY `patient_id` (`patient_id`),
          CONSTRAINT `medical_history_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `medication`
        --

        DROP TABLE IF EXISTS `medication`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `medication` (
          `medication_id` int NOT NULL AUTO_INCREMENT,
          `medication_name` varchar(255) NOT NULL,
          `type` enum('antibiotics','antifungals','antidepressants','analgesics','antipyretics','antivirals','vaccines','antacids') NOT NULL,
          `description` text,
          `amount` int NOT NULL,
          PRIMARY KEY (`medication_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `on_call_rotation`
        --

        DROP TABLE IF EXISTS `on_call_rotation`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `on_call_rotation` (
          `staff_id` int NOT NULL,
          `start_date` datetime NOT NULL,
          `end_date` datetime DEFAULT NULL,
          PRIMARY KEY (`staff_id`,`start_date`),
          CONSTRAINT `on_call_rotation_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `patient`
        --

        DROP TABLE IF EXISTS `patient`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `patient` (
          `patient_id` int NOT NULL AUTO_INCREMENT,
          `first_name` varchar(255) NOT NULL,
          `last_name` varchar(255) NOT NULL,
          `dob` date NOT NULL,
          `gender` enum('male','female','other','prefer_not_to_say') NOT NULL,
          `blood_group` enum('A+','A-','B+','B-','AB+','AB-','O+','O-') DEFAULT NULL,
          `phone` varchar(255) NOT NULL,
          `email` text NOT NULL,
          `address` text NOT NULL,
          `created_at` datetime NOT NULL,
          PRIMARY KEY (`patient_id`)
        ) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `payment_transaction`
        --

        DROP TABLE IF EXISTS `payment_transaction`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `payment_transaction` (
          `payment_id` int NOT NULL AUTO_INCREMENT,
          `bill_id` int NOT NULL,
          `amount` int NOT NULL,
          `method` enum('cash','card','upi','netbanking','insurance') NOT NULL,
          `status` enum('pending','success','failed') NOT NULL,
          `paid_at` datetime NOT NULL,
          `reference_number` varchar(100) DEFAULT NULL,
          PRIMARY KEY (`payment_id`),
          KEY `bill_id` (`bill_id`),
          CONSTRAINT `payment_transaction_ibfk_1` FOREIGN KEY (`bill_id`) REFERENCES `billing` (`bill_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `prescribed_medication`
        --

        DROP TABLE IF EXISTS `prescribed_medication`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `prescribed_medication` (
          `prescription_id` int NOT NULL,
          `medication_id` int NOT NULL,
          PRIMARY KEY (`prescription_id`,`medication_id`),
          KEY `medication_id` (`medication_id`),
          CONSTRAINT `prescribed_medication_ibfk_1` FOREIGN KEY (`prescription_id`) REFERENCES `prescription` (`prescription_id`),
          CONSTRAINT `prescribed_medication_ibfk_2` FOREIGN KEY (`medication_id`) REFERENCES `medication` (`medication_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `prescription`
        --

        DROP TABLE IF EXISTS `prescription`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `prescription` (
          `prescription_id` int NOT NULL AUTO_INCREMENT,
          `appointment_id` int NOT NULL,
          PRIMARY KEY (`prescription_id`),
          KEY `appointment_id` (`appointment_id`),
          CONSTRAINT `prescription_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointment` (`appointment_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `procedure`
        --

        DROP TABLE IF EXISTS `procedure`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `procedure` (
          `procedure_id` int NOT NULL AUTO_INCREMENT,
          `diagnosis_id` int NOT NULL,
          `procedure_code` int NOT NULL,
          `performed_at` datetime NOT NULL,
          `end_time` datetime DEFAULT NULL,
          `staff_id` int DEFAULT NULL,
          PRIMARY KEY (`procedure_id`),
          KEY `diagnosis_id` (`diagnosis_id`),
          KEY `idx_procedure_type_time` (`procedure_code`,`performed_at`),
          CONSTRAINT `procedure_ibfk_1` FOREIGN KEY (`diagnosis_id`) REFERENCES `diagnosis` (`diagnosis_id`),
          CONSTRAINT `procedure_ibfk_2` FOREIGN KEY (`procedure_code`) REFERENCES `procedure_catalog` (`procedure_code`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `procedure_catalog`
        --

        DROP TABLE IF EXISTS `procedure_catalog`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `procedure_catalog` (
          `procedure_code` int NOT NULL,
          `procedure_name` varchar(255) NOT NULL,
          `procedure_type` enum('imaging','laboratory_tests','endoscopy','surgery','biopsy','therapy','emergency') NOT NULL,
          PRIMARY KEY (`procedure_code`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `room`
        --

        DROP TABLE IF EXISTS `room`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `room` (
          `room_id` int NOT NULL AUTO_INCREMENT,
          `room_number` varchar(255) NOT NULL,
          `room_type` enum('office','ward','icu','consultation_room','operation_theatre','emergency_room','pharmacy','lab') NOT NULL,
          `department_id` int NOT NULL,
          PRIMARY KEY (`room_id`),
          KEY `department_id` (`department_id`),
          CONSTRAINT `room_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `shift`
        --

        DROP TABLE IF EXISTS `shift`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `shift` (
          `shift_id` int NOT NULL,
          `start_time` time NOT NULL,
          `end_time` time NOT NULL,
          PRIMARY KEY (`shift_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `specialization`
        --

        DROP TABLE IF EXISTS `specialization`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `specialization` (
          `specialization_id` int NOT NULL AUTO_INCREMENT,
          `name` varchar(255) NOT NULL,
          PRIMARY KEY (`specialization_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `staff`
        --

        DROP TABLE IF EXISTS `staff`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `staff` (
          `staff_id` int NOT NULL AUTO_INCREMENT,
          `first_name` varchar(255) NOT NULL,
          `last_name` varchar(255) NOT NULL,
          `role` enum('doctor','nurse','technician','receptionist','pharmacist','lab_assistant','admin') NOT NULL,
          `department_id` int NOT NULL,
          `phone` varchar(255) NOT NULL,
          `email` text NOT NULL,
          PRIMARY KEY (`staff_id`),
          KEY `department_id` (`department_id`),
          CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;

        --
        -- Table structure for table `staff_schedule`
        --

        DROP TABLE IF EXISTS `staff_schedule`;
        /*!40101 SET @saved_cs_client     = @@character_set_client */;
        /*!50503 SET character_set_client = utf8mb4 */;
        CREATE TABLE `staff_schedule` (
          `schedule_id` int NOT NULL AUTO_INCREMENT,
          `staff_id` int NOT NULL,
          `shift_id` int NOT NULL,
          `shift_rate` int NOT NULL,
          `date` date NOT NULL,
          PRIMARY KEY (`schedule_id`),
          KEY `shift_id` (`shift_id`),
          KEY `idx_staff_schedule_staff_date` (`staff_id`,`shift_rate`,`date`),
          CONSTRAINT `staff_schedule_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
          CONSTRAINT `staff_schedule_ibfk_2` FOREIGN KEY (`shift_id`) REFERENCES `shift` (`shift_id`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
        /*!40101 SET character_set_client = @saved_cs_client */;
        /*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

        /*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
        /*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
        /*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
        /*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
        /*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
        /*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
        /*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

        -- Dump completed on 2025-07-27 22:49:49
  

  