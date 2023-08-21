/*
Queries used for Tableau Project
Query statements are from project 1 (SQL - Data Exploration)
Main goal is to install, use, apply Public Tableau version for data visualization
*/

-- A. Prepare data

-- 1. Global View of total cases, total deaths, and deaths over cases rate
select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
from SQL_Tutorial..CovidDeaths$
where continent is not null 
order by 1,2

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Locatio

--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeaths
----Where location like '%states%'
--where location = 'World'
----Group By date
--order by 1,2


-- 2. Filtering out data that inner values of other data

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From SQL_Tutorial..CovidDeaths$
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc


-- 3. Countries' case count and infection rate

Select Location, Population, ISNULL(MAX(total_cases),0) as HighestInfectionCount,  
ISNULL(Max((total_cases/population))*100,0) as PercentPopulationInfected
From SQL_Tutorial..CovidDeaths$
Where location IS NOT NULL AND Population IS NOT NULL
Group by Location, Population
order by PercentPopulationInfected desc


-- 4. Countries' total case counts and infection rate per date


Select Location, Population, date, ISNULL(MAX(total_cases),0) as HighestInfectionCount,  
ISNULL(Max((total_cases/population))*100,0) as PercentPopulationInfected
From SQL_Tutorial..CovidDeaths$
Where location is not null and Population is not null
Group by Location, Population, date
order by PercentPopulationInfected desc

-- B. Copying data to 4 separate excel files and import to Tableau later
-- 1. Install Public Tableau
-- 2. Create View for each data file
-- 3. Drag and drop each view into a dashboard
-- 4. Save the Tableau file as public file in Tableau account and get shared link
https://public.tableau.com/app/profile/trong.pham4252/viz/CovidStatusDashboard/Dashboard1
