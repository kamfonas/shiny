shinyUI(pageWithSidebar(
    headerPanel("Car MPG Calculator"),
    sidebarPanel(
        radioButtons("choice", "Base Estimate on",
                           c("Weight only" = 1,
                            "Weight and Horsepower" = 2,
                             "Weight and Acceleration" = 3),
                           selected=2),
        helpText("Depending on the option selected above, one of three models is 
                 used for MPG prediction. Use the sliders below to assign the appropriate
                 values to the weight, horsepower or acceleration. Notice that depending on the option
                 selected the horsepower and/or acceleration may be ignored."),
        
        sliderInput('wt', 'Select Weight in K-Pounds',value = 2, min = 1, max = 5.5, step = 0.1),
        sliderInput('hp', 'Select Horsepower',value = 150, min = 75, max = 500, step = 10),
        sliderInput('qsec', 'Select Seconds to Quarter-Mile',value = 10, min = 3, max = 30, step = 1)
    ),
    mainPanel(
       plotOutput('newPlot'),
       helpText("The title tells us what prediction algorithm is used for the estimation, 
                and what value of horsepower or quarter-mile-seconds is used. 
                The vertical black line marks the weight of the car based on the value selected by
                the respective slider. Two regression lines are shown, The red for manual transmission,
                and the green for automatic. The shaded area indicates the prediction 90% 
                confidence range. Notice that for manual transmission the model cannot predict MPG
                for cars heavier than 4,000 pounds.
                The two text lines on the graph, print the estimated average MPG and its 90% 
                confidence range for manual and automatic transmission cars.
                
                You can change the slider values or pick a different model to base the estimate on")

       )
           )
)


