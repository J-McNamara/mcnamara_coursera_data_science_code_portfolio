setwd("C:/Users/Josh/Desktop")
library(sqldf)
install.packages('sqldf')
install.packages('RSQLite')

acs <- read.csv('getdata_data_ss06pid.csv')

sq

con = url('http://biostat.jhsph.edu/~jleek/contact.html')
htmlCode = readLines(con)
close(con)
htmlCode
nchar(htmlCode[10])
nchar(htmlCode[20])
nchar(htmlCode[30])
nchar(htmlCode[100])
