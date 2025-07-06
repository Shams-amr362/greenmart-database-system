-- Õ–› «·Ãœ«Ê· ≈–« ﬂ«‰  „ÊÃÊœ…
DROP TABLE IF EXISTS ReturnItem;
DROP TABLE IF EXISTS "Return";
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS PurchaseOrderItem;
DROP TABLE IF EXISTS PurchaseOrder;
DROP TABLE IF EXISTS Shift;
DROP TABLE IF EXISTS Expense;
DROP TABLE IF EXISTS Discount;
DROP TABLE IF EXISTS StockTransaction;
DROP TABLE IF EXISTS InvoiceItem;
DROP TABLE IF EXISTS Invoice;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Barcode;
DROP TABLE IF EXISTS Product;
DROP TABLE IF EXISTS Category;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS "User";

-- ≈‰‘«¡ «·Ãœ«Ê·
CREATE TABLE Category (
    CategoryID INT PRIMARY KEY,
    CategoryName VARCHAR(100),
    Description TEXT
);

CREATE TABLE Product (
    ProductID INT PRIMARY KEY,
    Name VARCHAR(100),
    CategoryID INT,
    Price DECIMAL(10,2),
    QuantityInStock INT,
    ExpiryDate DATE,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

CREATE TABLE Supplier (
    SupplierID INT PRIMARY KEY,
    Name VARCHAR(100),
    ContactNumber VARCHAR(20),
    Email VARCHAR(100),
    City VARCHAR(100),
    Street VARCHAR(100)
);

CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY,
    Name NVARCHAR(100),
    Phone NVARCHAR(20),
    Email NVARCHAR(100),
    Address NVARCHAR(255),
    BirthOfDate DATE,
    Age AS DATEDIFF(YEAR, BirthOfDate, GETDATE()) -- «·⁄„— Ì „ Õ”«»Â „‰  «—ÌŒ «·„Ì·«œ
);

