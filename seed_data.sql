-- Run schema.sql before this file.

USE fitness_center_db;

INSERT IGNORE INTO equipment_category (category_id, category_name) VALUES
    ('C001', 'Cardio'),
    ('C002', 'Strength'),
    ('C003', 'Flexibility');

INSERT IGNORE INTO equipment (equipment_id, category_id, equipment_name, quantity, equipment_status) VALUES
    ('E001', 'C001', 'Treadmill', 10, 'Available'),
    ('E002', 'C002', 'Dumbbells', 20, 'Available'),
    ('E003', 'C002', 'Barbell Set', 5, 'Under Maintenance'),
    ('E004', 'C003', 'Yoga Mat', 15, 'Available');

INSERT IGNORE INTO trainer (trainer_id, trainer_name, contact_info) VALUES
    ('T001', 'Trainer One', 'trainer.one@example.com'),
    ('T002', 'Trainer Two', 'trainer.two@example.com');

INSERT IGNORE INTO trainer_specialty (trainer_id, specialty) VALUES
    ('T001', 'Yoga'),
    ('T001', 'Pilates'),
    ('T002', 'Strength Training');

INSERT IGNORE INTO workshop (workshop_number, member_id, total_hours, start_date, end_date, fee) VALUES
    ('W001', 'M001', 3.00, '2025-09-01', '2025-09-08', 500.00),
    ('W002', 'M002', 2.00, '2025-09-03', '2025-09-03', 300.00);

INSERT IGNORE INTO workshop_detail (workshop_number, workshop_datetime, trainer_id, duration_minutes) VALUES
    ('W001', '2025-09-01 10:00:00', 'T001', 90),
    ('W001', '2025-09-08 10:00:00', 'T001', 90),
    ('W002', '2025-09-03 18:00:00', 'T002', 120);

INSERT IGNORE INTO workshop_detail_equipment (workshop_number, workshop_datetime, equipment_id) VALUES
    ('W001', '2025-09-01 10:00:00', 'E004'),
    ('W001', '2025-09-08 10:00:00', 'E004'),
    ('W002', '2025-09-03 18:00:00', 'E002'),
    ('W002', '2025-09-03 18:00:00', 'E003');
