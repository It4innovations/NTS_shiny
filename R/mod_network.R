#' network UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import shiny
#' @import shinyWidgets
#' @importFrom bs4Dash box
mod_network_ui <- function(id) {
  ns <- NS(id)
  shiny::tagList(
    # shinyWidgets::progressBar(
    #   id = ns("progress_bar"),
    #   value = 10,
    #   status = "danger",
    #   striped = TRUE
    # ),
    fluidRow(
      # Column 1 ----
      column(
        width = 4,
        box(
          title = "Settings",
          status = "primary",
          solidHeader = TRUE,
          width = 12,
          collapsible = FALSE,
          closable = FALSE,
          uiOutput(ns("network_buttons")),
          h4("Import network"),
          shiny::fileInput(ns("upload"), label = NULL),
          div(style = "margin-top: -20px"),
          hr(),
          h4("New network"),
          actionButton(
            inputId = ns("new_network"),
            label = "Create new network",
            style = "width: 100%;"
          ),
          shinyjs::hidden(
            div(id = ns("header_mod_div"),
              hr(),
              h4("Modify network"),
            )
          ),
          shinyjs::hidden(
            div(id = ns("add_div"),
                actionButton(
                  inputId = ns("add_fully_connected"),
                  label = "Add fully connected",
                  style = "width: 100%; margin-bottom: 1%;"
                ),
                actionButton(
                  inputId = ns("add_level_set"),
                  label = "Add level set",
                  style = "width: 100%; margin-bottom: 1%;"
                ),
                actionButton(
                  inputId = ns("add_exit"),
                  label = "Add exit",
                  style = "width: 100%;"
                ),
                hr()
              )
          ),
          shinyjs::hidden(
            div(id = ns("rem_div"),
                actionButton(
                  inputId = ns("remove_level"),
                  label = "Remove last level",
                  style = "width: 100%; margin-bottom: 1%;"
                ),
             )
          ),
          shinyjs::hidden(
            div(id = ns("save_div"),
                hr(),
                h4("Save network"),
                shiny::downloadButton(
                  outputId = ns("save_network"),
                  label = "Save network as CSV",
                  style = "width: 100%;"
                )
            ) 
          )
        )
      ),
      # Column 2 -----
      column(
        width = 8,
        box(
          title = "Network",
          status = "primary",
          solidHeader = TRUE,
          width = 12,
          collapsible = FALSE,
          closable = FALSE,
          plotly::plotlyOutput(ns("network"))
        )
      )
    )
  )
}

