# libraries
library(dplyr)
library(ggplot2)
library(tibble)


#  Load Dataset

df <- read.csv("6- infectious-and-parasitic-diseases-death-rate-who-mdb.csv")


names(df)[names(df) == "Age.standardized.deaths.that.are.from.infectious.and.parasitic.diseases.per.100.000.people..in.both.sexes.aged.all.ages"] <- "DeathRate"


#  Add Income Groups

income_data <- tribble(
  ~Code, ~IncomeGroup,
  "AFG", "Low income", 
  "ALB", "Upper-middle income",
  "DZA", "Upper-middle income",
  "AGO", "Lower-middle income",
  "ARG", "High income",
  "AUS", "High income",
  "AUT", "High income",
  "BGD", "Lower-middle income",
  "BEL", "High income",
  "BEN", "Low income",
  "BFA", "Low income",
  "BOL", "Lower-middle income",
  "BRA", "Upper-middle income",
  "CAN", "High income",
  "CHN", "Upper-middle income",
  "COL", "Upper-middle income",
  "COD", "Low income",
  "DEU", "High income",
  "DNK", "High income",
  "EGY", "Lower-middle income",
  "ETH", "Low income",
  "FRA", "High income",
  "GBR", "High income",
  "GHA", "Lower-middle income",
  "IND", "Lower-middle income",
  "KEN", "Lower-middle income",
  "LUX", "High income",
  "MAR", "Lower-middle income",
  "MEX", "Upper-middle income",
  "NGA", "Lower-middle income",
  "NPL", "Low income",
  "NOR", "High income",
  "PAK", "Lower-middle income",
  "RWA", "Low income",
  "SDN", "Low income",
  "SWE", "High income",
  "TZA", "Low income",
  "UGA", "Low income",
  "USA", "High income",
  "ZAF", "Upper-middle income",
  "ZMB", "Lower-middle income",
  "ZWE", "Lower-middle income"
)

# Merge into main dataset
df <- df %>%
  left_join(income_data, by = "Code")

# Some datasets cause duplicate income columns → fix
df <- df %>%
  mutate(
    IncomeGroup = coalesce(IncomeGroup, IncomeGroup.x, IncomeGroup.y, IncomeGroup.x.x, IncomeGroup.y.y)
  ) %>%
  select(Entity, Code, Year, DeathRate, IncomeGroup)
