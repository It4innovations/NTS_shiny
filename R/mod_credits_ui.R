mod_credits_ui <- function() {
  shiny::tagList(
    box(
      title = "Credits",
      status = "primary",
      solidHeader = TRUE,
      width = 12,
      collapsible = FALSE,
      closable = FALSE,
       p('Application was created by IT4Innovations National Supercomputing center, VSB - Technical University of Ostrava, Czech republic.'),
       hr(),
       h4('Authors'),
       'Tom\u00e1\u0161 Martinovi\u010d', HTML('<a itemprop="sameAs" content="https://orcid.org/0000-0002-0132-1434" href="https://orcid.org/0000-0002-0132-1434" target="orcid.widget" rel="me noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>'),  '<tomas.martinovic@vsb.cz>',
       br(),
       'Judita Buchlovsk\u00e1 Nagyov\u00e1', HTML('<a itemprop="sameAs" content="https://orcid.org/0000-0001-7782-4268" href="https://orcid.org/0000-0001-7782-4268" target="orcid.widget" rel="me noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>'),
       br(),
       'Radek Halfar', HTML('<a itemprop="sameAs" content="https://orcid.org/0000-0003-1453-0101" href="https://orcid.org/0000-0003-1453-0101" target="orcid.widget" rel="me noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>'),
       br(),
       'Ladislav Foltyn', HTML('<a itemprop="sameAs" content="https://orcid.org/0000-0002-2953-1628" href="https://orcid.org/0000-0002-2953-1628" target="orcid.widget" rel="me noopener noreferrer" style="vertical-align:top;"><img src="https://orcid.org/sites/default/files/images/orcid_16x16.png" style="width:1em;margin-right:.5em;" alt="ORCID iD icon"></a>'),
       hr(),
       h4('Acknowledgement'),
       p('This project has received funding from the European High-Performance Computing Joint Undertaking (JU) under grant agreement No 951732. The JU receives support from the European Union`s Horizon 2020 research and innovation programme and Germany, Bulgaria, Austria, Croatia, Cyprus, the Czech Republic, Denmark, Estonia, Finland, Greece, Hungary, Ireland, Italy, Lithuania, Latvia, Poland, Portugal, Romania, Slovenia, Spain, Sweden, the United Kingdom, France, the Netherlands, Belgium, Luxembourg, Slovakia, Norway, Switzerland, Turkey, Republic of North Macedonia, Iceland, Montenegro.')
    )
  )
}