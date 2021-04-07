NTS Shiny - Network traversal simulator shiny application
==========================
  
This package contains shiny application to define a network with source vertice, intermediary vertices, and exit vertice.
You can simulate flow through this network where edges determine the time of the traversal from one vertice to next one.
It was initially created to simulate vaccine centre as a graph and then calculate the human flow through the centre.

The application is hosted at [IT4Innovations shiny server](https://shiny.vsb.cz/app/nts-shiny).

To run the application You will need [bs4Dash version 2.0](https://github.com/RinteRface/bs4Dash) and [NTS package](https://github.com/It4innovations/NTS).

You can install this package using `devtools` package:
```
devtools::install_github("It4innovations/NTS_shiny")
```
or `remotes` package:
  
  ```
remotes::install_github("It4innovations/NTS_shiny")
```

You can also create this application in a docker container by running in the application directory. The dockerfile is included.
```
sudo docker build . -t tag_name
```

# How to use application
## Create network
To create a network, you just simply click on create new network in shiny app. Further, you select number of sets, number of vertices in each set, and weights of the edges in each set.

![](https://github.com/It4innovations/NTS_shiny/blob/dev/create_net.gif)

## Add fully connected sets
By the button "add fully connected" you are able to create a new level of sets which will be fully connected to the sets of the previous level. Further, you select number of sets, number of vertices in each set, and weights of the edges in each set.

![](https://github.com/It4innovations/NTS_shiny/blob/dev/add_fully.gif)

## Add custom sets
By the button "add level set" you create a new level of sets in which you define mapping of the new vertices to the sets of the previous level. New vertex is mapped to the defined set of the previous level like fully connected. Further, you select number of sets, number of vertices in each set, and weights of the edges in each set.

![](https://github.com/It4innovations/NTS_shiny/blob/dev/add_sets.gif)

## Add exit node
To add an exit vertex, you use the button "add exit". The exit (or sink node) will be added and all works on the given network is done.

![](https://github.com/It4innovations/NTS_shiny/blob/dev/add_exit.gif)

## Remove level
If there is some mistake in the network, you can remove last level by clicking on "remove last level".

![](https://github.com/It4innovations/NTS_shiny/blob/dev/remove.gif)

## Save network
You can save an existing network by clicking on "save network as csv".

![](https://github.com/It4innovations/NTS_shiny/blob/dev/save_net.gif)

## Load network
You can import an existing network by clicking on "browse".

![](https://github.com/It4innovations/NTS_shiny/blob/dev/load_net.gif)

## Start simulation
To start simulation, you define number of people wich will go through the graph, click on "compute" button, and click on "play" at the bottom a network window. Cyan dots represents the free nodes in given time, and red nodes the full ones. 

![](https://github.com/It4innovations/NTS_shiny/blob/dev/sim.gif)

# Acknowledgment

This project has received funding from the European High-Performance Computing Joint Undertaking (JU) under grant agreement No 951732.
The JU receives support from the European Union`s Horizon 2020 research and innovation programme and Germany, Bulgaria, Austria, Croatia,
Cyprus, the Czech Republic, Denmark, Estonia, Finland, Greece, Hungary, Ireland, Italy, Lithuania, Latvia, Poland, Portugal, Romania, Slovenia,
Spain, Sweden, the United Kingdom, France, the Netherlands, Belgium, Luxembourg, Slovakia, Norway, Switzerland, Turkey, Republic of North Macedonia,
Iceland, Montenegro.
