# Set up
library(shiny)
library(RWeka)
library(openNLP)
library(tm)

Mode <- function(x) {
    ux <- unique(x)
    ux[which.max(tabulate(match(x, ux)))]
}

# Define UI behavior
ui <- fluidPage(

    # Application title
    titlePanel("Text prediction algorithm"),
    sidebarLayout(position = "right",
                  sidebarPanel("Enter text in the empty space. Predictions will be generated dynamically as you type!"),
    
    mainPanel(
        h4("Enter text here:"),
        
        textInput(inputId = 'typed', '', value = ""),
        h4("Predicted next word:"),
        textOutput("predicted_word") # This is reactive output
    )
    
)
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$predicted_word <- renderText(input$typed)
    corpora <- load('data/n_grams.Rda')
    corpora <- n_grams
    #if (!length(corpora)){
    #    corpora <- load('data/corpora.Rda')
    #}
    # Define prediction algorithm
    predict <- function(inp, corpora){
        # Make input the last two words
        inp <- WordTokenizer(inp)
        
        
        
        # Return second entry of a trigram for one word entered
        if (length(inp) == 1){
            
            # Return 2nd elemnt of matching trigrams
            inp <- paste('^', inp, sep='')
            out <- grep(x=corpora, pattern=inp, value = TRUE)
            
            
            # Return function
            if (length(out)) {
                out <- out[1]
                out <- WordTokenizer(out)[2]
                return(out)
            }
            else {
                return('the')     
            }
        }
        
        # Return third entry of a trigram for two words enetered
        if (length(inp) >= 2){
            
            inp <- inp[(length(inp)-1):length(inp)]
    
            # Return 3rd elemnt of matching trigrams
            inp <- paste('^', inp[1], ' ', inp[2], ' ', sep='')
            out <- grep(x=corpora, pattern=inp, value = TRUE)

            
            # Return function
            if (length(out)) {
                out <- out[1]
                out <- WordTokenizer(out)[3]
                return(out)
            }
            else {
                return('the')     
            }
        }
    }
    # Make prediction based on input    
    prediction <- reactive({predict(input$typed, n_grams)})
    
    # Send prediction to UI
    output$predicted_word <- renderText(prediction())
}

# Run the application 
shinyApp(ui = ui, server = server)
