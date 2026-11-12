DROP TABLE IF EXISTS zoo_health_cleaned;

CREATE TABLE zoo_health_cleaned AS
SELECT 
    TRIM(Animal_Type) AS Animal_Type,
    Breed,
    CAST(Age AS INTEGER) AS Age,
    Gender,
    CAST(REPLACE(REPLACE(Body_Temperature, ' °C', ''), '°C', '') AS REAL) AS Body_Temperature_c,
    CAST(REPLACE(Heart_Rate, ' BPM', '') AS INTEGER) AS Heart_Rate_bpm,
    CAST(REPLACE(Weight, ' kg', '') AS REAL) AS Weight_kg,
    CAST(Daily_Steps AS INTEGER) AS Daily_Steps,
    CAST(REPLACE(Water_Intake, ' L', '') AS REAL) AS Water_Intake_l,
    Symptom_1,
    Symptom_2,
    Symptom_3,
    Symptom_4,
    Duration,
    Appetite_Loss,
    Vomiting,
    Diarrhea,
    Coughing,
    Labored_Breathing,
    Lameness,
    Skin_Lesions,
    Nasal_Discharge,
    Eye_Discharge,
    Disease_Prediction
FROM "Multispecies Diagnostic Records";

SELECT 
    Animal_Type,
    COUNT(*) AS total_records,
    ROUND(AVG(Body_Temperature_c), 2) AS avg_temperature_c,
    ROUND(AVG(Heart_Rate_bpm), 1) AS avg_heart_rate,
    ROUND(AVG(Weight_kg), 2) AS avg_weight_kg,
    ROUND(AVG(Daily_Steps), 0) AS avg_daily_steps,
    ROUND(AVG(Water_Intake_l), 2) AS avg_water_liters
FROM zoo_health_cleaned
GROUP BY Animal_Type
ORDER BY total_records DESC;