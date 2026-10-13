-- 1. Display all branch details
SELECT * FROM Branches;

-- 2. Display branches in Chennai
SELECT *
FROM Branches
WHERE City = 'Chennai';

-- 3. Select First Name, Last Name and Email of all customers
SELECT FirstName, LastName, Email
FROM Customers;

-- 4. Display male customers
SELECT *
FROM Customers
WHERE Gender = 'Male';

-- 5. Display active accounts
SELECT *
FROM Accounts
WHERE Status = 'Active';

-- 6. Accounts with opening balance above 10,000
SELECT *
FROM Accounts
WHERE OpeningBalance > 10000;

-- 7. Find maximum transaction amount
SELECT MAX(Amount) AS MaximumTransactionAmount
FROM Transactions;

-- 8. Display Credit transactions
SELECT *
FROM Transactions
WHERE TransactionType = 'Credit';

-- 19. Loans with interest rate above 10%
SELECT *
FROM Loans
WHERE InterestRate > 10;

-- 10. Home Loan details and principal amount
SELECT LoanID, CustomerID, LoanType, PrincipalAmount
FROM Loans
WHERE LoanType = 'Home Loan';

-- 11. Debit card details
SELECT *
FROM Cards
WHERE CardType = 'Debit';

-- 12. ATM transactions in the last 1 week
SELECT *
FROM ATMTransactions
WHERE TransactionDate >= DATE_SUB(CURDATE(), INTERVAL 1 WEEK);

-- 13. Employees with Manager role
SELECT *
FROM Employees
WHERE Role = 'Manager';

-- 14. Users with failed attempts greater than 3
SELECT *
FROM LoginDetails
WHERE FailedAttempts > 3;

-- 15. Customer name and account number
SELECT 
    c.FirstName,
    c.LastName,
    a.AccountNumber
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- 16. Accounts with branch names
SELECT
    a.AccountNumber,
    b.BranchName
FROM Accounts a
INNER JOIN Branches b
    ON a.BranchID = b.BranchID;

-- 17. All customers and their accounts
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    a.AccountNumber
FROM Customers c
LEFT JOIN Accounts a
    ON c.CustomerID = a.CustomerID;

-- 18. Transactions with account details
SELECT
    t.TransactionID,
    t.TransactionType,
    t.Amount,
    a.AccountNumber,
    a.AccountTypeID
FROM Transactions t
INNER JOIN Accounts a
    ON t.AccountID = a.AccountID;

-- 19. Customer accounts and card details
SELECT
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    ca.CardNumber,
    ca.CardType
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN Cards ca
    ON a.AccountID = ca.AccountID;

-- 20. Customers who have loans
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    l.LoanID,
    l.LoanType,
    l.PrincipalAmount
FROM Customers c
INNER JOIN Loans l
    ON c.CustomerID = l.CustomerID;

-- 21. Loan payments with customer details
SELECT
    lp.PaymentID,
    lp.LoanID,
    lp.AmountPaid,
    c.CustomerID,
    c.FirstName,
    c.LastName
FROM Loan_Payments lp
INNER JOIN Loans l
    ON lp.LoanID = l.LoanID
INNER JOIN Customers c
    ON l.CustomerID = c.CustomerID;

-- 22. Beneficiaries with customer details
SELECT
    c.FirstName,
    c.LastName,
    b.BeneficiaryName,
    b.AccountNumber
FROM Beneficiaries b
INNER JOIN Customers c
    ON b.CustomerID = c.CustomerID;

-- 23. Transfer reference and amount
SELECT
    tr.TransferID,
    tr.TransferReference,
    t.Amount
FROM Transfers tr
INNER JOIN Transactions t
    ON tr.TransactionID = t.TransactionID;

-- 24. ATM transaction history with Cards and Accounts
SELECT
    atm.ATMTransactionID,
    atm.TransactionDate,
    atm.Amount,
    ca.CardNumber,
    a.AccountNumber
FROM ATMTransactions atm
INNER JOIN Cards ca
    ON atm.CardID = ca.CardID
INNER JOIN Accounts a
    ON ca.AccountID = a.AccountID;

-- 25. Employees with branch details
SELECT
    e.EmployeeID,
    e.EmployeeName,
    e.Role,
    b.BranchName,
    b.City
