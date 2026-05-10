/* =================================================
   WORLD LAYOFFS - EXPLORATORY DATA ANALYSIS
   ================================================= */
 
SELECT * 
FROM layoff_staging2;
-- Previewing the cleaned dataset

/* =========================
 1. MAXIMUM LAYOFF ANALYSIS
   ========================= */
SELECT MAX(total_laid_off),MAX(percentage_laid_off)
FROM layoff_staging2;
-- Finding the highest number of layoffs and maximum layoff percentage

/* =========================
 2. Companies with 100% Layoffs
   ========================= */
SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1;
-- Identifying companies that laid off 100% of employees

/* =========================
 3. 100% Layoffs Ordered by Total Employees
   ========================= */
SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;
-- Sorting companies by highest number of employees laid off

/* =========================
 4. Funding vs Layoffs
   ========================= */
SELECT *
FROM layoff_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;
-- Analyzing companies with high funding that still faced complete layoffs

/* =========================
  5. COMPANY-WISE ANALYSIS
   ========================= */
SELECT company,SUM(total_laid_off) AS total_off
FROM layoff_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;
-- Calculating total layoffs by company

/* =========================
  6. Date Range Analysis
   ========================= */
SELECT MIN(`date`),MAX(`date`)
FROM layoff_staging2;
-- Finding the overall date range of the dataset

/* =========================
  7. INDUSTRY-WISE ANALYSIS
   ========================= */
SELECT industry,SUM(total_laid_off) AS total_off
FROM layoff_staging2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC;
-- Identifying industries with the highest layoffs

SELECT * 
FROM layoff_staging2;

/* =========================
  8. COUNTRY-WISE ANALYSIS
   ========================= */
SELECT country,SUM(total_laid_off) AS total_off
FROM layoff_staging2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC;
-- Calculating layoffs across different countries

/* =========================
  9. YEARLY TREND ANALYSIS
   ========================= */
SELECT YEAR(`date`),SUM(total_laid_off) AS total_off
FROM layoff_staging2
GROUP BY YEAR(`date`)
ORDER BY SUM(total_laid_off) DESC;
-- Analyzing layoffs trend year by year

/* =========================
 10. COMPANY STAGE ANALYSIS
   ========================= */
SELECT stage,SUM(total_laid_off) AS total_off
FROM layoff_staging2
GROUP BY stage
ORDER BY SUM(total_laid_off) DESC;
-- Evaluating layoffs based on company funding stage

/* =========================
 11. Average Layoff Percentage
   ========================= */
SELECT company,AVG(percentage_laid_off) AS total_off
FROM layoff_staging2
GROUP BY company
ORDER BY 2 DESC;
-- Calculating average layoff percentage for each company

/* =========================
  12. MONTHLY TREND ANALYSIS
   ========================= */
SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off) AS total_off
FROM layoff_staging2 
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`,1,7)
ORDER BY 1 ASC;
-- Calculating monthly layoffs trend

/* =========================
  13. Rolling Total Analysis
   ========================= */
WITH Rolling_total AS
(SELECT SUBSTRING(`date`,1,7) AS `MONTH`,SUM(total_laid_off) AS total_off
FROM layoff_staging2 
WHERE SUBSTRING(`date`,1,7) IS NOT NULL
GROUP BY SUBSTRING(`date`,1,7)
ORDER BY 1 ASC)
SELECT `MONTH`,total_off,SUM(total_off) OVER(ORDER BY `MONTH`) AS rolling_total
FROM Rolling_total; 
-- Calculating cumulative layoffs over time using rolling totals

SELECT company,SUM(total_laid_off) AS total_off
FROM layoff_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC;

/* =========================
  14. COMPANY YEARLY ANALYSIS
   ========================= */
SELECT company,YEAR(`date`)AS `YEAR`,SUM(total_laid_off) AS total_off
FROM layoff_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC ;
-- Calculating yearly layoffs for each company

/* =========================
  15. Ranking Companies by Layoffs
   ========================= */
WITH Company_year (company,years,total_laid_off) AS
(SELECT company,YEAR(`date`) ,SUM(total_laid_off) 
FROM layoff_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC )
SELECT *,DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_year 
where years IS NOT NULL
ORDER BY Ranking;
-- Ranking companies based on yearly layoffs using DENSE_RANK()

/* =========================
  16. TOP COMPANIES BY YEAR
   ========================= */
WITH Company_year (company,years,total_laid_off) AS
(SELECT company,YEAR(`date`) ,SUM(total_laid_off) 
FROM layoff_staging2
GROUP BY company,YEAR(`date`)
ORDER BY 3 DESC ),
Company_Year_Rank as(
SELECT *,DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS Ranking
FROM Company_year 
where years IS NOT NULL)
select *
from Company_Year_Rank
WHERE Ranking <= 5;
-- Identifying top 5 companies with highest layoffs each year