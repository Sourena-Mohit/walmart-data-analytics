# Hello R!
This is my first R based analytics . It is a simple R introduction in EDA .

# Walmart Sales Analysis

## Overview
This project analyzes Walmart sales data using R, including data preprocessing, summary statistics, missing value handling, and visualizations.

## Requirements
- R (version 4.0 or higher)
- Required Packages:
  ```r
  install.packages("readr")
  install.packages("zoo")
  install.packages("dplyr")
  ```
- Dataset: `data/lab_data.csv`

## Usage
1. Clone the repository:
   ```bash
   git clone https://github.com/Sourena-Mohit/walmart-data-analytics.git
   cd walmart-sales-analysis
   ```
2. Run the script in R:
   ```r
   source("walmart_analysis.R")
   ```

## Features
- Converts `Date` column to proper format
- Handles missing values using interpolation
- Computes summary statistics of sales
- Visualizes average weekly sales per store
- Plots sales trends for top stores

## License
This project is licensed under the MIT License.


