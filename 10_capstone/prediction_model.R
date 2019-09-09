
setwd('/Users/JTM/Desktop/OneDrive - Johns Hopkins University/programming/coursera_data_science_courses/10_capstone/')

inp <- "I'm not sure if these dogs "
corpora <- n_grams
corpora <- load('corpora_new.Rda')

# Preceding bigram grepping
predict <- function(inp, corpora){
        # Make input the last two words
        inp <- WordTokenizer(inp)
        inp <- inp[(length(inp)-1):length(inp)]
        print(inp)
        
        # Return 3rd elemnt of matching trigrams
        inp <- paste('^', inp[1], ' ', inp[2], ' ', sep='')
        print(inp)
        out <- grep(x=corpora, pattern=inp, value = TRUE)
        print(out)
        out == 'character(0)'
        
        # Return function
        if (length(out)) {
                out <- Mode(out)
                print(out)
                out <- WordTokenizer(out)[3]
                return(out)
        }
        else {
           return('the')     
        }
}



prediction <- predict(inp, corpora)
print(prediction)


