# Create a logical vector that identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products. Assign that logical vector to the variable agricultureLogical. Apply the which() function like this to identify the rows of the data frame where the logical vector is TRUE."






# Set up
setdir('/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3')
# library()

# Load the files
url <- 'https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv'
destfile <- 'C:/Users/Josh/OneDrive - Johns Hopkins University/coursera_data_science_program/03_getting_and_cleaning_data/week_3/p1.csv'
download.file(url = url, destfile = destfile)
df <- read.csv(destfile)

# Analysis
agricultureLogical <- df$ACR==3
agricultureLogical <- agricultureLogical * df$AGS==6
which(agricultureLogical)[c(1,2,3)]

