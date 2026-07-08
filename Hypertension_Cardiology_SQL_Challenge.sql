--CREATE THE HYPERTENSION_CARDIOLOGY_TABLE
CREATE TABLE Hypertension_Cardiology(
Patient_ID VARCHAR(10) PRIMARY KEY,	
Age	INT,
Age_Group VARCHAR(20),	
Gender VARCHAR(20),
Diabetes_Mellitus VARCHAR(10),
Chronic_Kidney_Disease VARCHAR(10),
Dyslipidemia VARCHAR(10),
Obesity	VARCHAR(10),
Baseline_Systolic_BP INT,	
Baseline_Diastolic_BP INT,
Antihypertensive_Class VARCHAR(50),
Medication_Adherence VARCHAR(20),
Followup_Systolic_BP INT,
Followup_Diastolic_BP INT,
BP_Systolic_Reduction INT,
BP_Diastolic_Reduction INT,
BP_Controlled_After_3_Months VARCHAR(10),	
Number_of_Visits INT,
Registration_Date DATE
);

-- Viewing the details of the dataset.
SELECT * FROM hypertension_cardiology;

--Overall performance
SELECT BP_controlled_after_3_months, COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS percentage
FROM Hypertension_Cardiology
GROUP BY BP_Controlled_After_3_Months;

--Which age group is affected the most?
SELECT Age_Group,ROUND(SUM(CASE WHEN BP_controlled_after_3_months='Yes' THEN 1 ELSE 0 END)*100.0/
	   COUNT(*),2) AS controlled_percentage, 
	   ROUND(SUM(CASE WHEN BP_controlled_after_3_months='No' THEN 1 ELSE 0 END)*100.0/ 
	   COUNT(*),2) AS failure_percentage
FROM Hypertension_Cardiology
GROUP BY Age_Group
ORDER BY failure_percentage DESC;

--which drug works best?
SELECT Antihypertensive_Class, COUNT(*) AS total_patients,
    SUM(CASE WHEN BP_controlled_after_3_months= 'Yes' THEN 1 ELSE 0 END) AS controlled,
    ROUND(SUM(CASE WHEN BP_controlled_after_3_months= 'Yes' THEN 1 ELSE 0 END)*100.0/ 
	COUNT(*),2) AS control_rate
FROM Hypertension_Cardiology
GROUP BY Antihypertensive_Class
ORDER BY control_rate DESC;

--Does gender affect outcome?
SELECT Gender, ROUND(SUM(CASE WHEN BP_controlled_after_3_months='Yes' THEN 1 ELSE 0 END)*100.0/
	   COUNT(*),2) AS controlled_percentage,
	   ROUND(SUM(CASE WHEN BP_controlled_after_3_months='No' THEN 1 ELSE 0 END)*100.0/
	   COUNT(*),2) AS failure_percentage
FROM Hypertension_Cardiology
GROUP BY Gender;

--does gender influence medical adherence?
SELECT Gender,Medication_adherence,
       ROUND(SUM(CASE WHEN BP_controlled_after_3_months= 'No' THEN 1 ELSE 0 END)*100.0/
	   COUNT(*),2) AS failure_rate
FROM Hypertension_Cardiology
GROUP BY Gender, Medication_adherence
ORDER BY Medication_adherence DESC;

--gender influence on drugs
SELECT Gender, Antihypertensive_class,
    ROUND(SUM(CASE WHEN BP_controlled_after_3_months= 'Yes' THEN 1 ELSE 0 END)*100.0/
	COUNT(*),2) AS control_rate
FROM Hypertension_Cardiology
GROUP BY Gender, Antihypertensive_class
ORDER BY Antihypertensive_class DESC;

--comordity impact
SELECT 
    Diabetes_Mellitus, Chronic_Kidney_Disease, Obesity, COUNT(*) AS total_patients,
    SUM(CASE WHEN BP_controlled_after_3_months='No' THEN 1 ELSE 0 END) AS failure_count
FROM Hypertension_Cardiology
GROUP BY Diabetes_Mellitus, Chronic_Kidney_Disease, Obesity
ORDER BY failure_count DESC;

--which drug reduces bp the most.
SELECT 
    Antihypertensive_class, ROUND(AVG(BP_systolic_reduction),2) AS avg_systolic_reduction,
    ROUND(AVG(BP_diastolic_reduction),2) AS avg_diastolic_reduction
FROM Hypertension_Cardiology
GROUP BY Antihypertensive_Class
ORDER BY avg_systolic_reduction DESC;