#' network Server Function
#'
#' @noRd
#'
#' @import shiny
#' @import shinyWidgets
#' @importFrom plotly renderPlotly
#' @importFrom utils write.csv read.csv
#' @importFrom NTS create_source add_exit add_level_set add_fully_connected
#' @importFrom golem print_dev
#' @importFrom rlang .data
#' @importFrom dplyr pull filter
mod_network_server <- function(id,
                               r) {
  moduleServer(id,
               function(input, output, session) {
                 ns <- session$ns
                 
                 # Setup ----
                 
                 r_network <- shiny::reactiveValues(
                   add_sets_count = 1,
                   # add_sets_counter = 0,
                   previous_sets = list(1),
                   sets = 1,
                   weights = 1,
                   add_page = 0,
                   add_class = "create",
                   create_counter = 0,
                   add_fully_connected_counter = 0,
                   add_level_set_counter = 0,
                   df_network_temp = NULL
                   # add_sets_count = 1,
                   # add_proceed = TRUE,
                   # network = NULL
                 )
                 
                 # Buttons UI ----
                 
                 observeEvent(r$df_network,
                              {
                                
                                if (is.null(r$df_network)) {
                                  status <- "danger"
                                  value <- 10
                                } else if ("exit" %in% r$df_network$to) {
                                  status <- "success"
                                  value <- 100
                                } else {
                                  status <- "warning"
                                  value <- 50
                                }
                                
                                # shinyWidgets::updateProgressBar(session = session,
                                #                                 id = "progress_bar",
                                #                                 value = value,
                                #                                 status = status)
                                
                                if (!("exit" %in% r$df_network$to) && shiny::isTruthy(r$df_network)) {
                                  shinyjs::show(
                                    id = "add_div"
                                  )
                                }
                                else {
                                  shinyjs::hide(
                                    id = "add_div"
                                  )
                                }
                                  
                                if (shiny::isTruthy(r$df_network)) {
                                  shinyjs::show(
                                    id = "header_mod_div"
                                  )
                                  shinyjs::show(
                                    id = "rem_div"
                                  )
                                  shinyjs::show(
                                    id = "save_div"
                                  )
                                } else {
                                  shinyjs::hide(
                                    id = "header_mod_div"
                                  )
                                  shinyjs::hide(
                                    id = "rem_div"
                                  )
                                  shinyjs::hide(
                                    id = "save_div"
                                  )
                                }
                              },
                              ignoreNULL = FALSE)

                 observeEvent(
                   {
                     input$new_network
                     input$add_fully_connected
                     input$add_level_set
                     TRUE
                   },
                   priority = 100,
                   {
                     if (r_network$create_counter < input$new_network) {
                       r_network$add_class <- "new"
                     }
                     if (r_network$add_fully_connected_counter < input$add_fully_connected) {
                       r_network$add_class <- "fully_connected"
                     }
                     if (r_network$add_level_set_counter < input$add_level_set) {
                       r_network$add_class <- "level_set"
                     }
                   }
                 )
                 
                 
                 # Form buttons ----
                 
                 output$form_buttons <- renderUI(
                  {  
                    output <- shiny::tagList()
                      if (r_network$add_page > 1) {
                       output <- shiny::tagAppendChild(output,
                          actionButton(
                           inputId = ns("previous_source"),
                           label = "Previous set"
                         )
                       )
                    }
                      if (r_network$add_page < as.numeric(input$set_count)) {
                        output <- shiny::tagAppendChild(output,
                         actionButton(
                           inputId = ns("next_source"),
                           label = "Next set"
                         )
                        )
                    }
                      if (r_network$add_page == as.numeric(input$set_count)) {
                        output <- shiny::tagAppendChild(output,
                         actionButton(
                           inputId = ns("accept_source"),
                           label = "Finish"
                         )
                        )
                      }
                    return(output)
                  }
                 )
                 
                 # Create network ----
                 shiny::observeEvent(
                   {input$new_network
                    input$add_fully_connected
                    input$add_level_set
                    TRUE
                    },
                              {
                                # if (!is.null(r$df_network)) {
                                #   shinyWidgets::ask_confirmation(
                                #     inputId = ns("confirm_new"),
                                #     title = "Network already exists",
                                #     text = "Do You want to overwrite existing network?",
                                #     btn_label = c("No", "Yes")
                                #   )
                                # }
                                
                                # if (!is.null(r$df_network)) {
                                #   if (input$confirm_new) {
                                #     network_form(r,
                                #                         ns)
                                #   }
                                # } else {
                                network_form(r,
                                             ns,
                                             output$network2)
                                
                                if (r_network$add_level_set_counter < input$add_level_set) {
                                  shinyjs::show(id = "add_previous_set")
                                  shinyWidgets::updatePickerInput(
                                    session = session,
                                    inputId = "add_previous_set",
                                    choices = unique(r$df_network$set[r$df_network$level == max(r$df_network$level)]),
                                    selected = 1
                                  )
                                }
                                  r_network$sets <- 1
                                  r_network$weights <- 1
                                  r_network$previous_sets <- list(1)
                                # }
                              },
                   ignoreInit = TRUE)
                 
                 # Form buttons events ----
                 shiny::observeEvent(input$set_count,
                              {
                                print(as.numeric(input$set_count))
                                print("observe add_sets")
                                r_network$add_page <- 1
                                if (r_network$add_class == "level_set") {
                                  r_network$previous_sets <- r_network$previous_sets[1]#r_network$previous_sets[1:min(length(r_network$previous_sets), input$set_count)]
                                }
                                r_network$sets <- r_network$sets[1]#r_network$sets[1:min(length(r_network$sets), input$set_count)]
                                r_network$weights <- r_network$weights[1]#r_network$weights[1:min(length(r_network$weights), input$set_count)]
                              })
                 
                 shiny::observeEvent(input$previous_source,
                              {
                               r_network$add_page <- r_network$add_page - 1 
                               if (r_network$add_class == "level_set") {
                                r_network$previous_sets <- utils::head(r_network$previous_sets, -1)
                               }
                               r_network$sets <- utils::head(r_network$sets, -1)
                               r_network$weights <- utils::head(r_network$weights, -1)
                               # golem::print_dev(r_network$previous_sets)
                               
                               golem::print_dev("previous")
                              })
                 
                 shiny::observeEvent(input$next_source,
                              {
                                if (r_network$add_class == "level_set") {
                                  print(input$add_previous_set)
                                  r_network$previous_sets <- append(r_network$previous_sets, list(as.numeric(input$add_previous_set)))
                                }
                                r_network$add_page <- r_network$add_page + 1 
                                r_network$sets <- c(r_network$sets, input$add_set)
                                r_network$weights <- c(r_network$weights, input$add_weight)
                                golem::print_dev("next")
                              })
                 
                 shiny::observeEvent(input$add_set,
                                     {
                                       r_network$sets[length(r_network$sets)] <- input$add_set
                                     })
                 
                 shiny::observeEvent(input$add_weight,
                                     {
                                       r_network$weights[length(r_network$weights)] <- input$add_weight
                                     })
                 
                 shiny::observeEvent(input$add_previous_set,
                                     {
                                       # print(unlist(as.numeric(input$add_previous_set)))
                                       # print(length(input$add_previous_set))
                                       # print(r_network[["previous_sets"]][[length(r_network$previous_sets)]])
                                       r_network$previous_sets[length(r_network$previous_sets)] <- list(as.numeric(input$add_previous_set))
                                     })
                 # Cancel modal ----
                 
                 shiny::observeEvent(input$cancel,
                                     {
                                       shiny::removeModal()
                                       
                                       r_network$create_counter <- input$new_network
                                       r_network$add_fully_connected_counter <- input$add_fully_connected
                                       r_network$add_level_set_counter <- input$add_level_set
                                     })
                 
                 # Actually update r$df_network ----
                 
                 shiny::observeEvent({
                   input$accept_source
                   r_network$sets
                   r_network$weights
                   r_network$previous_sets
                   TRUE
                   },
                   priority = 1,
                   {
                    print(r_network$add_class)
                    shiny::req(r_network$sets,
                               r_network$weights)
                     golem::print_dev("update")
                     
                     if (r_network$add_class == "new") {
                       r_network$df_network_temp <- NTS::create_source(r_network$sets,
                                                                r_network$weights)
                       
                     }
                     if (r_network$add_class == "fully_connected") {
                       req(r$df_network)
                       r_network$df_network_temp <- NTS::add_fully_connected(r$df_network,
                                                                              set = r_network$sets,
                                                                              weight = r_network$weights)
                     }
                     if (r_network$add_class == "level_set") {
                         req(r$df_network)
                         r_network$df_network_temp <- NTS::add_level_set(r$df_network,
                                                                          previous_set = r_network$previous_sets,
                                                                          set = r_network$sets,
                                                                          weight = r_network$weights,
                                                                          check_previous = FALSE)
                     }
                   },
                   ignoreInit = TRUE)
                 
                 observeEvent(input$accept_source,
                              {
                                
                                last_level <- max(r_network$df_network_temp$level)
                                prev_level <- last_level - 1
                                # Pick up sets numbering of the last level in the existing network
                                last_level_from <- r_network$df_network_temp %>%
                                  dplyr::filter(.data$level == last_level) %>%
                                  dplyr::pull(.data$from) %>%
                                  unique()
                                prev_level_to <- r_network$df_network_temp %>%
                                  dplyr::filter(.data$level == prev_level) %>%
                                  dplyr::pull(.data$to) %>%
                                  unique()

                                if (length(last_level_from) != length(prev_level_to) && r_network$add_class == "level_set" && last_level != 1) {
                                  shinyWidgets::sendSweetAlert(session = session,
                                                               title = "Error",
                                                               text = "Not all sets have been mapped from.",
                                                               type = "error")
                                }
                                else
                                {
                                  shiny::removeModal()
                                  r$df_network <- r_network$df_network_temp
                                  r_network$create_counter <- input$new_network
                                  r_network$add_fully_connected_counter <- input$add_fully_connected
                                  r_network$add_level_set_counter <- input$add_level_set
                                  r_network$add_class <- "dummy"
                                }
                              },
                              ignoreInit = TRUE,
                              ignoreNULL = TRUE)
                 
                 # Add exit ----
                 
                 shiny::observeEvent(input$add_exit,
                              {
                                shiny::req(r$df_network)
                                
                                if ("exit" %in% r$df_network$to) {
                                  shinyWidgets::sendSweetAlert(session = session,
                                                               title = "Error",
                                                               text = "This network already has an exit.",
                                                               type = "error")
                                  
                                } else {
                                  r$df_network <- NTS::add_exit(r$df_network)
                                }
                              })
                 
                 # Remove last level ----
                 
                 shiny::observeEvent(input$remove_level,
                              {
                                golem::print_dev("remove level")
                                max_level <- max(r$df_network$level)
                                
                                if (max_level == 1) {
                                  r$df_network <- NULL
                                  r_network$add_proceed <- TRUE
                                } else {
                                  r$df_network <- r$df_network %>%
                                    dplyr::filter(.data$level != max_level)
                                }
                              })
                 
                 # Save network ----
                 
                 output$save_network <- downloadHandler(
                   filename = function() {
                     paste("network-", Sys.Date(), ".csv", sep = "")
                   },
                   content = function(file) {
                     utils::write.csv(r$df_network,
                                      file,
                                      row.names = FALSE)
                   }
                 )
                 
                 # Upload network ----
                 
                 shiny::observeEvent(input$upload,
                              {
                              shiny::req(input$upload)
                                r$df_network <- utils::read.csv(input$upload$datapath,
                                                                header = TRUE)
                              })
                 
                 # Plotly ----
                 
                 output$network <- plotly::renderPlotly(
                   {
                    req(r$df_network)
                     NTS::plot_network(r$df_network)
                   })
                 
                 output$network2 <- plotly::renderPlotly(
                   {
                    req(r_network$df_network_temp)
                     NTS::plot_network(r_network$df_network_temp)
                   }
                   )
                 
               })
}


## To be copied in the UI
# mod_network_ui("network_ui_1")

## To be copied in the server
# callModule(mod_network_server, "network_ui_1")
