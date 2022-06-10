/*
Queries used for Tableau Portfolio Project
*/

-- 1. 

SELECT
	SUM(new_cases) AS total_cases, 
	SUM(cast(new_deaths AS INT)) AS total_deaths,
	SUM(cast(new_deaths AS INT))/SUM(New_Cases)*100 AS Death_Percentage
FROM 
	[Portfolio Project]..Covid_Deaths
--WHERE location LIKE '%states%'
WHERE continent IS NOT NULL 
--GROUP BY date
ORDER BY 1,2;

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Location

/*
SELECT 
	SUM(new_cases) as total_cases, 
	SUM(cast(new_deaths as int)) as total_deaths, 
	SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as Death_Percentage
FROM 
	[Portfolio Project]..Covid_Deaths
--WHERE location LIKE '%states%'
WHERE location = 'World'
--GROUP BY date
ORDER BY 1,2;
*/

-- 2. 

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

SELECT 
	location, 
	SUM(cast(new_deaths AS INT)) AS Total_Death_Count
FROM 
	[Portfolio Project]..Covid_Deaths
--WHERE location LIKE '%states%'
WHERE continent IS NULL 
AND location NOT IN ('World', 'European Union', 'International')
GROUP BY location
ORDER BY Total_Death_Count DESC;


-- 3.

SELECT 
	Location, 
	Population, 
	MAX(total_cases) AS Highest_Infection_Count,
	MAX((total_cases/population))*100 AS Percent_Population_Infected
FROM 
	[Portfolio Project]..Covid_Deaths
--WHERE location LIKE '%states%'
GROUP BY Location, Population
ORDER BY Percent_Population_Infected DESC;


-- 4.


SELECT
	Location, 
	Population,
	date, 
	MAX(total_cases) AS Highest_Infection_Count,
	MAX((total_cases/population))*100 AS Percent_Population_Infected
FROM 
	[Portfolio Project]..Covid_Deaths
--WHERE location LIKE '%states%'
GROUP BY Location, Population, date
ORDER BY Percent_Population_Infected DESC;