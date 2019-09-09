# Final project for Exploratory Data Analysis course
library(ggplot2)
# Read in the data
df <- readRDS('C:/Users/Josh/Desktop/summarySCC_PM25.rds', refhook = NULL)
labels <- readRDS('C:/Users/Josh/Desktop/Source_Classification_Code.rds')
options(device='RStudioGD')

# Analyze data
library(plyr)
# Subset to Baltimore
q3 <- df[(df$fips==24510),]
# Sum by year and type
q3 <- ddply(df, .(year, type), summarize, Emissions=sum(Emissions))

# Plot, making types different facets
plot3 <- ggplot(q3, aes(x=year, y=Emissions)) + 
    geom_line() + 
    geom_point() +
    facet_wrap(~ type, scales='free') + 
    ggtitle(label = 'Emissions of all types have decreased')

ggsave(filename = 'plot3.png', plot = plot3, device = 'png')

# # Make plot
# png(filename = 'pplot3.png', width = 480, height = 480, units = 'px')
# ggplot(q3, aes(x=year, y=Emissions)) + 
#     geom_line() + 
#     geom_point() +
#     facet_wrap(~ type, scales='free') + 
#     ggtitle(label = 'Emissions of all types have decreased')
# png
# dev.off()
