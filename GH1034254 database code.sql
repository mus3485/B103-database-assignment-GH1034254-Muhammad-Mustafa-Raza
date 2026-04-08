CREATE DATABASE Ecommerce_assignment;

USE Ecommerce_assignment;

CREATE TABLE Users (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address TEXT,
    City VARCHAR(50)
);

CREATE TABLE Products (
    ProductID INT PRIMARY KEY AUTO_INCREMENT,
    ProductName VARCHAR(100) NOT NULL,
    Price DECIMAL(10, 2) NOT NULL
);


CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    OrderDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
);


CREATE TABLE Order_Items (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    ProductID INT,
    Quantity INT DEFAULT 1,
    PriceAtPurchase DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    CustomerID INT, 
    TransactionDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod VARCHAR(50),
    PaymentStatus VARCHAR(20) DEFAULT 'Completed', 
    Amount DECIMAL(10, 2),
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID),
    FOREIGN KEY (CustomerID) REFERENCES Users(UserID)
    );

    
INSERT INTO Users (FullName, Email, Phone, Address, City) VALUES 
('Alice Smith', 'alice@mail.com', '+49 123', 'Street 1', 'Aachen'), 
('Zack Anderson', 'anderson@mail.com', '+49 456', 'Street 2', 'Berlin'),
('Beatrix Kiddo', 'kiddo@mail.com', '+49 789', 'Street 3', 'Munich'),
('Amara Okafor', 'okafor@mail.com', '+49 101', 'Street 4', 'Hamburg'),
('David Miller', 'miller@mail.com', '+49 202', 'Street 5', 'Berlin');


INSERT INTO Products (ProductName, Price) VALUES 
('Smartphone', 800.00), ('Desk Lamp', 45.00), ('Gaming Chair', 250.00);


INSERT INTO Orders (CustomerID) VALUES (1), (3), (4), (2), (5);


INSERT INTO Order_Items (OrderID, ProductID, Quantity, PriceAtPurchase) VALUES 
(1, 2, 1, 45.00), (2, 1, 1, 800.00), (3, 2, 1, 45.00), (4, 3, 1, 250.00), (5, 1, 1, 800.00);

-- 11. Insert 5 Transactions
INSERT INTO Transactions (OrderID, CustomerID, PaymentMethod, Amount) VALUES 
(1, 1, 'Credit Card', 45.00), 
(2, 3, 'PayPal', 800.00), 
(3, 4, 'Bank Transfer', 45.00), 
(4, 2, 'Credit Card', 250.00), 
(5, 5, 'Credit Card', 800.00);


SELECT 
    U.FullName AS 'Customer', 
    P.ProductName AS 'Item', 
    T.Amount AS 'Paid', 
    T.PaymentStatus AS 'Status',
    T.TransactionDate AS 'Date'
FROM Users U
LEFT JOIN Orders O ON U.UserID = O.CustomerID
JOIN Order_Items OI ON O.OrderID = OI.OrderID
JOIN Products P ON OI.ProductID = P.ProductID
RIGHT JOIN Transactions T ON O.OrderID = T.OrderID
ORDER BY U.FullName ASC;