FROM Employees e
INNER JOIN Branches b
    ON e.BranchID = b.BranchID;

-- 26. Customers with username and login status
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    ld.Username,
    ld.Status
FROM Customers c
INNER JOIN LoginDetails ld
    ON c.CustomerID = ld.CustomerID;

-- 27. Account balance history
SELECT
    abh.HistoryID,
    a.AccountNumber,
    abh.Balance,
    abh.RecordDate
FROM AccountBalanceHistory abh
INNER JOIN Accounts a
    ON abh.AccountID = a.AccountID;

-- 28. Customer ID = 1: accounts, loans and cards
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    l.LoanID,
    l.LoanType,
    ca.CardNumber,
    ca.CardType
FROM Customers c
LEFT JOIN Accounts a
    ON c.CustomerID = a.CustomerID
LEFT JOIN Loans l
    ON c.CustomerID = l.CustomerID
LEFT JOIN Cards ca
    ON a.AccountID = ca.AccountID
WHERE c.CustomerID = 1;

-- 29. Number of loans approved by each branch
SELECT
    b.BranchID,
    b.BranchName,
    COUNT(l.LoanID) AS TotalLoans
FROM Branches b
LEFT JOIN Loans l
    ON b.BranchID = l.BranchID
GROUP BY b.BranchID, b.BranchName
ORDER BY TotalLoans DESC;

-- 30. Total transactions for a particular account
SELECT
    a.AccountNumber,
    COUNT(t.TransactionID) AS TotalTransactions
FROM Accounts a
INNER JOIN Transactions t
    ON a.AccountID = t.AccountID
WHERE a.AccountID = 1
GROUP BY a.AccountNumber;

-- 31. RIGHT JOIN Branches and Accounts
SELECT
    b.BranchID,
    b.BranchName,
    a.AccountID,
    a.AccountNumber
FROM Branches b
RIGHT JOIN Accounts a
    ON b.BranchID = a.BranchID;

-- 32. Cards expiring soon with customer names
SELECT
    c.FirstName,
    c.LastName,
    ca.CardNumber,
    ca.ExpiryDate
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN Cards ca
    ON a.AccountID = ca.AccountID
WHERE ca.ExpiryDate BETWEEN CURDATE()
    AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- 33. NEFT transfers with beneficiary names
SELECT
    tr.TransferID,
    tr.TransferReference,
    b.BeneficiaryName,
    tr.TransferMode
FROM Transfers tr
INNER JOIN Beneficiaries b
    ON tr.BeneficiaryID = b.BeneficiaryID
WHERE tr.TransferMode = 'NEFT';

-- 34. Customer, branch and account opening details
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    a.AccountNumber,
    b.BranchName,
    b.City,
    a.OpeningDate
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
INNER JOIN Branches b
    ON a.BranchID = b.BranchID;
    
    -- 35. Number of accounts in each branch
SELECT
    BranchID,
    COUNT(AccountID) AS TotalAccounts
FROM Accounts
GROUP BY BranchID;

-- 36. Total current balance for each customer
SELECT
    CustomerID,
    SUM(CurrentBalance) AS TotalCurrentBalance
FROM Accounts
GROUP BY CustomerID;

-- 37. Number of accounts by account type
SELECT
    at.TypeName,
    COUNT(a.AccountID) AS TotalAccounts
FROM Account_Types at
INNER JOIN Accounts a
    ON at.AccountTypeID = a.AccountTypeID
GROUP BY at.TypeName;

-- 38. Average transaction amount for each account and type
SELECT
    AccountID,
    TransactionType,
    AVG(Amount) AS AverageAmount
FROM Transactions
GROUP BY AccountID, TransactionType;

-- 39. Total outstanding loan amount branch-wise
SELECT
    BranchID,
    SUM(OutstandingAmount) AS TotalOutstandingAmount
FROM Loans
GROUP BY BranchID;

-- 40. Total ATM withdrawal amount by location
SELECT
    Location,
    SUM(Amount) AS TotalWithdrawalAmount
FROM ATMTransactions
GROUP BY Location;

-- 41. Employee count branch-wise
SELECT
    BranchID,
    COUNT(EmployeeID) AS TotalEmployees
