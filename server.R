#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
function(input, output) {
    
    #Depending on the distribution, return the appropriate parameter selector
    output$params <- renderUI({
        switch(input$dist,
               "Uniform" = sliderInput("unifParams", "Range", -100, 100,
                                       c(-50,50)),
               "Poisson" = sliderInput("poisParams", "Mean",
                                       1, 100, 50),
               "Chi-Square" = sliderInput("chisqParams", "Degrees of Freedom",
                                          1, 100, 50),
               "Exponential" = sliderInput("expParams", "Rate", 0.01, 5, 2.5),
               "Geometric" = sliderInput("geomParams",
                                         "Probability of Success",
                                         0.01, 1, 0.5),
               "Log Normal" = list(sliderInput("lnormParams1", "Log Mean",
                                               -100, 100, 0),
                                   sliderInput("lnormParams2",
                                               "Log Standard Deviation",
                                               1, 100, 1)),
               "Beta" = list(sliderInput("betaParams1", "Shape 1 (\u03B1)",
                                         1, 100, 50),
                             sliderInput("betaParams2", "Shape 2 (\u03B2)",
                                         1, 100, 50)),
               "Binomial" = list(sliderInput("binomParams1",
                                             "Number of trials", 1, 100, 50),
                                 sliderInput("binomParams2",
                                             "Probability of Success",
                                             0, 1, 0.5)),
               "Normal" = list(sliderInput("normParams1", "Mean", -100, 100, 0),
                               sliderInput("normParams2", "Standard Deviation",
                                           1, 100, 1))
        )
    })
    
    # Generate means of random samples of the chosen distribution
    # If the reactive process receives an error or a warning
    # return NULL instead
    data <- reactive({ tryCatch({
        matrixSize <- input$sampleSize * input$numSample
        
        data <- switch(input$dist,
                       "Uniform" = runif(matrixSize, min=input$unifParams[1],
                                         max=input$unifParams[2]),
                       "Poisson" = rpois(matrixSize, lambda=input$poisParams),
                       "Chi-Square" = rchisq(matrixSize, df=input$chisqParams),
                       "Exponential" = rexp(matrixSize, rate=input$expParams),
                       "Geometric" = rgeom(matrixSize, prob=input$geomParams),
                       "Log Normal" = rlnorm(matrixSize,
                                             meanlog=input$lnormParams1,
                                             sdlog=input$lnormParams2),
                       "Beta" = rbeta(matrixSize, shape1=input$betaParams1,
                                      shape2=input$betaParams2),
                       "Binomial" = rbinom(matrixSize, size=input$binomParams1,
                                           prob=input$binomParams2),
                       "Normal" = rnorm(matrixSize, mean=input$normParams1,
                                        sd=input$normParams2)
                )
        
        data <- matrix(data, nrow=input$numSample, ncol=input$sampleSize)
        data <- rowMeans(data)
    }, error = function(e) NULL, warning = function(e) NULL)
    })
    
    # Plot output histogram
    output$hist <- renderPlot({
        
        # Calculate the vertical limit of the plot
        # sigma <- sd(data)
        # ymax <- dnorm(0, mean=0, sd=sigma)
        
        # Only plot if 'data()' is not 'NULL'
        if (! is.null(data())) {
            # Histogram
            hist(data(), freq=F,
                 main = sprintf("Histogram of %s sample means",input$numSample),
                 xlab = "Sample mean", ylab = "Density")
            
            # Normal density if required
            if (input$normD) {
                mu <- mean(data()); sigma <- sd(data())
                xs <- seq(min(data())-sigma, max(data())+sigma, length.out=1000)
                lines(xs, dnorm(xs, mu, sigma), col="red", lwd=2)
            }
            
            # Kernel density if required
            if (input$kernD) {
                lines(density(data()), col="blue", lwd=2)
            }
        }
    })
    
    
    # Plot output qqnorm plot (only if 'data()' is not 'NULL')
    output$qq <- renderPlot({
        if (! is.null(data())) {
            qqnorm(data())
            qqline(data(), col="magenta", lwd=2)
        }
    })
    
}
