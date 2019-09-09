# Final project for Exploratory Data Analysis course
#
# Read in the data
df <- readRDS('C:/Users/Josh/Desktop/summarySCC_PM25.rds', refhook = NULL)
labels <- readRDS('C:/Users/Josh/Desktop/Source_Classification_Code.rds')

# Analyze data
q2 <- df[(df$fips==24510),]
q2 <- aggregate(q2$Emissions, by=list(Category=q2$year), FUN=sum)

# Make plot
png(filename = 'plot2.png', width = 480, height = 480, units = 'px')
plot(y=q2$x, x=q2$Category, xlab='', ylab='Emissions (tons)', main = 'Total emissions decreased in Baltimore')
dev.off()
