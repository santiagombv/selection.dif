library(shiny)
library(ggplot2)
library(gridExtra, quietly =T)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("Diferenciales de selección"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput("tipo", 
                  label ="tipo de selección", 
                  choices = c(positiva = "Zp", 
                              negativa = "Zn", 
                              estabilizadora = "Ze", 
                              disruptiva = "Zd")),
      sliderInput("SOB", label = "% post selección", 
                  min=1, max=100, value = 100, step = 1), 
      width = 3),
    
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))