FROM Employees
GROUP BY BranchID
ORDER BY TotalEmployees DESC;

-- 42. Number of loans for each customer
SELECT
    CustomerID,
    COUNT(LoanID) AS TotalLoans
FROM Loans
GROUP BY CustomerID
ORDER BY TotalLoans DESC;

-- 43. Minimum, maximum and average opening balance
SELECT
    MIN(OpeningBalance) AS MinimumOpeningBalance,
    MAX(OpeningBalance) AS MaximumOpeningBalance,
    AVG(OpeningBalance) AS AverageOpeningBalance
FROM Accounts;

-- 44. Total failed login attempts customer-wise
SELECT
    CustomerID,
    SUM(FailedAttempts) AS TotalFailedAttempts
FROM LoginDetails
GROUP BY CustomerID;

-- 45. Total amount paid for each loan
SELECT
    LoanID,
    SUM(AmountPaid) AS TotalAmountPaid
FROM Loan_Payments
GROUP BY LoanID;

-- 46. Customers whose total current balance is above 50,000
SELECT
    CustomerID,
    SUM(CurrentBalance) AS TotalCurrentBalance
FROM Accounts
GROUP BY CustomerID
HAVING SUM(CurrentBalance) > 50000;

-- 47. Branches having more than 5 accounts
SELECT
    BranchID,
    COUNT(AccountID) AS TotalAccounts
FROM Accounts
GROUP BY BranchID
HAVING COUNT(AccountID) > 5;

-- 48. Customers whose balance is greater than average balance
SELECT
    CustomerID,
    AccountID,
    AccountNumber,
    CurrentBalance
FROM Accounts
WHERE CurrentBalance > (
    SELECT AVG(CurrentBalance)
    FROM Accounts
);

-- 49. Details of transactions having maximum amount
SELECT *
FROM Transactions
WHERE Amount = (
    SELECT MAX(Amount)
    FROM Transactions
);

-- 50. Customers who have not taken any loan
SELECT *
FROM Customers
WHERE CustomerID NOT IN (
    SELECT CustomerID
    FROM Loans
);

-- 51. Customers who have not opened any account
SELECT *
FROM Customers
WHERE CustomerID NOT IN (
    SELECT CustomerID
    FROM Accounts
);

-- 52. Accounts that have never made a transaction
SELECT *
FROM Accounts a
WHERE NOT EXISTS (
    SELECT 1
    FROM Transactions t
    WHERE t.AccountID = a.AccountID
);

-- 53. Top 5 accounts with highest current balance
SELECT *
FROM Accounts
ORDER BY CurrentBalance DESC
LIMIT 5;

-- 54. Second highest loan amount
SELECT *
FROM Loans
WHERE PrincipalAmount = (
    SELECT MAX(PrincipalAmount)
    FROM Loans
    WHERE PrincipalAmount < (
        SELECT MAX(PrincipalAmount)
        FROM Loans
    )
);

-- 55. Accounts of customers whose first name starts with A
SELECT
    c.FirstName,
    c.LastName,
    a.AccountNumber
FROM Customers c
INNER JOIN Accounts a
    ON c.CustomerID = a.CustomerID
WHERE c.FirstName LIKE 'A%';

-- 56. Categorize accounts based on current balance
SELECT
    AccountID,
    AccountNumber,
    CurrentBalance,
    CASE
        WHEN CurrentBalance >= 100000 THEN 'High Balance'
        WHEN CurrentBalance >= 50000 THEN 'Medium Balance'
        ELSE 'Low Balance'
    END AS BalanceCategory
FROM Accounts;

-- 57. Transactions within a date range
SELECT *
FROM Transactions
WHERE TransactionDate BETWEEN '2026-01-01' AND '2026-03-31';

-- 58. Find duplicate account numbers
SELECT
    AccountNumber,
    COUNT(*) AS DuplicateCount
FROM Accounts
GROUP BY AccountNumber
HAVING COUNT(*) > 1;

-- 59. Highest loan amount in each branch
SELECT
    l.*
FROM Loans l
WHERE l.PrincipalAmount = (
    SELECT MAX(l2.PrincipalAmount)
    FROM Loans l2
    WHERE l2.BranchID = l.BranchID
);