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