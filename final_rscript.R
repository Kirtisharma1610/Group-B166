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

############################################
# Section 3 – Descriptive statistics and RQ check
############################################

# Number of observations in each group
table(df_rq$Period)

# Summary of death_rate overall
summary(df_rq$death_rate)

# Summary of death_rate by period
summary(df_rq$death_rate[df_rq$Period == "Before 2000"])
summary(df_rq$death_rate[df_rq$Period == "After 2000"])

# Mean death rate in each period
mean_before <- mean(df_rq$death_rate[df_rq$Period == "Before 2000"], na.rm = TRUE)
mean_after  <- mean(df_rq$death_rate[df_rq$Period == "After 2000"],  na.rm = TRUE)

mean_before
mean_after

# Median death rates (useful with Wilcoxon)
median_before <- median(df_rq$death_rate[df_rq$Period == "Before 2000"], na.rm = TRUE)
median_after  <- median(df_rq$death_rate[df_rq$Period == "After 2000"],  na.rm = TRUE)

median_before
median_after
median_before - median_after    # difference in medians

# Interquartile range (IQR) for each period
IQR(df_rq$death_rate[df_rq$Period == "Before 2000"], na.rm = TRUE)
IQR(df_rq$death_rate[df_rq$Period == "After 2000"],  na.rm = TRUE)

# Basic structure and context
str(df_rq)
sum(is.na(df_rq$death_rate))
range(df$Year, na.rm = TRUE)
length(unique(df$Entity))

############################################
# Section 3.1 – Visualisation (boxplot and histogram)
############################################

# Boxplot: main plot for the RQ
png("boxplot_deathrate_period.png", width = 900, height = 600)
boxplot(death_rate ~ Period,
        data = df_rq,
        main = "Death Rate Before and After 2000",
        xlab = "Time period",
        ylab = "Death rate per 100,000 people",
        col = c("lightblue", "lightgreen"))
dev.off()
cat("Figure 1 saved as boxplot_deathrate_period.png\n")

# Histogram: distribution of death_rate WITH normal curve overlay
png("histogram_deathrate.png", width = 900, height = 600)

hist(df_rq$death_rate,
     main = "Distribution of Death Rates (with Normal Curve Overlay)",
     xlab = "Death rate per 100,000 people",
     ylab = "Frequency",
     col = "lightgray",
     breaks = 30,
     freq = FALSE)   # needed so curve scales properly

# Add normal curve overlay
curve(dnorm(x,
            mean = mean(df_rq$death_rate, na.rm = TRUE),
            sd   = sd(df_rq$death_rate, na.rm = TRUE)),
      col = "blue",
      lwd = 2,
      add = TRUE)

dev.off()
cat("Figure 2 saved as histogram_deathrate.png\n")

# Contingency table for the two periods
table(df_rq$Period)

# Or as a nicer data frame format
cont_table <- as.data.frame(table(df_rq$Period))
names(cont_table) <- c("Period", "Count")
cont_table

############################################
# Section 4 – Analysis (normality and Wilcoxon test)
############################################

# Split data into two groups
before_2000 <- df_rq$death_rate[df_rq$Period == "Before 2000"]
after_2000  <- df_rq$death_rate[df_rq$Period == "After 2000"]

# Shapiro-Wilk normality tests
shapiro.test(before_2000)
shapiro.test(after_2000)

# Wilcoxon Rank Sum test for difference between periods
wilcox.test(death_rate ~ Period, data = df_rq)

