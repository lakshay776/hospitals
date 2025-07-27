  # 🏥 Hospital Management System (JDBC + MySQL)

This project is a simple **Hospital Management System** built using **Java JDBC** and **MySQL**. It allows you to perform queries across multiple entities like patients, doctors, departments, staff, and appointments using SQL and Java.

---

## 📦 Project Structure

The repository contains:
- `hospitals.sql`: SQL script to create and populate the database schema with all necessary tables.
- `MyApp.jar`: Compiled Java application using JDBC to query the database.
- `README.md`: This file.

---

## 🗄️ Database Schema

The project revolves around the following core tables:

| Table Name      | Description |
|------------------|-------------|
| `department`     | Stores details about each hospital department. |
| `room`           | Rooms available across departments. |
| `staff`          | Hospital staff including doctors, nurses, and admins. |
| `patient`        | Records for admitted and visiting patients. |
| `appointment`    | Patient appointments with doctors. |
| `shift`          | Timing of staff shifts. |
| `procedure`      | Medical procedures scheduled/performed. |
| `diagnosis`      | Diagnoses assigned to patients. |
| `bill`           | Billing info linked to patients and procedures. |
| `prescription`   | Medicines prescribed to patients. |
| `medicine`       | Inventory of all medicines available. |

Each table includes primary and foreign keys to ensure relational integrity.

---

## 🛠️ How to Set Up

### 🧾 1. Set up MySQL Database

1. Start your MySQL server.
2. Open a MySQL client (like MySQL Workbench or command line).
3. Execute the schema file:

```sql
SOURCE path/to/HospitalSchema.sql;

2. Run the Java Project
The project is distributed as a compiled .jar file.

Ensure you have Java 17 or above installed.

Open terminal or command prompt and run:
java -jar hospital_project.jar


url = "jdbc:mysql://localhost:3306/hospitals";
user = "root";
password = "your_password";
⚠️ Update these inside the Java code or your environment if your credentials differ.


🙌 Contributions
Pull requests are welcome. For major changes, please open an issue first to discuss what you'd like to change.

