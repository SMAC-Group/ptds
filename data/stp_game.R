st_petersburg_game <- function(n_games, fee, seed){
  # st Petersburg game
  gains <- vector(mode = "double", length = n_games)
  set.seed(seed)
  for(i in 1:n_games){
    head <- TRUE
    pot <- 1
    set.seed(seed)
    while (head) {
      # toss a coin
      x <- rbinom(n = 1, size = 1, prob = 0.5) 
      
      # verify the coin
      if(x == 0){
        head <- FALSE
      }
      # update the pot
      pot <- pot * 2
    }
    # save the result
    gains[i] <- pot - fee
  }
  return(gains)
}

# Define UI for application
ui <- fluidPage(
 numericInput("n_games", "Number of games:", 10, 1, 1e4),
 numericInput("fee", "Fee for playing one game:", 10, 1, 1e7),
 numericInput("seed", "Simulation seed", 123, 1, 1e7),
 actionButton("play", "Let's play the games!", icon = icon("gamepad")),
 plotOutput("hist")
)

server <- function(input, output) {
  
  # play the games
  play <- eventReactive(input$play, {
    # St-Petersburg function that creates an object of class "sp_game"
    st_petersburg_game(n_games = input$n_games, fee = input$fee, 
                       seed = input$seed)
  })
  
  # plot the output
  output$hist <- renderPlot({
    plot(play())
  })
}