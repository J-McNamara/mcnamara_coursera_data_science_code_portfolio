# Set up
Sys.setenv(JAVA_HOME='/usr/bin/java')
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

# Build a sample set
set.seed(8234)
sampling_ratio <- 0.005

return_subset_indices <- function(file, ratio){
        file_length <- length(readLines(file))
        return(sample(1:file_length, file_length*ratio))
}

twit_indices <- (return_subset_indices(twit, sampling_ratio))
news_indices <- (return_subset_indices(news, sampling_ratio))
blog_indices <- (return_subset_indices(blog, sampling_ratio))

train <- sample(c(readLines(twit)[twit_indices], readLines(news)[news_indices], readLines(blog)[blog_indices])) # sample mixes the order up
        
# Tokenize the training set
#dataS <- c(blogs_sub, news_sub, twitter_sub)
corpus <- train[1:20]
corpus <- VCorpus(VectorSource(corpus))
corpus <- VCorpus(VectorSource(sapply(corpus, function(row) iconv(row, "latin1", "ASCII", sub=""))))

# Clean and tokenize
corpus1 <- tm_map(corpus, removeNumbers)
corpus1 <- tm_map(corpus1, stripWhitespace)
corpus1 <- tm_map(corpus1, removePunctuation, preserve_intra_word_dashes = TRUE)
corpus1 <- tm_map(corpus1, content_transformer(tolower))
#corpus1 <- tm_map(corpus1, stemDocument)
corpus1 <- tm_map(corpus1, removeWords, stopwords("en"))
#corpus2 <- tm_map(corpus1, PlainTextDocument)
#corpus1 <- NGramTokenizer(corpus1, Weka_control(min = 2, max = 2))


# Tokenize and make N-grams
unigrammer <- function(x) NGramTokenizer(x, Weka_control(min = 1, max = 1))
bigrammer  <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
trigrammer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))

unigrams <- TermDocumentMatrix(corpus1, control = list(tokenize = unigrammer))
bigrams <- TermDocumentMatrix(corpus1, control = list(tokenize = bigrammer))
trigrams <- TermDocumentMatrix(corpus1, control = list(tokenize = trigrammer))

#tokens <- AlphabeticTokenizer(x, control = NULL)
#n_grams <- NGramTokenizer(x)
#word_tokens <- WordTokenizer(x, control = NULL)
#save(x=n_grams, file='corpora.Rda')
uni_corpus <- findFreqTerms(unigrams,lowfreq = 0)
uni_corpusF <- rowSums(as.matrix(unigrams[uni_corpus,]))
uni_corpusF <- data.frame(word=names(uni_corpusF), frequency=uni_corpusF)
uni_corpusF <- uni_corpusF[order(-uni_corpusF$frequency),]
uni_corpusF[1:10,]

bi_corpus <- findFreqTerms(bigrams,lowfreq = 0)
bi_corpusF <- rowSums(as.matrix(bigrams[bi_corpus,]))
bi_corpusF <- data.frame(word=names(bi_corpusF), frequency=bi_corpusF)
bi_corpusF <- bi_corpusF[order(-bi_corpusF$frequency),]
bi_corpusF[1:10,]

tri_corpus <- findFreqTerms(trigrams,lowfreq = 0)
tri_corpusF <- rowSums(as.matrix(trigrams[tri_corpus,]))
tri_corpusF <- data.frame(word=names(tri_corpusF), frequency=tri_corpusF)
tri_corpusF <- tri_corpusF[order(-tri_corpusF$frequency),]
tri_corpusF[1:10,]

# Strategy- could be better to grep serially the words and shorten -1 until you get a match, then sort by mode