--which drug works best for patients with different health conditions?
SELECT 
    CASE 
        WHEN Diabetes_Mellitus = 'Yes' THEN 'Diabetes'
        WHEN Chronic_Kidney_Disease = 'Yes' THEN 'CKD'
        WHEN Dyslipidemia = 'Yes' THEN 'Dyslipidemia'
        WHEN Obesity = 'Yes' THEN 'Obesity'
        ELSE 'None'
    END AS Comorbidity_Group,
    Antihypertensive_Class, COUNT(*) AS total_patients,
	ROUND(SUM(CASE WHEN BP_Controlled_After_3_Months='Yes' THEN 1 ELSE 0 END)*100.0/
	COUNT(*),2) AS control_rate
FROM Hypertension_Cardiology
GROUP BY Comorbidity_Group, Antihypertensive_Class
ORDER BY Comorbidity_Group, control_rate DESC;

--COMORDITY PROFILE
SELECT 
    Antihypertensive_Class,
    Diabetes_Mellitus,
    Chronic_Kidney_Disease,
    Dyslipidemia,
    Obesity,
    COUNT(*) AS total_patients,
    
    ROUND(
        SUM(CASE WHEN BP_Controlled_After_3_Months='Yes' THEN 1 ELSE 0 END)*100.0 
        / COUNT(*), 2
    ) AS control_rate

FROM Hypertension_Cardiology

WHERE 
    Diabetes_Mellitus = 'Yes'
    OR Chronic_Kidney_Disease = 'Yes'
    OR Dyslipidemia = 'Yes'
    OR Obesity = 'Yes'

GROUP BY 
    Antihypertensive_Class,
    Diabetes_Mellitus,
    Chronic_Kidney_Disease,
    Dyslipidemia,
    Obesity

ORDER BY antihypertensive_class,control_rate DESC;


--BASELINE SEVERITY
SELECT 
    CASE 
        WHEN Baseline_Systolic_BP >= 160 THEN 'Severe'
        WHEN Baseline_Systolic_BP >= 140 THEN 'Moderate'
        ELSE 'Mild'
    END AS BP_Level,

    ROUND(
        SUM(CASE WHEN BP_Controlled_After_3_Months='No' THEN 1 ELSE 0 END)*100.0
        / COUNT(*), 2
    ) AS failure_rate

FROM Hypertension_Cardiology
GROUP BY BP_Level
ORDER BY failure_rate DESC;

--ADHERENCE
SELECT 
    Medication_Adherence,
    ROUND(
        SUM(CASE WHEN BP_Controlled_After_3_Months='No' THEN 1 ELSE 0 END)*100.0
        / COUNT(*), 2
    ) AS failure_rate
FROM Hypertension_Cardiology
GROUP BY Medication_Adherence;

--WHO ARE HIGH RISK PATEINR

SELECT 
    Age_Group,
    Medication_Adherence,
    Diabetes_Mellitus,
    Chronic_Kidney_Disease,
    COUNT(*) AS total,
    
    ROUND(
        SUM(CASE WHEN BP_Controlled_After_3_Months='No' THEN 1 ELSE 0 END)*100.0
        / COUNT(*), 2
    ) AS failure_rate

FROM Hypertension_Cardiology
GROUP BY 
    Age_Group,
    Medication_Adherence,
    Diabetes_Mellitus,
    Chronic_Kidney_Disease

ORDER BY failure_rate DESC;


WITH profile_result AS (
    SELECT
        CONCAT(
            'DM:', Diabetes_Mellitus,
            ' | CKD:', Chronic_Kidney_Disease,
            ' | Dys:', Dyslipidemia,
            ' | Obs:', Obesity
        ) AS Comorbidity_Profile,
        Antihypertensive_Class,
        COUNT(*) AS total_patients,
        SUM(CASE WHEN BP_Controlled_After_3_Months = 'Yes' THEN 1 ELSE 0 END) AS controlled_patients,
        ROUND(
            SUM(CASE WHEN BP_Controlled_After_3_Months = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*),
            2
        ) AS control_rate
    FROM Hypertension_Cardiology
    GROUP BY
        Diabetes_Mellitus,
        Chronic_Kidney_Disease,
        Dyslipidemia,
        Obesity,
        Antihypertensive_Class
),

ranked_drugs AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY Comorbidity_Profile
            ORDER BY control_rate DESC
        ) AS drug_rank
    FROM profile_result
)

SELECT
    Comorbidity_Profile,
    Antihypertensive_Class AS Best_Drug_Class,
    total_patients,
    controlled_patients,
    control_rate
FROM ranked_drugs
WHERE drug_rank = 1
ORDER BY Comorbidity_Profile;