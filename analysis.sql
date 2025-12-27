use heart_prediction_db;
-- ALTER TABLE heart_attack_prediction_dataset RENAME TO Patients_Table;
 -- describe Patients_Table;
-- ALTER TABLE Patients_Table CHANGE `Patient ID` `Patient_ID` text;
-- ALTER TABLE Patients_Table CHANGE `Heart Rate` `Heart_Rate` text;
-- ALTER TABLE Patients_Table CHANGE `Family History` `Family_History` text;
-- ALTER TABLE Patients_Table CHANGE `Blood Pressure` `Blood_Pressure` text;
-- ALTER TABLE Patients_Table CHANGE `Alcohol Consumption` `Alcohol_Consumptio` text;
-- ALTER TABLE Patients_Table CHANGE `Exercise Hours Per Week` `Exercise_Hours_Per_Week` text;
-- ALTER TABLE Patients_Table CHANGE `Previous Heart Problems` `Previous_Heart_Problems` text;
-- ALTER TABLE Patients_Table CHANGE `Medication Use` `Medication_Use` text;
-- ALTER TABLE Patients_Table CHANGE `Sedentary Hours Per Day` `Sedentary_Hours_Per_Day` text;
-- ALTER TABLE Patients_Table CHANGE `Stress Level` `Stress_Level` text;
-- ALTER TABLE Patients_Table CHANGE `Heart Attack Risk` `Heart_Attack_Risk` text;
-- 1
-- SELECT
--     Sex,
--     AVG(CASE WHEN Cholesterol > 200 THEN 1 ELSE 0 END) AS HighCholesterol,
--     AVG(CASE WHEN Blood_Pressure >= 140 OR Blood_Pressure <= 90 THEN 1 ELSE 0 END) AS HighBloodPressure,
--     AVG(CASE WHEN Diabetes = 'Yes' THEN 1 ELSE 0 END) AS DiabetesPrevalence
-- FROM
--     patients_table
-- GROUP BY
--     Sex;

-- SELECT
--     Sex,
--     AVG(CASE WHEN Cholesterol > 200 OR Blood_Pressure >= 140 OR Blood_Pressure <= 90 OR Diabetes = 'Yes' THEN 1 ELSE 0 END) AS HighRiskPatients
-- FROM
--     patients_table
-- GROUP BY
--     Sex;
-- Assessing life style impact
-- 2
-- SELECT
--     Smoking,
--     Obesity,
--     AVG(`Heart_Attack_Risk`) AS AvgHeartAttackRisk
-- FROM
--     Patients_table
-- GROUP BY
--     Smoking, Obesity;

-- 3

-- SELECT
--     Country,
--     Continent,
--     AVG(`Heart_Attack_Risk`) AS AvgHeartAttackRisk,
--     AVG(CASE WHEN Cholesterol > 200 THEN 1 ELSE 0 END) AS HighCholesterol,
--     AVG(CASE WHEN Blood_Pressure >= 140 OR Blood_Pressure <= 90 THEN 1 ELSE 0 END) AS HighBloodPressure,
--     AVG(CASE WHEN Diabetes = 'Yes' THEN 1 ELSE 0 END) AS DiabetesPrevalence
-- FROM
--     patients_table
-- GROUP BY
--     Country, Continent;

-- SELECT
--     Country,
--     Continent,
--     AVG(CASE WHEN Cholesterol > 200 THEN 1 ELSE 0 END) AS HighCholesterol,
--     AVG(CASE WHEN Blood_Pressure >= 140 OR Blood_Pressure <= 90 THEN 1 ELSE 0 END) AS HighBloodPressure,
--     AVG(CASE WHEN Diabetes = 'Yes' THEN 1 ELSE 0 END) AS DiabetesPrevalence,
--     AVG(CASE WHEN Income < 50000 THEN 1 ELSE 0 END) AS LowIncomePopulation
-- FROM
--     patients_table
-- GROUP BY
--     Country, Continent;
    
-- 4
-- SELECT
--     CORR(Cholesterol, `Blood_Pressure`) AS Cholesterol_BloodPressure_Correlation,
--     CORR(Cholesterol, BMI) AS Cholesterol_BMI_Correlation,
--     CORR(`Blood_Pressure`, BMI) AS BloodPressure_BMI_Correlation,
--     CORR(Cholesterol, `Heart_Attack_Risk`) AS Cholesterol_HeartAttackRisk_Correlation,
--     CORR(`Blood_Pressure`, `Heart_Attack_Risk`) AS BloodPressure_HeartAttackRisk_Correlation,
--     CORR(BMI, `Heart_Attack_Risk`) AS BMI_HeartAttackRisk_Correlation
-- FROM
--     patients_table;

-- SELECT
--     Patient_ID,
--     (Cholesterol * 0.3) + (Blood_Pressure * 0.4) + (Age * 0.3) AS Risk_Score
-- FROM
--     patients_table;
    
