mod_info_ui <- function() {
  shiny::tagList(
    # box(
    #   title = "About App",
    #   status = "primary",
    #   solidHeader = TRUE,
    #   width = 12,
    #   collapsible = FALSE,
    #   closable = FALSE,
    #   h4('Introduction'),
    #   p('Application was created as a simulator of the COVID vaccine centre in 
    #     Moravia-Silesian region Czech republic. Due to a fact that the COVID is
    #     the global world problem, we provide this "simple to use" app to all of you.
    #     This simulator may be used to simulate other use cases that are based on 
    #     `traveling` from one point to other through different routes. Most of the
    #     queue problems should be possible to simulate using this application.
    #     The backend is mainly the NTS package.
    #     '),
    #   hr(),
    #   h4('Setup Network'),
    #   p('In Setup Network tab, you can create a new graph or import existing graph
    #     from .csv file in the given form. You are able to add fully connected nodes
    #     in new level, create customised sets of nodes in the level, simply add exit
    #     (sink) node, and remove last existing level, if there is some mistake. Moreover,
    #     there is a possibility to export created graph into .csv file. For each level
    #     maximum 10 sets are allowed. Further, there is an option to set a number of nodes
    #     by set and option to set weights of the edges to each created node.'),
    #   hr(),
    #   h4('Simulation'),
    #   p('In Simulation tab, you can test permeability of the created graph. You
    #     simply configure how many people will go through the graph and then click
    #     on compute button. Cyan dots represent free nodes, and red dots full ones, 
    #     in the given time.
    #     '),
    #   hr(),
    #   h4('Future work'),
    #   p('We are planning on improving both the NTS package and this application.
    #     For example we would like to provide more functionalities from the NTS package
    #     such as `events` creation and management.
    #     '),
    #   hr(),
    #   h4('Github refences'),
    #   p('You can find this application and NTS package on github.'),
    #   a("Simulator app",
    #     href = "https://github.com/It4innovations/",
    #     target = "_parent"),
    #   br(),
    #   a("NTS package",
    #     href = "https://github.com/It4innovations/",
    #     target = "_parent")
    # ),
    
    box(
      title = "Introduction",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('Application was created as a simulator of the COVID vaccine centre in 
        Moravia-Silesian region Czech republic. Due to a fact that the COVID is
        the global world problem, we provide this "simple to use" app to all of you.
        This simulator may be used to simulate other use cases that are based on 
        `traveling` from one point to other through different routes. Most of the
        queue problems should be possible to simulate using this application.
        The backend is mainly the NTS package.
        ')),
      box(
        title = "Setup",
        status = "primary",
        solidHeader = TRUE,
        width = 12,
        collapsible = TRUE,
        closable = FALSE,
      p('In Setup Network tab, you can create a new graph or import existing graph
        from .csv file in the given form. You are able to add fully connected nodes
        in new level, create customised sets of nodes in the level, simply add exit
        (sink) node, and remove last existing level, if there is some mistake. Moreover,
        there is a possibility to export created graph into .csv file. For each level
        maximum 10 sets are allowed. Further, there is an option to set a number of nodes
        by set and option to set weights of the edges to each created node.'
        )),
    box(
      title = "Simulation",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('In Simulation tab, you can test permeability of the created graph. You
        simply configure how many people will go through the graph and then click
        on compute button. Cyan dots represent free nodes, and red dots full ones, 
        in the given time.
        ')),
    box(
      title = "Future work",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('We are planning on improving both the NTS package and this application.
        For example we would like to provide more functionalities from the NTS package
        such as `events` creation and management.
        ')),
    box(
      title = "Github",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('You can find this application and NTS package on github. You can also submit issues there.'),
      a("Simulator app",
        href = "https://github.com/It4innovations/NTS_shiny",
        target = "_parent"),
      br(),
      a("NTS package",
        href = "https://github.com/It4innovations/NTS",
        target = "_parent")
    )
  )
}