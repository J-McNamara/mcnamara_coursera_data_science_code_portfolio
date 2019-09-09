---
title: "Impact of adverse weather events"
output: 
  html_document:
    keep_md: true
---
Josh McNamara

## Synopsis
This analysis compares the cost of various adverse weather events in the United States in therms of their economic cost and impact on public health. These damages are summed by the category of adverse weather events and compared.
  This analysis found that floods have the greatest economic cost in the US, yet tornados cause both the most injuries and the most fatalities of any adverse weather category.

## Data Processing
  Data were loaded and the appropriate data columns wre subsetted. The resultant dataframe was saved as an R data file for re-loading to speed iterative debugging, as the csv loading was rate limiting. 
  The weird data expontnts in the original data were corrected to a numeric format. Damages to crops and property were summed and counted as the total economic cost. Injuries and fatalities were evaluated as separate categories in the analysis.


```r
# Point to project
setwd('/Users/JTM/Desktop/OneDrive - Johns Hopkins University/coursera_data_science_program/05_reproducible_research')

# Read in data
#df <- read.csv('~/Desktop/repdata-data-StormData.csv')

# Jettison unnecessary columns
#df<- df[,c(8,23,24,25,26,27,28)]

# Save and load the R datafile for faster debugging later
#save(df, file='~/df.R')
load(file='~/Desktop/df.R')

# Fix property damage exponent formats
df$PROPDMGEXP <- as.character(df$PROPDMGEXP)
df$PROPDMGEXP[df$PROPDMGEXP=='B'] <- 9
df$PROPDMGEXP[df$PROPDMGEXP=='M'] <- 6
df$PROPDMGEXP[df$PROPDMGEXP=='m'] <- 6
df$PROPDMGEXP[df$PROPDMGEXP=='K'] <- 3
df$PROPDMGEXP[df$PROPDMGEXP=='k'] <- 3
df$PROPDMGEXP[is.na(df$PROPDMGEXP)] <- 1
df$PROPDMGEXP[df$PROPDMGEXP==''] <- 1
df$PROPDMGEXP[df$PROPDMGEXP=='?'] <- 1
df$PROPDMGEXP[df$PROPDMGEXP=='+'] <- 1
df$PROPDMGEXP[df$PROPDMGEXP=='-'] <- 1
df$PROPDMGEXP[df$PROPDMGEXP=='H'] <- 2
df$PROPDMGEXP[df$PROPDMGEXP=='h'] <- 2
df$PROPDMGEXP <- as.numeric(df$PROPDMGEXP)
df$propd <- df$PROPDMG * (10 ^ df$PROPDMGEXP)

# Fix crop damage exponent formats
df$CROPDMGEXP <- as.character(df$CROPDMGEXP)
df$CROPDMGEXP[df$CROPDMGEXP=='B'] <- 9
df$CROPDMGEXP[df$CROPDMGEXP=='M'] <- 6
df$CROPDMGEXP[df$CROPDMGEXP=='m'] <- 6
df$CROPDMGEXP[df$CROPDMGEXP=='K'] <- 3
df$CROPDMGEXP[df$CROPDMGEXP=='k'] <- 3
df$CROPDMGEXP[is.na(df$CROPDMGEXP)] <- 1
df$CROPDMGEXP[df$CROPDMGEXP==''] <- 1
df$CROPDMGEXP[df$CROPDMGEXP=='?'] <- 1
df$CROPDMGEXP[df$CROPDMGEXP=='H'] <- 2
df$CROPDMGEXP <- as.numeric(df$CROPDMGEXP)
df$cropd <- df$CROPDMG * (10 ^ df$CROPDMGEXP)
df$dmg <- df$propd + df$cropd

# Get rid of old exponent columns
df <- df[,c(1,2,3,10)] 

# Sum damages by event type
grouped <- aggregate(x = df[,2:4], by = list(df$EVTYPE), FUN=sum)
colnames(grouped)[1] <- 'EVTYPE' # This colname got deleted by the aggregation

# Order by each category and head the tables to show onlythe top expenses
dmg <- grouped[order(-grouped$dmg),c(1,4)]
injur <- grouped[order(-grouped$INJURIES),c(1,3)]
fatal <- grouped[order(-grouped$FATALITIES),c(1,2)]
fatal <- head(fatal)
injur <- head(injur)
dmg <- head(dmg)
```


## Results

Below are summary tables exhibiting the weather events with the highest cost in human fatalities, injuries, and overall economic damages:
 
 

```r
# Display summary tables for each group
fatal
```

```
##             EVTYPE FATALITIES
## 834        TORNADO       5633
## 130 EXCESSIVE HEAT       1903
## 153    FLASH FLOOD        978
## 275           HEAT        937
## 464      LIGHTNING        816
## 856      TSTM WIND        504
```

```r
injur
```

```
##             EVTYPE INJURIES
## 834        TORNADO    91346
## 856      TSTM WIND     6957
## 170          FLOOD     6789
## 130 EXCESSIVE HEAT     6525
## 464      LIGHTNING     5230
## 275           HEAT     2100
```

```r
dmg
```

```
##                EVTYPE          dmg
## 170             FLOOD 150319678320
## 411 HURRICANE/TYPHOON  71913712800
## 834           TORNADO  57362334514
## 670       STORM SURGE  43323541000
## 244              HAIL  18761222526
## 153       FLASH FLOOD  18243992942
```

```r
# Make a plot summarizing fatalities
barplot(fatal$FATALITIES, names.arg=(fatal$EVTYPE), cex.names=0.5, las=2, main='Fatalities from adverse weather', ylab= 'Fatalities' )
```

![](weather_report_files/figure-html/unnamed-chunk-1-1.png)<!-- -->

```r
# Make a plot summarizing injuries
#barplot(injur$INJURIES, names.arg=(injur$EVTYPE), cex.names=0.5, las=2, main='Injuries from adverse weather', ylab= 'Injuries' )

# Make a plot summarizing costs
#barplot(dmg$dmg, names.arg=(dmg$EVTYPE), cex.names=0.5, las=2, main='Damage cost of adverse weather', ylab= 'Fatalities' )
```

  
##Conclusion
  
  
  
  It is evident from the charts and plot above that floods have the greatest adverse economic impact of any category of adverse weather event in the United States. 
  In terms of impact on human health, tornados injure and kill more Americans than any other category of weather event.
