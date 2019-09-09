##########
# download.file(url = 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv', destfile = 'C:/Users/Josh/OneDrive - Johns Hopkins University/Coursera Data Science/quiz1-data.csv')
# df <- read.csv('C:/Users/Josh/OneDrive - Johns Hopkins University/Coursera Data Science/quiz1-data.csv')
# sum(df$VAL ==24, na.rm = NA)
##########

#########

file <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx'
destfile <- 'C:/Users/Josh/OneDrive - Johns Hopkins University/Coursera Data Science/qquiz1-data-2.xlsx'
download.file(url = file, destfile = destfile)
library('xlsx')
setwd('C:\Users\Josh/OneDrive - Johns Hopkins University\Coursera Data Science')
dat <- read.xlsx(file = 'P.xlsx', sheetName = 'NGAP Sample Data', colIndex = 7:15, startRow = 18, endRow = 23, sheetIndex = 1)
dat$Zip ]
sum(dat$Zip*dat$Ext,na.rm=T)

#########
# 
# file <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml'
# destfile <-'C:/Users/Josh/OneDrive - Johns Hopkins University/Coursera Data Science/getdata%2Fdata%2Frestaurants.xml'
# download.file(url = file, destfile = destfile)
# library('XML')
# doc <- xmlTreeParse(destfile, useInternal= TRUE)
# rootNode <- xmlRoot(doc)
# xmlName(rootNode)
# df <- xmlParse(file = destfile)
# print(df)
# df <- xmlToDataFrame(destfile)
# df
# print(df)
# 
# url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv'
# destfile <- 'C:/Users/Josh/OneDrive - Johns Hopkins University/Coursera Data Science/getdata%2Fdata%2Fss06pid.csv'
# download.file(url = url, destfile = destfile)
# library('data.table')
# DT <-fread(file = destfile)
# 
# system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))
# 
