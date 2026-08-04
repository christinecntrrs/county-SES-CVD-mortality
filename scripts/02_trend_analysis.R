# loading cleaned dataset created in script 01

library(dplyr)
library(ggplot2)

# create yearly summary (age-adjusted)

year_summary <- ny_cvd_clean |>
  group_by(Year) |>
  summarise(
    age_adjusted_rate = mean(age_adjusted_rate, na.rm = TRUE),
    crude_rate = mean(crude_rate, na.rm = TRUE),
    .groups = "drop"
  )


# build & save plot (age-adjsuted)

p <- ggplot(data = year_summary,
            aes(x = Year, y = age_adjusted_rate)) +
  geom_line() +
  geom_point() +
  labs(
    title = "New York Cardiovascular Mortality (Age-Adjusted), 2013–2020",
    x = "Year",
    y = "Age-Adjusted Death Rate per 100,000"
  )

p

ggsave("output/ny_cvd_age_adjusted_trend_2013_2020.png", plot = p)