############################################
# Section 2 – Data preparation and RQ setup
############################################

# Load dataset
df <- read.csv("6- infectious-and-parasitic-diseases-death-rate-who-mdb.csv")

# Create Period variable (Before 2000 vs After 2000)
df$Period <- ifelse(df$Year < 2000, "Before 2000", "After 2000")
df$Period <- factor(df$Period, levels = c("Before 2000", "After 2000"))

# Extract death_rate variable (DV)
df$death_rate <- df$Age.standardized.deaths.that.are.from.infectious.and.parasitic.diseases.per.100.000.people..in.both.sexes.aged.all.ages

# Create dataset for the research question
df_rq <- data.frame(
  Period = df$Period,
  death_rate = df$death_rate
)

