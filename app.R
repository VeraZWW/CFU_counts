#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)

ui <- fluidPage(

    # Application title
    titlePanel("CFU count tool"),

    # Sidebar with a slider input for number of bins 
    sidebarLayout(
        sidebarPanel(
            actionButton("start", "Start")
        ),

        # Show a plot of the generated distribution
        mainPanel(
           textOutput("test app")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  # Define paths for ImageJ and macro script
  imagej_path <- "/Applications/Fiji.app/Contents/MacOS/ImageJ-macosx"
  # for macros without specified path
  image_dir <- "/Users/verasysoeva/Downloads/2025_01_09_Ssobrinus_dilution"
  macro_path <- "/Users/verasysoeva/Documents/Dental_project/MacroForSobrinus.ijm"
    observeEvent(input$start, {
      # call Fiji and run the macro
      system2(imagej_path, args = c("-macro", macro_path, image_dir), 
              stdout = "imagej_log.txt", stderr = "imagej_error.txt", wait = TRUE)
      
      
     # notes
      # it works
      # select directory from ui -> pass as an argument
      # set dilutions, volume -> pass as an argument
      # save the result measurement as csv in the directory
      # save binary images and countings as images? in the directory
      # open the csv file and convert colonies to cfu per ml
      # create pdf with the report
     # report finish
      cat("ImageJ macro executed.\n")
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
