# Health Intervention Study Analysis

This repository contains R code and data for analyzing the effects of a health intervention on participant scores. The analysis includes statistical tests, visualizations, and comprehensive reporting of results.
**Important Note:** The dataset (`data.csv`) is a simulated dataset generated using random number generation for educational and demonstration purposes. It does not contain real participant data.



## Table of Contents

- Setup
- Data Loading
- T-test Analysis
- Data Visualization
- Regression Analysis
- Diagnostic Plots
- Descriptive Statistics
- Creating Summary Tables


## Dataset Overview


The simulated dataset contains information from 92 hypothetical participants in a health intervention study:

- **Participants:** 92 individuals (mixed gender and age groups)
- **Variables:** age, sex, weight, score, and intervention status
- **Groups:** Control (`intervention=0`) and Intervention (`intervention=1`)

## Data Structure

**Note:** While this is simulated data, the structure and relationships between variables are designed to mimic realistic patterns found in health intervention studies.

### Variables in `data.csv`:
- `age`: Participant age (years)
- `sex`: Gender (male/female)
- `weight`: Body weight (kg)
- `score`: Performance score 
- `intervention`: Group assignment (0=Intervention, 1=Control)

## Analysis Features

### Basic Statistical Tests
- Independent t-test comparing intervention groups
- Descriptive statistics by group

### Data Visualization
- Boxplots comparing score distributions
- Diagnostic plots for regression analysis

### Advanced Analytics
- Independent samples t-test
- Multiple regression analysis (`score ~ weight + age`)
- Comprehensive summary tables using `gtsummary`

## Getting Started

### Prerequisites
- R (version 4.0.0 or higher)
- RStudio (recommended)

### Required R Packages
```r
install.packages(c(
    "gtsummary",
    "tidyverse",
    "stargazer",
    "modelsummary"
))
