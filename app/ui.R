library(shiny)

shinyUI(fluidPage(
  titlePanel("Car Fuel Efficiency Predictor"),
  tabsetPanel(
    tabPanel(
      "Predict MPG",
      sidebarLayout(
        sidebarPanel(
          h4("Enter the car's specifications"),
          sliderInput(
            "weight", "Weight (thousands of pounds)",
            min = 1.5, max = 5.5, value = 3.0, step = 0.1
          ),
          numericInput(
            "horsepower", "Gross horsepower",
            value = 150, min = 50, max = 350, step = 10
          ),
          selectInput(
            "cylinders", "Number of cylinders",
            choices = c("4" = 4, "6" = 6, "8" = 8)
          ),
          radioButtons(
            "transmission", "Transmission",
            choices = c("Automatic" = 0, "Manual" = 1)
          ),
          helpText("The estimate updates automatically when any input changes.")
        ),
        mainPanel(
          h3(textOutput("prediction")),
          h4(textOutput("interval")),
          br(),
          plotOutput("mpg_plot", height = "420px"),
          p("The orange point shows your car. Gray points show the 32 cars in the training data.")
        )
      )
    ),
    tabPanel(
      "How to use",
      h3("Getting started"),
      p("This app estimates fuel efficiency in miles per US gallon (MPG) from four car characteristics."),
      tags$ol(
        tags$li("Open the Predict MPG tab."),
        tags$li("Choose the car's weight, horsepower, cylinder count, and transmission."),
        tags$li("Read the estimated MPG and 95% prediction interval. The plot updates with your estimate.")
      ),
      h4("How the prediction works"),
      p("A multiple linear regression model was fitted to R's mtcars dataset. The model uses weight, horsepower, number of cylinders, and transmission type. The prediction interval describes the uncertainty for an individual car rather than just the average response."),
      h4("Data and limitations"),
      p("The dataset contains 32 cars from 1973–1974, so this is a small demonstration rather than a tool for evaluating modern vehicles. Predictions are most reasonable within the range of the inputs provided. No information entered in the app is stored."),
      h4("For reviewers"),
      p("The server performs reactive model predictions from the UI inputs and displays the results as text and a plot. The source code is available in ui.R and server.R in the accompanying GitHub repository.")
    )
  )
))