-- 5
-- SELECT
--     Medication_Use,
--     COUNT(*) AS Patients_Count,
--     avg(Heart_Attack_Risk) AS Average_HeartAttack_Risk
-- FROM
--     patients_table
-- WHERE
--     Previous_Heart_Problems = 'Yes'
-- GROUP BY
--     Medication_Use;

-- 6

-- SELECT
--     Stress_Level,
--     AVG(`Heart_Attack_Risk`) AS Average_HeartAttack_Risk
-- FROM
--     patients_table
-- GROUP BY
--     Stress_Level;
    
-- Identify patients with elevated stress levels and high cardiovascular risk
-- SELECT
--     Patient_ID,
--     Stress_Level,
--     Heart_Attack_Risk
-- FROM
--     patients_table
-- WHERE
--     Stress_Level >= 'low' AND `Heart_Attack_Risk` >= 0;

-- 7
-- SELECT
--     Diet,
--     AVG(Cholesterol) AS Average_Cholesterol,
--     AVG(Triglycerides) AS Average_Triglycerides,
--     AVG(Blood_Pressure) AS Average_Blood_Pressure,
--     AVG(Heart_Rate) AS Average_Heart_Rate
-- FROM
--     patients_table
-- GROUP BY
--     Diet;

-- Identify patients with specific dietary patterns and cardiovascular risk factors

-- SELECT
--     Patient_ID,
--     Diet,
--     Cholesterol,
--     Triglycerides,
--     Blood_Pressure,
--     Heart_Rate
-- FROM
--     patients_table
-- WHERE
--     Diet IN ('Unhealthy', 'Average') 
--     AND (Cholesterol > 200 OR Triglycerides > 150 OR Blood_Pressure >= 140 OR Heart_Rate >= 100);

-- 8
-- Identify key insights for educational interventions
-- Identify key insights for educational interventions
-- SELECT
--     Age,
--     Sex,
--     Smoking,
--     Diabetes,
--     AVG(`Heart_Attack_Risk`) AS Average_HeartAttack_Risk,
--     COUNT(*) AS Number_of_Patients
-- FROM
--     patients_table
-- GROUP BY
--     Age , Sex, Smoking, Diabetes
-- ORDER BY
--     Average_HeartAttack_Risk DESC;


-- views

-- Create views based on the provided queries
CREATE VIEW LifestyleImpact AS
SELECT Smoking, Obesity, AVG(Heart_Attack_Risk) AS AvgHeartAttackRisk
FROM patients_table
GROUP BY Smoking, Obesity;

create table heart_prediction_db.LifestyleImpacts as 
select Smoking,Obesity,AvgHeartAttackRisk
from LifestyleImpact; 



CREATE VIEW GeographicImpact AS
SELECT Country, Continent, AVG(Heart_Attack_Risk) AS AvgHeartAttackRisk
FROM patients_table
GROUP BY Country, Continent;

create table heart_prediction_db.GeographicImpacts as 
select Country,Continent,AvgHeartAttackRisk
from GeographicImpact; 

-- view to table
SELECT *
FROM LifestyleImpact AS LI
JOIN GeographicImpact AS GI
ON LI.AvgHeartAttackRisk = GI.AvgHeartAttackRisk;
-- view
CREATE VIEW medication_use_adherence AS
SELECT
    Medication_Use,
    COUNT(*) AS Patients_Count,
    AVG(Heart_Attack_Risk) AS Average_HeartAttack_Risk
FROM
    patients_table
WHERE
    Previous_Heart_Problems = 'Yes'
GROUP BY
    Medication_Use;
    
create table heart_prediction_db.medication_use_adherences as 
select Medication_Use,Patients_Count,Average_HeartAttack_Risk
from medication_use_adherence; 
    
    
CREATE VIEW psychosocial_factors AS
SELECT
    Stress_Level,
    AVG(Heart_Attack_Risk) AS Average_HeartAttack_Risk
FROM
    patients_table
GROUP BY
    Stress_Level;
    

create table heart_prediction_db.psychosocial_factorss as 
select Stress_Level,Average_HeartAttack_Risk
from psychosocial_factors; 

CREATE VIEW educational_interventions AS
SELECT
    Age,
    Sex,
    Smoking,
    Diabetes,
    AVG(Heart_Attack_Risk) AS Average_HeartAttack_Risk,
    COUNT(*) AS Number_of_Patients
FROM
    patients_table
GROUP BY
    Age, Sex, Smoking, Diabetes
ORDER BY
    Average_HeartAttack_Risk DESC;
    
create table heart_prediction_db.educational_interventionss as 
select Age,Sex,Smoking,Diabetes,Average_HeartAttack_Risk,Number_of_Patients
from educational_interventions; 
-- joins

SELECT *
FROM patients_table AS p
INNER JOIN lifestyleimpacts AS l ON p.Obesity = l.Obesity;

SELECT *
FROM patients_table AS p
LEFT JOIN geographicimpacts AS g ON p.Country = g.Country;















    









