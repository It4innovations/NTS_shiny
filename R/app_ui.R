#' The application User-Interface
#'
#' @param request Internal parameter for `{shiny}`.
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom bs4Dash dashboardPage dashboardHeader dashboardBrand dashboardSidebar menuItem sidebarMenu dashboardBody tabItems tabItem
#' @noRd
app_ui <- function(request) {
  
  shiny::tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # bs4Dash page ----
    bs4Dash::dashboardPage(
      header = bs4Dash::dashboardHeader(
        title = bs4Dash::dashboardBrand(title = "Vaccination center"),
        tagList(
          fluidRow(
            img(src = 'img/IT4I_with_borders_EN.svg', height = "60px"),
            href = "https://www.it4i.cz",
            target = "_parent"
          )
        )
      ),
      # bs4Dash sidebar ----
      sidebar = bs4Dash::dashboardSidebar(
        width = 250,
        compact = TRUE,
        skin = "light",
        status = "primary",
        expand_on_hover = FALSE,
        disable = FALSE,
        bs4Dash::sidebarMenu(
          id = "sidebarState",
          bs4Dash::menuItem(
            text = "About App",
            tabName = "aboutapp",
            icon = shiny::icon("info-circle")
          ),
          bs4Dash::menuItem(
            text = "Setup network",
            tabName = "network",
            icon = shiny::icon("project-diagram")
          ),
          bs4Dash::menuItem(
            text = "Simulation",
            tabName = "simulation",
            icon = shiny::icon("play-circle")
          ),
          bs4Dash::menuItem(
            text = "Credits",
            tabName = "credits",
            icon = shiny::icon("copyright")
          )
        )
      ),
      # bs4Dash body ----
      body = bs4Dash::dashboardBody(
        bs4Dash::tabItems(
          bs4Dash::tabItem(tabName = "aboutapp",
                           mod_info_ui()),
          bs4Dash::tabItem(tabName = "network",
                           mod_network_ui("network_1")),
          bs4Dash::tabItem(tabName = "simulation",
                           mod_simulator_ui("simulator_1")),
          bs4Dash::tabItem(tabName = "credits",
                           mod_credits_ui())
        )
      )
    )
  )
}

#' Add external Resources to the Application
#'
#' This function is internally used to add external
#' resources inside the Shiny application.
#'
#' @import shiny
#' @import shinyWidgets
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @importFrom shinyjs useShinyjs
#' @importFrom waiter use_waiter
#' @noRd
golem_add_external_resources <- function() {
  add_resource_path('www', app_sys('app/www'))
  add_resource_path('img', app_sys('app/img'))
  
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "styles.css"),
    favicon(),
    bundle_resources(path = app_sys('app/www'),
                     app_title = 'msk.covid.app'),
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert()
    shinyjs::useShinyjs(),
    shinyWidgets::useSweetAlert(theme = "bootstrap-4",
                                ie = TRUE),
    waiter::use_waiter(),
    tags$style(
      "
      .progress-bar-danger {background-color: #f61414 !important}
      .progress-bar-warning {background-color: #FF5A1D !important}
      .progress-bar-success {background-color: #16e343 !important}
      .progress-bar {border-radius: 2em !important}
      .progress {border-radius: 2em !important}
      "
    )
  )
}
