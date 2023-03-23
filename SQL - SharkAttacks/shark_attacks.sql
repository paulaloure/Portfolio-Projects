-- SHARK ATTACKS

---------------------------------------------------------------
-- PART 1: CREATING A NEW TABLE

-- CREATING A NEW TABLE:
CREATE TABLE sharks(
	CaseNumber1 VARCHAR(255),
	Date VARCHAR(255),
	Year INT,
	Type VARCHAR(255),
	Country VARCHAR(255),
	Area VARCHAR(255),
	Location VARCHAR(255),
	Activity VARCHAR(255),
	Name VARCHAR(255),
	Sex VARCHAR(255),
	Age VARCHAR(255),
	Injury VARCHAR(255),
	Fatal VARCHAR(255),
	Time VARCHAR(255),
	Species VARCHAR(255),
	Source VARCHAR(255),
	pdf VARCHAR(255),
	hrefformula VARCHAR(255),
	href VARCHAR(255),
	CaseNumber2 VARCHAR(255),
	CaseNumber3 VARCHAR(255),
	originalOrder VARCHAR(255)
);
-- checking if data was imported correctly:
SELECT *
FROM sharks;

---------------------------------------------------------------
-- PART 2: CHECKING AND CLEANING DATA


-- dropping columns that are not going to be used:
ALTER TABLE sharks
DROP COLUMN hrefformula,
DROP COLUMN href,
DROP COLUMN location,
DROP COLUMN name, 
DROP COLUMN source, 
DROP COLUMN pdf, 
DROP COLUMN originalorder;

-- Adding the new column with serial numbers - as an index
ALTER TABLE sharks ADD COLUMN my_id SERIAL;

-------------------------------------------------------------------
-- COLUMNS WITH CASENUMBER

-- comparing columns containing casenumber1, casenumber2 and casenumber3
SELECT casenumber1, casenumber2, casenumber3,
CASE 
WHEN casenumber1=casenumber2 AND casenumber2=casenumber3
	THEN True
WHEN casenumber1 IS NULL AND casenumber2 IS NULL AND casenumber3 IS NULL
	THEN True
ELSE False
END as samecasenumbers
FROM sharks;

-- counting the amount of rows that are the same and different in these columns
WITH casenumbercomparison AS(
SELECT casenumber1, casenumber2, casenumber3,
CASE 
WHEN casenumber1=casenumber2 AND casenumber2=casenumber3
	THEN True
WHEN casenumber1 IS NULL AND casenumber2 IS NULL AND casenumber3 IS NULL
	THEN True
ELSE False
END as samecasenumbers
FROM sharks)
SELECT DISTINCT(samecasenumbers), COUNT(samecasenumbers)
FROM casenumbercomparison
GROUP BY samecasenumbers;

-- reviewing rows that had different values in casenumber
WITH casenumbercomparison AS(
SELECT casenumber1, casenumber2, casenumber3,
CASE 
WHEN casenumber1=casenumber2 AND casenumber2=casenumber3
	THEN True
WHEN casenumber1 IS NULL AND casenumber2 IS NULL AND casenumber3 IS NULL
	THEN True
ELSE False
END as samecasenumbers
FROM sharks)
SELECT casenumber1, casenumber2, casenumber3, samecasenumbers
FROM casenumbercomparison
WHERE samecasenumbers = 'False';

-- after comparing columns, we see that the column casenumber3 containes the best quality data 
-- I will remove columns casenumber1 and casenumber2 from the dataset, as they are redundant 
ALTER TABLE sharks
DROP COLUMN casenumber1,
DROP COLUMN casenumber2;

-- renaming column casenumber3 to casenumber
ALTER TABLE sharks
RENAME COLUMN casenumber3 TO casenumber;




-------------------------------------------------------------------
-- COLUMN WITH DATE

SELECT date
FROM sharks
WHERE date IS NOT NULL;

-- removing the string 'reported ' from the date column
SELECT date, replace(date,'Reported ','') as date_corr
FROM sharks
WHERE date LIKE '%Reported%';

UPDATE sharks
SET date = replace(date,'Reported ','');

-- removing white spaces:
SELECT date, trim(date)
FROM sharks;

UPDATE sharks
SET date = trim(date);


-- correcting the dates starting with 'Before'
WITH new_sharks AS(
SELECT my_id, date, TRANSLATE(regexp_match(date, '[0-9]{4}')::TEXT, '{}', '')||'-01-01' as new_date
FROM sharks
WHERE date LIKE 'Before %')
UPDATE sharks s
SET date = ud.new_date
FROM new_sharks ud
WHERE s.my_id = ud.my_id;

-- correcting the dates starting with 'Summer'
WITH new_sharks AS(
SELECT my_id, date, TRANSLATE(regexp_match(date, '[0-9]{4}')::TEXT, '{}', '')||'-07-01' as new_date
FROM sharks
WHERE date LIKE 'Summer%' AND Length(date)>10)
UPDATE sharks s
SET date = ud.new_date
FROM new_sharks ud
WHERE s.my_id = ud.my_id;

-- extracing the year from the other text formats - and assigning the last day of the year extracted from the text
-- applied only to strings longer than 11:
SELECT date, translate(regexp_matches(date, '[0-9]{4}')::text, '{}', '')||'-01-01'
FROM sharks
WHERE LENGTH(date)>11;

WITH new_sharks AS(
	SELECT my_id, date, translate(regexp_matches(date, '[0-9]{4}')::text, '{}', '')||'-01-01' as new_date
FROM sharks
WHERE LENGTH(date)>11
)
UPDATE sharks s
SET date = ud.new_date
FROM new_sharks ud
WHERE s.my_id = ud.my_id;

