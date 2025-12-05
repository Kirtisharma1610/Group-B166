# libraries
library(dplyr)
library(ggplot2)
library(tibble)


#  Load Dataset

df <- read.csv("6- infectious-and-parasitic-diseases-death-rate-who-mdb.csv")


names(df)[names(df) == "Age.standardized.deaths.that.are.from.infectious.and.parasitic.diseases.per.100.000.people..in.both.sexes.aged.all.ages"] <- "DeathRate"


