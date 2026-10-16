# County-Level Socioeconomic Disadvantage and Cardiovascular Mortality in New York State

## About the project

This project grew out of an interest I developed during my MPH thesis, which explored how residents in Limassol, Cyprus, perceived their neighborhood environments and how those perceptions differed by neighborhood social position. That work broadened my thoughts about how the places people live shape their experiences and opportunities for health.

Thus, I explore a related question using county-level data from New York State: how are socioeconomic conditions across communities associated with cardiovascular disease (CVD) mortality? Using data from 2013 to 2020, I examine differences in age-adjusted CVD mortality across counties and look at how those patterns relate to poverty, household income, and educational attainment.

Albeit the two projects use different approaches and measure different aspects of place, both reflect my interest in understanding how social and environmental conditions may contribute to differences in health across communities.

## Data and approach

I combined county-level mortality data from CDC WONDER with socioeconomic estimates from the U.S. Census Bureau's American Community Survey. The analysis, which was conducted in R, includes data cleaning, exploratory analysis, mortality trends, comparisons across socioeconomic groups, and regression models examining associations between socioeconomic indicators and CVD mortality.

I also compare New York City with counties outside the city to explore whether mortality patterns differ across these geographic areas.

## What I am exploring

Rather than looking at New York State as a single population, I am interested in how health outcomes vary across the communities within it. Poverty, income, and educational attainment capture different aspects of socioeconomic conditions, and examining them together offers a way to explore how these factors relate to geographic differences in CVD mortality.

## Limitations

This is an ecological analysis, so the findings describe associations at the county level and cannot be used to draw conclusions about individuals. The socioeconomic indicators are correlated with one another, and the ACS estimates (2015–2019) cover a different period than the annual mortality data (2013–2020). Other county-level factors not included in the analysis may also influence cardiovascular mortality. The analysis is exploratory and cannot establish that socioeconomic disadvantage causes higher cardiovascular mortality.

## Repository contents

* `data_raw/` contains the source datasets.
* `docs/` contains project notes and documentation.
* `output/` contains figures generated during the analysis.
* `scripts/` contains the R scripts used for data preparation and analysis.

This is an independent project through which I am continuing to develop my skills in epidemiological analysis, data management, and visualization while exploring questions about place and health.