CREATE TABLE Invoice (
    InvoiceID INT PRIMARY KEY,
    CustomerID INT,
    InvoiceDate DATE,
    TotalAmount DECIMAL(10,2),
    DiscountApplied DECIMAL(10,2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE InvoiceItem (
    InvoiceItemID INT PRIMARY KEY,
    InvoiceID INT,
    ProductID INT,
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE StockTransaction (
    TransactionID INT PRIMARY KEY,
    ProductID INT,
    TransactionType VARCHAR(50), -- e.g., "IN", "OUT"
    TransactionDate DATE,
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE "User" (
    UserID INT PRIMARY KEY,
    Username VARCHAR(50),
    Password VARCHAR(100),
    Email VARCHAR(100),
    FullName VARCHAR(100)
);

CREATE TABLE PurchaseOrder (
    PurchaseOrderID INT PRIMARY KEY,
    SupplierID INT,
    OrderDate DATE,
    Status VARCHAR(50),
    FOREIGN KEY (SupplierID) REFERENCES Supplier(SupplierID)
);

CREATE TABLE PurchaseOrderItem (
    PurchaseOrderItemID INT PRIMARY KEY,
    PurchaseOrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (PurchaseOrderID) REFERENCES PurchaseOrder(PurchaseOrderID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Payment (
    PaymentID INT PRIMARY KEY,
    InvoiceID INT,
    PaymentDate DATE,
    AmountPaid DECIMAL(10,2),
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID)
);

CREATE TABLE "Return" (
    ReturnID INT PRIMARY KEY,
    InvoiceID INT,
    CustomerID INT,
    ReturnDate DATE,
    Reason TEXT,
    FOREIGN KEY (InvoiceID) REFERENCES Invoice(InvoiceID),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

CREATE TABLE ReturnItem (
    ReturnItemID INT PRIMARY KEY,
    ReturnID INT,
    ProductID INT,
    Quantity INT,
    Condition VARCHAR(50),
    FOREIGN KEY (ReturnID) REFERENCES "Return"(ReturnID),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

CREATE TABLE Discount (
    DiscountID INT PRIMARY KEY,
    Description TEXT,
    DiscountType VARCHAR(50), -- e.g., "Percentage", "Fixed"
    StartDate DATE,
    EndDate DATE
);

CREATE TABLE Expense (
    ExpenseID INT PRIMARY KEY,
    ExpenseType VARCHAR(100),
    Amount DECIMAL(10,2),
    Description TEXT,
    Date DATE
);
CREATE TABLE Shift (
    ShiftID INT PRIMARY KEY,
    UserID INT,
    StartTime DATETIME,
    EndTime DATETIME,
    TotalSales DECIMAL(10,2),
    FOREIGN KEY (UserID) REFERENCES "User"(UserID)
); 
CREATE TABLE Barcode (
    BarcodeID INT PRIMARY KEY,
    ProductID INT,
    BarcodeNumber VARCHAR(100),
    Format VARCHAR(50),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);

-- ≈÷«›… »Ì«‰«  ≈·Ï «·Ãœ«Ê·
INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (1, 'Dairy', 'Milk and cheese products');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (2, 'fruits', 'apples,bananas,orange');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (3, 'Meat', 'beef,chicken,turkey,Meat');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (4, 'seafood', 'fish,salmon,shrimp,tuna');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (5, 'Backery', 'bread,rolls,cakes');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (6, 'frozen foods', 'frozen pizza,ice cream');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (7, 'pantry staples', 'rice,pasta,flour,sugar');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (8, 'snacks', 'chips,chocolate,nuts,cookies');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (9, 'drinks', 'juice,tea,coffee,soda,water');

INSERT INTO Category (CategoryID, CategoryName, Description)
VALUES (10, 'personal care', 'shampoo,soap,toothpaste,deodorant');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (1, 'Milk', 1, 30, 100, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (2, 'cheese', 1, 10.50, 100, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (3, 'apple', 2, 20, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (4, 'banana', 2, 20, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (5, 'orange', 2, 20, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (6, 'beef', 3, 100, 100, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (7, 'chicken', 3, 150, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (8, 'turkey', 3, 60, 70, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (9, 'meat', 3,300, 100, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (10, 'fish', 4, 200, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (11, 'salmon', 4, 80, 80, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (12, 'shrimp', 4, 250, 90, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (13, 'tuna', 4, 40, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (14, 'bread', 5, 20, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (15, 'rolls', 5, 15, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (16, 'cake', 5, 50, 10, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (17, 'frozen pizza', 6, 100, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (18, 'ice cream', 6, 20, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (19, 'rice', 7, 40, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (20, 'pasta', 7, 15, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (21, 'fiour', 7, 10, 70, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (22, 'sugar', 7, 50, 200, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (23, 'chips', 8, 10, 500, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (24, 'chocolate', 8, 30, 200, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (25, 'nuts', 8, 25, 500, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (26, 'cookies', 8, 50, 300, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (27, 'juice', 9, 10, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (28, 'tea', 9, 15, 100, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (29, 'coffee', 9, 20, 100, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (30, 'water', 9, 5, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (31, 'shampoo', 10, 160, 20, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (32, 'soap', 10, 20, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (33, 'toothpaste', 10, 100, 50, '2025-12-01');

INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (34, 'deodorant', 10, 200, 50, '2025-12-01');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (1, 'Dairy suppliers', '0123456789', 'info@dairy.com', 'Cairo', 'Tahrir Street');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (2, 'Fruits', '0125423789', 'info@fruits.com', 'Cairo', 'obour city');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (3, 'meat&poultry', '0123456123', 'info@meat&poultry.com', 'Cairo', '6th of october');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (4, 'seafood ', '01234123123', 'info@seafood.com', 'Cairo', 'giza');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (5, 'Bakery ', '016734123123', 'info@Bakery.com', 'Cairo', 'Beheira');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (6, 'frozen food ', '016734432123', 'info@frozen food.com', 'Cairo', 'Alx');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (7, 'snacks ', '01673445623', 'info@snacks.com', 'Cairo', 'Nasr city');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (8, 'drinks ', '012334432123', 'info@drinks.com', 'Cairo', '6th of october');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (9, 'personal care ', '012334432555', 'info@personalcare.com', 'Cairo', '10th of Ramadan');

INSERT INTO Supplier (SupplierID, Name, ContactNumber, Email, City, Street)
VALUES (10, 'pantry staples ', '012334432123', 'info@pantrystaples.com', 'Cairo', 'cairo');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (1, 'Ahmed Ali', '0101234567', 'ahmed@example.com', 'Cairo, Tahrir', '1995-01-01');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (2, 'saber Amr', '010156668', 'saber@example.com', 'Cairo', '2013-07-20');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (3, 'marwan Amr', '01044490567', 'marwan@example.com', 'Cairo', '2016-11-10');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (4, 'Hamzah moataz', '0101554567', 'Hamza@example.com', 'Cairo, ', '2015-01-01');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (5, 'Omar samy', '01012567567', 'omar@example.com', 'Cairo, ', '2014-04-01');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (6, 'Abdo Ahmed', '01012345123', 'Abdo@example.com', 'Cairo, ', '2013-01-17');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (7, 'sham Amr', '0101234567', 'sham@example.com', 'Cairo, ', '2024-3-13');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (8, 'makkah moataz', '0101234123', 'makah@example.com', 'Cairo, ', '2019-4-20');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (9, 'salma moataz', '010153884567', 'salma@example.com', 'Cairo, ', '2010-4-15');

INSERT INTO Customer (CustomerID, Name, Phone, Email, Address, BirthOfDate)
VALUES (10, 'Ahlam omar', '010155674567', 'ahlam@example.com', 'Cairo, ', '1994-01-01');
-- ≈‰‘«¡ «·Ãœ«Ê· «·„ »ﬁÌ… »⁄œ ÃœÊ· Customer



-- ≈÷«›… »Ì«‰«  ≈·Ï «·Ãœ«Ê· «·„ »ﬁÌ…
INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (1, 1, '2025-04-20', 105.00, 5.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (2, 5, '2025-03-25', 350.00, 40.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (3, 6, '2025-02-26', 400.00, 10.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (4, 10, '2025-04-11', 100.00, 8.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (5, 4, '2025-04-9', 30.00, 0.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (6, 7, '2025-03-15', 80.00, 1.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (7, 8, '2025-04-20', 120.00, 5.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (8, 2, '2025-02-04', 180.00, 5.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (9, 1, '2025-04-25', 400.00, 5.00);

INSERT INTO Invoice (InvoiceID, CustomerID, InvoiceDate, TotalAmount, DiscountApplied)
VALUES (10, 6, '2025-04-29', 500.00, 20.00);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (1, 1, 1, 2, 10.50);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (2, 8, 20, 7, 50);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (3, 10, 34, 3, 50);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (4, 7, 15, 4, 100);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (5, 9, 20, 1, 100);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (6, 4, 30, 1, 200);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (7, 5, 22, 9, 10);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (8, 2, 33, 1, 30);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (9, 6, 27, 3, 10.50);

INSERT INTO InvoiceItem (InvoiceItemID, InvoiceID, ProductID, Quantity, UnitPrice)
VALUES (10, 3, 29, 1, 5);

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (1, 1, 'purchase', '2025-04-20');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (2, 30, 'sales', '2025-03-20');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (3, 15, 'Return to supplier', '2025-04-15');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (4, 10, 'customer Return', '2025-03-22');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (5, 11, 'stock Adjustment', '2025-03-10');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (6, 18, 'promotion', '2025-04-26');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (7, 14, 'consignment', '2025-03-11');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (8, 27, 'payment transaction', '2025-04-2');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (9, 33, 'Refund', '2025-04-25');

INSERT INTO StockTransaction (TransactionID, ProductID, TransactionType, TransactionDate)
VALUES (10, 19, 'stock transfer', '2025-03-30');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (1, 'admin', 'password123', 'admin@example.com', 'Admin User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (2, 'EMP1001', 'password456', 'EMP1001@example.com', 'EMP1001 User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (3, 'admin334', '5555559123', 'admin334@example.com', 'Admin334 User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (4, 'shams', '4999978123', 'shams@example.com', 'shams User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (5, 'habiba', '0188834123', 'habiba@example.com', 'habiba User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (7, 'Abrar', '888292123', 'abrar@example.com', 'Abrar User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (8, 'Nouran', '5558888123', 'nouran@example.com', 'nouran User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (9, 'Eyad', 'password4444', 'eyad@example.com', 'Eyad User');

INSERT INTO "User" (UserID, Username, Password, Email, FullName)
VALUES (10, 'ad335', '11002233', 'ad335@example.com', 'ad335 User');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (1, 1, '2025-04-20', 'Pending');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (2, 2, '2025-04-25', 'confirmed');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (3, 3, '2025-04-30', 'Shipped');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (4, 4, '2025-04-15', 'Delivered');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (5, 5, '2025-04-22', 'Cancelled');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (6, 6, '2025-04-23', 'Returned');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (7, 7, '2025-04-15', 'failed');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (8, 8, '2025-04-25', 'completed');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (9, 9, '2025-04-19', 'Pending');

INSERT INTO PurchaseOrder (PurchaseOrderID, SupplierID, OrderDate, Status)
VALUES (10, 10, '2025-04-29', 'Refunded');

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (1, 1, 1, 14);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (2, 2, 29, 22);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (3, 3, 19, 15);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (4, 4, 20, 11);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (5, 5, 30, 10);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (6, 6, 17, 20);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (7, 7, 15, 90);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (8, 8, 22, 30);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (9, 9, 33, 20);

INSERT INTO PurchaseOrderItem (PurchaseOrderItemID, PurchaseOrderID, ProductID, Quantity)
VALUES (10, 10, 11, 10);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (1, 1, '2025-04-21', 110.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (2, 2, '2025-04-20', 90.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (3, 3, '2025-04-11', 400.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (4, 4, '2025-04-14', 80.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (5, 5, '2025-04-15', 240.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (6, 6, '2025-04-22', 350.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (7, 7, '2025-04-29', 300.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (8, 8, '2025-04-30', 105.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (9, 9, '2025-04-22', 200.00);

INSERT INTO Payment (PaymentID, InvoiceID, PaymentDate, AmountPaid)
VALUES (10, 10, '2025-04-30', 100.00);

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (1, 1, 1, '2025-04-22', 'incorrect price');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (2, 2, 2, '2025-04-25', 'short supplied');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (3, 3, 3, '2025-04-23', 'over supplied');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (4, 4, 4, '2025-04-12', 'Order issues');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (5, 5, 5, '2025-04-15', 'Packaging Damage');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (6, 6, 6, '2025-04-21', 'Defective item');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (7, 7, 7, '2025-04-19', 'Wrong item Delivered');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (8, 8, 8, '2025-04-15', 'Expired product');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (9, 9, 9, '2025-04-17', 'Damaged item');

INSERT INTO "Return" (ReturnID, InvoiceID, CustomerID, ReturnDate, Reason)
VALUES (10, 10, 10, '2025-04-10', ' product issues');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (1, 1, 1, 1, 'incorrect price');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (2, 2, 2, 2, 'short supplied');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (3, 3, 3, 3, 'over supplied');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (4, 4, 4, 4, 'Order issues');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (5, 5, 5, 5, 'Packaging Damage');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (6, 6, 6, 6, 'Defective item');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (7, 7, 7, 7, 'Wrong item Delivered');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (8, 8, 8, 8, 'Expired product');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (9, 9, 19, 19, 'Damaged item');

INSERT INTO ReturnItem (ReturnItemID, ReturnID, ProductID, Quantity, Condition)
VALUES (10, 10, 10, 10, 'Defective');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (1, 'Spring Sale', 'Percentage', '2025-04-01', '2025-04-30');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (2, 'Ramadan offer', 'Fixed amount', '2025-03-01', '2025-04-01');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (3, 'Back to school', 'Buy x get y', '2025-04-01', '2025-04-30');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (4, 'Eid promotion', 'volume', '2025-04-01', '2025-04-06');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (5, 'Black friday', 'seasonal', '2025-05-02', '2025-05-03');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (6, 'Anniversary sale', 'Clearance ', '2025-04-01', '2025-04-30');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (7, 'New Branch openning offer', 'loyalty', '2025-05-01', '2025-05-02');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (8, 'flash sale', 'Employee ', '2025-04-11', '2025-04-15');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (9, 'Mid-year sale', 'supplier promotion', '2025-05-01', '2025-05-04');

INSERT INTO Discount (DiscountID, Description, DiscountType, StartDate, EndDate)
VALUES (10, 'Buy More Save more', 'coupon', '2025-05-01', '2025-05-03');
INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (1, 'Office Supplies', 55.00, 'purchased printer ink for cashier office', '2025-04-25');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (2, 'Rent', 10.00, 'Monthly rent payment for main branch', '2025-04-11');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (3, 'Utilities', 30.00, 'Electricity bill for branch Nasr city', '2025-04-25');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (4, 'Salaries and wages', 15.00, 'April salaries for staff', '2025-04-12');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (5, 'maintenance and Repairs', 20.00, 'Repair of dairy fridge', '2025-04-29');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (6, 'marketing and advertising', 22.00, 'Facebook campaign for Ramadan offer', '2025-04-26');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (7, 'transportation and Delivery', 45.00, 'Delivery charges for supplier shipment', '2025-04-30');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (8, 'Licenses and permits', 33.00, 'Renewal of bussiness license for branch', '2025-04-13');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (9, 'insurance ', 10.00, 'Insurance premium payment for store assets', '2025-04-10');

INSERT INTO Expense (ExpenseID, ExpenseType, Amount, Description, Date)
VALUES (10, 'Bank charges and fees', 11.00, 'monthly POS machine fee', '2025-04-29');

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (1, 1, '2025-04-26 01:30', '2025-04-26 3:00', 115.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (2,2, '2025-04-16 02:30', '2025-04-16 10:30', 500.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (3, 3, '2025-04-11 03:30', '2025-04-11 11:30', 200.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (4, 4, '2025-04-20 09:00', '2025-04-20 17:00', 200.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (5, 5, '2025-04-25 03:00', '2025-04-25 13:00', 110.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (6, 6, '2025-04-24 06:00', '2025-04-24 14:00', 230.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (7, 7, '2025-04-23 07:00', '2025-04-23 15:00', 250.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (8, 8, '2025-04-22 08:00', '2025-04-22 16:00', 100.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (9, 9, '2025-04-21 09:00:00', '2025-04-21 17:00:00', 500.00);

INSERT INTO Shift (ShiftID, UserID, StartTime, EndTime, TotalSales)
VALUES (10, 10, '2025-04-20 10:00', '2025-04-20 18:00', 300.00);

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (1, 1, '123456781232', 'EAN-6');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (2, 2, '123678789012', 'EAN-7');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (3, 3, '1234520209012', 'EAN-8');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (4, 4, '123456789011', 'EAN-9');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (5, 5, '123456789010', 'EAN-10');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (6, 6, '123412339012', 'EAN-11');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (7, 7, '123456700012', 'EAN-12');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (8, 8, '1234567000012', 'EAN-15');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (9, 9, '123454449012', 'EAN-14');

INSERT INTO Barcode (BarcodeID, ProductID, BarcodeNumber, Format)
VALUES (10, 10, '12345555789012', 'EAN-23');

SELECT 
    product.ProductID,
    product.Name,
    category.CategoryName
FROM 
    product
JOIN 
    category ON product.categoryid = category.categoryid;

-- «” ⁄·«„«  ·· √ﬂœ „‰ «·»Ì«‰«  «·„œŒ·…

-- ≈⁄ÿ«¡ ’·«ÕÌ«  ··„” Œœ„Ì‰
GRANT SELECT, INSERT ON Product TO shams;
GRANT UPDATE ON Product TO habiba;

-- ”Õ» ’·«ÕÌ… INSERT 
REVOKE INSERT ON Product FROM abrar;

-- »œ¡ „⁄«„·… (Transaction)
BEGIN TRANSACTION;

UPDATE Product
SET Price = 80
WHERE ProductID = 34;

-- ≈÷«›… „‰ Ã ÃœÌœ
INSERT INTO Product (ProductID, Name, CategoryID, Price, QuantityInStock, ExpiryDate)
VALUES (35, 'Vcola', 9, 40, 50, '2025-12-01');



-- Õ–› „‰ Ã
DELETE FROM Product
WHERE ProductID = 32;

--  ›Ì Õ«·… ÕœÊÀ Œÿ√° Ì„ﬂ‰ «· —«Ã⁄ ⁄‰ «·„⁄«„·…
 --ROLLBACK;


--  ÕœÌÀ ”⁄— „‰ Ã
SELECT * FROM Category;
SELECT * FROM Product;
SELECT * FROM Supplier;
SELECT * FROM Customer;
-- «” ⁄·«„«  ·· √ﬂœ „‰ «·»Ì«‰«  «·„œŒ·…
SELECT * FROM Invoice;
SELECT * FROM InvoiceItem;
SELECT * FROM StockTransaction;
SELECT * FROM "User";
SELECT * FROM PurchaseOrder;
SELECT * FROM PurchaseOrderItem;
SELECT * FROM Payment;
SELECT * FROM "Return";
SELECT * FROM ReturnItem;
SELECT * FROM Discount;
SELECT * FROM Expense;
SELECT * FROM Shift;
SELECT * FROM Barcode;


-- Õ›Ÿ «· €ÌÌ—«  ‰Â«∆Ì«
COMMIT;
 