-- correcting other unstandard formats:
SELECT date,
CASE
WHEN date LIKE '%II'
THEN '1939-09-01'
WHEN date LIKE 'Apr-13%'
THEN '1802-04-12'
WHEN date LIKE 'Aug-24%'
THEN '1806-08-24'
WHEN date LIKE 'May-17%'
THEN '1803-05-17'
WHEN date LIKE 'May-28%'
THEN '1797-05-28'
WHEN date LIKE '02-Ap%'
THEN '2001-04-02'
WHEN date LIKE '06-26%'
THEN '1890-06-26'
WHEN date LIKE '08-Ap%'
THEN '1936-04-28'
ELSE date
END
FROM sharks
WHERE Length(date)>10
ORDER BY 1 DESC;

UPDATE sharks
SET date = CASE
WHEN date LIKE '%II'
THEN '1939-09-01'
WHEN date LIKE 'Apr-13%'
THEN '1802-04-12'
WHEN date LIKE 'Aug-24%'
THEN '1806-08-24'
WHEN date LIKE 'May-17%'
THEN '1803-05-17'
WHEN date LIKE 'May-28%'
THEN '1797-05-28'
WHEN date LIKE '9-Aug%'
THEN '1890-08-09'
WHEN date LIKE '3-Jul%'
THEN '1879-07-03'
WHEN date LIKE '02-Ap%'
THEN '2001-04-02'
WHEN date LIKE '06-26%'
THEN '1890-06-26'
WHEN date LIKE '08-Ap%'
THEN '1936-04-28'
WHEN date LIKE '77  A.%'
THEN NULL
WHEN date LIKE '1920 -1923%'
THEN NULL
WHEN date LIKE '22-Jul%'
THEN NULL
ELSE date
END;


-- correcting formats from DD-MMM-YYYY to YYYY-MM-DD, where month are given as text:
SELECT date,
CASE
WHEN date LIKE '%Jan%'
THEN SUBSTRING(date,8,11)||'-01-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Feb%'
THEN SUBSTRING(date,8,11)||'-02-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Mar%'
THEN SUBSTRING(date,8,11)||'-03-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Apr%'
THEN SUBSTRING(date,8,11)||'-04-'||SUBSTRING(date,1,2)
WHEN date LIKE '%May%'
THEN SUBSTRING(date,8,11)||'-05-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Jun%'
THEN SUBSTRING(date,8,11)||'-06-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Jul%'
THEN SUBSTRING(date,8,11)||'-07-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Aug%'
THEN SUBSTRING(date,8,11)||'-08-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Sep%'
THEN SUBSTRING(date,8,11)||'-09-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Oct%'
THEN SUBSTRING(date,8,11)||'-10-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Nov%'
THEN SUBSTRING(date,8,11)||'-11-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Dec%'
THEN SUBSTRING(date,8,11)||'-12-'||SUBSTRING(date,1,2)
ELSE date
END
FROM sharks
WHERE Length(date)>10
ORDER BY 1 DESC;

UPDATE sharks
SET date = CASE
WHEN date LIKE '%Jan%'
THEN SUBSTRING(date,8,11)||'-01-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Feb%'
THEN SUBSTRING(date,8,11)||'-02-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Mar%'
THEN SUBSTRING(date,8,11)||'-03-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Apr%'
THEN SUBSTRING(date,8,11)||'-04-'||SUBSTRING(date,1,2)
WHEN date LIKE '%May%'
THEN SUBSTRING(date,8,11)||'-05-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Jun%'
THEN SUBSTRING(date,8,11)||'-06-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Jul%'
THEN SUBSTRING(date,8,11)||'-07-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Aug%'
THEN SUBSTRING(date,8,11)||'-08-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Sep%'
THEN SUBSTRING(date,8,11)||'-09-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Oct%'
THEN SUBSTRING(date,8,11)||'-10-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Nov%'
THEN SUBSTRING(date,8,11)||'-11-'||SUBSTRING(date,1,2)
WHEN date LIKE '%Dec%'
THEN SUBSTRING(date,8,11)||'-12-'||SUBSTRING(date,1,2)
ELSE date
END
WHERE Length(date)>10;



-- extracting year from cells with text of length >10:
WITH new_sharks AS(
	SELECT my_id, date, translate(regexp_matches(date, '[0-9]{4}')::text, '{}', '')||'-01-01' as new_date
FROM sharks
WHERE LENGTH(date)>10
)
UPDATE sharks s
SET date = ud.new_date
FROM new_sharks ud
WHERE s.my_id = ud.my_id;

-- and extracting year from cells with text of length <10
WITH new_sharks AS(
	SELECT my_id, date, translate(regexp_matches(date, '[0-9]{4}')::text, '{}', '')||'-01-01' as new_date
FROM sharks
WHERE LENGTH(date)<10
)
UPDATE sharks s
SET date = ud.new_date
FROM new_sharks ud
WHERE s.my_id = ud.my_id;

-- and extracting year from cells with text of length =10 
SELECT my_id, date, translate(regexp_matches(date, '[0-9]{4}')::text, '{}', '')||'-01-01' as new_date
FROM sharks
WHERE date ~ '^[ a-zA-Z]';

WITH new_sharks AS(
	SELECT my_id, date, translate(regexp_matches(date, '[0-9]{4}')::text, '{}', '')||'-01-01' as new_date
FROM sharks
WHERE date ~ '^[ a-zA-Z]'
)
UPDATE sharks s
SET date = ud.new_date
FROM new_sharks ud
WHERE s.my_id = ud.my_id;

UPDATE sharks
SET date = NULL
WHERE date ~ '^[a-zA-Z]{1}.*';

