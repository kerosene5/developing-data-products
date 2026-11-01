library(shiny)

server <- function(input, output, session) {
  model <- lm(mpg ~ wt + hp + factor(cyl) + factor(am), data = mtcars)

  car <- reactive({
    data.frame(
      wt = input$weight,
      hp = input$horsepower,
      cyl = factor(input$cylinders, levels = c(4, 6, 8)),
      am = factor(input$transmission, levels = c(0, 1))
    )
  })

  estimate <- reactive({
    predict(model, newdata = car(), interval = "prediction", level = 0.95)
  })

  output$prediction <- renderText({
    sprintf("Estimated fuel efficiency: %.1f MPG", estimate()[1, "fit"])
  })

  output$interval <- renderText({
    sprintf(
      "95%% prediction interval: %.1f to %.1f MPG",
      estimate()[1, "lwr"], estimate()[1, "upr"]
    )
  })

  output$mpg_plot <- renderPlot({
    par(mar = c(4.5, 4.5, 2.5, 1))
    plot(
      mtcars$wt, mtcars$mpg,
      pch = 19, col = "#8996a8", cex = 1.3,
      xlab = "Weight (thousands of pounds)",
      ylab = "Miles per gallon (MPG)",
      main = "Your estimate compared with the training cars"
    )
    grid(col = "#e5e7eb")
    points(
      input$weight, estimate()[1, "fit"],
      pch = 19, col = "#e76f51", cex = 2.2
    )
    legend(
      "topright", c("Training cars", "Your estimate"),
      col = c("#8996a8", "#e76f51"), pch = 19, bty = "n"
    )
  })
}
