
> library(readr)
data <- read.csv("6- infectious-and-parasitic-diseases-death-rate-who-mdb.csv")
> 
> head(data)
   Entity Code Year
1 Albania  ALB 1987
2 Albania  ALB 1988
3 Albania  ALB 1989
4 Albania  ALB 1992
5 Albania  ALB 1993
6 Albania  ALB 1994
  Age.standardized.deaths.that.are.from.infectious.and.parasitic.diseases.per.100.000.people..in.both.sexes.aged.all.ages
1                                                                                                                13.34700
2                                                                                                                11.11083
3                                                                                                                15.65497
4                                                                                                                 9.98638
5                                                                                                                13.13065
6                                                                                                                11.63521
> 
> 
> colnames(data)[4] <- "DeathRate"
> 
> head(data)
   Entity Code Year DeathRate
1 Albania  ALB 1987  13.34700
2 Albania  ALB 1988  11.11083
3 Albania  ALB 1989  15.65497
4 Albania  ALB 1992   9.98638
5 Albania  ALB 1993  13.13065
6 Albania  ALB 1994  11.63521


plot(data$Year, data$DeathRate,
+      main = "Scatter Plot of Death Rate vs Year",
+      xlab = "Year",
+      ylab = "Death Rate per 100,000",
+      pch = 19, col = "blue")
> 
> abline(lm(DeathRate ~ Year, data = data), col = "red", lwd = 2)
> 
> hist(data$DeathRate,
+      main="Histogram of Death Rates",
+      xlab="Death Rate per 100,000",
+      col="lightblue",
+      border="black")


cor.test(data$Year, data$DeathRate, method = "pearson")

	Pearson's product-moment correlation

data:  data$Year and data$DeathRate
t = -23.375, df = 4705, p-value < 2.2e-16
alternative hypothesis: true correlation is not equal to 0
95 percent confidence interval:
 -0.3479219 -0.2967243
sample estimates:
      cor 
-0.322559 



