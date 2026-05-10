# 🌍 World Layoffs SQL Analysis

## 📌 Project Overview

##### This project focuses on Data Cleaning and Exploratory Data Analysis (EDA) on a global layoffs dataset using SQL.
##### The main objective of this project is to clean raw layoff data, analyze trends, and uncover meaningful business insights related to layoffs across different companies, industries, countries, and years.

##### This project demonstrates practical SQL skills commonly used in real-world data analytics workflows.

## 🎯 Objectives
- 🧹 Clean and preprocess raw data
- 🔍 Perform exploratory data analysis using SQL
- 📊 Identify layoff trends and patterns
- 🌎 Analyze layoffs across industries and countries
- 📈 Generate business insights from the dataset

## 🗂️ Dataset Information

##### The dataset contains layoff records from companies around the world.

### 📋 Columns Included
- Company
- Location
- Industry
- Total Laid Off
- Percentage Laid Off
- Date
- Stage
- Country
- Funds Raised (Millions)

## 🛠️ Tools & Technologies Used
- 💻 SQL
- 🗄️ MySQL Workbench
- 📓 Jupyter Notebook
- 🧑‍💻 VS Code
- 🌐 GitHub

## 🧹 Data Cleaning Process

##### The following data cleaning steps were performed:

### ✅ 1. Removing Duplicates
- Identified duplicate records using ROW_NUMBER()
- Removed duplicate rows while preserving original data
### ✅ 2. Standardizing Data
- Trimmed unnecessary spaces
- Standardized industry names
- Cleaned country names
- Converted date columns into proper DATE format
### ✅ 3. Handling Null & Blank Values
- Replaced blank values with NULL values
- Populated missing industry values using self joins
- Removed records with insufficient data
### ✅ 4. Final Data Preparation
- Removed temporary helper columns
- Prepared cleaned dataset for analysis

## 📊 Exploratory Data Analysis (EDA)

##### The project includes multiple SQL analyses such as:

### 📌 Overall Layoff Analysis
- Maximum layoffs
- Companies with 100% layoffs
- Most funded companies affected by layoffs
### 🏢 Company-Wise Analysis
- Companies with highest layoffs
- Average layoff percentage by company
### 🏭 Industry-Wise Analysis
- Industries most affected by layoffs
### 🌍 Country-Wise Analysis
- Countries with highest layoffs
### 📅 Yearly & Monthly Trend Analysis
- Year-wise layoffs
- Monthly layoff trends
- Rolling total layoffs over time
### 🏆 Ranking Analysis
- Top companies with highest layoffs each year using DENSE_RANK()

## 🧠 SQL Concepts Used
- SELECT Statements
- GROUP BY & ORDER BY
- Aggregate Functions
- Window Functions
- ROW_NUMBER()
- DENSE_RANK()
- Common Table Expressions (CTEs)
- Joins
- Date Functions
- Data Cleaning Techniques

## 🔍 Key Insights
- 📉 The technology industry experienced significant layoffs.
- US The United States recorded the highest number of layoffs.
- 🚨 Several companies laid off 100% of their workforce.
- 📈 Layoffs increased significantly during certain years.
- 💰 Highly funded startups were also affected by layoffs.

## 📁 Project Structure
<pre>
world-layoffs-sql-analysis/
│
├── data_cleaning.sql
├── exploratory_data_analysis.sql
├── layoffs.csv
└── README.md </pre>

## 🚀 How to Run the Project
- Download the dataset
- Import the CSV file into MySQL
- Open MySQL Workbench
- Run data_cleaning.sql
- Run exploratory_data_analysis.sql
- Explore the generated insights

## 🔮 Future Improvements
- 📊 Build an interactive Power BI dashboard
- 📈 Add advanced KPI analysis
- 🐍 Perform visualization using Python
- ⚡ Automate data cleaning workflows

## 👩‍💻 Author

#### Vidhi Pathak

If you found this project useful, feel free to ⭐ the repository.