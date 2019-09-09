setwd('C:/Users/Josh/OneDrive - Johns Hopkins University/Coursera Data Science/R programming/week 3/rprog_data_ProgAssignment3-data/')
##########
df <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
df[, 11] <- as.numeric(df[, 11])
#df <- df[df['State']== 'GA',]


# For a given state and indication,
# return the hospital with the best outcome
best <- function(state, outcome) {
    # Read in outcome data
    df <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
    df[, 11] <- as.numeric(df[, 11])
    
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
    # Look up the best hospital for the chosen outcome and state
    else {
        # Subset the dataframe for the correct state
        stated <<- subset(df, State == state)
        outcomes <- list('heart attack' = stated[,11], 'heart failure' = stated[,17], 'pneumonia' = stated[,23])
        # Return the best hospital for the given condition
        return(stated[which.min(outcomes[[outcome]]),]$Hospital.Name)
    
    }
    
}

rankhospital <- function(state, outcome, num = "best") {
    # Load the data and format
    df <- read.csv('outcome-of-care-measures.csv', colClasses = 'character')
    df[, 11] <- as.numeric(df[, 11])
    
    
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
    df <- na.omit(df)
    
    
    ## Return hospital name in that state with the given rank
    ## 30-day death rate
    outcomes <- list('heart attack' = df[,11], 'heart failure' = df[,17], 'pneumonia' = df[,23])
    #return(outcomes[[outcome]])
    
    dff <- df[order(outcomes[[outcome]], decreasing = FALSE),]
    
    # Interpret the num variable
    if (num == 'best') {
        dff <- subset(dff, dff[,11] == min(dff[,11]))
        return(sort(dff$Hospital.Name)[1])
    }
    if (num == 'worst') {
        dff <- subset(dff, dff[,11] == max(dff[,11]))
        return(sort(dff$Hospital.Name)[1])
    } else {
        if (is.numeric(num)) {
            dff <- subset(dff, dff[,11] == dff[num,11])
            return(sort(dff$Hospital.Name)[1])
        } else {
            return("Num argument is invalid")
        }
    }
    
}

rankall <- function(outcome, num = "best") {
    ## Read outcome data
    ## Check that state and outcome are valid
    ## For each state, find the hospital of the given rank
    ## Return a data frame with the hospital names and the
    ## (abbreviated) state name
}


    
    
    