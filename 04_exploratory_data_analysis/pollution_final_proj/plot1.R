# Final project for Exploratory Data Analysis course
#
# Read in the data
df <- readRDS('C:/Users/Josh/Desktop/summarySCC_PM25.rds', refhook = NULL)
labels <- readRDS('C:/Users/Josh/Desktop/Source_Classification_Code.rds')

# Analyze data
q1 <- aggregate(df$Emissions, by=list(Category=df$year), FUN=sum)

# Make plot
png(filename = 'plot1.png', width = 480, height = 480, units = 'px')
plot(y=q1$x, x=q1$Category, xlab='', ylab='Emissions (tons)', main = 'Total emissions decreased')
dev.off()
