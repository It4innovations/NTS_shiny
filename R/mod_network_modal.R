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
network_form <- function(r,
                         ns,
                         output){
  shiny::showModal(shiny::modalDialog(
    tippy::with_tippy(
      shinyWidgets::pickerInput(
          inputId = ns("set_count"),
          label = "Number of sets",
          choices = 1:10,
          selected = 1
        ),
        tooltip = "Set number of sets for mapping to the next set."
    ),
    shiny::fluidRow(
      column(
        width = 4,
        tippy::with_tippy(
          shiny::numericInput(
            inputId = ns("add_set"),
            label = "Vertices count.",
            value = 1,
            min = 1,
            max = 200,
            step = 1
          ),
          tooltip = "Set number of vertices for given set."
        )
      ),
    column(
      width = 4,
      tippy::with_tippy(
        shiny::numericInput(
          inputId = ns("add_weight"),
          label = "Weight.",
          value = 1,
          min = 1,
          max = 2000,
          step = 1
        ),
        tooltip = "Set weight for given set."
      )
    ),
    column(
      width = 4,
      tippy::with_tippy(
      shinyjs::hidden(
        shinyWidgets::pickerInput(
          inputId = ns("add_previous_set"),
          label = "Previous set.",
          choices = "",
          multiple = TRUE
        )
      ),
      tooltip = "Select previous set you want to connect."
      )
    ),
    plotly::plotlyOutput(ns("network2"))),
    size = "l",
    easyClose = FALSE,
    footer = tagList(
      actionButton(
       inputId = ns("cancel"),
       label = "Cancel"
      ),
      uiOutput(ns("form_buttons"))
    )
  )
  )
}