-- Data Cleaning

SELECT * FROM layoffs;

-- 1. Remove Duplicates
-- 2. Standarize the data
-- 3. Null Values or Bank Values 
-- 4. Remove Any Columns or rows

CREATE TABLE layoff_staging
LIKE layoffs;

SELECT * FROM layoff_staging;

INSERT layoff_staging 
SELECT * FROM layoffs;

-- Remove duplicates

SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
AS row_num
 FROM layoff_staging;
 
 WITH duplicates_cte AS 
 (SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
AS row_num
 FROM layoff_staging
 )
 SELECT *
 FROM duplicates_cte
 WHERE row_num > 1;
 
 SELECT *
 FROM layoff_staging
 WHERE company = 'Casper';
 
 /* THIS WORKS IN SOME MYSQL TO DELETE DUPLICATES USING CTES
  WITH duplicates_cte AS 
 (SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
AS row_num
 FROM layoff_staging
 )
 DELETE
 FROM duplicates_cte
 WHERE row_num > 1;
 */
 
 CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
   row_num INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select *  
from layoff_staging2;

INSERT layoff_staging2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions)
AS row_num
 FROM layoff_staging;
 
 select *  
from layoff_staging2;

select *  
from layoff_staging2
where row_num > 1;

select *  
from layoff_staging2
where company = 'Casper';

delete
from layoff_staging2
where row_num > 1;

-- 2. Standarizing the Data

select  distinct company from layoff_staging2;

select company,trim(company)
from layoff_staging2;

UPDATE layoff_staging2
SET company = trim(company);

select DISTINCT industry 
FROM layoff_staging2
ORDER BY 1;

SELECT * 
FROM layoff_staging2
WHERE industry LIKE 'Crypto%';

UPDATE layoff_staging2
SET industry ='Crypto'
WHERE industry LIKE 'Crypto%';

select distinct country
 from layoff_staging2
order by 1 ;

select  distinct country,TRIM(TRAILING '.' FROM country)
FROM layoff_staging2
order by 1;

UPDATE layoff_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT `date`,str_to_date(`date`,'%m/%d/%y')
FROM layoff_staging2;
UPDATE layoff_staging2
SET `date` = str_to_date(`date`,'%m/%d/%Y');

select * from layoff_staging2;

ALTER  TABLE layoff_staging2
MODIFY COLUMN `date` DATE;

-- 3.NULL and Blank values

select * from layoff_staging2
WHERE total_laid_off is null and 
percentage_laid_off is null;

SELECT DISTINCT industry FROM 
layoff_staging2;

select *
FROM layoff_staging2
WHERE industry='' OR industry  is NULL;

select * from layoff_staging2
where company ='Airbnb';

update layoff_staging2
set industry = NULL where industry ='';

select t1.industry,t2.industry from
layoff_staging2 t1
inner join layoff_staging2 t2
on t1.company = t2.company
where (t1.industry is null or t1.industry ='')
and t2.industry is not null;

update layoff_staging2 t1 
join layoff_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where (t1.industry is null or t1.industry ='')
and t2.industry is not null;

select * from layoff_staging2
where company like 'Bally%';

-- Remove any columns

DELETE FROM layoff_staging2
WHERE total_laid_off is null and percentage_laid_off is null; 

select * from layoff_staging2;

ALTER TABLE layoff_staging2 
DROP COLUMN row_num;