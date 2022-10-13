--SELECT DISTINCT year   -- Data spans from 1996 to 2018.
--FROM cancer_data
--ORDER BY year;

--SELECT *               -- Viewing all NULL values.
--FROM cancer_data
--WHERE year IS NULL;

--DELETE                 -- Removing NULL values (Blank Rows from raw data).
--FROM cancer_data
--WHERE year IS NULL;

--SELECT SUM(num)   -- Selecting row I want to edit to ensure accuracy
--FROM cancer_data
--WHERE icdsub4 = 'C00-C96, D45-D47' -- This Total matches the Regs_Total excel sheet.
--	AND type = 'regs'
--	AND year = '2018'
--	AND sex = 'AllSex';

--SELECT icdsub4, Combo, num   -- Selecting row I want to edit to ensure accuracy.
--FROM cancer_data
--WHERE icdsub4 = 'D45-D47';   -- D45-D47 Category needs to be excluded 
                             -- because if included it creates an error in total registrations
							 -- when compared to the Regs_Total excel sheet.


--DELETE                     -- Deleting data error.
--FROM cancer_data
--WHERE icdsub4 = 'D45-D47'; 


---------------------------------------------------------

--SELECT icdsub4, Combo
--FROM cancer_data               -- Selecting what is to be edited first to ensure accuracy.
--WHERE icdsub4 = 'C00-C96, D45-D47';

--UPDATE cancer_data          -- Editing row with correct name from coding information.
--SET icdsub4 = 'Total Cancer'
--WHERE icdsub4 = 'C00-C96, D45-D47';

--SELECT icdsub4, Combo
--FROM cancer_data               -- Checking update.
--WHERE icdsub4 = 'Total Cancer';

--SELECT SUM(num)   
--FROM cancer_data
--WHERE icdsub4 = 'Total Cancer' -- This Total matches the Regs_Total excel sheet.
--	AND type = 'regs'
--	AND year = '2018'
--	AND sex = 'AllSex';

--UPDATE cancer_data          -- Editing row with correct name from coding information.
--SET icdsub4 = 'Lip, Oral Cavity and Pharynx'
--WHERE icdsub4 = 'C00-C14';

--UPDATE cancer_data          -- Editing row with correct name from coding information.
--SET icdsub4 = 'Melanoma'
--WHERE icdsub4 = 'C43';

--SELECT icdsub4, Combo
--FROM cancer_data             -- Checking for any values with the name written as it is in the coding excel sheet.
--WHERE icdsub4 = 'C50 + "F"';

--SELECT icdsub4, Combo          -- This will be what needs to be edited.
--FROM cancer_data            
--WHERE icdsub4 = 'C50'
--	AND sex = 'Female';

--UPDATE cancer_data          -- Editing row with correct name from coding information.
--SET icdsub4 = 'Female Breast'
--WHERE icdsub4 = 'C50'
--	AND sex = 'Female';

--SELECT icdsub4, Combo          -- This will be what needs to be edited using codes from 2003 onwards.
--FROM cancer_data            
--WHERE icdsub4 = 'C82-C86, C96'

--UPDATE cancer_data          -- Editing row with correct name from coding information.
--SET icdsub4 = 'Ovary and other uterine adnexa'
--WHERE icdsub4 = 'C56-C57';

--SELECT icdsub4, Combo, sex    -- Viewing results.
--FROM cancer_data;


--UPDATE cancer_data          -- Editing row with correct name from coding information.
--SET icdsub4 = 'Male Breast'
--WHERE icdsub4 = 'C50'
--	AND sex = 'Male';

--UPDATE cancer_data          -- Editing row with correct name from coding information.
--SET icdsub4 = 'AllSex Breast'
--WHERE icdsub4 = 'C50'
--	AND sex = 'AllSex';

--SELECT icdsub4, Combo, sex    -- Viewing results.
--FROM cancer_data;

------------------------------------------------------------------------------- Editing done, now time to query.

--SELECT year, ROUND(AVG(rate), 2) AS 'Average Death Rate (Per 100 K Population)'
--FROM cancer_data
--WHERE type = 'deaths'
--	AND sex = 'AllSex'
--	AND icdsub4 = 'Total Cancer'          -- Variations in death rates over time.
--GROUP BY year
--ORDER BY year;


--SELECT icdsub4 AS 'Cancer Type', ROUND(AVG(rate), 2) AS 'Average Death Rate'        -- Checking with data sheet to make sure the correct death rate is aquired. 
--FROM cancer_data
--WHERE type = 'deaths'
--	AND icdsub4 = 'Colorectum and anus'
--	AND year = '2018'
--	AND sex = 'AllSex'
--GROUP BY icdsub4
--ORDER BY icdsub


--SELECT icdsub4 AS 'Cancer Type', ROUND(AVG(rate), 2) AS 'Total Cancer Death Rate (Per 100 K Population)'
--FROM cancer_data
--WHERE type = 'deaths'                        -- Death rates of each cancer type.
--	AND sex = 'AllSex'
--	AND icdsub4 <> 'Total Cancer'
--GROUP BY icdsub4
--ORDER BY icdsub4;

