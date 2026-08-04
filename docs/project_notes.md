# Project Notes – NYS County-Level SES and CVD Mortality

## 2/23/26 – Project Design

### Working Title
County-Level Socioeconomic Disadvantage and Cardiovascular Mortality in New York State

### Research Question
Is county-level socioeconomic disadvantage associated with cardiovascular mortality rates in New York State?

### Outcome
Cardiovascular disease (CVD) mortality

### Geographic Unit
New York State counties

### Time Period (Initial Plan)
2013–2022

### Draft SES Indicators
- % below poverty
- % unemployed
- % with bachelor’s degree or higher
- Median household income
- % uninsured

---

## 2/24/26 – Data Availability Update

County-level underlying cause of death data from CDC WONDER are available in final form through 2020 
Therefore, the primary analysis period will be **2013–2020**.  

Provisional mortality data for later years may be explored separately as sensitivity analysis

---

## 4/25/26 – Project Resumed

After a pause in analysis, the dataset was reconstructed and cleaned in R

### Completed Tasks
- Imported CDC WONDER county-level mortality data
- Cleaned dataset (removed missing year values)
- Converted crude rate variable to numeric
- Created yearly statewide summary (2013–2020)
- Generated preliminary trend visualization

### Preliminary Findings
Statewide aggregated CVD mortality rates were relatively stable from 2013–2019 (~218–228 per 100,000), followed by a marked increase in 2020 (251 per 100,000)

This suggests a possible structural change in cardiovascular mortality patterns coinciding with the COVID-19 pandemic period

### Prelim Interpretation
The observed 2020 increase may reflect:
- Direct cardiovascular effects of COVID-19 infection
- Indirect effects from disruptions in healthcare
- Delayed care and system-level strain during the pandemic

---

## 4/26/26

### Work Completed
- Built analysis scripts for data cleaning and trend analysis
- Generated and saved statewide CVD mortality trend plot

### Key Output
- Figure: NYS CVD mortality trend (2013–2020)

### Next Steps
1. Stratify mortality trends by NYC vs non-NYC counties  
2. Merge county-level socioeconomic indicators  
3. Assess socioeconomic gradient in CVD mortality  
4. Explore heterogeneity in 2020 mortality increase

---

## 4/27/26 – Inequality Analysis NYC vs Non-NYC

### Objective
To assess whether cardiovascular disease (CVD) mortality trends differ between New York City (NYC) counties and non-NYC counties from 2013–2020

### Rationale
State-level trends may mask important geographic heterogeneity. NYC differs from the rest of New York State in:
- population density
- socioeconomic composition
- healthcare access and system strain
- baseline cardiovascular risk profiles

Stratifying by NYC vs non-NYC provides a first-level assessment of geographic health inequality within the state

### Exposure (Stratification Variable)
- NYC counties vs non-NYC counties  
(defined using county-level geographic classification)

### Outcome
- County-level cardiovascular mortality rate (crude rate per 100,000)

### Planned Analysis
1. Create NYC indicator variable at county level  
2. Compare yearly mortality trends between NYC and non-NYC counties  
3. Visualize stratified time trends using line plots  
4. Assess whether 2020 mortality increase differs by geography

### Hypothesis 
NYC counties may show a larger increase in 2020 CVD mortality compared to non-NYC counties due to:
- higher COVID-19 burden in early pandemic period
- greater healthcare system strain
- higher baseline population density and comorbidity burden


##Preliminary Findings
The 2020 increase in CVD mortality appears more pronounced in NYC counties compared to non-NYC counties, while non-NYC counties remain relatively stable

### Methodology Considerations

The NYC vs non-NYC stratification gives a useful first-level geographic comparison but masks substantial heterogeneity within the non-NYC category. Non-NYC counties vary widely in urbanicity, socioeconomic status, population density, and healthcare access

Future analyses will incorporate county-level socioeconomic indicators to better capture within-region variation and reduce ecological oversimplification


------- 

## 5/18/26 - SES Data 

Downloaded county-level socioeconomic indicators from the American Community Survey (ACS) 5-year estimates centered around 2019 and created a county SES dataset for all New York State counties

Because county-level ACS measures were treated as relatively stable, SES variables were applied uniformly across all county-year mortality observations (2013–2020)


