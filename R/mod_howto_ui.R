mod_howto_ui <- function() {
  shiny::tagList(
    box(
      title = "Create network",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('To create a network, you just simply click on create new network in 
        shiny app. Further, you select number of sets, number of vertices in 
        each set, and weights of the edges in each set. Numbers which represent
        the weights of the edges are in the sense "How many people could go through
        each edge in time".
        '),
      img(src="img/create_net.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
      ),
    box(
      title = "Add fully connected sets",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('By the button "add fully connected" you are able to create a new level 
        of sets which will be fully connected to the sets of the previous level.
        Further, you select number of sets, number of vertices in each set, and
        weights of the edges in each set. Numbers which represent
        the weights of the edges are in the sense "How many people could go through
        each edge in time".' 
      ),
      img(src="img/add_fully.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
    ),
    box(
      title = "Add custom sets",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('By the button "add level set" you create a new level of sets in which 
        you define mapping of the new vertices to the sets of the previous level.
        New vertex is mapped to the defined set of the previous level like fully
        connected. Further, you select number of sets, number of vertices in each
        set, and weights of the edges in each set. Numbers which represent
        the weights of the edges are in the sense "How many people could go through
        each edge in time".'
      ),
      img(src="img/add_sets.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
    ),
    box(
      title = "Add exit",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('To add an exit vertex, you use the button "add exit". The exit (or sink
        node) will be added and all works on the given network is done.'
      ),
      img(src="img/add_exit.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
    ),
    box(
      title = "Remove level",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('If there is some mistake in the network, you can remove last level by
        clicking on "remove last level".'
      ),
      img(src="img/remove.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
    ),
    box(
      title = "Save network",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('You can save an existing network by clicking on "save network as csv".'
      ),
      img(src="img/save_net.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
    ),
    box(
      title = "Load network",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('You can import an existing network by clicking on "browse".'
      ),
      img(src="img/load_net.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
    ),
    box(
      title = "Start simulation",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = TRUE,
      closable = FALSE,
      p('To start simulation, you define number of people wich will go through 
        the graph, click on "compute" button, and click on "play" at the bottom 
        a network window. Cyan dots represents the free nodes in given time, and 
        red nodes the full ones.'
      ),
      img(src="img/sim.gif", width='100%', style="max-width: 800px; 
          display: block; margin-left: auto; margin-right: auto;
          border: 2px solid #ddd; border-radius:0.4rem")
    )
  )
}