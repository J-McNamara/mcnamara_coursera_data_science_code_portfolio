# Week 1 quiz

library(magrittr)
library(stringr)

setwd('~/Desktop/OneDrive - Johns Hopkins University/r_programming/coursera_data_science_courses/10_capstone')

# Quiz q1
file.info('final/en_US/en_US.blogs.txt')$size / 1000000

# How many lines are in the twitter file?
sum(grep('^.', readLines('final/en_US/en_US.twitter.txt')))
length(readLines('final/en_US/en_US.twitter.txt'))

# Which file has the longest line?
files <- '~/Desktop/test.txt'
max(str_length(readLines('final/en_US/en_US.blogs.txt')))
max(str_length(readLines('final/en_US/en_US.news.txt')))
max(str_length(readLines('final/en_US/en_US.twitter.txt')))

#for (i in files){
 #       print(i)
  #      print(readLines(i))
        #print(i)
        #for (j in 1:len){
                print(i[j])
                #print(length(readLines(i, j)))
                #print(str_length(i[j]))
                #(str_length(readLines(files[i][j]))
 #       }


# Love hate question
love <- length(grep('love', readLines('final/en_US/en_US.twitter.txt')))
hate <- length(grep('hate', readLines('final/en_US/en_US.twitter.txt')))
love / hate                

# Biostats question
#grep('biostats', readLines('final/en_US/en_US.twitter.txt'))

readLines('final/en_US/en_US.twitter.txt')[grep('cat pictures', readLines('final/en_US/en_US.twitter.txt'))]

# Exact match
length(grep("A computer once beat me at chess, but it was no match for me at kickboxing", readLines('final/en_US/en_US.twitter.txt')))