-- setting the dates before the year 1000 and 'No date' to null
UPDATE sharks
SET date = NULL
WHERE LENGTH(date)<10;

UPDATE sharks
SET date = NULL
WHERE date ~ '^[a-zA-Z]{1}.*';

-- checking all the values that appear more than once
SELECT date, COUNT(date)
FROM sharks
GROUP BY date
HAVING COUNT(date)>1
ORDER BY date;

-- changing data format to DATE
SELECT date, CAST(date as DATE)
FROM sharks;

ALTER TABLE sharks 
ALTER COLUMN date TYPE DATE
USING date::DATE;

-- setting values in the future as NULL, as they must be incorrect
SELECT date
FROM sharks
WHERE date > '2023-02-25';

UPDATE sharks
SET date = NULL
WHERE date > '2023-02-25';


SELECT date, 
FROM sharks;

-- calculating the number of nulls
SELECT SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END)
FROM sharks;

-- calculating the percentage of nulls
SELECT (SUM(CASE WHEN date IS NULL THEN 1 ELSE 0 END)*100)/COUNT(*)
FROM sharks;
-- the result is 76%

-------------------------------------------------------------------
-- Column YEAR

-- checking the column with year
SELECT year
FROM sharks
ORDER BY 1;

SELECT year, count(year)
FROM sharks
GROUP BY year
ORDER BY 1;

-- setting all values before 1000 to NULL
SELECT year
FROM sharks
WHERE year < 1000;

UPDATE sharks
SET year = NULL
WHERE year <1000;

-------------------------------------------------------------------
-- COLUMN TYPE

-- checking the columns 'type'
SELECT type, COUNT(type)
FROM sharks
GROUP BY type;

-- as BOAT and BOATING are very similar, I will group them together by changing boat to boating
-- I will also set all the INVALID types to NULL
UPDATE sharks
SET type = CASE
WHEN type = 'Boat'
THEN 'Boating'
WHEN type = 'Invalid'
THEN NULL
ELSE type
END;

-------------------------------------------------------------------
-- COLUMN COUNTRY

SELECT country, COUNT(country)
FROM sharks
GROUP BY country
ORDER BY 1;

-- removing the white spaces which are present before the country name
UPDATE sharks
SET country = trim(country);

-- setting the case to only first letter as major (except USA)
SELECT country, CASE 
WHEN country = 'USA'
THEN country
ELSE INITCAP(country)
END
FROM sharks;

UPDATE sharks
SET country = CASE 
WHEN country = 'USA'
THEN country
ELSE INITCAP(country)
END;


--removing question marks 
SELECT country, REPLACE(country, '?','')
FROM sharks
WHERE country LIKE '%?%';

UPDATE sharks
SET country = REPLACE(country, '?','');

-- removing countries after '/'
SELECT country, REGEXP_REPLACE(country, ' /.*', '')
FROM sharks
WHERE country LIKE '%/%';

UPDATE sharks
SET country = REGEXP_REPLACE(country, ' /.*', '')
WHERE country LIKE '%/%';

-- removing 'MID-' from the ocean names:
SELECT country, REPLACE(country, LEFT(country,4), '')
FROM sharks
WHERE country LIKE 'Mid%';

UPDATE sharks
SET country = REPLACE(country, LEFT(country,4), '')
WHERE country LIKE 'Mid%';


-- correcting non-standard names:
SELECT country, CASE
WHEN country LIKE 'Ceylon%' THEN 'Sri Lanka'
WHEN country LIKE 'Between%' THEN 'Portugal'
WHEN country LIKE 'North%Ocean' THEN REPLACE(country, 'North ','')
WHEN country = 'Pacifc Ocean' THEN 'Pacific Ocean'
WHEN country = 'South Pacifc Ocean' THEN 'Pacific Ocean'
WHEN country = 'Southwest Pacifc Ocean' THEN 'Pacific Ocean'
WHEN country = 'South Atlantic Ocean' THEN 'Atlantic Ocean'
WHEN country LIKE '%(Uae)' THEN 'United Arab Emirates'
ELSE country
END
FROM sharks
WHERE country IS NOT NULL;

UPDATE sharks
SET country = CASE
WHEN country LIKE 'Ceylon%' THEN 'Sri lanka'
WHEN country LIKE 'Between%' THEN 'Portugal'
WHEN country LIKE 'North%Ocean' THEN REPLACE(country, 'North ','')
WHEN country = 'Pacifc Ocean' THEN 'Pacific ocean'
WHEN country = 'South Pacific Ocean' THEN 'Pacific ocean'
WHEN country = 'Southwest Pacific Ocean' THEN 'Pacific ocean'
WHEN country = 'Central Pacific' THEN 'Pacific ocean'
WHEN country = 'South Atlantic Ocean' THEN 'Atlantic ocean'
WHEN country LIKE '%(Uae)' THEN 'United Arab Emirates'
ELSE country
END;

------- chcecking the number of attacks per country
SELECT country, COUNT(country)
FROM sharks
GROUP BY country
ORDER BY 1;

-------------------------------------------------------------------
-- COLUMN AREA


SELECT country, area
FROM sharks;

-- removing white spaces at the begining and end of line
UPDATE sharks
SET area = TRIM(area);

-- updating field North & South Carolina to NULL
UPDATE sharks
SET area = NULL
WHERE area LIKE 'North & South%';

-- checking the states within USA:
SELECT country, area, COUNT(area)
FROM sharks
GROUP BY country, area
HAVING country = 'USA'
ORDER BY 2;

-------------------------------------------------------------------
-- COLUMN ACTIVITY

--setting all case to lower to make analysis easier
UPDATE sharks
SET activity = lower(activity);

