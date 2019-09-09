# Final project for Exploratory Data Analysis course
library(ggplot2)
# Read in the data
df <- readRDS('C:/Users/Josh/Desktop/summarySCC_PM25.rds', refhook = NULL)
labels <- readRDS('C:/Users/Josh/Desktop/Source_Classification_Code.rds')
options(device='RStudioGD')

# Subset ON ROAD sources and sum emissions by year
q5 <- df[(df$fips==24510),]
q5 <- q5[(q5$type=='ON-ROAD'),]
q5 <- aggregate(q5$Emissions, by=list(Category=q5$year), FUN=sum)

# Plot emissions
plot(q5, xlab='', ylab='Emissions (tons)', main='Balt emissions from motor vehicles decreased')

# Save plot
png(filename = 'plot5.png', width = 480, height = 480, units = 'px')

plot(q5, xlab='', ylab='Emissions (tons)', main='Balt emissions from motor vehicles decreased')


dev.off()