Selected SES indicators:

- Median household income
- Percent below poverty
- Percent with bachelor’s degree or higher (age 25+)

Cleaned raw data into one CSV file with SES indicators organized by county 

-------

## 5/22/26 - SES and Mortality Merge

Merged SES indicators into the county-level CVD mortality dataset using county name

Initial merge failed because county identifiers were not formatted identically across datasets

Mortality dataset counties were formatted as:

- "Albany County, NY"

SES dataset counties were formatted as:

- "Albany County"

This caused SES variables to return as NA after left_join().

Resolved by standardizing county identifiers in R using:

- rename()
- paste0()
- string inspection tools (setdiff(), nchar())

Final merge validation:

- sum(is.na(median_income)) = 0

This confirmed successful merge

### Conceptual Notes

Learned that:

- joins require exact identifier matches
- visually similar strings can still fail merges
- hidden formatting 
- cleaning inside R is more reliable than manual editing in Excel


### Current Dataset Structure

Merged dataset now contains:

- County
- Year
- Deaths
- Population
- Crude CVD mortality rate
- Median income
- Poverty percentage
- Bachelor’s degree percentage


Planned Next Analyses
1. Create SES teritles
2. Compare mortality trends across SES groups
3. Evaluate whether higher-poverty counties experienced higher CVD mortality burden
4. Explore whether 2020 mortality increase differed by SES level

------

## 5/24/26 - Inequality plots

### SES Poverty Level CVD Mortality (age-adjusted)

A fairly stepwise socioeconomic (SE) pattern in CVD mortality is observed across NY counties from 2013–2020 after age adjustment. In most years, counties in the highest-poverty tertile (3) experience the highest age-adjusted CVD mortality rates, while counties in the lowest-poverty tertile (1) consistently experience the lowest rates. Middle-poverty counties (tertile 2) generally remain intermediate, showing a relatively ordered SES gradient across the study period, although in 2019–2020 tertile 2 exceeds the tertile 3 in mortality rates

Across all tertiles, age-adjusted mortality generally declines from 2013 through 2019, suggesting overall improvement in CVD mortality statewide over time. However, SE disparities persist throughout the study period. In 2020, mortality rates increase across all tertiles, consistent with broader mortality disruptions during the first year of the COVID-19 pandemic, while overall SES differences remain evident

### SES Inequality Gap

The figure shows the difference in age-adjusted cardiovascular mortality rates between the highest-poverty (tertile 3) and lowest-poverty (tertile 1) counties in NYS from 2013 to 2020

socioeconomic inequality presistent but fluctuating in cardiovascular mortality across study period

gap is consistently positive throughout all years, meaning that counties with higher poverty levels experience higher age-adjusted CVD mortality than lower-poverty counties
  -magnitude of this disparity is not stable over time

The inequality gap plot:

- peaks around 2016 (largest observed disparity)
- declines sharply in 2017 
- increases again in 2018
- fluctuates moderately from 2019–2020, with a moderate rise in 2020

2020 value does not represent the maximum inequality in the series


These patterns suggest that:

- There is a consistent positive SES gradient in CVD mortality from 2013–2020, with higher-poverty counties experiencing higher age-adjusted death rates
- Magnitude of inequality varies year-to-year, indicating that broader contextual factors (health system changes, demographic shifts, or period-specific shocks) may temporarily worsen or reduce disparities
- The inequality gap did not consistently widen in 2020, suggesting the pandemic raised mortality broadly rather than disproportionately increasing SES differences


------------

## 5/25/2026

### NYC vs NON NYC Age-Adjusted Mortality by SES + Spatially

Further SES stratification within NYC produced sparse subgroups due to the small number of NYC counties and uneven distribution across statewide poverty tertiles. As a result, interpretation of within-NYC SES subgroup trends was considered unstable

### Regression Analysis - poverty vs age-adjusted CVD mortality

#### RESULTS: 

Call:
lm(formula = age_adjusted_rate ~ pct_poverty, data = ny_merged)

Residuals:
    Min      1Q  Median      3Q     Max 