-- grouping the cases by categories
SELECT activity,
CASE
WHEN activity LIKE '%fishing%' THEN 'fishing'
WHEN activity LIKE '%boat%' THEN 'boating'
WHEN activity LIKE '%air%disaster%' OR activity LIKE '%aircraft%' THEN 'air disaster'
WHEN activity LIKE '%bathing%' OR activity LIKE '%standing%' THEN 'bathing'
WHEN activity LIKE '%surfing%'OR activity LIKE '%surf%' THEN 'surfing'
WHEN activity LIKE '%diving%' THEN 'diving'
WHEN activity LIKE '%swimming%' THEN 'bathing'
WHEN activity LIKE '%kayaking%' OR activity LIKE '%canoeing%' OR activity LIKE '%rowing%' THEN 'canoeing'
WHEN activity LIKE '%kite%' THEN 'kitesurfing'
WHEN activity LIKE '%snorkeling%' THEN 'snorkeling'
WHEN activity LIKE '%canoe%' OR activity LIKE '%paddle%' THEN 'canoeing'
WHEN activity LIKE '%sea%disaster%' OR activity LIKE '%shipwreck%' THEN 'sea disaster'
WHEN activity = 'fell overboard' THEN 'fell into the water'
ELSE activity
END
FROM sharks
ORDER BY 1;


UPDATE sharks
SET activity = CASE
WHEN activity LIKE '%fishing%' THEN 'fishing'
WHEN activity LIKE '%boat%' THEN 'boating'
WHEN activity LIKE '%air%disaster%' OR activity LIKE '%aircraft%' THEN 'air disaster'
WHEN activity LIKE '%bathing%' OR activity LIKE '%standing%' THEN 'bathing'
WHEN activity LIKE '%surfing%'OR activity LIKE '%surf%' THEN 'surfing'
WHEN activity LIKE '%diving%' THEN 'diving'
WHEN activity LIKE '%swimming%' THEN 'bathing'
WHEN activity LIKE '%kayaking%' OR activity LIKE '%canoeing%' OR activity LIKE '%rowing%' THEN 'canoeing'
WHEN activity LIKE '%kite%' THEN 'kitesurfing'
WHEN activity LIKE '%snorkeling%' THEN 'snorkeling'
WHEN activity LIKE '%canoe%' OR activity LIKE '%paddle%' THEN 'canoeing'
WHEN activity LIKE '%sea%disaster%' OR activity LIKE '%shipwreck%' THEN 'sea disaster'
WHEN activity = 'fell overboard' THEN 'fell into the water'
ELSE activity
END;

-- assigning category OTHER to activities that has count below 8
WITH activcount as(
SELECT my_id, activity, COUNT(activity) OVER (PARTITION BY activity) AS activitycount
FROM sharks)
UPDATE sharks
SET activity = CASE 
WHEN activitycount > 7 THEN activcount.activity
ELSE 'other'
END
FROM activcount
WHERE sharks.my_id = activcount.my_id;

-------------------------------------------------------------------
-- COLUMN SEX

SELECT sex, COUNT(sex)
FROM sharks
GROUP BY sex
ORDER BY 1

-- removing white spaces at the begining and end:
UPDATE sharks
SET sex = TRIM(sex);

-- leaving values with only M or F for Male and Female:
UPDATE sharks
SET sex = CASE
WHEN sex IN ('F', 'M') THEN sex
ELSE NULL
END;



-------------------------------------------------------------------
-- COLUMN AGE


SELECT age, COUNT(age)
FROM sharks
GROUP BY age
ORDER BY 1;

-- removing white spaces
UPDATE sharks
SET age = TRIM(age);

-- if value of age is given in months - setting the age as 1
-- and resolving other unstandard cases
WITH tempcte as 
(SELECT age, CASE
WHEN age LIKE '%month%' THEN '1'
WHEN age = 'Both 11' THEN '11'
WHEN age = '21 & ?' THEN '21'
WHEN age ~ '.*[ort].*' THEN SUBSTRING(age, 1, POSITION(' ' IN age))
WHEN age LIKE '%&%' THEN SUBSTRING(age,LENGTH(age)-2,LENGTH(age))
WHEN age ~ '\d' THEN REGEXP_REPLACE(age, '[^\d]','' ,'gi')
ELSE NULL
END as new_age
FROM sharks)
SELECT age, new_age, COUNT(new_age)
FROM tempcte
GROUP BY age, new_age
ORDER BY 2;


UPDATE sharks
SET age = CASE
WHEN age LIKE '%month%' THEN '1'
WHEN age = 'Both 11' THEN '11'
WHEN age = '21 & ?' THEN '21'
WHEN age ~ '.*[ort].*' THEN SUBSTRING(age, 1, POSITION(' ' IN age))
WHEN age LIKE '%&%' THEN SUBSTRING(age,LENGTH(age)-2,LENGTH(age))
WHEN age ~ '\d' THEN REGEXP_REPLACE(age, '[^\d]','' ,'gi')
WHEN age = '21 & ?' THEN '21'
ELSE NULL
END;

-- removing white spaces
UPDATE sharks
SET age = TRIM(age);

-- setting all empty cells to NULLS
SELECT age, CASE
WHEN coalesce(age, '') = '' THEN NULL
ELSE age
END
FROM sharks
ORDER BY 1;

UPDATE sharks
SET age = CASE
WHEN coalesce(age, '') = '' THEN NULL
ELSE age
END;

-------------------------------------------------------------------
-- COLUMN FATAL


SELECT DISTINCT(fatal) FROM sharks;

-- checking if we can extract data abaout fatal attacks from column injury:
SELECT injury, fatal
FROM sharks
WHERE fatal IS NULL AND injury LIKE '%fatal%'

