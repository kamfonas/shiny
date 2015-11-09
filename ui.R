shinyUI(pageWithSidebar(
    headerPanel("Car MPG Calculator"),
    sidebarPanel(
        radioButtons("choice", "Base Estimate on",
                           c("Weight only" = 1,
                            "Weight and Horsepower" = 2,
                             "Weight and Acceleration" = 3),
                           selected=2),
        
        sliderInput('wt', 'Weight in K-Pounds',value = 2, min = 1, max = 5.5, step = 0.1),
        sliderInput('hp', 'Horsepower',value = 150, min = 75, max = 500, step = 10),
        sliderInput('qsec', 'Seconds to Quarter-Mile',value = 10, min = 3, max = 30, step = 1)
    ),
    mainPanel(
       plotOutput('newPlot')
    )
))

