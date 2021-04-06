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

# Acknowledgment

This project has received funding from the European High-Performance Computing Joint Undertaking (JU) under grant agreement No 951732.
The JU receives support from the European Union`s Horizon 2020 research and innovation programme and Germany, Bulgaria, Austria, Croatia,
Cyprus, the Czech Republic, Denmark, Estonia, Finland, Greece, Hungary, Ireland, Italy, Lithuania, Latvia, Poland, Portugal, Romania, Slovenia,
Spain, Sweden, the United Kingdom, France, the Netherlands, Belgium, Luxembourg, Slovakia, Norway, Switzerland, Turkey, Republic of North Macedonia,
Iceland, Montenegro.