-- assigning Y to column fatal, where column injury indicates that the accident was fatal
SELECT injury, fatal, CASE
WHEN fatal IS NULL AND injury LIKE '%fatal%' THEN 'Y'
ELSE fatal
END
FROM sharks
WHERE fatal IS NULL AND injury LIKE '%fatal%';

UPDATE sharks
SET fatal = CASE
WHEN fatal IS NULL AND injury LIKE '%fatal%' THEN 'Y'
ELSE fatal
END;

-- removing the white spaces from the column fatal
UPDATE sharks
SET fatal = TRIM(fatal);

-- setting all letters to upper case
UPDATE sharks
SET fatal = UPPER(fatal);

-- setting all the values that are not Y or N to NULL
SELECT fatal, CASE 
WHEN fatal IN ('Y', 'N') THEN fatal
ELSE NULL
END
FROM sharks
ORDER BY 1;

UPDATE sharks
SET fatal = CASE 
WHEN fatal IN ('Y', 'N') THEN fatal
ELSE NULL
END;

SELECT fatal, COUNT(fatal)
FROM sharks
GROUP BY fatal;

-------------------------------------------------------------------
-- COLUMN INJURY


SELECT injury
FROM sharks
ORDER BY 1;

-- setting all text to lower case
UPDATE sharks
SET injury = LOWER(injury);

-- trying to extract and group by body part that was attacked:
SELECT injury, CASE
WHEN injury LIKE '%hand%' THEN 'hand'
WHEN injury LIKE '%finger%' THEN 'hand'
WHEN injury LIKE '%wrist%' THEN 'hand'
WHEN injury LIKE '%arm%' THEN 'arm'
WHEN injury LIKE '%elbow%' THEN 'arm'
WHEN injury LIKE '%shoulder%' THEN 'arm'
WHEN injury LIKE '%head%' THEN 'head'
WHEN injury LIKE '%face%' THEN 'head'
WHEN injury LIKE '%cheek%' THEN 'head'
WHEN injury LIKE '%leg%' THEN 'leg'
WHEN injury LIKE '%calf%' THEN 'leg'
WHEN injury LIKE '%thigh%' THEN 'leg'
WHEN injury LIKE '%buttock%' THEN 'leg'
WHEN injury LIKE '%hip%' THEN 'leg'
WHEN injury LIKE '%knee%' THEN 'leg'
WHEN injury LIKE '%foot%' THEN 'foot'
WHEN injury LIKE '%ankle%' THEN 'foot'
WHEN injury LIKE '%heel%' THEN 'foot'
WHEN injury LIKE '%toe%' THEN 'foot'
WHEN injury LIKE '%feet%' THEN 'foot'
WHEN injury LIKE '%abdomen%' THEN 'trunk'
WHEN injury LIKE '%chest%' THEN 'trunk'
WHEN injury LIKE '%torso%' THEN 'trunk'
ELSE NULL
END
FROM sharks
WHERE injury IS NOT NULL
ORDER BY 2;

UPDATE sharks
SET injury = CASE
WHEN injury LIKE '%hand%' THEN 'hand'
WHEN injury LIKE '%finger%' THEN 'hand'
WHEN injury LIKE '%wrist%' THEN 'hand'
WHEN injury LIKE '%arm%' THEN 'arm'
WHEN injury LIKE '%elbow%' THEN 'arm'
WHEN injury LIKE '%shoulder%' THEN 'arm'
WHEN injury LIKE '%head%' THEN 'head'
WHEN injury LIKE '%face%' THEN 'head'
WHEN injury LIKE '%cheek%' THEN 'head'
WHEN injury LIKE '%leg%' THEN 'leg'
WHEN injury LIKE '%calf%' THEN 'leg'
WHEN injury LIKE '%thigh%' THEN 'leg'
WHEN injury LIKE '%buttock%' THEN 'leg'
WHEN injury LIKE '%hip%' THEN 'leg'
WHEN injury LIKE '%knee%' THEN 'leg'
WHEN injury LIKE '%foot%' THEN 'foot'
WHEN injury LIKE '%ankle%' THEN 'foot'
WHEN injury LIKE '%heel%' THEN 'foot'
WHEN injury LIKE '%toe%' THEN 'foot'
WHEN injury LIKE '%feet%' THEN 'foot'
WHEN injury LIKE '%abdomen%' THEN 'trunk'
WHEN injury LIKE '%chest%' THEN 'trunk'
WHEN injury LIKE '%torso%' THEN 'trunk'
ELSE NULL
END;

SELECT injury, COUNT(injury)
FROM sharks
GROUP BY injury;

-------------------------------------------------------------------
-- COLUMN TIME

-- removing white spaces
UPDATE sharks 
SET time = TRIM(time);

-- extracting the time from time field with various time formats and text:
SELECT time, CASE
WHEN time ~ '^[\d]{2}h[\d]{2}$' THEN time
WHEN time ~ '^[\d]{2}h[\d]{2}' THEN LEFT(time, 5)
WHEN time ~ '[\d]{2}h[\d]{2}$' THEN RIGHT(time, 5)
WHEN time ~ '[^\d]+' THEN NULL
WHEN time ~ '^[\d]{3}$' THEN '0' || LEFT(time, 1) || 'h' || RIGHT(time,2)
ELSE time
END
FROM sharks
WHERE time IS NOT NULL
ORDER BY 1;

UPDATE sharks
SET time = CASE
WHEN time ~ '^[\d]{2}h[\d]{2}$' THEN time
WHEN time ~ '^[\d]{2}h[\d]{2}' THEN LEFT(time, 5)
WHEN time ~ '[\d]{2}h[\d]{2}$' THEN RIGHT(time, 5)
WHEN time ~ '[^\d]+' THEN NULL
WHEN time ~ '^[\d]{3}$' THEN '0' || LEFT(time, 1) || 'h' || RIGHT(time,2)
ELSE time
END;


