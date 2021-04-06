#' simulator UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @import shiny
#' @importFrom bs4Dash box
#' @importFrom plotly renderPlotly
#' @importFrom tippy with_tippy
mod_simulator_ui <- function(id){
  ns <- NS(id)
  tagList(
    # Settings box ----
    box(
      title = "Settings",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = FALSE,
      closable = FALSE,
      #
      shiny::numericInput(
        inputId = ns("input_people"),
        label = "Set the number of people that should enter network.",
        value = 100,
        min = 10,
        max = 5000,
        step = 1
      ),
      # Events planned to be supported in next release
      # actionButton(
      #   inputId = ns("add_event_button"),
      #   label = "Add event"
      # ),
      shiny::actionButton(
        inputId = ns("update"),
        label = "Compute simulation"
      )
    ),
    # Simulation box ----
    box(
      title = "Simulation",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = FALSE,
      closable = FALSE,
      plotly::plotlyOutput(ns("simulation_plot"))
    )
  )
}
    
#' simulator Server Function
#'
#' @noRd 
#' 
#' @import shiny
#' @importFrom magrittr `%>%`
#' @importFrom shinyWidgets show_alert
mod_simulator_server <- function(id,
                                 r) {
  moduleServer(id,
               function(input, output, session) {
                 ns <- session$ns
                 
                 # Setup ----
                 r_simulation <- shiny::reactiveValues(
                   simulation = NULL,
                   animation = NULL
                 )
              
                # Events ----
                # Events planned to be supported in next release
                #  output$event_ui <- event_ui(r,
                #                              ns,
                #                              session)
                # 
                #  
                # observeEvent(input$add_event_button,
                #                    {
                #                      add_event_form(r,
                #                                     ns)
                #                    })
                # 
                # observeEvent(input$cancel,
                #              {
                #                removeModal(session = session)
                #              })
  
                # Check df_network
                 
                 observeEvent(r$df_network,
                              priority = 100,
                              {
                                r_simulation$simulation <- NULL
                                r_simulation$animation <- NULL
                              })
                 
                # Simulation ----
                 observeEvent(input$update, {
                   
                   # Check input_people
                   if (input$input_people > 5000 |
                       input$input_people < 1) {
                     
                     shinyWidgets::show_alert(
                       title = "Error !!",
                       text = "Input people should be integer between 1 and 5000.",
                       type = "error"
                     )
                     
                     input_people <- NULL
                   } else {
                     input_people <- round(input$input_people)
                   }
                   
                   # Check network
                   network_check <- TRUE
                   if (NTS::check_network(r$df_network) > 0) {
                     network_check <- FALSE
                     
                     shinyWidgets::show_alert(
                       title = "Error !!",
                       text = "The network definition is missing exit.",
                       type = "error"
                     )
                   }
                   
                   req(input_people,
                       r$df_network,
                       network_check)
                     res <- NTS::simulate_flow(df_edges = r$df_network,
                                                input_people = input_people)
  
                     r_simulation$simulation <- res[[1]]

                  })
                 
                 
                 observeEvent(r_simulation$simulation,
                              {
                                req(r_simulation$simulation)
                                r_simulation$animation <- 
                                  NTS::animate_simulation(df_edges = r$df_network,
                                                           r_simulation$simulation)
                              })
                 
                 output$simulation_plot <- plotly::renderPlotly(
                   {
                     r_simulation$animation
                   }
                 )
               })
}