--SELECT icdsub4 AS 'Cancer Type', ROUND(AVG(rate), 2) AS 'Total Cancer Registration Rate (Per 100 K Population)'
--FROM cancer_data
--WHERE type = 'regs'                        -- Registration rates of each cancer type.
--	AND sex = 'AllSex'
--	AND icdsub4 <> 'Total Cancer'
--GROUP BY icdsub4
--ORDER BY icdsub4;
			  
--SELECT sex AS 'Sex', ROUND(AVG(rate), 2) AS 'Average Death Rate'
--FROM cancer_data
--WHERE type = 'deaths'
--GROUP BY sex                             -- Variation of death rate between sexes.
--ORDER BY sex
--OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;    -- Removing 'AllSex' row from select result as it is not needed here.

--SELECT sex AS 'Sex', ROUND(AVG(rate), 2) AS 'Average Registration Rate'
--FROM cancer_data
--WHERE type = 'regs'
--GROUP BY sex                             -- Variation of registration rate between sexes.
--ORDER BY sex
--OFFSET 1 ROWS FETCH NEXT 2 ROWS ONLY;    -- Removing 'AllSex' row from select result as it is not needed here.

--SELECT SUM(num) AS 'Number of Cancer Registrations for Females (1996-2018)',
--icdsub4 AS 'Cancer Type'
--	FROM cancer_data                -- Number of registrations for females (1996-2018).
--	WHERE sex = 'Female'
--		AND type = 'regs'
--	GROUP BY icdsub4
--	ORDER BY SUM(num) DESC;

--SELECT SUM(num) AS 'Number of Cancer Registrations for Males (1996-2018)',
--icdsub4 AS 'Cancer Type'
--	FROM cancer_data
--	WHERE sex = 'Male'
--		AND type = 'regs'
--	GROUP BY icdsub4
--	ORDER BY SUM(num) DESC;


--SELECT year AS 'Year', SUM(rate) AS 'Total Cancer Death Rate Per 100 K (1996-2018)'
--FROM cancer_data
--WHERE type = 'deaths'                -- Total Cancer death rate over time.
--	AND sex = 'AllSex'
--	AND icdsub4 = 'total cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(rate) AS 'Total Cancer Registration Rate Per 100 K (1996-2018)'
--FROM cancer_data
--WHERE type = 'regs'                -- Total Cancer registration rate over time.
--	AND sex = 'AllSex'
--	AND icdsub4 = 'total cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(num) AS 'Total Cancer Registrations'
--FROM cancer_data
--WHERE type = 'regs'                -- Total cancer registrations.
--	AND sex = 'AllSex'
--	AND icdsub4 = 'Total Cancer'  
--GROUP BY year
--ORDER BY year;


--SELECT year AS 'Year', SUM(num) AS 'Total Cancer Deaths'
--FROM cancer_data
--WHERE type = 'deaths'          -- Total cancer deaths.
--	AND sex = 'AllSex'
--	AND icdsub4 = 'Total Cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(num) AS 'Total Cancer Deaths (Male)'
--FROM cancer_data
--WHERE type = 'deaths'          -- Total cancer deaths (male).
--	AND sex = 'Male'
--	AND icdsub4 = 'Total Cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(num) AS 'Total Cancer Deaths (Female)'
--FROM cancer_data
--WHERE type = 'deaths'          -- Total cancer deaths (female).
--	AND sex = 'Female'
--	AND icdsub4 = 'Total Cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(num) AS 'Total Cancer Registrations (Female)'
--FROM cancer_data
--WHERE type = 'regs'          -- Total cancer registrations (female).
--	AND sex = 'Female'
--	AND icdsub4 = 'Total Cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(num) AS 'Total Cancer Registrations (Male)'
--FROM cancer_data
--WHERE type = 'regs'          -- Total cancer registrations (male).
--	AND sex = 'Male'
--	AND icdsub4 = 'Total Cancer'
--GROUP BY year
--ORDER BY year;


--SELECT year AS 'Year', SUM(rate) AS 'Average Death Rate for Females (Per 100 K)'
--FROM cancer_data
--WHERE type = 'deaths'                -- Average death rate over time (female).
--	AND sex = 'Female'
--	AND icdsub4 = 'total cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(rate) AS 'Average Death Rate for Males (Per 100 K)'
--FROM cancer_data
--WHERE type = 'deaths'                -- Average death rate over time (male).
--	AND sex = 'Male'
--	AND icdsub4 = 'total cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(rate) AS 'Average Registration Rate for Females (Per 100 K)'
--FROM cancer_data
--WHERE type = 'regs'                -- Average registration rate over time (female).
--	AND sex = 'Female'
--	AND icdsub4 = 'total cancer'
--GROUP BY year
--ORDER BY year;

--SELECT year AS 'Year', SUM(rate) AS 'Average Registration Rate for Males (Per 100 K)'
--FROM cancer_data
--WHERE type = 'regs'                -- Average registration rate over time (male).
--	AND sex = 'Male'
--	AND icdsub4 = 'total cancer'
--GROUP BY year
--ORDER BY year;
