CREATE TABLE alayta_bank(
	customerid INT,
	customername VARCHAR(255),
	loanid INT,
	loanamount DECIMAL(15,2),
	loaninterestrate DECIMAL(15,2),
	loanduration VARCHAR(50),
	loanstartdate DATE,
	officerid INT,
	officername VARCHAR(255),
	officerphone VARCHAR(50),
	officeremail VARCHAR(255),
	branchid INT,
	brachname VARCHAR(50),
	branchaddress VARCHAR(255),
	paymentid INT,
	paymentdate DATE,
	paymentamount DECIMAL(15,2),
	transactionid INT,
	transactiondate DATE, 
	transactiontype VARCHAR(50)
);


CREATE TABLE customers(
	customerid INT,
	customername VARCHAR(255)
);

INSERT INTO customers
SELECT customerid, customername
FROM alayta_bank;

CREATE TABLE loan(
	loanid INT,
	loanamount DECIMAL(15,2),
	loaninterestrate DECIMAL(15,2),
	loanduration VARCHAR(50),
	loanstartdate DATE
);

INSERT INTO loan
SELECT loanid,loanamount, loaninterestrate, loanduration, loanstartdate
FROM alayta_bank;


CREATE TABLE office(
	officerid INT,
	officername VARCHAR(255),
	officerphone VARCHAR(50),
	officeremail VARCHAR(255)
);

INSERT INTO office
SELECT officerid,officername,officerphone,officeremail
FROM alayta_bank;

CREATE TABLE branch(
	branchid INT,
	brachname VARCHAR(50),
	branchaddress VARCHAR(255)
);

INSERT INTO branch
SELECT branchid, brachname, branchaddress
FROM alayta_bank;


CREATE TABLE payment(
	paymentid INT,
	paymentdate DATE,
	paymentamount DECIMAL(15,2)
);

INSERT INTO payment
SELECT paymentid, paymentdate,paymentamount
FROM alayta_bank;


CREATE TABLE transaction(
	transactionid INT,
	transactiondate DATE, 
	transactiontype VARCHAR(50)
);

INSERT INTO transaction
SELECT transactionid, transactiondate, transactiontype
FROM alayta_bank;

--1 Retrieve all distinct loan officers from the dataset.
SELECT DISTINCT officername
FROM office;

-- 2 Count the total number of loans managed by each officer
SELECT  officername, COUNT(officerid)
FROM office
GROUP by officername;

--3.Find the total loan amount managed by the officer 'Katherine Dennis'.

SELECT sum(loanamount)
FROM alayta_bank
WHERE officername = 'Katherine Dennis';

--4 List all loans with a duration of more than 36 months.
SELECT loanID, customerid, loanamount, loanduration
FROM alayta_bank
WHERE loanduration > '36 months';


--5. Which branch has the highest total loan amount?

SELECT branchid, brachname, SUM(loanamount)
FROM alayta_bank
GROUP BY branchid, brachname
LIMIT 1;

--6. Find the average loan interest rate for loans starting after January 1, 2022.
SELECT COUNT(loaninterestrate), SUM(loaninterestrate), AVG(loaninterestrate)
FROM alayta_bank
WHERE loanstartdate > '2022-01-01';

--7 Count how many loans have a loan amount greater than $20,000.
SELECT COUNT(loanamount)
FROM alayta_bank
WHERE loanamount > 20000

--8. Find the customer IDs and loan amounts for customers who have made 'Interest Payment'.

SELECT customerid, loanamount
FROM alayta_bank
WHERE transactiontype = 'Interest Payment';

--9.List the officer names and phone numbers for all officers who manage loans in the 'Perez, James and Cook' branch.

SELECT officername, officerphone
FROM alayta_bank
WHERE brachname = 'Perez, James and Cook';

--10.What is the total payment amount made by the customer 'James Allen'?

SELECT SUM(paymentamount)
FROM alayta_bank
WHERE customername = 'James Allen';

--11.Find the total number of payments made in 2023.

SELECT COUNT(paymentamount)
FROM alayta_bank
WHERE EXTRACT (YEAR FROM paymentdate) = 2023;


SELECT COUNT(*) AS total_payments
FROM alayta_bank
WHERE EXTRACT(YEAR FROM PaymentDate) = 2023;

--12 Which loan has the highest loan interest rate, and who is the officer in charge?

SELECT officername, officerid, loaninterestrate
FROM alayta_bank
GROUP BY officername, officerid, loaninterestrate
ORDER BY loaninterestrate DESC
LIMIT 1;

--13.Find the average loan duration for each branch.

SELECT branchid, brachname, AVG(CAST(SPLIT_PART(loanduration, ' ', 1) AS INTEGER)) AS avg_loan_duration
FROM alayta_bank
GROUP BY branchid, brachname;


--14.List all customers who have made at least one 'Principal Payment'.
SELECT customerid, customername, transactiontype, count(transactiontype)
FROM alayta_bank
WHERE transactiontype = 'Principal Payment'
GROUP BY customerid, customername, transactiontype;

--15.Which loan has the earliest start date in the dataset?
SELECT customerid, customername, loanid, loanstartdate
FROM alayta_bank
GROUP BY customerid, customername, loanid, loanstartdate
ORDER BY loanstartdate ASC
LIMIT 1;


--16 Retrieve the total payment amount for each loan.

SELECT a.customerid, a.customername, a.loanid, (a.loanamount+a.paymentamount) AS total_payment_amount
FROM alayta_bank a
GROUP BY a.customerid, a.customername, a.loanid,a.loanamount,a.paymentamount
ORDER BY a.customerid ASC;


--17 Which customer has made the largest single payment, and how much was it?

SELECT DISTINCT a.customerid, a.customername, a.loanid, (a.loanamount+a.paymentamount) AS total_payment_amount
FROM alayta_bank a
GROUP BY a.customerid, a.customername, a.loanid,a.loanamount,a.paymentamount
ORDER BY total_payment_amount DESC
LIMIT 1;


--18.Find the total loan amount for loans with a duration of 12 months.
SELECT loanduration, sum(loanamount) AS total_loan_amount
FROM alayta_bank
WHERE loanduration = '12 months'
GROUP BY loanduration;

--19.List the names and emails of loan officers who are managing more than 3 loans.

SELECT DISTINCT officername, officeremail, COUNT(officername) AS A
FROM alayta_bank
GROUP BY officername, officeremail
HAVING COUNT(officername) >3;

--20. Find the branch with the most transactions in 2023.

SELECT brachname, COUNT(transactiondate) 
FROM alayta_bank
WHERE EXTRACT(YEAR FROM transactiondate) = 2023
GROUP BY  brachname
ORDER BY COUNT(transactiondate) DESC;
















