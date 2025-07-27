 
    SET FOREIGN_KEY_CHECKS=0;
    -- ===== Sample DEPARTMENT DATA =====
INSERT INTO department (department_id, name) VALUES
  (1, 'Cardiology'),
  (2, 'Oncology'),
  (3, 'Neurology');

-- ===== Sample SPECIALIZATION DATA =====
INSERT INTO specialization (specialization_id, name) VALUES
  (1, 'Cardiologist'),
  (2, 'Oncologist'),
  (3, 'Neurologist');

-- ===== Sample PATIENT DATA =====
INSERT INTO patient (patient_id, first_name, last_name, dob, gender, blood_group, phone, email, address, created_at) VALUES
  (1, 'Alice', 'Smith', '1980-02-14', 'female', 'A+', '9876543210', 'alice.smith@example.com', '123 Main St, City', '2025-07-01 08:00:00'),
  (2, 'Bob', 'Brown', '1990-07-20', 'male', 'O-', '9123456789', 'bob.brown@example.com', '456 Park Ave, City', '2025-07-05 08:00:00'),
  (3, 'Carlos', 'Garcia', '1975-05-23', 'male', 'B+', '9955443322', 'carlos.garcia@example.com', '789 State St, City', '2025-07-15 09:00:00');

-- ===== Sample STAFF DATA =====
INSERT INTO staff (staff_id, first_name, last_name, role, department_id, phone, email) VALUES
  (1, 'Dr. Emma', 'White', 'doctor', 1, '9988776655', 'emma.white@hospital.com'),
  (2, 'Nurse', 'Green', 'nurse', 2, '9988771234', 'nurse.green@hospital.com'),
  (3, 'Sam', 'Lee', 'technician', 1, '9988778888', 'sam.lee@hospital.com'),
  (4, 'Olivia', 'Patil', 'receptionist', 3, '9933445566', 'olivia.patil@hospital.com');

-- ===== Sample DOCTOR DATA =====
INSERT INTO doctor (staff_id, specialization_id) VALUES
  (1, 1);

-- ===== Sample ROOM DATA =====
INSERT INTO room (room_id, room_number, room_type, department_id) VALUES
  (1, '101', 'ward', 1),
  (2, '201', 'icu', 1),
  (3, '301', 'consultation_room', 2);

-- ===== Sample SHIFT DATA =====
INSERT INTO shift (shift_id, start_time, end_time) VALUES
  (1, '08:00:00', '16:00:00'),
  (2, '16:00:00', '23:59:00');

-- ===== Sample STAFF_SCHEDULE DATA =====
INSERT INTO staff_schedule (schedule_id, staff_id, shift_id, shift_rate, date) VALUES
  (1, 1, 1, 500, '2025-07-28'),
  (2, 2, 2, 400, '2025-07-28'),
  (3, 3, 1, 350, '2025-07-28');

-- ===== Sample DIAGNOSIS_CATALOG DATA =====
INSERT INTO diagnosis_catalog (diagnosis_code, name) VALUES
  (101, 'Hypertension'),
  (102, 'Migraine');

-- ===== Sample PROCEDURE_CATALOG DATA =====
INSERT INTO procedure_catalog (procedure_code, procedure_name, procedure_type) VALUES
  (301, 'ECG', 'laboratory_tests'),
  (302, 'Brain MRI', 'imaging');

-- ===== Sample APPOINTMENT DATA =====
INSERT INTO appointment (appointment_id, patient_id, department_id, staff_id, date, start_time, end_time, room_id, status) VALUES
  (1, 1, 1, 1, '2025-07-20', '10:00:00', '10:30:00', 3, 'scheduled'),
  (2, 2, 2, 1, '2025-07-21', '11:00:00', '11:45:00', 1, 'completed'),
  (3, 3, 3, 1, '2025-07-22', '12:00:00', '12:30:00', 2, 'completed');

-- ===== Sample ADMISSION DATA =====
INSERT INTO admission (admit_id, appointment_id, room_id, admission_date, discharge_date) VALUES
  (1, 1, 1, '2025-07-20 09:00:00', '2025-07-22 09:00:00'),
  (2, 2, 2, '2025-07-21 10:00:00', NULL);

