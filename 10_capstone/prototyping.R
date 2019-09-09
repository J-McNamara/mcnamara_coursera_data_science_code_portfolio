# http://blog.kaggle.com/2017/08/25/data-science-101-getting-started-in-nlp-tokenization-tutorial/

# Files
path <- '~/Desktop/OneDrive - Johns Hopkins University/r_programming/coursera_data_science_courses/10_capstone/'
setwd(path)
twit <- 'final/en_US/en_US.twitter.txt'
news <- 'final/en_US/en_US.news.txt'
blog <- 'final/en_US/en_US.blogs.txt'


# Gemischify
twit_len <- length(readLines(twit))
news_len <- length(readLines(news))
blog_len <- length(readLines(blog))
total_len <- twit_len + news_len + blog_len




evaluate <- function(model, input, corpora, cases){
        for (i in cases) {
                case <- sample(input, 1)
                prediction <- test_predict(case, corpora)
                actual <- case[length(case)-1]
                correct <- FALSE
                print(case)
                print(prediction)
                if (actual == prediction) {
                        correct <<- TRUE
                }
                print(paste(case, prediction, 'Prediction is correct?', correct))
                
        }
}

evaluate(test_predict, train, n_grams, 1)

test_predict(sample(train ,1), n_grams)


```{r}
Sys.setenv(JAVA_HOME='/usr/bin/java')


Mode <- function(x) {
        ux <- unique(x)
        ux[which.max(tabulate(match(x, ux)))]
}

test_predict <- function(inp, corpora){
        # Make input the last two words
        inp <- WordTokenizer(inp)
        inp <- inp[(length(inp)-2):length(inp)-1]
        
        # Return 3rd elemnt of matching trigrams
        inp <- paste('^', inp[1], ' ', inp[2], ' ', sep='')
        out <- grep(x=corpora, pattern=inp, value = TRUE)
        #out == 'character(0)'
        
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
