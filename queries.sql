-- Loan Default & Credit Risk Analysis — SQL queries
-- Run against the credit_risk_dataset table (loaded from data/credit_risk_dataset.csv)

-- 1. Overall portfolio size and default rate
SELECT
    COUNT(*) AS total_loans,
    SUM(loan_status) AS total_defaults,
    ROUND(100.0 * SUM(loan_status) / COUNT(*), 2) AS default_rate_pct
FROM credit_risk_dataset;

-- 2. Default rate by credit grade
SELECT
    loan_grade,
    COUNT(*) AS num_loans,
    ROUND(100.0 * SUM(loan_status) / COUNT(*), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_grade
ORDER BY loan_grade;

-- 3. Default rate by loan purpose
SELECT
    loan_purpose,
    COUNT(*) AS num_loans,
    ROUND(100.0 * SUM(loan_status) / COUNT(*), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_purpose
ORDER BY default_rate_pct DESC;

-- 4. Default rate by income band
SELECT
    CASE
        WHEN person_income < 30000 THEN '1. <30k'
        WHEN person_income < 60000 THEN '2. 30k-60k'
        WHEN person_income < 100000 THEN '3. 60k-100k'
        ELSE '4. 100k+'
    END AS income_band,
    COUNT(*) AS num_loans,
    ROUND(100.0 * SUM(loan_status) / COUNT(*), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY income_band
ORDER BY income_band;

-- 5. Default rate by home ownership
SELECT
    person_home_ownership,
    COUNT(*) AS num_loans,
    ROUND(100.0 * SUM(loan_status) / COUNT(*), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY person_home_ownership
ORDER BY default_rate_pct DESC;

-- 6. Loan-to-income ratio vs default (risk banding)
SELECT
    CASE
        WHEN loan_percent_income < 0.10 THEN '1. <10%'
        WHEN loan_percent_income < 0.20 THEN '2. 10-20%'
        WHEN loan_percent_income < 0.35 THEN '3. 20-35%'
        ELSE '4. 35%+'
    END AS loan_to_income_band,
    COUNT(*) AS num_loans,
    ROUND(100.0 * SUM(loan_status) / COUNT(*), 2) AS default_rate_pct
FROM credit_risk_dataset
GROUP BY loan_to_income_band
ORDER BY loan_to_income_band;

-- 7. Portfolio value at risk (loan amount tied to defaulted loans)
SELECT
    ROUND(SUM(loan_amnt) / 1e6, 2) AS total_portfolio_value_millions,
    ROUND(SUM(CASE WHEN loan_status = 1 THEN loan_amnt ELSE 0 END) / 1e6, 2) AS value_at_risk_millions
FROM credit_risk_dataset;
