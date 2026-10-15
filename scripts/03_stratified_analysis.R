# 03_stratified_analysis.R
# NYC vs Non-NYC CVD Mortality Trends (age-adjusted)

library(dplyr)
library(ggplot2)

# specify nyc counties

nyc_counties <- c(
  "Bronx County, NY",
  "Kings County, NY",
  "New York County, NY",
  "Queens County, NY",
  "Richmond County, NY"
)

# create region variable

ny_cvd_clean <- ny_cvd_clean |>
  mutate(
    region = ifelse(County %in% nyc_counties, "NYC", "Non-NYC")
  )

# yearly region summary (age-adjusted) 

year_region_summary <- ny_cvd_clean |>
  group_by(Year, region) |>
  summarise(
    age_adj_rate = mean(age_adjusted_rate, na.rm = TRUE),
    crude_rate = mean(crude_rate, na.rm = TRUE),
    .groups = "drop"
  )

# age-adjusted plot

p <- ggplot(year_region_summary,
            aes(x = Year, y = age_adj_rate, color = region)) +
  geom_line() +
  geom_point() +
  labs(
    title = "NYC vs Non-NYC Cardiovascular Mortality (Age-Adjusted), 2013–2020",
    x = "Year",
    y = "Age-Adjusted Death Rate per 100,000",
    color = "Region"
  )

p

ggsave("output/nyc_vs_nonnyc_age_adjusted_trend_2013_2020.png", plot = p)



# merging SES data

ny_merged <- ny_cvd_clean |>
  left_join(ny_ses, by = "County")
  
  
  
