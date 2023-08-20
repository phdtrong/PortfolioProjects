-- Project 1. SQL DATA EXPLORATION
--0.Project Goal
-- Install SQL
-- Working with raw data (ETL)
-- Adapting different SQL levels of beginning, mediate, and advanced
-- Data visualization

--1. Visit ourworldindata.org/covid-deaths to download, 
--  split data into 2 separate files as CovidDeaths.xlsx and CovidVaccinations.xlsx
--2. Visit SQL and select DatabaseName > Task > Import Data(*)
--  Excel version: Microsoft Excel 97-2003
--  Source: Select the data in step 1 to import into your DatabaseName
--  Destination: Microsoft OLE DB Provider for SQL Server
--  Server Name: Ensure your server name is correctly selected
--  Database: Ensure your database name is correctly selected (i.e. DatabaseName above)
--  (*)Issue of SQL Server Excel Import - The 'Microsoft.ACE.OLEDB.12.0' ? 
--   solution is download and then install 32bit version of importer tool as show here
--   https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine.exe
--3. Apply SQL techniques to clean, filter data and finally create views for step 4

--3.1. Checking correct data tables are imported?
select top 100 * from CovidDeaths$ where continent is not null
order by 3,4

select top 100 * from CovidVaccinations$ vac
join CovidDeaths$ dea on dea.location = vac.location 
where dea.continent is not null
order by 3,4

--3.2. Total cases vs total deaths, total cases vs population
select location, total_cases, total_deaths, population,
	(total_deaths/total_cases)*100 as deaths_over_cases_rates,
	(total_cases/population)*100 as cases_over_population_rates
from CovidDeaths$
where continent is not null
order by 4 desc

-- Project 1. SQL DATA EXPLORATION
--1. Visit ourworldindata.org/covid-deaths to download, 
--  split data into 2 separate files as CovidDeaths.xlsx and CovidVaccinations.xlsx
--2. Visit SQL and select DatabaseName > Task > Import Data(*)
--  Excel version: Microsoft Excel 97-2003
--  Source: Select the data in step 1 to import into your DatabaseName
--  Destination: Microsoft OLE DB Provider for SQL Server
--  Server Name: Ensure your server name is correctly selected
--  Database: Ensure your database name is correctly selected (i.e. DatabaseName above)
--  (*)Issue of SQL Server Excel Import - The 'Microsoft.ACE.OLEDB.12.0' ? 
--   solution is download and then install 32bit version of importer tool as show here
--   https://download.microsoft.com/download/2/4/3/24375141-E08D-4803-AB0E-10F2E3A07AAA/AccessDatabaseEngine.exe
--3. Apply SQL techniques to clean, filter data and finally create views for step 4

--3.1. Checking correct data tables are imported?
select top 100 * from CovidDeaths$
where continent is not null
order by 3,4
select top 100 * from CovidVaccinations$
where continent is not null
order by 3,4

--3.2. Total cases vs total deaths, total cases vs population
select location, total_cases, total_deaths, population,
	(total_deaths/total_cases)*100 as deaths_over_cases_rates,
	(total_cases/population)*100 as cases_over_population_rates
from CovidDeaths$
where continent is not null
order by 4 desc

--3.3. Looking at Countries with Highest Infection rate compared to Population
select location, population, max(total_cases) as highest_infection_count, max(total_cases/population)*100 as cases_over_population_rates
from CovidDeaths$
group by location, population
order by 4 desc

--3.4. Showing countries with Highest Death Count per Population
select location, population, max(cast(total_deaths as bigint)) as highest_infection_count, max(total_deaths/population)*100 as deaths_over_population_rates
from CovidDeaths$
where continent is not null
group by location, population
order by 4 desc

--3.4.2. Looking at total population vs vaccination
select dea.date, dea.continent, dea.location, vac.total_vaccinations, dea.population
from CovidVaccinations$ vac
join CovidDeaths$ dea on dea.location = vac.location 
where dea.continent is not null
group by dea.date
order by 1,2

-- CONTINENTS NUMBERS

--3.5. Showing continents with Highest Death Count per Population
select continent, max(cast(total_deaths as int)) as highest_infection_count, max(total_deaths/population)*100 as deaths_over_population_rates
from CovidDeaths$
where continent is not null
group by continent
order by 3 desc

-- GLOBAL NUMBERS

--3.6. Global Death Counts per Date
select date, sum(cast(total_deaths as int)) as global_infection_count
from CovidDeaths$
where continent is not null
group by date

--3.7. Global New Cases Counts per Date
select date, sum(new_cases) as global_new_infection_count, sum(cast(new_deaths as int)) as global_new_deaths,
 sum(cast(new_deaths as int))/sum(new_cases)*100 as new_death_rates
from CovidDeaths$
where continent is not null
group by date
order by 1
--4. Apply Tableau to visualize views' data that are given from step 3