-- seting all the empty cells to NULL
SELECT time, CASE
WHEN COALESCE(time,'') = '' THEN NULL
ELSE time
END
FROM sharks
ORDER BY 1;

UPDATE sharks
SET time = CASE
WHEN COALESCE(time,'') = '' THEN NULL
ELSE time
END;



SELECT time, COUNT(time)
FROM sharks
GROUP BY time
ORDER BY 1;

-------------------------------------------------------------------
-- COLUMN SPECIES

-- removing white spaces and setting everything to lower case:
UPDATE sharks
SET species = TRIM(LOWER(species));

-- creating groups for shark species, NULL when undefined
SELECT species, CASE
WHEN species LIKE '%dusky shark%' THEN 'dusky shark'
WHEN species LIKE '%tiger shark%' THEN 'tiger shark'
WHEN species LIKE '%white shark%' THEN 'great white shark'
WHEN species LIKE '%sand shark%' THEN 'sand tiger shark'
WHEN species LIKE '%sandshark%' THEN 'sand tiger shark'
WHEN species LIKE '%nurse shark%' THEN 'sand tiger shark'
WHEN species LIKE '%ragged%' THEN 'sand tiger shark'
WHEN species LIKE '%spinner shark%' THEN 'spinner shark'
WHEN species LIKE '%hammerhead%' THEN 'hammerhead'
WHEN species LIKE '%whitetip reef%' THEN 'whitetip reef shark'
WHEN species LIKE '%white-tipped reef%' THEN 'whitetip reef shark'
WHEN species LIKE '%caribbean reef%' THEN 'caribbean reef shark'
WHEN species LIKE '%sandbar%' THEN 'sandbar shark'
WHEN species LIKE '%brown%' THEN 'sandbar shark'
WHEN species LIKE '%blacktip%' THEN 'blacktip shark'
WHEN species LIKE '%black-tip%' THEN 'blacktip shark'
WHEN species LIKE '%black tip%' THEN 'blacktip shark'
WHEN species LIKE '%bull%' THEN 'bull shark'
WHEN species LIKE '%zambezi%' THEN 'bull shark'
WHEN species LIKE '%zambesi%' THEN 'bull shark'
WHEN species LIKE '%blue%' THEN 'blue shark'
WHEN species LIKE '%galapagos%' THEN 'galapagos shark'
WHEN species LIKE '%basking%' THEN 'basking shark'
WHEN species LIKE '%shortfin%' THEN 'shortfin mako shark'
WHEN species LIKE '%mako%' THEN 'shortfin mako shark'
WHEN species LIKE '%blue pointer%' THEN 'shortfin mako shark'
WHEN species LIKE '%grey reef%' THEN 'grey reef shark'
WHEN species LIKE '%reef shark%' THEN 'grey reef shark'
WHEN species LIKE '%grey%' THEN 'grey reef shark'
WHEN species LIKE '%gray%' THEN 'grey reef shark'
WHEN species LIKE '%silky%' THEN 'silky shark'
WHEN species LIKE '%carpet%' THEN 'carpet shark'
WHEN species LIKE '%wobbegong%' THEN 'carpet shark'
WHEN species LIKE '%oceanic whitetip%' THEN 'oceanic whitetip shark'
WHEN species LIKE '%bronze whaler%' THEN 'copper shark'
WHEN species LIKE '%bronze%' THEN 'copper shark'
WHEN species LIKE '%copper%' THEN 'copper shark'
WHEN species LIKE '%whaler%' THEN 'copper shark'
WHEN species LIKE '%whale%' THEN 'whale shark'
WHEN species LIKE '%lemon%' THEN 'lemon shark'
WHEN species LIKE '%angel%' THEN 'angel shark'
WHEN species LIKE '%sevengill%' THEN 'broadnose sevengill shark'
WHEN species LIKE '%seven%' THEN 'broadnose sevengill shark'
WHEN species LIKE '%gill%' THEN 'broadnose sevengill shark'
WHEN species LIKE '%salmon%' THEN 'salmon shark'
WHEN species LIKE '%silvertip%' THEN 'silvertip shark'
WHEN species LIKE '%leopard%' THEN 'leopard shark'
WHEN species LIKE '%cookie%' THEN 'cookiecutter shark'
WHEN species LIKE '%goblin%' THEN 'goblin shark'
WHEN species LIKE '%cow%' THEN 'cow shark'
WHEN species LIKE '%porbeagle%' THEN 'porbeagle'
WHEN species LIKE '%dog%' THEN 'spiny dogfish'
WHEN species LIKE '%leucas%' THEN 'bull shark'
WHEN species LIKE '%catshark%' THEN 'catshark'
WHEN species LIKE '%thresher%' THEN 'thresher shark'
WHEN species LIKE '%shovel%' THEN 'shovelnose guitarfish'
WHEN species LIKE '%gummy%' THEN 'gummy shark'
ELSE NULL
END
FROM sharks
WHERE species IS NOT NULL
ORDER BY 2;

