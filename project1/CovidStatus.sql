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
order by 3,4
select top 100 * from CovidVaccinations$
order by 3,4

--3.2. Total cases vs total deaths, total cases vs population
select location, total_cases, total_deaths, population,
	(total_deaths/total_cases)*100 as deaths_over_cases_rates,
	(total_cases/population)*100 as cases_over_population_rates
from CovidDeaths$
order by 4 desc
--4. Apply Tableau to visualize views' data that are given from step 3
