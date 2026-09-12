# Fitness Center Management System

This is my individual part of a group database-design project from class. The original class report is not included because it contains other group members' information. This repository only shows the part I worked on: trainers, equipment, equipment categories, workshop sessions, and workshop equipment usage.

## My Contribution

I designed the logical ER diagram, relational schema, data dictionary, and sample reports for trainer, trainer specialty, equipment, equipment category, workshop detail, and workshop-equipment usage tables.

## Database Design

This diagram is generated from the current `schema.sql`, so its table names and key relationships match the implementation in this repository.

![Fitness Center Management System ER Diagram](assets/er-diagram.svg)

### Entity Relationship Diagram for This Repository

```mermaid
erDiagram
    EQUIPMENT_CATEGORY ||--o{ EQUIPMENT : contains
    TRAINER ||--o{ TRAINER_SPECIALTY : has
    WORKSHOP ||--|{ WORKSHOP_DETAIL : includes
    TRAINER ||--o{ WORKSHOP_DETAIL : leads
    WORKSHOP_DETAIL ||--o{ WORKSHOP_DETAIL_EQUIPMENT : uses
    EQUIPMENT ||--o{ WORKSHOP_DETAIL_EQUIPMENT : is_assigned_to

    EQUIPMENT_CATEGORY {
        varchar category_id PK
        varchar category_name
    }
    EQUIPMENT {
        varchar equipment_id PK
        varchar category_id FK
        varchar equipment_name
        int quantity
        varchar equipment_status
    }
    TRAINER {
        varchar trainer_id PK
        varchar trainer_name
        varchar contact_info
    }
    TRAINER_SPECIALTY {
        varchar trainer_id PK, FK
        varchar specialty PK
    }
    WORKSHOP {
        varchar workshop_number PK
        varchar member_id
        decimal total_hours
        date start_date
        date end_date
        decimal fee
    }
    WORKSHOP_DETAIL {
        varchar workshop_number PK, FK
        datetime workshop_datetime PK
        varchar trainer_id FK
        int duration_minutes
    }
    WORKSHOP_DETAIL_EQUIPMENT {
        varchar workshop_number PK, FK
        datetime workshop_datetime PK, FK
        varchar equipment_id PK, FK
    }
```

## Features

- Tracks trainers, contact information, and multiple specialties.
- Manages equipment, categories, quantities, and availability status.
- Records equipment assigned to individual workshop sessions.
- Includes reporting queries for trainer profiles, equipment availability, inventory summaries, and maintenance needs.

## Repository Contents

| File | Description |
| --- | --- |
| `schema.sql` | Creates the MySQL 8.0+ database schema. |
| `seed_data.sql` | Inserts fictional sample data for demonstration. |
| `queries.sql` | Contains example reporting and analysis queries. |

## Tech Stack

MySQL 8.0+, SQL, Relational Database Design, ER Diagram, Primary Keys, Foreign Keys, JOIN, Aggregation

## How to Run

1. Open MySQL Workbench or another MySQL 8.0+ client.
2. Run `schema.sql`.
3. Run `seed_data.sql`.
4. Run `queries.sql` to view the example reports.

## Note

This repository is based on a group project, but it only contains my own database-design scope. All names, emails, IDs, and records in `seed_data.sql` are fictional examples. The `member_id` field is only a workshop reference because the full member-management module was outside my part. No class report, classmate information, student IDs, or real fitness-center data are included here.

## License

This repository uses the MIT License. You can use or adapt the SQL and schema as a learning example, but please keep the copyright and license notice.
