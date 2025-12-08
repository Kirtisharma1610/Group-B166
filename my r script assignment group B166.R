
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

