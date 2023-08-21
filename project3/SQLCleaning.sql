/*
 Project 3 - Cleaning and Visualizing Housing Data
*/
select * from SQL_Tutorial..NashvilleHousing$
-- 1. Standardize date data
update SQL_Tutorial..NashvilleHousing$
set SaleDate = convert(Date, SaleDate)
select * from SQL_Tutorial..NashvilleHousing$

select SaleDate, convert(Date, SaleDate) as ConvertedSaleDate
from SQL_Tutorial..NashvilleHousing$

-- 2. Populate property address data

select a.PropertyAddress, a.ParcelID, b.PropertyAddress, b.ParcelID
from SQL_Tutorial..NashvilleHousing$ a
join SQL_Tutorial..NashvilleHousing$ b
on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

update a
set a.PropertyAddress = b.PropertyAddress
from SQL_Tutorial..NashvilleHousing$ a
join SQL_Tutorial..NashvilleHousing$ b
on a.ParcelID = b.ParcelID and a.UniqueID <> b.UniqueID
where a.PropertyAddress is null

select * from SQL_Tutorial..NashvilleHousing$

--3. Breaking out owner's address into Address, City, State


