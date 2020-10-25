FROM rocker/verse
MAINTAINER Theodore Wang <theowang@live.unc.edu>
RUN R -e "install.packages('readxl')"
RUN R -e "install.packages('tidyverse')"
RUN R -e "install.packages('janitor')"
RUN R -e "install.packages('gmb')"
RUN R -e "install.packages('MLmetrics')"
RUN R -e "install.packages('Rtsne')"
RUN apt update -y && apt install -y python3-pip
RUN pip3 install jupyter jupyterlab
RUN pip3 install numpy pandas sklearn plotnine matplotlib pandasql bokeh
RUN apt update && apt-get install -y ne