UPDATE sharks
SET species = CASE
WHEN species LIKE '%dusky shark%' THEN 'dusky shark'
WHEN species LIKE '%tiger shark%' THEN 'tiger shark'
WHEN species LIKE '%white shark%' THEN 'great white shark'
WHEN species LIKE '%sand shark%' THEN 'sand tiger shark'
WHEN species LIKE '%sandshark%' THEN 'sand tiger shark'
WHEN species LIKE '%nurse shark%' THEN 'sand tiger shark'
WHEN species LIKE '%ragged%' THEN 'sand tiger shark'
WHEN species LIKE '%spinner shark%' THEN 'spinner shark'
WHEN species LIKE '%hammerhead%' THEN 'hammerhead'
WHEN species LIKE '%whitetip reef%' THEN 'whitetip reef shark'
WHEN species LIKE '%white-tipped reef%' THEN 'whitetip reef shark'
WHEN species LIKE '%caribbean reef%' THEN 'caribbean reef shark'
WHEN species LIKE '%sandbar%' THEN 'sandbar shark'
WHEN species LIKE '%brown%' THEN 'sandbar shark'
WHEN species LIKE '%blacktip%' THEN 'blacktip shark'
WHEN species LIKE '%black-tip%' THEN 'blacktip shark'
WHEN species LIKE '%black tip%' THEN 'blacktip shark'
WHEN species LIKE '%bull%' THEN 'bull shark'
WHEN species LIKE '%zambezi%' THEN 'bull shark'
WHEN species LIKE '%zambesi%' THEN 'bull shark'
WHEN species LIKE '%blue%' THEN 'blue shark'
WHEN species LIKE '%galapagos%' THEN 'galapagos shark'
WHEN species LIKE '%basking%' THEN 'basking shark'
WHEN species LIKE '%shortfin%' THEN 'shortfin mako shark'
WHEN species LIKE '%mako%' THEN 'shortfin mako shark'
WHEN species LIKE '%blue pointer%' THEN 'shortfin mako shark'
WHEN species LIKE '%grey reef%' THEN 'grey reef shark'
WHEN species LIKE '%reef shark%' THEN 'grey reef shark'
WHEN species LIKE '%grey%' THEN 'grey reef shark'
WHEN species LIKE '%gray%' THEN 'grey reef shark'
WHEN species LIKE '%silky%' THEN 'silky shark'
WHEN species LIKE '%carpet%' THEN 'carpet shark'
WHEN species LIKE '%wobbegong%' THEN 'carpet shark'
WHEN species LIKE '%oceanic whitetip%' THEN 'oceanic whitetip shark'
WHEN species LIKE '%bronze whaler%' THEN 'copper shark'
WHEN species LIKE '%bronze%' THEN 'copper shark'
WHEN species LIKE '%copper%' THEN 'copper shark'
WHEN species LIKE '%whaler%' THEN 'copper shark'
WHEN species LIKE '%whale%' THEN 'whale shark'
WHEN species LIKE '%lemon%' THEN 'lemon shark'
WHEN species LIKE '%angel%' THEN 'angel shark'
WHEN species LIKE '%sevengill%' THEN 'broadnose sevengill shark'
WHEN species LIKE '%seven%' THEN 'broadnose sevengill shark'
WHEN species LIKE '%gill%' THEN 'broadnose sevengill shark'
WHEN species LIKE '%salmon%' THEN 'salmon shark'
WHEN species LIKE '%silvertip%' THEN 'silvertip shark'
WHEN species LIKE '%leopard%' THEN 'leopard shark'
WHEN species LIKE '%cookie%' THEN 'cookiecutter shark'
WHEN species LIKE '%goblin%' THEN 'goblin shark'
WHEN species LIKE '%cow%' THEN 'cow shark'
WHEN species LIKE '%porbeagle%' THEN 'porbeagle'
WHEN species LIKE '%dog%' THEN 'spiny dogfish'
WHEN species LIKE '%leucas%' THEN 'bull shark'
WHEN species LIKE '%catshark%' THEN 'catshark'
WHEN species LIKE '%thresher%' THEN 'thresher shark'
WHEN species LIKE '%shovel%' THEN 'shovelnose guitarfish'
WHEN species LIKE '%gummy%' THEN 'gummy shark'
ELSE NULL
END;

SELECT species, COUNT(species)
FROM sharks
GROUP BY species
ORDER BY 1;

---------------------------------------------------------------
-- PART 3: DATA ANALYSIS AND ANSWERING THE QUESTIONS

SELECT * 
FROM sharks;

-- 1. Which of the states in US have the higher amount of shark attacks?

SELECT country, area, COUNT(area)
FROM sharks
WHERE country = 'USA'
GROUP BY country, area
ORDER BY 3 DESC;
-- The majority of the shark attacks happened in Florida. Then, the next are Hawaii and California 

--2. What is the percentage of attacks between man and woman based on the available data?

SELECT sex, COUNT(*) as sumofsex,
 ROUND(COUNT(*)*100.0 / SUM(COUNT(*)) OVER(),2) as percentage
FROM sharks
WHERE sex IS NOT NULL
GROUP BY sex;
-- Based on the available data, victis of 89% of shark attacks were men



--3. Which of the US states has the higher rate of fatal attacts with regard to all attacks?

WITH usafatal as(
SELECT 
    country, area, fatal, COUNT(sex),
	ROUND(COUNT(*)*100 / SUM(COUNT(*)) OVER(PARTITION BY area),2) as percentage
FROM sharks 
WHERE country = 'USA' AND
	area IS NOT NULL AND
	fatal IS NOT NULL
GROUP BY country, area, fatal
ORDER BY 2,3)
SELECT *
FROM usafatal
WHERE usafatal.fatal = 'Y'
ORDER BY 5 DESC;
-- There are a few states, where the statistics are high, because there are not many shark attacks. 
-- For these states, even 2 fatal attacks corresponds to high percentage of all attacks (for example 40% for Mississipi)
-- For Hawaii, with 69 fatal attacks, 25% of all attacks were fatal.
-- For Florida, where they were 65 fatal attacks, it corresponds to only 6.7% of all attacks

--4. What is the percentage of fatal attacts between man and woman?

