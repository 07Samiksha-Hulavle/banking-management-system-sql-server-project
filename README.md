# 🏦 Banking Management System using SQL Server

# 📌 Project Overview
This project is a Banking Management System developed using SQL Server to simulate real-world banking operations. The system manages customers, accounts, and financial transactions while implementing secure transaction processing through stored procedures, transaction management, and error handling mechanisms.

The project demonstrates essential database concepts and business logic commonly used in banking applications.

# 🛠️ Technologies Used
* SQL Server
* SQL Server Management Studio (SSMS)
 
# 📂 Database Structure
# Customers
Stores customer information including:
* Customer ID
* Customer Name
* City
* Phone Number

# Accounts
Stores account-related information:
* Account ID
* Customer ID
* Account Type
* Account Balance

# Transactions
Stores transaction history:
* Transaction ID
* Account ID
* Transaction Type (Deposit/Withdrawal)
* Amount
* Transaction Date

# ✨ Features Implemented
✅ Database Creation
✅ Table Creation with Relationships
✅ Primary Key and Foreign Key Constraints
✅ Customer Account Management
✅ Transaction Tracking
✅ INNER JOIN Queries
✅ Aggregate Functions
✅ Stored Procedures
✅ TRY-CATCH Error Handling
✅ Transaction Management
✅ COMMIT and ROLLBACK Operations
✅ Business Rule Validations

# 📊 SQL Concepts Covered
* Relational Database Design
* Primary Keys
* Foreign Keys
* Joins
* Aggregate Functions
* Subqueries
* Stored Procedures
* Views
* Transaction Management
* TRY...CATCH Blocks
* Error Handling using RAISERROR / THROW

# 🔍 Sample Business Queries
* Display customer account details
* View transaction history
* Calculate total bank funds
* Find average account balance
* Identify customers with above-average balances
* Rank customers based on account balances
* Generate account statements
* Perform secure money transfers

# 🔒 Banking Validations Implemented
The money transfer procedure validates:
* Sender account exists
* Receiver account exists
* Transfer amount is greater than zero
* Sender and receiver accounts are different
* Sufficient account balance is available

If any validation fails:
* Transaction is rolled back
* Error message is generated
* Data consistency is maintained

# ⚙️ Transaction Flow
1. Validate sender account
2. Validate receiver account
3. Validate transfer amount
4. Validate account balance
5. Debit sender account
6. Credit receiver account
7. Commit transaction if successful
8. Rollback transaction if an error occurs

# 🎯 Learning Outcomes
Through this project, I gained hands-on experience in:
* Database design and normalization
* SQL query writing
* Transaction management
* Error handling techniques
* Implementing business logic using stored procedures
* Managing relational data in SQL Server

# 🚀 Future Enhancements
* Loan Management Module
* Credit Score Tracking
* ATM Transaction Simulation
* Interest Calculation System
* Trigger-Based Auditing
* Monthly Financial Reports
* User Authentication System

# 💡 Project Goal
The objective of this project is to strengthen SQL Server skills by implementing a practical banking application that demonstrates real-world database operations, transaction handling, and business rule validation.
