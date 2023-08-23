SELECT *
FROM Absenteeism_at_work ab
JOIN Reasons re
ON ab.Reason_for_absence = re.Number

SELECT *
FROM Absenteeism_at_work ab
JOIN compensation co
ON ab.ID = co.ID

SELECT *
FROM Absenteeism_at_work ab
JOIN compensation co
ON ab.ID = co.ID
JOIN Reasons re
ON ab.Reason_for_absence = re.Number

-- Finding the healthiest employees

SELECT *
FROM Absenteeism_at_work ab
WHERE Social_drinker = 0 AND Social_smoker = 0 AND Body_mass_index < 25
AND Absenteeism_time_in_hours < (SELECT AVG(Absenteeism_time_in_hours) FROM Absenteeism_at_work)

-- Increasing compensation for non-smokers (Budget $ 1,000,000 = $0.7008 per hour increase/$1457.7259 per year)

SELECT Count(*) As non_smokers
FROM Absenteeism_at_work ab
WHERE Social_smoker = 0 

-- Narrow down all 3 queries

SELECT ab.ID, re.Reason, ab.Month_of_absence, ab.Body_mass_index,
CASE
WHEN Body_mass_index < 18 THEN 'Underweight'
WHEN Body_mass_index between 18 AND 25 THEN 'Healthy'
WHEN Body_mass_index between 25 AND 30 THEN 'Overweight'
WHEN Body_mass_index > 30 THEN 'Obese'
ELSE 'Unknown' END as BMI_Weight_Class,
CASE
WHEN Month_of_absence IN (12, 1, 2) THEN 'Winter'
WHEN Month_of_absence IN (3, 4, 5) THEN 'Spring'
WHEN Month_of_absence IN (6, 7, 8) THEN 'Summer'
WHEN Month_of_absence IN (9, 10, 11) THEN 'Fall'
ELSE 'Unknown' END as Season_Names,
ab.Seasons,
ab.Day_of_the_week,
ab.Transportation_expense,
ab.Education, 
ab.Son,
ab.Social_drinker,
ab.Social_smoker,
ab.Pet,
ab.Disciplinary_failure,
ab.Age,
CASE
WHEN Age < 25 THEN 'Young' 
WHEN Age between 25 AND 40 THEN'Adult'
WHEN Age between 40 AND 60 THEN 'Middle-Aged'
WHEN Age > 60 THEN 'Old'
ELSE 'Unknown' END as Age_Group,
ab.Work_load_Average_day, 
ab.Absenteeism_time_in_hours
FROM Absenteeism_at_work ab
JOIN compensation co
ON ab.ID = co.ID
JOIN Reasons re
ON ab.Reason_for_absence = re.Number	