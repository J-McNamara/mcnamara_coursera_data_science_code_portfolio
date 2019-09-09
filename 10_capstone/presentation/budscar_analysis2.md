<style>
body {
    overflow: scroll;
}
</style>
Text prediction Shiny app
========================================================
author: Josh McNamara
date: 2019
autosize: true

Project for Coursera Data Science capstone

Goal of the text prediction productggg
========================================================

- The purpose of this exercise is to deploy a web app that can predict the next word in a typed sequence.
- The project was split in three phases- development of a corpus for text mining, development of a prediction algorithm, deployment on a web server
- The application must make a reasonable word prediction within ~1 second 

Corpus construction
========================================================
- The corpus was constructed by combining 0.5% of the lines in each data set (Twitter, news, blogs)
- Various data cleaning schemes were applied, but the algorithm makes the most realistic predictions has minimally altered text. The RWeka word tokenizer was applied to extract tokens and exclude special characters.
- Here is a sample of 3 lines from the corpus, and then a sample of 3 n-grams


```
[1] "Of all the issues of aging, the one that gets me the most is short term memory loss. People laugh about it but it's truly a curse."
[2] "Dear Omni Hotel or whoever is responsible for planning the menu: Vegetarians eat more than vegetables, and we need protein, too."  
[3] "they changed the potatoes for hashbrowns. they can't get the right food to the right person. Lot of untrained new staff"           
```

```
[1] "to"             "Wondering What" "works"         
```

Prediction model design
========================================================
- The prediction mode follows a simple decision tree: grep for the last bigram entered in the first two positions in the bank of trigrams. Return the third element of the trigram with the highest frequency in the corpora. Otherwise, return the most common English word: 'the'.

```r
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
```


Implementation and performance
========================================================
- Shiny app
- Accuracy plot

![plot of chunk unnamed-chunk-3](budscar_analysis2-figure/unnamed-chunk-3-1.png)
