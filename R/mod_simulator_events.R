#' Add form
#'
#' @description Add network form modal.
#'
#' @param r,ns,output Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @import shiny
#' @import shinyWidgets
#' @importFrom tippy with_tippy
add_event_form <- function(r,
                           ns)
{
  
  shiny::showModal(
    shiny::modalDialog(
      tagList(
      shinyWidgets::radioGroupButtons(
          inputId = ns("event_type"),
          label = "Label",
          choices = c("Vertice",
                      "Edge"),
          checkIcon = list(
            yes = icon("ok",
            lib = "glyphicon")),
          status = "primary"
        ),
      uiOutput(ns("event_ui"))
      ),
      size = "l",
      easyClose = FALSE,
      footer = tagList(
        actionButton(
          inputId = ns("cancel"),
          label = "Cancel"),
        actionButton(
          inputId = ns("confirm_event"),
          label = "Finish"
        )
      )
    )
  )
  
}



vertice_ui <- function(r,
                     ns,
                     input,
                     session){
  out <- renderUI(
    tagList(
      numericInput(
        ns("event_value"),
        label = "Value",
        value = 0
      )
    )
  )
    return(out)
}

edge_ui <- function(r,
                    ns,
                    input,
                    session){
  out <- renderUI(
    tagList(
      shinyWidgets::pickerInput(
        ns("from"),
        label = "Edges from",
        choices = "",
        multiple = TRUE
      ),
      shinyWidgets::pickerInput(
        ns("to"),
        label = "Edges to",
        choices = "",
        multiple = TRUE
      )
    )
  )
  return(out)
}