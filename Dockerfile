FROM rocker/r-ver:4.0.2
RUN apt-get update && apt-get install -y  git-core libcairo2-dev libcurl4-openssl-dev libgit2-dev libicu-dev libssl-dev libxml2-dev make pandoc pandoc-citeproc zlib1g-dev && rm -rf /var/lib/apt/lists/*
RUN echo "options(repos = c(CRAN = 'https://cran.rstudio.com/'), download.file.method = 'libcurl')" >> /usr/local/lib/R/etc/Rprofile.site
RUN R -e 'install.packages("remotes")'
RUN R -e 'remotes::install_github("r-lib/remotes", ref = "97bbf81")'
RUN Rscript -e 'remotes::install_version("magrittr",upgrade="never", version = "2.0.1")'
RUN Rscript -e 'remotes::install_version("rlang",upgrade="never", version = "0.4.10")'
RUN Rscript -e 'remotes::install_version("dplyr",upgrade="never", version = "1.0.2")'
RUN Rscript -e 'remotes::install_version("config",upgrade="never", version = "0.3")'
RUN Rscript -e 'remotes::install_version("shinyjs",upgrade="never", version = "2.0.0")'
RUN Rscript -e 'remotes::install_version("tippy",upgrade="never", version = "0.1.0")'
RUN Rscript -e 'remotes::install_version("thinkr",upgrade="never", version = "0.15")'
RUN Rscript -e 'remotes::install_version("shinyWidgets",upgrade="never", version = "0.5.4")'
RUN Rscript -e 'remotes::install_version("golem",upgrade="never", version = "0.2.1")'
RUN Rscript -e 'remotes::install_github("rstudio/htmltools@ac43afe7b6f58f80234dc7881e9d61c77bf8c3ed")'
RUN Rscript -e 'remotes::install_github("rstudio/jquerylib@94b1a3bdec571b533634cc837bb28960604e8fa2")'
RUN Rscript -e 'remotes::install_github("rstudio/bslib@aa5a8425d527dba500cf9dc41e50950434dd09fb")'
RUN Rscript -e 'remotes::install_github("rstudio/shiny@8395598328b845d67ff72f801c1911675f51ba54")'
RUN Rscript -e 'remotes::install_github("JohnCoene/waiter@7ada4467600f68d47a0925053cbf4dc3ea0d5cee")'
RUN Rscript -e 'remotes::install_github("ropensci/plotly@97096fc99b86a60e6b0f02546d8e4364cd4073f1")'
RUN Rscript -e 'remotes::install_github("It4innovations/NTS@1641586f355aa4410052c49bd085dc7a2854a673")'
RUN Rscript -e 'remotes::install_github("RinteRface/bs4Dash@d8cb044f267abb8162068c29e2d959ba520cd040")'
RUN mkdir /build_zone
ADD . /build_zone
WORKDIR /build_zone
RUN R -e 'remotes::install_local(upgrade="never")'
EXPOSE 3838
CMD  ["R", "-e", "options('shiny.port'=3838,shiny.host='0.0.0.0');msk.covid.app::run_app()"]
