--Create Database:
CREATE DATABASE BankingSystem;

USE BankingSystem;

--Create Table customers :
CREATE TABLE customers
(
CustomerID INT PRIMARY KEY,
CustomerName VARCHAR(50),
City VARCHAR(50),
Phone VARCHAR(15)
);

--Insert Values Into customers :
INSERT INTO customers VALUES
(1,'Samiksha','Pune','7673825758'),
(2,'Tanaya','Mumbai','8447867482'),
(3,'Siddhi','Delhi','9167385638');


--Fetch Data From customers :
SELECT * FROM customers;


--Create Table accounts :
CREATE TABLE accounts
(
AccountID INT PRIMARY KEY,
CustomerID INT,
AccountType VARCHAR(20),
Balance DECIMAL(12,2)

FOREIGN KEY (CustomerID)
REFERENCES customers(CustomerID)
);

--Insert Values Into customers :
INSERT INTO accounts VALUES
(101,1,'Savings',75000),
(102,2,'Current',55000),
(103,3,'Savings',30000);

--Fetch Data From customers :
SELECT * FROM accounts;


--Create Table transactions :
CREATE TABLE transactions
(
TransactionID INT PRIMARY KEY,
AccountID INT,
TransactionType VARCHAR(20),
Amount DECIMAL(12,2),
TransactionDate DATE DEFAULT GETDATE()

FOREIGN KEY (AccountID) 
REFERENCES accounts(AccountID)
);

--Insert Values Into customers :
INSERT INTO transactions (TransactionID,AccountID,TransactionType,Amount) VALUES
(1,101,'Deposit',10000),
(2,102,'Withdrawal',5000),
(3,103,'Deposit',15000);

--Fetch Data From customers :
SELECT * FROM transactions;


--Show Customer Accounts :
SELECT c.CustomerName,
	   a.AccountType,
	   a.Balance
FROM Customers c
INNER JOIN Accounts a
ON c.CustomerID = a.CustomerID;


--Show Transaction History :
SELECT c.CustomerName, 
	   a.AccountID,
	   t.Transactiontype,
	   t.Amount,
	   t.TransactionDate
FROM transactions t
INNER JOIN accounts a
ON a.AccountID = t.AccountID
INNER JOIN customers c
ON c.CustomerID = a.customerID;


--Total Bank Balance :
SELECT SUM(Balance) AS Total_Bank_Balance 
FROM accounts;


--Average Account Balance :
SELECT AVG(Balance) AS AverageBalance
FROM accounts;


--Customer with Highest Balance :
  --Gives Name & Balance :
SELECT TOP 1 c.CustomerName,
             a.Balance
FROM accounts a
INNER JOIN customers c
ON c.CustomerID = a.CustomerID

ORDER BY Balance DESC;

           --OR 

  --Gives Only Balance :
SELECT MAX(Balance) FROM accounts;


--Find Customers with Balance Above Average :
SELECT c.CustomerName,
       a.Balance
FROM accounts a
INNER JOIN customers c
ON c.CustomerID = a.CustomerID
WHERE 
a.Balance > (SELECT AVG(Balance) FROM accounts);


--Rank Customers by Balance :
SELECT c.CustomerName,
       a.Balance,

RANK() OVER
(ORDER BY a.Balance DESC) AS BalanceRank

FROM accounts a
INNER JOIN customers c
ON c.CustomerID = a.CustomerID;


--Top 2 Richest Customers :
SELECT TOP 2 c.CustomerName,
             a.Balance
FROM accounts a
INNER JOIN customers c
ON c.CustomerID = a.CustomerID

ORDER BY Balance DESC;


				--STORED PROCEDURE

--Procedure for Transfering Money From Sender To Receiver :
CREATE PROCEDURE TransferMoney
	@FromID INT,
	@ToID INT,
	@Amount DECIMAL(12,2)
AS 
BEGIN
	BEGIN TRY
		BEGIN TRANSACTION

		--Check Sender Account
		IF NOT EXISTS (SELECT 1 FROM accounts WHERE AccountID = @FromID)
		BEGIN 
			RAISERROR('Invalid Sender Account',16,1);
		END;

		--Check Receiver Account
		IF NOT EXISTS(SELECT 1 FROM accounts WHERE AccountID = @ToID)
		BEGIN
			RAISERROR('Invalid Receiver Account',16,1);
		END;

		--Prevent Self Transfer:
		IF @FromID = @ToID
		BEGIN
		    RAISERROR('Sender and Receiver Account Cannot Be Same',16,1);
		END;

		
        IF @Amount <= 0
        BEGIN
            RAISERROR('Invalid Transfer Amount',16,1)
        END

		--Check Balance:
		IF (SELECT Balance FROM accounts WHERE AccountID = @FromID) < @Amount
		BEGIN
			RAISERROR('Insufficient Balance',16,1);
		END;
		

		--Debit Sender:
		UPDATE accounts
		SET Balance = Balance - @Amount 
		WHERE AccountID = @FromID;
		
			
		--Credit Receiver:
		UPDATE accounts
		SET Balance = Balance + @Amount
		WHERE AccountID = @ToID;

		COMMIT TRANSACTION;

		PRINT 'Transaction Successful';

	END TRY

	BEGIN CATCH

		ROLLBACK TRANSACTION;

		PRINT 'Transaction Failed';
		PRINT ERROR_MESSAGE();
    END CATCH;
END;

--INSTEAD OF RAISERROR WE CAN ALSO USE
--THROW 50001,;'error_message',1;
			--or
--;THROW 50001,;'error_message',1;


--Check For Invalid sender Account:
EXEC TransferMoney @fromID = 104, @ToID = 102, @Amount = 500;
					
--Check For Invalid sender Account:
EXEC TransferMoney @fromID = 101, @ToID = 104, @Amount = 500;

--Check For Self Transfer Prevention:
EXEC TransferMoney @fromID = 101, @ToID = 101, @Amount = 500;

--Check For Insufficient Balance:
EXEC TransferMoney @fromID = 101, @ToID = 102, @Amount = 80000;

--Check Credit & Debit:
EXEC TransferMoney @fromID = 102, @ToID = 101, @Amount = 1000;

SELECT * FROM accounts

				--VIEW 

--Create View to View Customer Accounts :
CREATE VIEW CustomerAccounts
AS
	SELECT c.CustomerName,
	   a.AccountType,
	   a.Balance
	FROM accounts a
	INNER JOIN customers c
	ON c.CustomerID = a.CustomerID;

--Show View :
SELECT * FROM CustomerAccounts;
