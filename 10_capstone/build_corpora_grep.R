# Set up
Sys.setenv(JAVA_HOME='/usr/bin/java')
options(java.parameters = "-Xmx4000m")


# Might need to run this fin the terminal:
# sudo R CMD javareconf
library(rJava)
library(RWeka)
library(openNLP)
library(ggplot2)
library(dplyr)
library(magrittr)
#install.packages('slam')
library(slam)
library(tm)


# Read it in
path <- '~/Desktop/OneDrive - Johns Hopkins University/programming/coursera_data_science_courses/10_capstone/'
setwd(path)
twit <- 'final/en_US/en_US.twitter.txt'
news <- 'final/en_US/en_US.news.txt'
blog <- 'final/en_US/en_US.blogs.txt'
test <- 'test.txt'
sources <- c(twit, news, blog)
source_names <- c('twit', 'news', 'blog')

# Build a sample set and a test set of equal size, mutually exclusive
set.seed(8234)
sampling_ratio <- 0.03
return_subset_indices <- function(file, ratio){
        file_length <- length(readLines(file))
        return(sample(1:file_length, file_length*ratio))
}

twit_indices <- (return_subset_indices(twit, sampling_ratio))
news_indices <- (return_subset_indices(news, sampling_ratio))
blog_indices <- (return_subset_indices(blog, sampling_ratio))

train <- sample(c(readLines(twit)[twit_indices], readLines(news)[news_indices], readLines(blog)[blog_indices])) # sample mixes the order up

# Keep conctractions by eliminating apostrophes from words before tokenizing

#train <- gsub('\'', '', train, ignore.case=T) # RWeka word tokenizer will not recognize the apostrophe-free words
train <- replace_contraction(train)
#save(x=train, file='train.Rda')
#rm(list = ls())
#load('train.Rda')


# Tokenize the training set
#tokens <- AlphabeticTokenizer(readLines('train.Rda'), control = NULL)
#n_grams <- NGramTokenizer(readLines('train.Rda'), Weka_control(min = 3, max = 3)) # Readlines does not work here
n_grams <- NGramTokenizer(train, Weka_control(min = 3, max = 3))

#word_tokens <- WordTokenizer(train, control = NULL)

u_n_grams <- sort(table(n_grams), decreasing=TRUE)
sorted_ngrams <- names(u_n_grams)
n_grams <- sorted_ngrams
n_grams <- n_grams[1:75000]

save(x=n_grams, file='n_grams.Rda')
save(x=sorted_ngrams, file='sorted_ngrams.Rda')
load('n_grams.Rda')
#save(x=corpora, file='corpora_new.Rda')
#save(x=train, file='train.Rda')

# Then save into data folder on app
# One way to make this more efficient is to eliminate redundancy on the first two elements in each token in the priority list.


