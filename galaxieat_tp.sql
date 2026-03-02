PRAGMA foreign_keys = ON;

-- Reset
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS CustomerOrders;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Dishes;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Restaurants;

-- Tables
CREATE TABLE Restaurants (
    restaurant_id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    planet TEXT NOT NULL,
    sector TEXT,
    opened_date TEXT
);

CREATE TABLE Employees (
    employee_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    full_name TEXT NOT NULL,
    role TEXT NOT NULL,
    salary REAL,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE Dishes (
    dish_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    dish_name TEXT NOT NULL,
    category TEXT,
    price REAL,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

-- Orders puis renommage
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    customer_name TEXT NOT NULL,
    customer_planet TEXT,
    order_date TEXT NOT NULL,
    total_amount REAL,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

ALTER TABLE Orders RENAME TO CustomerOrders;

-- Maintenant seulement : OrderItems (référence CustomerOrders)
CREATE TABLE OrderItems (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    dish_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    unit_price REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES CustomerOrders(order_id),
    FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id)
);

-- Alter table
ALTER TABLE Employees ADD COLUMN hire_date TEXT;
ALTER TABLE Dishes ADD COLUMN is_vegan INTEGER; -- 0 = non, 1 = oui

-- Inserts
INSERT INTO Restaurants (restaurant_id, name, planet, sector, opened_date) VALUES
(1, 'GalaxiEat Terra', 'Earth', 'North', '2024-01-12'),
(2, 'GalaxiEat Mars', 'Mars', 'Dome-7', '2024-03-20'),
(3, 'GalaxiEat Venus', 'Venus', 'Cloud-3', '2025-02-11'),
(4, 'GalaxiEat Titan', 'Titan', 'Port-2', '2025-06-01'),
(5, 'GalaxiEat Mercury', 'Mercure', 'Orbit-1', '2026-01-10');

INSERT INTO Employees (employee_id, restaurant_id, full_name, role, salary, hire_date) VALUES
(1, 1, 'Lina Aster', 'Manager', 3200, '2024-02-01'),
(2, 1, 'Noah Quark', 'Chef', 2800, '2024-02-15'),
(3, 2, 'Mila Nova', 'Server', 1900, '2024-04-02'),
(4, 2, 'Eli Photon', 'Chef', 2700, '2024-04-10'),
(5, 3, 'Zara Comet', 'Server', 1850, '2025-03-03'),
(6, 4, 'Iris Orbit', 'Manager', 3300, '2025-06-10');

INSERT INTO Dishes (dish_id, restaurant_id, dish_name, category, price, is_vegan) VALUES
(1, 1, 'Nebula Burger', 'Main', 13.90, 0),
(2, 1, 'Cosmic Salad', 'Starter', 8.50, 1),
(3, 2, 'Mars Tacos', 'Main', 11.20, 0),
(4, 2, 'Red Dust Soup', 'Starter', 6.90, 1),
(5, 3, 'Venus Noodles', 'Main', 12.40, 1),
(6, 4, 'Titan Ice Cream', 'Dessert', 5.80, 1),
(7, 3, 'Orbit Pizza', 'Main', NULL, NULL),
(8, 4, 'Solar Cake', 'Dessert', 7.30, 0);

INSERT INTO CustomerOrders (order_id, restaurant_id, customer_name, customer_planet, order_date, total_amount) VALUES
(1, 1, 'Ben K', 'Earth', '2026-02-20', 22.40),
(2, 2, 'Aya L', 'Mars', '2026-02-21', 4.50),
(3, 3, 'Rex T', 'Venus', '2026-02-22', 18.60),
(4, 4, 'Moe P', 'Titan', '2026-02-23', 13.10),
(5, 5, 'Van A', 'Mercure', '2026-02-14', 16.75);

INSERT INTO OrderItems (order_item_id, order_id, dish_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 13.90),
(2, 1, 2, 1, 8.50),
(3, 2, 6, 1, 4.50),
(4, 3, 5, 1, 12.40),
(5, 3, 8, 1, 6.20),
(6, 4, 3, 1, 11.20),
(7, 4, 4, 1, 6.90);