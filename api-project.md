# API Project

I am using this to plan for the API project. The goal is to create a simple API project that can be used to demonstrate the use of the API. The project is to build a API server that can perform CRUD operations on a database.

## Data model

Create a DB in PostgreSQL with a user for the API to connect to. The DB should have the following tables:

- products
- products_inventory
- orders
- users

```sql
CREATE DATABASE api_project;
CREATE USER api_user WITH PASSWORD 'password';
GRANT ALL PRIVILEGES ON DATABASE api_project TO api_user;
# Connect to the database
\c api_project;
```

## Products

- id: integer
- name: string
- description: string
- price: float
- created_at: datetime
- updated_at: datetime

```sql
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    price DECIMAL(10, 2) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

Product Management.

Products can only be added by <owners>. It must include the QTY of products.
The QTY and Price can be updated later.

## Inventory

- id: integer
- product_id: integer
- quantity: integer
- created_at: datetime
- updated_at: datetime

```sql
CREATE TABLE products_inventory (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## Orders

- id: integer
- product_id: integer
- quantity: integer
- total_price: float
- status: string
- created_at: datetime
- updated_at: datetime

```sql
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    product_id INTEGER REFERENCES products(id),
    quantity INTEGER NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL,
    status VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

## Users

- id: integer
- name: string
- email: string
- created_at: datetime
- updated_at: datetime

```sql
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```


## Requirements




Products can be viewed and managed (add, update, delete) using API.
Orders can be viewed and managed (add, update, delete) using API.
Users can be viewed and managed (add, update, delete) using API.

A product cannot be deleted if there are orders associated with it.
A user cannot be deleted if there are orders associated with it.
