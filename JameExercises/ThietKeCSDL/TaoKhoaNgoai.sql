CREATE TABLE customers(
   id INT IDENTITY(1,1) PRIMARY KEY,
   name VARCHAR(40),
   address VARCHAR(255),
   email VARCHAR(255)
);
CREATE TABLE orders(
   id INT IDENTITY(1,1),
   staff VARCHAR(50),
   PRIMARY KEY(id),
   customer_id INT FOREIGN KEY REFERENCES customers(id)
);
-- Ngoài ra
/*CREATE TABLE orders(
   id INT IDENTITY(1,1) PRIMARY KEY,
   staff VARCHAR(50),
   customer_id INT,
   FOREIGN KEY (customer_id) REFERENCES customers(id)
);*/