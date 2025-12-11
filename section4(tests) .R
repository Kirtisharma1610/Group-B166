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