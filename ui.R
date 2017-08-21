#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that demonstrates the CLT
fluidPage(
    
    # Application title
    titlePanel("Central Limit Theorem Demonstration"),
    
    
    sidebarLayout(
        
        sidebarPanel(
            
            # Choose distribution
            selectInput("dist", "Select distribution",
                        sort(c("Uniform", "Poisson", "Chi-Square",
                               "Exponential", "Geometric", "Log Normal",
                               "Beta", "Binomial", "Normal"))),
            
            # A dynamic UI that allows the user to select the parameter(s)
            # according to the chosen distribution
            uiOutput("params"),
            
            # Choose the size of each sample (to take the mean of)
            sliderInput("sampleSize", "Number of random observations in a
                        sample", min = 1, max = 100, value = 50),
            
            # Choose the number of samples
            sliderInput("numSample", "Number of samples",
                        min = 10, max = 1000, value = 500),
            
            # Choose whether to display the normal density
            checkboxInput("normD", HTML("<span style=\"color:red\">Display normal density</span>")),
            
            # Choose whether to display the kernel density
            checkboxInput("kernD", HTML("<span style=\"color:blue\">Display kernel density</span>"))
        ),
        
        # Show the histogram and qqnorm of the generated means
        mainPanel(
            tabsetPanel(
                tabPanel("Plots", plotOutput("hist"), plotOutput("qq")),
                tabPanel("Documentation",
                         HTML(markdown::markdownToHTML(knitr::knit("doc.Rmd",
                                                                   quiet=T))))
            )
        )
    )
)
