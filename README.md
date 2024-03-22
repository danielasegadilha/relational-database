# Relational-data-base

This project stores scripts for practicing basic relational database concepts. It includes scripts for creating databases, tables, defining primary and foreign keys, queries with and without JOIN, creating views, procedures, and functions.

## Introduction

This project aims to assist in learning and practicing fundamental concepts in relational databases. The provided scripts cover a variety of topics, from creating basic database structures to more advanced queries and stored procedures.

## Project Structure

The project is structured as follows:

- **scripts/**: Contains SQL scripts for creating databases, tables, queries, views, procedures, and functions.
  
Here's an example of creating a users table in a SQLServer database:

```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```
## Features

- Database creation.
- Table definition with primary and foreign keys.
- Simple and advanced queries, including JOINs.
- Creation of views for frequent queries.
- Implementation of procedures and functions for logic reusability.

## Usage

1. Clone this repository to your local environment.
2. Execute the SQL scripts in your database management system (e.g., MySQL, PostgreSQL, SQL Server).
3. Explore the different scripts to understand and practice the presented concepts.

