# Final project for Exploratory Data Analysis course
library(ggplot2)
# Read in the data
df <- readRDS('C:/Users/Josh/Desktop/summarySCC_PM25.rds', refhook = NULL)
labels <- readRDS('C:/Users/Josh/Desktop/Source_Classification_Code.rds')
options(device='RStudioGD')

# Label cities
q6 <- df
q6$city <- NA
q6[q6$fips == '06037',]$city <- 'Los Angeles'
q6[q6$fips == '24510',]$city <- 'Baltimore'
q6 <- na.omit(q6)

# Subset motor vehicles
q6 <- q6[(q6$type=='ON-ROAD'),]
library(plyr)
q6 <- ddply(q6, .(year, city), summarize, Emissions=sum(Emissions))

plot6 <- ggplot(q6, aes(x=year, y=Emissions)) + 
    geom_line() + 
    geom_point() +
    facet_wrap(~ city, scales='free', nrow=2) + 
    ggtitle(label = 'Baltimore MV emissions decreased, Los Angeles increased')
plot6
ggsave(filename = 'plot6.png', plot = plot6, device = 'png')
