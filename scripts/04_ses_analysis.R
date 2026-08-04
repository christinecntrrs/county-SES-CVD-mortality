# ses dataset

library(readr)
library(dplyr)
library(ggplot2)

# load ses data 

ny_ses <- read_csv("data_raw/ny_county_ses.csv") |>
  rename(County = COUNTY) |>
  select(County, median_income, pct_poverty, pct_bachelors) |>
  mutate(
    County = paste0(County, ", NY")
  )

# load age-adjusted mortality data

ny_cvd_raw <- read_csv("data_raw/ny_cvd_mortality_2013_2020_age_adjusted.csv")

ny_cvd_clean <- ny_cvd_raw |>
  filter(!is.na(Year)) |>
  mutate(
    crude_rate = as.numeric(`Crude Rate`),
    age_adjusted_rate = as.numeric(`Age Adjusted Rate`)
  )

# data merge

ny_merged <- ny_cvd_clean |>
  left_join(ny_ses, by = "County")

# check merge 

sum(is.na(ny_merged$median_income))


# form ses, poverty-based tertiles

ny_merged <- ny_merged |>
  mutate(
    poverty_tertile = ntile(pct_poverty, 3)
  )

# ses inequality summary (age-adjusted) 

tertile_summary <- ny_merged |>
  group_by(Year, poverty_tertile) |>
  summarise(
    age_adj_rate = mean(age_adjusted_rate, na.rm = TRUE),
    crude_rate = mean(crude_rate, na.rm = TRUE),
    .groups = "drop"
  )

# ses ineqality plot (age-adjusted) ----------------------------

p <- ggplot(tertile_summary,
            aes(x = Year,
                y = age_adj_rate,
                color = factor(poverty_tertile))) +
  geom_line() +
  geom_point() +
  labs(
    title = "NY Cardiovascular Mortality by County Poverty Level (Age-Adjusted), 2013–2020",
    x = "Year",
    y = "Age-Adjusted Death Rate per 100,000",
    color = "Poverty Tertile"
  )

p

ggsave("output/ny_cvd_age_adjusted_tertile_trend.png", plot = p)


# Linear regression analysis -----------------------------------

# simple linear regression:
# poverty vs age-adjusted CVD mortality

model1 <- lm(
  age_adjusted_rate ~ pct_poverty,
  data = ny_merged
)

summary(model1)


# Multivariable SES regression --------------------------------

model2 <- lm(
  age_adjusted_rate ~ pct_poverty +
    median_income +
    pct_bachelors,
  data = ny_merged
)

summary(model2)


# Correlation among SES indicators -----------------------------------

ses_vars <- ny_merged |>
  select(
    pct_poverty,
    median_income,
    pct_bachelors
  )

cor(ses_vars,
    use = "complete.obs")


# SES model comparisons ------------------------------------

model_income <- lm(
  age_adjusted_rate ~ median_income,
  data = ny_merged
)

summary(model_income)


model_education <- lm(
  age_adjusted_rate ~ pct_bachelors,
  data = ny_merged
)

summary(model_education)


model_pe <- lm(
  age_adjusted_rate ~ pct_poverty +
    pct_bachelors,
  data = ny_merged
)

summary(model_pe)
