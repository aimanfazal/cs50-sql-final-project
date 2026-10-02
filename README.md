# DDT Database

A relational database for tracking WWE wrestlers, brands, championships, title reigns, events, and matches.

Built as the final project for **CS50's Introduction to Databases with SQL**.

## Overview

The database focuses on three WWE brands:

- Raw
- SmackDown
- NXT

It supports:

- Wrestler profiles and current status
- Wrestler brand assignments
- Championship histories
- Current champions
- WWE events and matches
- Wrestler win/loss records

The project is designed for record-keeping and querying historical data, not booking future matches.

## Database

The database consists of six tables:

| Table | Description |
|---|---|
| `brands` | WWE brands |
| `wrestlers` | Wrestler information and brand assignments |
| `championships` | Championships and divisions |
| `title_reigns` | Championship reign history |
| `events` | WWE events |
| `matches` | Matches and their results |

An ER diagram showing the relationships between these entities is included in [`assets/er-diagram.png`](assets/er-diagram.png).

## Repository Structure

```text
.
├── assets/
│   ├── certificate.png
│   └── er-diagram.png
├── sql/
│   ├── queries.sql
│   └── schema.sql
├── DESIGN.md
└── README.md
```

## Files

`DESIGN.md`
Contains the database's:
- Purpose and scope
- Entities and relationships
- ER diagram
- Functional requirements
- Optimizations
- Limitations

`sql/schema.sql`
Defines the database schema, including:
- Tables
- Primary and foreign keys
- Constraints
- Indexes
- current_champions view

`sql/queries.sql`
Contains sample:
- SELECT
- INSERT
- UPDATE
- DELETE
statements demonstrating how the database can be used.

## Getting Started

Create a MySQL database and run the schema:

`mysql -u <username> -p <database_name> < sql/schema.sql`

Then run the example queries and data:

`mysql -u <username> -p <database_name> < sql/queries.sql`

## Limitations

- Matches directly support two wrestlers; additional participants are represented through notes.
- Ongoing title reigns use NULL for lost_date.
- Tag-team championships are not fully modeled as teams.

See [`DESIGN.md`](DESIGN.md) for the complete design and limitations.

## Course

**CS50's Introduction to Databases with SQL**

Final Project — 2026

## Author

**Aiman Fazal**

GitHub / edX: `aimanfazal`