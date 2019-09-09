# Final project for Exploratory Data Analysis course
library(ggplot2)
# Read in the data
df <- readRDS('C:/Users/Josh/Desktop/summarySCC_PM25.rds', refhook = NULL)
labels <- readRDS('C:/Users/Josh/Desktop/Source_Classification_Code.rds')
options(device='RStudioGD')

# Subset data to coal emissions
coal_SCCs <- labels[grep('coal', labels$Short.Name, ignore.case = TRUE),]$SCC
coal_df <- df[(df$SCC %in% coal_SCCs),]
# Sum emissions by year
q4 <- aggregate(coal_df$Emissions, by=list(Category=coal_df$year), FUN=sum)

# Plot emissions
plot(q4, xlab='', ylab='Emissions (tons)', main='Emissions from coal decreased')

# Plot emissions
png(filename = 'plot4.png', width = 480, height = 480, units = 'px')

plot(q4, xlab='', ylab='Emissions (tons)', main='Emissions from coal decreased')


dev.off()
