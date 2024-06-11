library(shiny)
library(leaflet)
library(ggplot2)

data <- read.csv('nyairbnb_dataset_after_exploration.csv', stringsAsFactors = F, na.strings = c("", "NA"))
head(data)

log_data <- read.csv('nyairbnb_dataset_bubble.csv', stringsAsFactors = F, na.strings = c("", "NA"))

length(unique(data$host_id))

# Displaying the above data using Shiny (including a graph using ggplot)
#-----------------------------------------------------------------------------------------
ui <- fluidPage(
  # Application title
  headerPanel("NY Airbnb host success factors"),
  # create map canvas on the page
  leafletOutput("NYmap"),
  leafletOutput("price_dist"),
  plotOutput('bubble'),
  
  # Sidebar with controls to select the feature.
  # sidebarLayout(
  #   sidebarPanel(
  # Dropdown menu input for type of coral.
  # selectInput(inputId = "feature", label="Listing Feature:",
  #             c("bc"="blue corals",
  #               "hc"="hard corals",
  #               "sf"="sea fans",
  #               "sp"="sea pens",
  #               "sc"="soft corals")
  #     ),
  #   ),
  # )
)







# Define server logic.
server <- function(input, output) {
  # formulaText <- reactive(input$feature)
  # # Return the formula text for printing as a caption
  # output$caption <- renderText({formulaText()})
  
  # Generate a plot of the requested coral with the choice of smoother.
  output$NYmap <- renderLeaflet({
  #   # check the input for type of coral.
  #   if (input$coral == "blue corals") {
  #     data1 <- data[data$coralType=="blue corals",]
  #   }
  #   else if (input$coral == "hard corals"){
  #     data1 <- data[data$coralType=="hard corals",]
  #   }
  #   else if (input$coral == "sea fans"){
  #     data1 <- data[data$coralType=="sea fans",]
  #   }
  #   else if (input$coral == "sea pens"){
  #     data1 <- data[data$coralType=="sea pens",]
  #   }
  #   else {
  #     data1 <- data[data$coralType=="soft corals",]
  #   }
  #   
    m <- leaflet(data = data) 
    m <- addTiles(m) 
    m <- addCircleMarkers(m,lng=data$longitude, lat=data$latitude,clusterOptions = markerClusterOptions(showCoverageOnHover = TRUE))#, label = ~as.character(name))
    m
    # print(m)
  })
  
  # Plot dot density map for price in NY
  output$price_dist <- renderLeaflet({
    # Create a continuous palette function
    priceRangeVals <- factor(c("very high(200-10000)","high(130-200)","medium(90-130)","low(60-90)","very low(0-60)"),
                             levels = c("very high(200-10000)","high(130-200)","medium(90-130)","low(60-90)","very low(0-60)"))
    
    pal <- colorFactor(
      palette = topo.colors(5),
      domain = data$price_range,
      levels = priceRangeVals ,
      reverse = F)
    
    
    m <- leaflet(data = data,options = leafletOptions(preferCanvas = TRUE)) 
    # map won't update tiles until zoom is done
    m <- addTiles(m)
    m <- addCircles(m, lng=data$longitude, lat=data$latitude, weight = 1,color = ~pal(price_range))
    m <- addLegend(m,"topright", pal = pal, values = priceRangeVals, labels=priceRangeVals,
                   title = "Price ranges in USD",
                   opacity = 1)
    m
    
  })
  
  # Plot bubble chart
  output$bubble <- renderPlot({
    ggplot(log_data, aes(x=log_price, y=all_log_total_revenue, size = minnts_range,colour = review_range)) +
      geom_point(alpha=0.7)
    
    
  })
}

shinyApp(ui, server)

#---------------------------------------------------------------------------------------