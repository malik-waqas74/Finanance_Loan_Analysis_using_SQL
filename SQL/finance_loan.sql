use Finance_Loan

-- Total Loan Applications
SELECT COUNT(id) as Total_Applications from 
financial_loan_data

-- Month To Date
SELECT COUNT(id) as Total_Applications
from financial_loan_data
WHERE MONTH(issue_date) = 12

--Month To Month
SELECT COUNT(id) as Total_Applications
from financial_loan_data
WHERE MONTH(issue_date) = 11


--Total Funded Amount

SELECT SUM(loan_amount) as Total_Funded_Amount
from financial_loan_data

SELECT SUM(loan_amount) as Total_Funded_Amount
from financial_loan_data
WHERE MONTH(issue_date) = 12

SELECT SUM(loan_amount) as Total_Funded_Amount
from financial_loan_data
WHERE MONTH(issue_date) = 11

-- Total Amount Received


SELECT SUM(total_payment) as Total_Recieved_Amount
from financial_loan_data

SELECT SUM(total_payment) as Total_Paid_Amount
from financial_loan_data
WHERE MONTH(issue_date) = 12

SELECT SUM(total_payment) as Total_Paid_Amount
from financial_loan_data
WHERE MONTH(issue_date) = 11

--Average Interest Rate


SELECT round(AVG(int_rate) * 100,2) as Average_Interst_Rate
from financial_loan_data
--Month to Date
SELECT round(AVG(int_rate) * 100,2) as Average_Interst_Rate
from financial_loan_data
WHERE MONTH(issue_date) = 12
--Month To Month


--Average Debt-to-Income Ratio (DTI)

SELECT round(AVG(dti)*100,2) as Average_DTI
FROM financial_loan_data
--Month to Date
SELECT round(AVG(dti)*100,2) as Average_DTI
FROM financial_loan_data
WHERE MONTH(issue_date) = 12
--Month to Month


--Good Loan KPIs:
--Good Loan Application Percentage: 
--We need to calculate the percentage of loan applications
--classified as 'Good Loans.' 
--This category includes loans with
--a loan status of 'Fully Paid' and 'Current.'

SELECT count(loan_status) as Total_Loan_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Paid_Amount

from financial_loan_data
where loan_status='Fully Paid' or 
loan_status = 'Current'

select top 6 * from financial_loan_data
--Good Loan Percentage
SELECT
    (COUNT(CASE WHEN loan_status = 'Fully Paid' OR loan_status = 'Current' THEN id END) * 100.0) / 
	COUNT(id) AS Good_Loan_Percentage
FROM financial_loan_data

--Bad Loan KPIs:
--Bad Loan Application Percentage:
--Calculating the percentage of loan applications
--categorized as 'Bad Loans.'
--This category specifically includes loans with
--a loan status of 'Charged Off.'

SELECT COUNT(id) as Total_Bad_Applications,
sum(loan_amount) as Total_Funded_Amount,
sum(total_payment) as Total_Paid_Amount
from financial_loan_data
where loan_status='Bad Loans' or loan_status='Charged Off'

--Bad Loan Percentage
SELECT (COUNT(CASE WHEN loan_status = 'Bad Loans' or 
loan_status='Charged Off' then id end) *100.0)/
COUNT(id) as Bad_Loan_Percentage
FROM financial_loan_data

--Loan Status
select top 6 * from financial_loan_data

SELECT
loan_status,
COUNT(id) as Total_Loan_Count,
SUM(loan_amount) as Total_Loan,
SUM(total_payment) as Total_Paid,
AVG(int_rate * 100) as Interst_Rate,
AVG(dti * 100) as DTI
from financial_loan_data
group by loan_status

--Now MTD MTM

SELECT loan_status,
sum(loan_amount) as Total_Loan_Amount,
sum(total_payment) as Total_Payment_Recieved
FROM
financial_loan_data
where MONTH(issue_date) = 12 
group by loan_status

--Create the complete report 
-- based on the each month

SELECT 
MONTH(issue_date) as Month_Number,
DATENAME(MONTH,issue_date) as Month_Name,
COUNT(id) as Total_Applications,
SUM(loan_amount) as Total_Loan_Amount,
SUM(total_payment) as Total_Payment_Recieved
FROM
financial_loan_data
group by MONTH(issue_date),DATENAME(MONTH,issue_date)
order by Month_Number

--Regional Analysis by State 

SELECT address_state as State_Name,
COUNT(id) as Total_Applications_Recieved,
SUM(loan_amount) as Total_Loan_Amount,
SUM(total_payment) as Total_Payment_Recieved
FROM
financial_loan_data
group by address_state
order by address_state

--Loan Term Analysis

SELECT term as Loan_Term,
COUNT(id) as Total_Applications_Recieved,
SUM(loan_amount) as Total_Loan_Amount,
SUM(total_payment) as Total_Payment_Recieved
FROM
financial_loan_data
GROUP BY term

--Analysis based on Employee Length

SELECT emp_length as Employee_Length,
COUNT(id) as Total_Applications,
SUM(loan_amount) as Total_Loan_Amount,
SUM(total_payment) as Total_Payment_Recieved
FROM 
financial_loan_data
GROUP BY emp_length

--Loan Purpose Break_Down
SELECT top 4 * from financial_loan_data

SELECT purpose as Loan_Purpose,
COUNT(id) as Total_Applications,
SUM(loan_amount) as Total_Loan_Amount,
SUM(total_payment) as Total_Payment_Recieved
FROM 
financial_loan_data
GROUP BY purpose

--Home Ownership Analysis

SELECT home_ownership as Home_Ownership_status,
COUNT(id) as Total_Applications,
SUM(loan_amount) as Total_Loan_Amount,
SUM(total_payment) as Total_Payment_Recieved
FROM 
financial_loan_data
GROUP BY home_ownership

--Grade Wise Analysis
SELECT 
	grade, 
	COUNT(id) AS Total_Loan_Applications,
	SUM(loan_amount) AS Total_Funded_Amount,
	SUM(total_payment) AS Total_Amount_Received
FROM financial_loan_data
GROUP BY grade
ORDER BY grade

--All the Anlysis done with SQL
-- If you have any issue regarding results
--look at the dashboard picture in tablue
-- compare the results




