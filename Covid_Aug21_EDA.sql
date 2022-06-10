USE [Portfolio Project];

SELECT 
	*
FROM 
	[Portfolio Project]..Covid_Deaths
ORDER BY 
	location, date;

--SELECT *
--FROM [Portfolio Project]..Covid_Vaccinations
--ORDER BY location, date;

--Select Data that we are going to be using

SELECT 
	location, date, total_cases, new_cases, total_deaths, population
FROM 
	[Portfolio Project]..Covid_Deaths
ORDER BY 
	location, date;

--Looking at Total Number of Cases vs Total Deaths
--Examining rough probability of death from COVID-19 in the US upon infection

SELECT 
	location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS death_percent
FROM 
	[Portfolio Project]..Covid_Deaths
WHERE 
	location LIKE '%United States%'
ORDER BY 
	location, date;

--Looking at Total Cases vs Population
--Shows percent of population that have gotten COVID
--Potential error by not accounting for people infected multiple times

SELECT 
	location, date, total_cases, population, (total_cases/population)*100 AS infection_percent
FROM 
	[Portfolio Project]..Covid_Deaths
WHERE 
	location LIKE '%United States%'
ORDER BY 
	location, date;

--Looking at countries with highest infection percentage compared to population

SELECT 
	location, MAX(total_cases) AS total_cases, population, (MAX(total_cases)/population)*100 AS infection_percent
FROM 
	[Portfolio Project]..Covid_Deaths
GROUP BY 
	location, population
ORDER BY 
	infection_percent DESC;

--Showing Countries with highest number of deaths from COVID

SELECT 
	location, MAX(CAST(total_deaths AS INT)) AS total_death_amount
FROM 
	[Portfolio Project]..Covid_Deaths
WHERE
	continent IS NOT NULL
GROUP BY 
	location
ORDER BY 
	total_death_amount DESC;

--Looking at total deaths by continent

SELECT 
	continent, MAX(CAST(total_deaths AS INT)) AS total_death_amount
FROM 
	[Portfolio Project]..Covid_Deaths
WHERE
	continent IS NOT NULL
GROUP BY 
	continent
ORDER BY 
	total_death_amount DESC;

--Global Numbers

SELECT 
	date, SUM(new_cases) AS total_cases, 
	SUM(CAST (new_deaths AS INT)) AS total_deaths, 
	SUM(CAST (new_deaths AS INT))/SUM(new_cases)*100 AS death_percent
FROM 
	[Portfolio Project]..Covid_Deaths
WHERE 
	continent IS NOT NULL
GROUP BY
	date
ORDER BY 
	date;

--Looking at Total Population vs Total Vaccinations

SELECT
	d.continent, d.location, d.date, d.population, v.new_vaccinations, 
	SUM(CAST(v.new_vaccinations AS INT)) 
		OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vax_total
FROM
	[Portfolio Project]..Covid_Deaths d
	JOIN [Portfolio Project]..Covid_Vaccinations v
		ON d.location = v.location
		AND d.date = v.date
WHERE
	d.continent IS NOT NULL
ORDER BY
	location, date;

--USING CTE

WITH Pop_vs_Vac (Continent, location, date, population, new_vaccinations, rolling_vax_total)
AS
(
SELECT
	d.continent, d.location, d.date, d.population, v.new_vaccinations, 
	SUM(CAST(v.new_vaccinations AS INT)) 
		OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vax_total
--,	(rolling_vax_total/population)*100
FROM
	[Portfolio Project]..Covid_Deaths d
	JOIN [Portfolio Project]..Covid_Vaccinations v
		ON d.location = v.location
		AND d.date = v.date
WHERE
	d.continent IS NOT NULL
--ORDER BY
	--2,3
)

SELECT
	*, (rolling_vax_total/population)*100 AS vaccine_percent
FROM
	Pop_vs_Vac;

--Temp Table

DROP TABLE IF EXISTS #Vaccinated_Percentage
CREATE TABLE #Vaccinated_Percentage
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
Date DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
Rolling_vax_total NUMERIC
)

INSERT INTO #Vaccinated_Percentage
SELECT
	d.continent, d.location, d.date, d.population, v.new_vaccinations, 
	SUM(CAST(v.new_vaccinations AS INT)) 
		OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vax_total
--,	(rolling_vax_total/population)*100
FROM
	[Portfolio Project]..Covid_Deaths d
	JOIN [Portfolio Project]..Covid_Vaccinations v
		ON d.location = v.location
		AND d.date = v.date
WHERE
	d.continent IS NOT NULL
--ORDER BY
	--2,3

SELECT
	*, (Rolling_vax_total/Population)*100 AS Percent_vaccinated
FROM
	#Vaccinated_Percentage

--Creating View to use for visualization in Tableau

CREATE VIEW Percent_Population_Vaccinated

SELECT
	d.continent, d.location, d.date, d.population, v.new_vaccinations, 
	SUM(CAST(v.new_vaccinations AS INT)) 
		OVER (PARTITION BY d.location ORDER BY d.location, d.date) AS rolling_vax_total
--,	(rolling_vax_total/population)*100
FROM
	[Portfolio Project]..Covid_Deaths d
	JOIN [Portfolio Project]..Covid_Vaccinations v
		ON d.location = v.location
		AND d.date = v.date
WHERE
	d.continent IS NOT NULL
--ORDER BY 2,3

SELECT *
FROM Percent_Population_Vaccinated