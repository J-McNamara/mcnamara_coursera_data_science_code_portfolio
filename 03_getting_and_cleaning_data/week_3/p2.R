# Set up
setdir('/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3')
library(jpeg)

# Load the files
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg'
destfile <- '/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/pic.jpg'
download.file(url = url, destfile = destfile)
pic <- readJPEG(destfile, native = TRUE)

# Analysis
quantile(pic, probs = c(.30, .80))
