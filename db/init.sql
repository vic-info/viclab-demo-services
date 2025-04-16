-- Drop tables if exist
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS users;

-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status TEXT DEFAULT 'active'
);

-- Create orders table
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    item TEXT NOT NULL,
    quantity INTEGER NOT NULL,
    total NUMERIC(10,2),
    status TEXT DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert dummy users
INSERT INTO users (name, email, phone, status) VALUES
  ('Alice', 'alice@example.com', '1234567890', 'active'),
  ('Bob', 'bob@example.com', '2345678901', 'inactive'),
  ('Charlie', 'charlie@example.com', '3456789012', 'active'),
  ('Diana', 'diana@example.com', '4567890123', 'active');

-- Insert dummy orders
INSERT INTO orders (user_id, item, quantity, total, status) VALUES
  (1, 'Book', 2, 50.00, 'shipped'),
  (1, 'Pen', 5, 12.50, 'pending'),
  (2, 'Notebook', 3, 22.50, 'pending'),
  (3, 'Headphones', 1, 89.99, 'shipped'),
  (4, 'Backpack', 1, 120.00, 'pending'),
  (1, 'Laptop Stand', 1, 45.00, 'shipped');
