-- 1. DATABASE CREATION--

CREATE DATABASE IF NOT EXISTS banking_system;

USE banking_system;

-- drop database banking_system;

-- 2. TABLE CREATION WITH FOREIGN KEYS
CREATE TABLE Branches (
    BranchID INT PRIMARY KEY,
    BranchCode VARCHAR(20) UNIQUE,
    BranchName VARCHAR(100),
    City VARCHAR(50),
    State VARCHAR(50),
    Pincode VARCHAR(10)
);



CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerCode VARCHAR(20) UNIQUE,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50),
    Gender VARCHAR(10),
    DateOfBirth DATE,
    Phone VARCHAR(15),
    Email VARCHAR(100),
    Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    Pincode VARCHAR(10)
);



CREATE TABLE Accounts (
    AccountID INT PRIMARY KEY,
    AccountNumber VARCHAR(20) UNIQUE NOT NULL,
    CustomerID INT NOT NULL,
    BranchID INT NOT NULL,
    AccountType VARCHAR(30),
    OpenDate DATE,
    OpeningBalance DECIMAL(15,2) DEFAULT 0.00,
    CurrentBalance DECIMAL(15,2) DEFAULT 0.00,
    Status VARCHAR(20) DEFAULT 'Active',
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);


CREATE TABLE Transactions (
    TransactionID INT PRIMARY KEY,
    TransactionReference VARCHAR(30) UNIQUE NOT NULL,
    AccountID INT NOT NULL,
    TransactionDate DATETIME,
    TransactionType VARCHAR(20),
    Amount DECIMAL(15,2) NOT NULL,
    Description VARCHAR(255),
    Channel VARCHAR(30),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Beneficiaries (
    BeneficiaryID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    BeneficiaryCode VARCHAR(50) UNIQUE,
    BeneficiaryName VARCHAR(100),
    AccountNumber VARCHAR(30),
    BankName VARCHAR(100),
    IFSCCode VARCHAR(11),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


CREATE TABLE Transfers (
    TransferID INT PRIMARY KEY,
    TransferReference VARCHAR(50) UNIQUE,
    TransactionID INT,
    FromAccountID INT NOT NULL,
    BeneficiaryID INT NOT NULL,
    Amount DECIMAL(15,2),
    TransferMode VARCHAR(30),
    TransferDate DATETIME,
    Status VARCHAR(20),
    FOREIGN KEY (TransactionID) REFERENCES Transactions(TransactionID),
    FOREIGN KEY (FromAccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (BeneficiaryID) REFERENCES Beneficiaries(BeneficiaryID)
);


CREATE TABLE Loans (
    LoanID INT PRIMARY KEY,
    LoanNumber VARCHAR(30) UNIQUE,
    CustomerID INT NOT NULL,
    BranchID INT NOT NULL,
    LoanType VARCHAR(50),
    PrincipalAmount DECIMAL(12,2),
    InterestRate DECIMAL(5,2),
    TenureMonths INT,
    StartDate DATE,
    OutstandingAmount DECIMAL(12,2),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);


CREATE TABLE LoanPayments (
    PaymentID INT PRIMARY KEY,
    PaymentReference VARCHAR(50) UNIQUE,
    LoanID INT NOT NULL,
    PaymentDate DATE,
    AmountPaid DECIMAL(12,2),
    InterestComponent DECIMAL(12,2),
    PrincipalComponent DECIMAL(12,2),
    PaymentMethod VARCHAR(30),
    FOREIGN KEY (LoanID) REFERENCES Loans(LoanID)
);



CREATE TABLE AccountBalanceHistory (
    BalanceHistoryID INT PRIMARY KEY,
    AccountID INT NOT NULL,
    BalanceDate DATE,
    Balance DECIMAL(15,2),
    Source VARCHAR(50),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);


CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeNumber VARCHAR(30) UNIQUE,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    BranchID INT NOT NULL,
    Role VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    Status VARCHAR(20),
    FOREIGN KEY (BranchID) REFERENCES Branches(BranchID)
);


CREATE TABLE Cards (
    CardID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    AccountID INT NOT NULL,
    CardNumber VARCHAR(20) UNIQUE,
    CardType VARCHAR(20),
    IssueDate DATE,
    ExpiryDate DATE,
    CVV VARCHAR(4),
    Status VARCHAR(20),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);


CREATE TABLE ATMTransactions (
    ATMTransactionID INT PRIMARY KEY,
    TransactionReference VARCHAR(50) UNIQUE,
    AccountID INT NOT NULL,
    CardID INT NOT NULL,
    ATMID VARCHAR(20),
    TransactionDate DATETIME,
    TransactionType VARCHAR(30),
    Amount DECIMAL(15,2),
    Location VARCHAR(100),
    Status VARCHAR(20),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CardID) REFERENCES Cards(CardID)
);


CREATE TABLE LoginDetails (
    LoginID INT PRIMARY KEY,
    CustomerID INT NOT NULL,
    Username VARCHAR(50) UNIQUE,
    PasswordHash VARCHAR(255),
    LastLogin DATETIME,
    FailedAttempts INT DEFAULT 0,
    
    AccountStatus VARCHAR(20),
    CreatedDate DATETIME,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID));