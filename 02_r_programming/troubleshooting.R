outcome <- 'heart failure'
state <- 'NV'
num <- '10'



# Load the data and format
df <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
df[, 11] <- as.numeric(df[, 11])
df[, 17] <- as.numeric(df[, 17])
df[, 23] <- as.numeric(df[, 23])



# Map the outcome inputs to columns in the dataframe
outcomes <- list('heart attack' = NULL, 'heart failure' = NULL, 'pneumonia' = NULL)

# Check state and outcome are valid
if ((state %in% df[,7]) == FALSE) {
    print('State argument not valid')
    return(NA)
}
if ((outcome %in% names(outcomes)) == FALSE) {
    print('Outcome argument not valid')
    return(NA)
}

# Subset the dataframe for the correct state
df <- subset(df, State == state)


## Return hospital name in that state with the given rank
## 30-day death rate
outcomes <- list('heart attack' = df[,11], 'heart failure' = df[,17], 'pneumonia' = df[,23])
#return(outcomes[[outcome]])

df <- df[order(outcomes[[outcome]], decreasing = FALSE, na.last = NA),]
#dff <- na.omit(dff)

# Interpret the num variable
if (num == 'best') {
    df <- subset(df, outcomes[[outcome]] == min(outcomes[[outcome]]))
    return((df$Hospital.Name))
}
if (num == 'worst') {
    df <- subset(df, outcomes[[outcome]] == max(outcomes[[outcome]]))
    return((df$Hospital.Name))
} else {
    if (is.numeric(num)) {
        dff <- subset(df, outcomes[[outcome]] == outcomes[[outcome]][num])
        return(sort(dff$Hospital.Name))
    } else {
        return("Num argument is invalid")
    }
}