-- ===== Sample BILLING DATA =====
INSERT INTO billing (bill_id, patient_id, total_amount, paid_amount, due_date, payment_status, billed_at) VALUES
  (1, 1, 3000, 3000, '2025-07-30', 'completed', '2025-07-22 10:00:00'),
  (2, 2, 4000, 1500, '2025-08-10', 'partial', '2025-07-21 12:00:00'),
  (3, 3, 2000, 0, '2025-08-13', 'pending', '2025-07-22 13:00:00');

-- ===== Sample BILL_LINE_ITEM DATA =====
INSERT INTO bill_line_item (bill_item_id, bill_id, item_type, item_id, amount) VALUES
  (1, 1, 'appointment', 1, 1000),
  (2, 1, 'procedure', 1, 2000),
  (3, 2, 'appointment', 2, 2000),
  (4, 2, 'procedure', 2, 2000);

-- ===== Sample PAYMENT_TRANSACTION DATA =====
INSERT INTO payment_transaction (payment_id, bill_id, amount, method, status, paid_at, reference_number) VALUES
  (1, 1, 3000, 'card', 'success', '2025-07-22 11:00:00', 'TXN0001'),
  (2, 2, 1500, 'upi', 'success', '2025-07-21 14:00:00', 'UPI98765');

-- ===== Sample INSURANCE_CLAIM DATA =====
INSERT INTO insurance_claim (claim_id, bill_id, insurance_provider, status, submitted_date, approved_date, claim_amount) VALUES
  (1, 2, 'MediCare', 'pending', '2025-07-22', NULL, 2500);

-- ===== Sample MEDICAL_HISTORY DATA =====
INSERT INTO medical_history (history_id, patient_id, condition_name, notes, recorded_at) VALUES
  (1, 1, 'Asthma', 'Stable with medication', '2025-07-02 10:00:00'),
  (2, 2, 'Diabetes', 'Type 2 - managed', '2025-07-06 11:00:00');

-- ===== Sample MEDICATION DATA =====
INSERT INTO medication (medication_id, medication_name, type, description, amount) VALUES
  (1, 'Paracetamol', 'antipyretics', 'Fever reducer', 100),
  (2, 'Metformin', 'antidepressants', 'Blood sugar control', 80),
  (3, 'Amoxicillin', 'antibiotics', 'For infections', 60);

-- ===== Sample PRESCRIPTION DATA =====
INSERT INTO prescription (prescription_id, appointment_id) VALUES
  (1, 1),
  (2, 2);

-- ===== Sample PRESCRIBED_MEDICATION DATA =====
INSERT INTO prescribed_medication (prescription_id, medication_id) VALUES
  (1, 1),
  (1, 2),
  (2, 2);

-- ===== Sample DIAGNOSIS DATA =====
INSERT INTO diagnosis (diagnosis_id, appointment_id, diagnosis_code, remarks, recorded_by, recorded_at) VALUES
  (1, 1, 101, 'High blood pressure noted', 1, '2025-07-20 10:30:00'),
  (2, 2, 102, 'Migraine symptoms noted', 1, '2025-07-21 11:45:00');

-- ===== Sample PROCEDURE DATA =====
INSERT INTO procedure (procedure_id, diagnosis_id, procedure_code, performed_at, end_time, staff_id) VALUES
  (1, 1, 301, '2025-07-20 11:00:00', '2025-07-20 11:20:00', 1),
  (2, 2, 302, '2025-07-21 12:00:00', '2025-07-21 12:45:00', 1);

-- ===== Sample ON_CALL_ROTATION DATA =====
INSERT INTO on_call_rotation (staff_id, start_date, end_date) VALUES
  (1, '2025-07-27 16:00:00', '2025-07-28 08:00:00'),
  (2, '2025-07-27 16:00:00', '2025-07-28 08:00:00');

-- You may add more records as needed.

 SET FOREIGN_KEY_CHECKS=1;