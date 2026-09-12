-- Run schema.sql and seed_data.sql before this file.

USE fitness_center_db;

-- 1. Trainer profiles with their specialties.
SELECT
    t.trainer_id,
    t.trainer_name,
    t.contact_info,
    COALESCE(GROUP_CONCAT(ts.specialty ORDER BY ts.specialty SEPARATOR ', '), 'Not specified') AS specialties
FROM trainer AS t
LEFT JOIN trainer_specialty AS ts ON t.trainer_id = ts.trainer_id
GROUP BY t.trainer_id, t.trainer_name, t.contact_info;

-- 2. Equipment availability report.
SELECT
    e.equipment_id,
    e.equipment_name,
    ec.category_name,
    e.quantity,
    e.equipment_status
FROM equipment AS e
JOIN equipment_category AS ec ON e.category_id = ec.category_id
ORDER BY ec.category_name, e.equipment_name;

-- 3. Inventory total by category and status.
SELECT
    ec.category_name,
    e.equipment_status,
    SUM(e.quantity) AS total_items
FROM equipment AS e
JOIN equipment_category AS ec ON e.category_id = ec.category_id
GROUP BY ec.category_name, e.equipment_status
ORDER BY ec.category_name, e.equipment_status;

-- 4. Equipment assigned to each workshop session.
SELECT
    wd.workshop_number,
    wd.workshop_datetime,
    t.trainer_name,
    COALESCE(GROUP_CONCAT(e.equipment_name ORDER BY e.equipment_name SEPARATOR ', '), 'No equipment assigned') AS equipment_used
FROM workshop_detail AS wd
JOIN trainer AS t ON wd.trainer_id = t.trainer_id
LEFT JOIN workshop_detail_equipment AS wde
    ON wd.workshop_number = wde.workshop_number
    AND wd.workshop_datetime = wde.workshop_datetime
LEFT JOIN equipment AS e ON wde.equipment_id = e.equipment_id
GROUP BY wd.workshop_number, wd.workshop_datetime, t.trainer_name
ORDER BY wd.workshop_datetime;

-- 5. Identify equipment requiring attention.
SELECT
    equipment_id,
    equipment_name,
    quantity,
    equipment_status
FROM equipment
WHERE equipment_status IN ('Damaged', 'Under Maintenance')
ORDER BY equipment_status, equipment_name;
