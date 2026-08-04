# 01_data_download.R
# Project: NY County-Level CVD Mortality
# Data Source: CDC WONDER (Underlying Cause of Death)
# Years: 2013–2020
# State: New York
# Cause: Diseases of heart (ICD-10 codes I00–I09, I11, I13, I20–I51)
# Date Downloaded: 2/24/26

# Load packages
library(readr)
library(dplyr)

# Import raw data (age-adjusted version)


ny_cvd_raw <- read_csv("data_raw/ny_cvd_mortality_2013_2020_age_adjusted.csv")


# Clean 

ny_cvd_clean <- ny_cvd_raw |>
  filter(!is.na(Year)) |>
  mutate(
    crude_rate = as.numeric(`Crude Rate`),
    age_adjusted_rate = as.numeric(`Age Adjusted Rate`)
  )

