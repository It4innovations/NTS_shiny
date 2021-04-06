#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # List the first level callModules here

  # Create common reactive variables
  r <- shiny::reactiveValues(
    df_network = NULL
  )
  
  # Network page
  mod_network_server(id = "network_1",
                     r)
  # Simulator page
  mod_simulator_server(id = "simulator_1",
                       r)
}
