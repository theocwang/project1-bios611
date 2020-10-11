FROM rocker/verse
MAINTAINER Theodore Wang <theowang@live.unc.edu>
RUN R -e "install.packages('readxl')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('janitor')"
RUN R -e "install.packages('gmb')"
RUN apt-get install ne