SELECT sex, fatal, COUNT(fatal),
	ROUND(COUNT(*) * 100.00 / SUM(COUNT(*)) OVER(), 2)
FROM sharks
WHERE fatal = 'Y' AND sex IS NOT NULL
GROUP BY sex, fatal
ORDER BY 1,2;
-- Based on the data, 91.30% of fatal accidents happen to men

SELECT sex, fatal, COUNT(fatal),
	ROUND(COUNT(*) * 100.00 / SUM(COUNT(*)) OVER(PARTITION BY sex), 2)
FROM sharks
WHERE fatal IS NOT NULL 
	AND sex IS NOT NULL
GROUP BY sex, fatal
ORDER BY 1,2;
-- Rate of fatal accidents for men is 27% and for woman is 20% with regard to all shark attacks


-- 5. What percentage of all fatal attacks were provoked?

SELECT type, fatal, count(fatal),
	ROUND(count(*)*100 / SUM(COUNT(*)) OVER (PARTITION BY fatal),2)
FROM sharks
WHERE type IN ('Provoked', 'Unprovoked')
	AND fatal IS NOT NULL
GROUP BY type, fatal
ORDER BY 2;
-- Only 1.46% of all fatal attacks were provoked

--6. Calculating attacks in given country/region by shark species. 
-- Is there a region where attacks by one shark specie are most common than by the other?

SELECT country, species, COUNT(*) as attacks_count, 
	ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER (PARTITION BY country),2)
FROM sharks
WHERE country IS NOT NULL 
	AND species IS NOT NULL
GROUP BY country, species
ORDER BY 3 DESC;
-- Based on analyzis, we see that:
-- - nearly 29% of all attacks in USA are caused by great white shark, and 18% by tiger shark
-- - 57% of all attacks in South Affrica are caused by great white shark
-- - 90% of attacks in Italy are by great white shark
-- - 100% of attacks in Croatia is by great white shark
-- - 100% of attacks in Iran is by Bull shark

--7. Which shark specie attacks more often?

SELECT species, COUNT(species),
	ROUND(COUNT(*)*100 / SUM(COUNT(*)) OVER (),2)
FROM sharks
WHERE species IS NOT NULL
GROUP BY species
ORDER BY 2 DESC;
-- Over 30% of all attacks are caused by great white sharks!

--8. Which shark spiecie is the most deadly:

SELECT species, fatal, COUNT(*),
	ROUND(COUNT(*)*100 / SUM(COUNT(*)) OVER (PARTITION BY species),2)
FROM sharks
WHERE species IS NOT NULL
	AND fatal IS NOT NULL
GROUP BY species, fatal
ORDER BY 2 DESC, 4 DESC;
-- nearly 30% of tiger shark attacks are deadly, 
-- 24% of great white shark - so every 4th attack of great white shark is fatal
-- non of the attacks by carpet shark (53) or gray reef shark (45) was fatal

-- 9. Which body part is attacked by sharks the most often?

SELECT injury, COUNT(*), ROUND(COUNT(*)*100 / SUM(COUNT(*)) OVER (),2) as percentage
FROM sharks
WHERE injury IS NOT NULL
GROUP BY injury
ORDER BY 2 DESC;
-- over 40% of injuries is of the leg and over 22 og food, so over 60% of lower limbs.
-- 15% injuries of arm and 16% of hand, so over 30% of upper limbs

-- 10. Which shark species attact which human body part?

WITH injury_by_species as(
SELECT species,injury, 
	COUNT(*) as injury_count, ROUND(COUNT(*)*100 / SUM(COUNT(*)) OVER (PARTITION BY species),2) as percentage
FROM sharks
WHERE injury IS NOT NULL
GROUP BY injury, species)
SELECT *
FROM injury_by_species
WHERE species IS NOT NULL
ORDER BY 1,3 DESC;

-- Is there any shark than attacked most time different body part than leg?
WITH injury_by_species as(
SELECT species,injury, 
	COUNT(*) as injury_count, ROUND(COUNT(*)*100 / SUM(COUNT(*)) OVER (PARTITION BY species),2) as percentage
FROM sharks
WHERE injury IS NOT NULL
GROUP BY injury, species)
SELECT species, injury, injury_count, percentage
FROM injury_by_species
WHERE species IS NOT NULL
 AND (species, injury_count) IN 
 (SELECT species, MAX(injury_count)
 FROM injury_by_species
 GROUP BY species)
ORDER BY 1 DESC;

-- Based on the data for most species, the body part attacked most often is leg or feet,
-- however there are some shark species for which the most often attacted part is arm (caribbean reef shark) 
-- or hand (for example oceanic whitetip shark which most often attack hand or arm)


-- 11. Which activies caused the most fatal attacks:

SELECT activity, fatal, COUNT(*)
FROM sharks
WHERE fatal IS NOT NULL
GROUP BY activity, fatal
ORDER BY 2 DESC, 3 DESC;
-- most of the fatal accidents happened during bathing, fishing and diving

-- What are the activities with the highest ratio of fatal attacks?
WITH fatal_activity as(
SELECT activity, fatal, COUNT(*),
 ROUND(COUNT(*)*100/SUM(COUNT(*)) OVER (PARTITION BY activity),2)
FROM sharks
WHERE fatal IS NOT NULL
GROUP BY activity, fatal)
SELECT *
FROM fatal_activity
WHERE fatal = 'Y'
ORDER BY 4 DESC;
-- The highest probability of fatal attacks experienced people that fell into water. 
-- according to data, nearly 84% of them died after being attacked!
-- next activity is boating and sea disaster.
-- the lowest percentage is for boogie boarding and surfing, where less than 7% of all attacks are fatal



-- SOURCE: https://www.kaggle.com/datasets/mysarahmadbhat/shark-attacks