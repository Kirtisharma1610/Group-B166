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