-80.452 -18.513  -0.963  16.042 119.542 

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 152.5730     4.7215  32.315  < 2e-16 ***
pct_poverty   1.8507     0.3387   5.465 7.41e-08 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 28.51 on 488 degrees of freedom
  (6 observations deleted due to missingness)
Multiple R-squared:  0.05766,	Adjusted R-squared:  0.05573 
F-statistic: 29.86 on 1 and 488 DF,  p-value: 7.413e-08

#### INTERPRETATION:

pct_poverty coefficient = 1.85
p = 7.41e-08
R² = 0.058

- Each 1 percent increase in county poverty is associated with approximately 1.85 additional age-adjusted cardiovascular deaths per 100,000 population
- The positive association between poverty and CVD mortality is unlikely to be due to random variation alone
- + coefficient means higher poverty, higher age-adjusted mortality
- poverty alone explains about 5.8% of variation in county-level age-adjusted CVD mortality

Linear regression demonstrated a + association between county poverty and age-adjusted CVD mortality in NYS. Each 1 percent increase in county poverty was associated with approximately 1.85 additional CVD deaths per 100,000 population. The association is statistically significant (p < 0.001), supporting the presence of a SE gradient in CVD mortality after age adjustment. Poverty alone explained a modest proportion of mortality variation (R² ≈ 0.06), suggesting that additional factors (demographic, behavioral, structural, etc) also contribute to county-level differences in CVD mortality


### Multivariable SES regression

### associations between county-level socioeconomic indicators and age-adjusted cardiovascular mortality

#### RESULTS: 

 Call:
lm(formula = age_adjusted_rate ~ pct_poverty + median_income + 
    pct_bachelors, data = ny_merged)

Residuals:
    Min      1Q  Median      3Q     Max 
-76.587 -16.429  -0.633  15.522 110.497 

Coefficients:
                Estimate Std. Error t value Pr(>|t|)    
(Intercept)    1.308e+02  1.167e+01  11.211  < 2e-16 ***
pct_poverty    3.057e+00  4.419e-01   6.918 1.45e-11 ***
median_income  9.884e-04  1.542e-04   6.411 3.43e-10 ***
pct_bachelors -1.971e+00  1.926e-01 -10.233  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 25.85 on 486 degrees of freedom
  (6 observations deleted due to missingness)
Multiple R-squared:  0.2285,	Adjusted R-squared:  0.2237 
F-statistic: 47.97 on 3 and 486 DF,  p-value: < 2.2e-16

#### INTERPRETATION:

R² = 0.229

the three SES variables (poverty, median income, bachelors) together explain about 23% of county-level variation in age-adjusted CVD mortality

##### Poverty

Estimate = +3.06
p < 0.001

- After accounting for county income and educational attainment, each 1 percent increase in poverty was associated with approximately 3 additional age-adjusted CVD deaths per 100,000 population
- highly statistically significant
- strong independent association

##### Education

Estimate = -1.97
p < 0.001

- Each 1 percent increase in bachelor’s degree attainment was associated with roughly 2 fewer CVD deaths per 100,000 population
- highly statistically significant 
- strong protective association 

##### Median Income 

Estimate = 0.000988

- sign of multicollinearity?
- poverty, education, and income highly related to one another 


------------

## 6/20/2026 - Correlation among SES variables

### Results:
              pct_poverty median_income pct_bachelors
pct_poverty     1.0000000    -0.6575665    -0.2672744
median_income  -0.6575665     1.0000000     0.7151752
pct_bachelors  -0.2672744     0.7151752     1.0000000

#### Correlation among SES indicators: 

  -County poverty was moderately inversely correlated with median household income (r = -0.66), while median income and bachelor's degree attainment were strongly positively correlated (r = 0.72). 
  -Poverty and educational attainment exhibited a weaker inverse relationship (r = -0.27). 
  -The correlations suggest overlap among SES measures and may explain the + coefficient for income in the fully adjusted regression model.

### SES model comparisons:

Model                        | R²   
Poverty only                 | 0.058 
Income only                  | 0.044 
Education only               | 0.144 
Poverty + Income             | 0.062
Poverty + Education          | 0.163 
Income + Education           | 0.153
Poverty + Education + Income | 0.229  Best-fitting mode****               

-compared to income, education is the dominant predictor
