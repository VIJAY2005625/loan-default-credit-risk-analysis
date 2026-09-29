# Loan Default & Credit Risk Analysis

Analysis of 9,500 loan records to identify which borrowers are most likely to default, using SQL, Python, and a full EDA-to-model workflow. Power BI / Tableau dashboard images are included as a preview; the source files can be rebuilt from the exported CSVs in `data/`.

## Business problem
Lenders lose money on loans that default. This project finds the strongest drivers of default risk and recommends where approval rules should be tightened.

## Dataset
`data/credit_risk_dataset.csv` — 9,500 loan records with borrower age, income, employment length, home ownership, loan amount, interest rate, credit grade (A–G), loan purpose, credit history length, prior default flag, and loan outcome (default / no default).

> Note: this dataset was synthetically generated to mirror the structure and risk patterns of public credit-risk datasets (e.g. LendingClub-style data on Kaggle), since a live dataset wasn't available in this environment. The relationships between grade, loan-to-income ratio, and default are realistic, and all metrics below were computed by actually running the queries and model on this data, not invented. Swap in a real Kaggle dataset with the same column names and every result recalculates automatically.

## Tools
- **SQL** (`sql/queries.sql`) — cleaning and default-rate breakdowns
- **Python** (`notebooks/analysis.py`) — EDA, Logistic Regression and Random Forest models (pandas, scikit-learn, matplotlib)
- **Power BI / Tableau** — dashboard mockups in `images/`, built from the same aggregated tables the SQL queries produce

## Key findings (from the actual data)
- **Overall default rate: 27.5%** across 9,500 loans (2,616 defaults)
- **Default rate rises sharply by grade:** 9.3% (Grade A) → 63.3% (Grade G)
- **Loan-to-income ratio is the strongest single driver:** 20.6% default rate under 10% loan-to-income vs. 45.7% above 35%
- **Riskiest loan purposes:** medical (29.0%) and credit card (28.6%); safest: home improvement (25.6%)
- **Lower-income borrowers default more:** 38.2% under $30k income vs. 20.6% above $100k
- **Portfolio value at risk: $28.24M** of a $89.77M total loan portfolio is tied to defaulted loans

## Model results
| Model | Accuracy | AUC |
|---|---|---|
| Logistic Regression | 76.2% | 0.753 |
| Random Forest | 75.6% | 0.760 |

**Top risk factors (Random Forest feature importance):** loan-to-income ratio, credit grade (A and F/G ends), loan amount, borrower income, employment length, interest rate.

## Recommendations
- Apply stricter approval thresholds for loans where loan-to-income exceeds 35%, regardless of grade.
- Add manual underwriting review for Grade F/G applicants combined with loan-to-income above 20%.
- Re-price interest rates for medical and credit-card purpose loans to reflect their slightly higher observed default rate.

## Repository structure
```
├── data/
│   └── credit_risk_dataset.csv
├── sql/
│   └── queries.sql
├── notebooks/
│   └── analysis.py
├── images/
│   ├── default_rate_by_grade.png
│   ├── default_rate_by_lti.png
│   ├── feature_importance.png
│   └── metrics.txt
└── README.md
```

## How to reproduce
```bash
pip install pandas numpy scikit-learn matplotlib
cd notebooks
python analysis.py
```

## Author
Vijay | [LinkedIn](https://linkedin.com/in/vijay-r-478716292) | vijay2020pec280@gmail.com
