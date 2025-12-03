#############################################
# 7COM1079 Final Project - Analysis Script
# Infectious & Parasitic Disease Mortality
#############################################

# Load required libraries
library(dplyr)
library(ggplot2)
library(tibble)

#--------------------------------------------
# 1. Load Dataset
#--------------------------------------------

df <- read.csv("6- infectious-and-parasitic-diseases-death-rate-who-mdb.csv")

# Rename long column for easier use
names(df)[names(df) == "Age.standardized.deaths.that.are.from.infectious.and.parasitic.diseases.per.100.000.people..in.both.sexes.aged.all.ages"] <- "DeathRate"


#--------------------------------------------
# 2. Add Income Groups (World Bank categories)
#--------------------------------------------

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


#--------------------------------------------
# 3. Create simplified income categories
#--------------------------------------------

df2 <- df %>%
  mutate(
    Income2 = case_when(
      IncomeGroup %in% c("Low income", "Lower-middle income") ~ "LowerIncome",
      IncomeGroup %in% c("Upper-middle income", "High income") ~ "HigherIncome",
      TRUE ~ NA_character_
    )
  ) %>%
  filter(!is.na(Income2))


#--------------------------------------------
# 4. Create yearly average trends
#--------------------------------------------

yearly_trends <- df2 %>%
  group_by(Year, Income2) %>%
  summarise(MeanDeathRate = mean(DeathRate, na.rm = TRUE))


#--------------------------------------------
# 5. Plot 1: Line chart of mortality trends
#--------------------------------------------

ggplot(yearly_trends, aes(x = Year, y = MeanDeathRate, colour = Income2)) +
  geom_line(linewidth = 1.2) +
  labs(
    title = "Trends in Infectious & Parasitic Disease Mortality by Income Group",
    x = "Year",
    y = "Average Death Rate per 100,000"
  ) +
  theme_minimal()


#--------------------------------------------
# 6. Plot 2: Scatterplot + regression line
#--------------------------------------------

ggplot(df2, aes(x = Year, y = DeathRate, colour = Income2)) +
  geom_point(alpha = 0.3) +
  geom_smooth(method = "lm", se = FALSE, linewidth = 1.2) +
  labs(
    title = "Infectious Disease Mortality with Regression Lines",
    x = "Year",
    y = "Death Rate per 100,000"
  ) +
  theme_minimal()


#--------------------------------------------
# 7. Regression Model (Hypothesis Test)
#--------------------------------------------

model <- lm(DeathRate ~ Year * Income2, data = df2)
summary(model)

#############################################
# END OF SCRIPT
#############################################

