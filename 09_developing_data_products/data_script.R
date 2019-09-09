# Set up environment
library(ggplot2)
library(shiny)
library(plotly)
library(leaflet)
library(dplyr)
library(magrittr)

# Load and join data
setwd('Desktop/')
cost <- read.csv('cost-living.csv')
pats <- read.csv('uspto-tidy.csv')
coords <- read.csv('coords.csv')

df <- merge(cost, pats,by="city", all=TRUE)
df <- merge(df, coords,by="city", all=TRUE)
df$comp <- df$patents / (df$cost)^7 #Make composite score
sorted <- df[order(df$comp, decreasing = TRUE),] 
head(sorted)

# Make a map

# From https://www.census.gov/geo/maps-data/data/cbf/cbf_state.html
states <- readOGR("shp/cb_2013_us_state_20m.shp",
                  layer = "cb_2013_us_state_20m", GDAL1_integer64_policy = TRUE)

neStates <- subset(states, states$STUSPS %in% c(
        "CT","ME","MA","NH","RI","VT","NY","NJ","PA"
))

leaflet(neStates) %>%
        addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                    opacity = 1.0, fillOpacity = 0.5,
                    fillColor = ~colorQuantile("YlOrRd", ALAND)(ALAND),
                    highlightOptions = highlightOptions(color = "white", weight = 2,
                                                        bringToFront = TRUE))
df <- df[complete.cases(df),]
#df$cost <- df$cost/max(df$cost)
#df$patents <- df$patents/max(df$patents)

pal <- colorNumeric(
        palette = "RdYlGn",
        domain = df$cost)


leaflet(df) %>% addTiles() %>%
        addCircleMarkers(lng = ~lon, lat = ~lat,
                   radius = ~patents/1000, popup = ~city, color = ~pal(cost), stroke = ~comp, fillOpacity = 0.9

        )

leaflet(df) %>% addTiles() %>%
        addCircleMarkers(lng = ~lon, lat = ~lat,
                         radius = ~comp/2, popup = ~city, color = 'Blue', fillOpacity = 0.9
                         
        )

