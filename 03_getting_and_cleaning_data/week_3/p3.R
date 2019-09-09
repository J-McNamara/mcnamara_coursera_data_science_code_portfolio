# # 
# 
# 
# # Set up
# setdir('/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3')
# # library()
# 
# # Load the files
# url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv'
# destfile <- '/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/gdp.csv'
# download.file(url = url, destfile = destfile)
# gdp <- read.csv(destfile)
# 
# url2 <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv'
# destfile2 <- '/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/ed_data.csv'
# download.file(url = url2, destfile = destfile2)
# edData <- read.csv(destfile2)

# Analysis
gdp <- read.csv(destfile)
gdp$X.3 <- as.numeric(as.numeric(gsub(",", "", gdp$X.3)))
gdp <- gdp[order(gdp$X.3, na.last = TRUE, decreasing = FALSE),]
gdp[13,][4]

gdp$X.2 <- as.character(gdp$X.2)
edData$Short.Name <- as.character(edData$Short.Name)
a<- match(gdp$X.2, edData$Short.Name)

counter <-0

for (i in a) {
  if (!(is.na(i)) ) {
    counter <<- counter + 1
    print(i)
  }
}
counter


tapply()


fil <- '/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/p3a.csv'


gdp <- read.csv(fil)
gdp$US.dollars. <- as.numeric(gsub(",", "", gdp$US.dollars.))
gdp$US.dollars. > 49717634
a <- merge(x = gdp, y = edData, by = "Short.Name", all = TRUE )



