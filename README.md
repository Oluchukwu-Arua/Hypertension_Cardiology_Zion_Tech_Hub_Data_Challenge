# Hypertension-Cardiology Data Challenge

**Predicting BP Control Failure and Evaluating Drug Outcomes Across Comorbidity Profiles**

An Excel, SQL, Python, and Power BI project analyzing 350 hypertension patient records to predict blood pressure control failure and identify the most effective antihypertensive drug class for different comorbidity profiles.

---

## 📊 The Dashboard

<img width="1919" height="1079" alt="image" src="https://github.com/user-attachments/assets/8b1fcff0-7bfb-4088-bf68-a04b026ad0a3" />


🔗 [Explore the interactive dashboard](https://app.powerbi.com/view?r=eyJrIjoiNTUwZjk0NDItNzllYy00Y2Y1LWE2MTMtMTljODNiY2MxMWUxIiwidCI6ImJlNTQ4NDEyLWYxYzQtNDcyYi04OGE4LWQ2NzJlNWM4MzhiMyJ9)

📖 [Read the full write-up on Medium](https://medium.com/@aruaoluchilaw/hypertension-cardiology-data-challenge-predicting-bp-control-failure-and-evaluating-drug-outcomes-160d5d5ec949)

---

## Business Problem

The challenge centered on two core questions:

- What predicts BP control failure at 3 months, and can high-risk patients be identified at the point of prescription?
- Which antihypertensive drug class delivers the best outcomes for patients with specific comorbidity profiles?

## Key Performance Indicators

| Metric | Value |
|---|---|
| Total Patients | 350 |
| %BP Controlled at 3 Months | 9.43% |
| Best Performing Drug Class | Combination Therapy |
| Model ROC-AUC | 0.95 |

## Key Findings

- **317 of 350 patients** did not achieve BP control after 3 months.
- **Females had a higher control rate (11.24%)** than Males (7.56%), linked to stronger medication adherence.
- **Combination Therapy led overall** with a 21.05% control rate, ahead of Thiazide Diuretic (13.11%), Beta Blocker (9.84%), ARB (5.88%), and Calcium Channel Blocker (5.17%), ACE Inhibitor recorded 0%.
- **Drug effectiveness varies by comorbidity** — Thiazide Diuretic performed best for Chronic Kidney Disease, while Combination Therapy led for Diabetes, Dyslipidemia, and Obesity.
- **The predictive model achieved 92.86% accuracy**, a recall of 1.00 for BP failure, and a ROC-AUC of 0.95 correctly flagging every high-risk patient in the test set.
- **Top predictors of BP control failure**: baseline BP severity, medication adherence, comorbidities, and antihypertensive drug class.

## Recommendations

1. Treat severe baseline hypertension as high-risk from the point of prescription
2. Use personalized treatment plans matched to each patient's comorbidity profile
3. Consider Combination Therapy as the default for patients with multiple risk factors
4. Strengthen medication adherence programs (counseling, reminders, education)
5. Deploy predictive risk scoring to flag high-risk patients early
6. Schedule closer follow-up visits for patients identified as high-risk

## Limitation

The dataset's small sample size (350 patients) limits generalization. The predictive model should be validated against larger datasets before clinical deployment.

## Repository Contents

| File | Description |
|---|---|
| `Hypertension_Cardiology_Executive_Summary.pdf` | A 2-page executive summary of the full analysis |
| `Hypertension_Cardiology_Data_Challenge.pdf` | Full project documentation with detailed methodology and findings |
| `Hypertension_Cardiology_Data_Challenge.ipynb` | Python notebook predictive modeling and risk classification |
| `Hypertension_Cardiology_SQL_Challenge.sql` | SQL queries used for drug class and comorbidity analysis |

## Tools Used

- **Excel** — data cleaning and exploration
- **PostgreSQL** — granular analysis and insight generation
- **Python (Jupyter Notebook)** — predictive modeling, high-risk patient identification, data visualization
- **Power BI** — dashboard design, DAX measures, interactive reporting

## About

Built by **Arua Oluchukwu Lawrencia**, a data analyst specializing in Excel, Power BI, SQL, and Python.

- 🔗 [Medium](https://medium.com/@aruaoluchilaw)
- 💼 [LinkedIn](https://linkedin.com/in/oluchukwu-arua-law2349043419246)
- 🐦 [X (Twitter)](https://twitter.com/OluchukwuArua)
