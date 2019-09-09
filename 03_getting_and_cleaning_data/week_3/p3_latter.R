setwd(dir = 'C:/Users/Josh/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/')
# Load the files
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
destfile <- 'C:/Users/Josh/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/gdp.csv'
#download.file(url = url, destfile = destfile)
gdp <- read.csv(destfile)
# 
# url2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
destfile2 <- 'C:/Users/Josh/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/ed_data.csv'
# download.file(url = url2, destfile = destfile2)
edData <- read.csv(destfile2)

# Analysis
gdp <- read.csv(destfile)
gdp$X.3 <- as.numeric(as.numeric(gsub(",", "", gdp$X.3)))
gdp <- gdp[order(gdp$X.3, na.last = TRUE, decreasing = FALSE),]


gdp$X.2 <- as.character(gdp$X.2)
colnames(gdp)[4] <- 'Short.Name'
edData$Short.Name <- as.character(edData$Short.Name)
#fil <- '/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/p3a.csv'


merged <- merge(x = gdp, y = edData, by = "Short.Name", all = TRUE )
highClub <- merged[merged$Income.Group == 'High income: OECD',]
highNoClub <- merged[merged$Income.Group == 'High income: nonOECD',]

mean(highClub$X.3, na.rm = TRUE)
mean(highNoClub$X.3, na.rm = TRUE)
merged <- merged[order(merged$X.3, na.last = TRUE, decreasing = FALSE),]

merged$Gross.domestic.product.2012 <- as.numeric(merged$Gross.domestic.product.2012)
mean(merged[merged$Income.Group == 'High income: OECD',]$Gross.domestic.product.2012, na.rm = TRUE)

#Question 5
tops <- merged[merged$Gross.domestic.product.2012 < 41  & merged$Gross.domestic.product.2012 > 2 ,]$Short.Name
tops %in% merged[merged$Income.Group == 'Lower middle income',]

                 