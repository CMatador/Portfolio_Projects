/* Cleaning data in SQL */

SELECT *
FROM [Portfolio Project].dbo.Nashville_Housing

-- Standardize date format

ALTER TABLE Nashville_Housing
ADD SaleDateConverted Date;

UPDATE Nashville_Housing
SET SaleDateConverted = CONVERT(date, SaleDate)

SELECT SaleDateConverted
FROM [Portfolio Project].dbo.Nashville_Housing

-- Populate Property Address data

SELECT *
FROM [Portfolio Project].dbo.Nashville_Housing
--WHERE PropertyAddress IS NULL
ORDER BY ParcelID

	--A duplicate Parcel ID also has the same address so we can use these to populate missing addresses that match a parcel ID somewhere else

SELECT h1.ParcelID, h1.PropertyAddress, h2.ParcelID, h2.PropertyAddress, ISNULL(h1.PropertyAddress, h2.PropertyAddress)
FROM [Portfolio Project].dbo.Nashville_Housing h1
JOIN [Portfolio Project].dbo.Nashville_Housing h2
	ON h1.ParcelID = h2.ParcelID
	AND h1.[UniqueID ] <> h2.[UniqueID ]
WHERE h1.PropertyAddress IS NULL

UPDATE h1
SET PropertyAddress = ISNULL(h1.PropertyAddress, h2.PropertyAddress)
FROM [Portfolio Project].dbo.Nashville_Housing h1
JOIN [Portfolio Project].dbo.Nashville_Housing h2
	ON h1.ParcelID = h2.ParcelID
	AND h1.[UniqueID ] <> h2.[UniqueID ]
WHERE h1.PropertyAddress IS NULL

-- Seperating Address into individual columns (Address, City, State)

SELECT PropertyAddress
FROM [Portfolio Project].dbo.Nashville_Housing

	-- Address and City are seperated by a comma so we use a substring to pull the text before the comma

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address
FROM [Portfolio Project].dbo.Nashville_Housing

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) AS Address,
	SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS City
FROM [Portfolio Project].dbo.Nashville_Housing

ALTER TABLE Nashville_Housing
ADD PropertySplitAddress NVARCHAR(255) ;

UPDATE Nashville_Housing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1)

ALTER TABLE Nashville_Housing
ADD PropertySplitCity NVARCHAR(255);

UPDATE Nashville_Housing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

	--We will perform the same split with the Owner Address, though in a different way because there are three different pieces to split (Address, City and State)

SELECT OwnerAddress
FROM [Portfolio Project].dbo.Nashville_Housing

SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3) AS Address
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2) AS City
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1) AS State
FROM [Portfolio Project].dbo.Nashville_Housing

ALTER TABLE Nashville_Housing
ADD OwnerSplitAddress NVARCHAR(255) ;

UPDATE Nashville_Housing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

ALTER TABLE Nashville_Housing
ADD OwnerSplitCity NVARCHAR(255) ;

UPDATE Nashville_Housing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

ALTER TABLE Nashville_Housing
ADD OwnerSplitState NVARCHAR(255) ;

UPDATE Nashville_Housing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)

-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant)
FROM [Portfolio Project].dbo.Nashville_Housing

	-- We have both Y/N and Yes/No, so we will standardize this column to Yes/No with a case statement

SELECT SoldAsVacant
,	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END
FROM [Portfolio Project].dbo.Nashville_Housing

UPDATE Nashville_Housing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
		 WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END

-- Remove Duplicates

	-- While I wouldn't recommend deleting real work data, I'll do this for the purposes of the exercise

WITH RowNumCTE AS(
SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
FROM [Portfolio Project].dbo.Nashville_Housing
)
DELETE
FROM RowNumCTE
WHERE row_num > 1

-- Delete Unused Columns

	--Again don't do this to raw data!

ALTER TABLE [Portfolio Project].dbo.Nashville_Housing
DROP COLUMN OwnerAddress, PropertyAddress, SaleDate