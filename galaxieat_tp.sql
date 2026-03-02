--PRAGMA foreign_keys = ON; (inutile pour le moment)

-- On fait des reset pour 0 conflic (j'espere)
DROP TABLE IF EXISTS OrderItems;
DROP TABLE IF EXISTS CustomerOrders;
DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Dishes;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Restaurants;

--création des tables(pour le moment c'est des provisoires)
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

-- On crée Orders puis on la renomme 
CREATE TABLE Orders (
    order_id INTEGER PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    customer_name TEXT NOT NULL,
    customer_planet TEXT,
    order_date TEXT NOT NULL,
    total_amount REAL,
    FOREIGN KEY (restaurant_id) REFERENCES Restaurants(restaurant_id)
);

CREATE TABLE OrderItems (
    order_item_id INTEGER PRIMARY KEY,
    order_id INTEGER NOT NULL,
    dish_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL CHECK(quantity > 0),
    unit_price REAL NOT NULL,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (dish_id) REFERENCES Dishes(dish_id)
);

-- Modif la struct (alter table)
ALTER TABLE Employees ADD COLUMN hire_date TEXT;
ALTER TABLE Dishes ADD COLUMN is_vegan INTEGER; -- 0 = non, 1 = oui
ALTER TABLE Orders RENAME TO CustomerOrders;

-- Insertion de données
INSERT INTO Restaurants (restaurant_id, name, planet, sector, opened_date) VALUES
(1, 'GalaxiEat Terra', 'Earth', 'North', '2024-01-12'),
(2, 'GalaxiEat Mars', 'Mars', 'Dome-7', '2024-03-20'),
(3, 'GalaxiEat Venus', 'Venus', 'Cloud-3', '2025-02-11'),
(4, 'GalaxiEat Titan', 'Titan', 'Port-2', '2025-06-01'),
(5, 'GalaxiEat Europa', 'Europa', 'Ice-1', '2025-08-14'),
(6, 'GalaxiEat Ganymede', 'Ganymede', 'Crater-9', '2025-10-02'),
(7, 'GalaxiEat Neptune', 'Neptune', 'Ring-4', '2026-01-05'),
(8, 'GalaxiEat Pluto', 'Pluto', 'Base-5', '2026-01-20');

INSERT INTO Employees (employee_id, restaurant_id, full_name, role, salary, hire_date) VALUES
(1, 1, 'Lina Aster', 'Manager', 3200, '2024-02-01'),
(2, 1, 'Noah Quark', 'Chef', 2800, '2024-02-15'),
(3, 2, 'Mila Nova', 'Server', 1900, '2024-04-02'),
(4, 2, 'Eli Photon', 'Chef', 2700, '2024-04-10'),
(5, 3, 'Zara Comet', 'Server', 1850, '2025-03-03'),
(6, 4, 'Iris Orbit', 'Manager', 3300, NULL),
(7, 3, 'Axel Ray', 'Chef', 2750, '2025-03-12'),
(8, 4, 'Nina Flux', 'Server', 1920, '2025-06-22'),
(9, 5, 'Orion Pike', 'Manager', 3400, '2025-08-20'),
(10, 5, 'Kira Sun', 'Chef', 2850, '2025-09-01'),
(11, 6, 'Tara Sky', 'Server', 1950, '2025-10-09'),
(12, 7, 'Vega Bolt', 'Chef', 2900, '2026-01-11'),
(13, 8, 'Mara Ion', 'Server', 1880, NULL),
(14, 8, 'Luca Drift', 'Manager', 3350, '2026-02-03');

INSERT INTO Dishes (dish_id, restaurant_id, dish_name, category, price, is_vegan) VALUES
(1, 1, 'Nebula Burger', 'Main', 13.90, 0),
(2, 1, 'Cosmic Salad', 'Starter', 8.50, 1),
(3, 2, 'Mars Tacos', 'Main', 11.20, 0),
(4, 2, 'Red Dust Soup', 'Starter', 6.90, 1),
(5, 3, 'Venus Noodles', 'Main', 12.40, 1),
(6, 4, 'Titan Ice Cream', 'Dessert', 5.80, 1),
(7, 3, 'Orbit Pizza', 'Main', NULL, NULL),
(8, 4, 'Solar Cake', 'Dessert', 7.30, 0),
(9, 2, 'Astro Wrap', 'Main', 9.90, NULL),
(10, 5, 'Europa Risotto', 'Main', 14.20, 0),
(11, 5, 'Ice Moon Bowl', 'Starter', 7.80, 1),
(12, 6, 'Ganymede Steak', 'Main', 16.90, 0),
(13, 6, 'Crater Fries', 'Side', 4.90, 1),
(14, 7, 'Neptune Curry', 'Main', 13.60, 1),
(15, 7, 'Blue Ring Soup', 'Starter', 6.40, 1),
(16, 8, 'Pluto Pie', 'Dessert', 8.10, 0),
(17, 8, 'Dark Matter Tea', 'Drink', 3.90, 1),
(18, 1, 'Meteor Pasta', 'Main', 12.80, 0),
(19, 2, 'Galaxy Smoothie', 'Drink', 5.20, 1),
(20, 3, 'Comet Tiramisu', 'Dessert', 9.40, 0);

INSERT INTO CustomerOrders (order_id, restaurant_id, customer_name, customer_planet, order_date, total_amount) VALUES
(1, 1, 'Ben K', 'Earth', '2026-02-20', 22.40),
(2, 2, 'Aya L', 'Mars', '2026-02-21', 4.50),
(3, 3, 'Rex T', 'Venus', '2026-02-22', 18.60),
(4, 4, 'Moe P', 'Titan', '2026-02-23', 13.10),
(5, 5, 'Lio V', 'Europa', '2026-02-23', 22.00),
(6, 6, 'Sia R', 'Ganymede', '2026-02-24', 21.80),
(7, 7, 'Nox Q', 'Neptune', '2026-02-24', 20.00),
(8, 8, 'Ema J', 'Pluto', '2026-02-24', 12.00),
(9, 1, 'Kai D', 'Earth', '2026-02-25', 16.70),
(10, 5, 'Umi S', 'Europa', '2026-02-25', 3.90),
(11, 6, 'Pax H', 'Mars', '2026-02-25', 14.20),
(12, 7, 'Yara C', 'Venus', '2026-02-25', 18.90);

INSERT INTO OrderItems (order_item_id, order_id, dish_id, quantity, unit_price) VALUES
(1, 1, 1, 1, 13.90),
(2, 1, 2, 1, 8.50),
(3, 2, 6, 1, 4.50),
(4, 3, 5, 1, 12.40),
(5, 3, 8, 1, 6.20),
(6, 4, 3, 1, 11.20),
(7, 4, 4, 1, 1.90),
(8, 5, 10, 1, 14.20),
(9, 5, 11, 1, 7.80),
(10, 6, 12, 1, 16.90),
(11, 6, 13, 1, 4.90),
(12, 7, 14, 1, 13.60),
(13, 7, 15, 1, 6.40),
(14, 8, 16, 1, 8.10),
(15, 8, 17, 1, 3.90),
(16, 9, 18, 1, 12.80),
(17, 9, 19, 1, 3.90),
(18, 10, 17, 1, 3.90),
(19, 11, 13, 1, 4.90),
(20, 11, 10, 1, 9.30),
(21, 12, 14, 1, 13.60),
(22, 12, 20, 1, 5.30),
(23, 6, 19, 1, 5.20),
(24, 5, 16, 1, 7.80);


-- =====================================================
-- 1: PARTIE SIMPLE
--    avec (SELECT / WHERE / ORDER BY / DELETE)
-- =====================================================

-- 1. Lister tous les restaurants
SELECT * FROM Restaurants;

-- 2. Lister tous les plats triés par prix (du moins chere au plus chere)
SELECT dish_name, price
FROM Dishes
ORDER BY price DESC;

-- 3. Lister les employés triés par rôle
SELECT full_name, role
FROM Employees
ORDER BY role ASC, full_name ASC;

-- 4. Lister les plats végétariens (vegan ici)
SELECT dish_name, is_vegan
FROM Dishes
WHERE is_vegan = 1;

-- 5. Trouver les plats avec prix NULL
SELECT *
FROM Dishes
WHERE price IS NULL;

-- 5.2. Trouver les plats où is_vegan est NULL
SELECT *
FROM Dishes
WHERE is_vegan IS NULL;

-- 5.3. Trouver les employés où hire_date est NULL
SELECT *
FROM Employees
WHERE hire_date IS NULL;

-- 6. Supprimer les plats avec prix NULL
DELETE FROM Dishes
WHERE price IS NULL;

-- 7. Supprimer les commandes de montant < 5
DELETE FROM OrderItems
WHERE order_id IN (
    SELECT order_id
    FROM CustomerOrders
    WHERE total_amount < 5
);

DELETE FROM CustomerOrders
WHERE total_amount < 5;

-- 8. Lister les commandes triées par montant décroissant
SELECT order_id, customer_name, total_amount
FROM CustomerOrders
ORDER BY total_amount DESC;


-- =====================================================
-- 2) PARTIE AVANCÉE
-- =====================================================

-- -----------------------------------------------------
-- A. JOINTURES
-- -----------------------------------------------------

-- A1: employés + nom du restaurant
SELECT e.employee_id, e.full_name, e.role, r.name AS restaurant_name
FROM Employees e
JOIN Restaurants r ON r.restaurant_id = e.restaurant_id
ORDER BY r.name, e.full_name;

-- A2: plats commandés + client + planète
-- Relier CustomerOrders -> OrderItems -> Dishes
SELECT
    co.order_id,
    co.customer_name,
    r.planet AS restaurant_planet,
    d.dish_name,
    oi.quantity,
    oi.unit_price
FROM CustomerOrders co
JOIN OrderItems oi ON oi.order_id = co.order_id
JOIN Dishes d ON d.dish_id = oi.dish_id
JOIN Restaurants r ON r.restaurant_id = co.restaurant_id
ORDER BY co.order_id, d.dish_name;

-- A3: restaurants + nombre d'employés
SELECT r.name, COUNT(e.employee_id) AS employee_count
FROM Restaurants r
LEFT JOIN Employees e ON e.restaurant_id = r.restaurant_id
GROUP BY r.restaurant_id, r.name
ORDER BY employee_count DESC;


-- -----------------------------------------------------
-- B. AGRÉGATIONS (AVG / SUM / COUNT)
-- -----------------------------------------------------

-- B1: prix moyen des plats
SELECT ROUND(AVG(price), 2) AS avg_dish_price
FROM Dishes;

-- B2: total des ventes (depuis les lignes de commande)
SELECT ROUND(SUM(quantity * unit_price), 2) AS total_sales
FROM OrderItems;

-- B3: prix moyen par catégorie
SELECT
    category,
    ROUND(AVG(price), 2) AS avg_price_per_category
FROM Dishes
GROUP BY category
ORDER BY avg_price_per_category DESC;

-- B4: nombre d'articles par commande
SELECT
    order_id,
    SUM(quantity) AS total_items
FROM OrderItems
GROUP BY order_id
ORDER BY total_items DESC;

-- B5: nombre total d'articles + montant total pour chaque commande
SELECT
    co.order_id,
    co.customer_name,
    COALESCE(SUM(oi.quantity), 0) AS total_items,
    co.total_amount
FROM CustomerOrders co
LEFT JOIN OrderItems oi ON oi.order_id = co.order_id
GROUP BY co.order_id, co.customer_name, co.total_amount
ORDER BY co.order_id;


-- -----------------------------------------------------
-- C. SOUS-REQUÊTE
-- -----------------------------------------------------

-- C1: plats dont le prix > prix moyen
SELECT dish_name, price
FROM Dishes
WHERE price > (
    SELECT AVG(price)
    FROM Dishes
)
ORDER BY price DESC;


-- -----------------------------------------------------
-- D. UPDATE conditionnel
-- -----------------------------------------------------

-- D1: réduction intelligente
-- si price > 12  => -10%
-- sinon          => -5%
UPDATE Dishes
SET price = CASE
    WHEN price > 12 THEN ROUND(price * 0.90, 2)
    ELSE ROUND(price * 0.95, 2)
END
WHERE price IS NOT NULL;

-- N'oublié pas de recrée la base depuis zéro en cliquant sur "Nouvelle base de données", puis exécute tout le fichier d'un coup avec Ctrl+A → Exécuter. 
-- Comme ça les INSERT remettent les prix originaux et l'UPDATE s'applique une seule fois proprement.


-- -----------------------------------------------------
-- E. MINI-ANALYSE finale
-- -----------------------------------------------------

-- E1: Top 3 plats les plus chers
SELECT dish_name, price
FROM Dishes
WHERE price IS NOT NULL
ORDER BY price DESC
LIMIT 3;

-- E2: Employés dont le nom contient "a"
SELECT full_name, role
FROM Employees
WHERE full_name LIKE '%a%'
ORDER BY full_name;

