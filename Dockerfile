# Verwende eine einfache R Installation
FROM rocker/r-ver:latest

# Aktualisiere die Paketlisten
RUN apt-get update -qq

# Installiere libssl-dev
RUN apt-get install -y libssl-dev

# Installiere libcurl4-gnutls-dev
RUN apt-get install -y libcurl4-gnutls-dev

# Installiere zlib1g-dev
RUN apt-get install -y zlib1g-dev

# Installiere libsodium-dev
RUN apt-get install -y libsodium-dev

# Schreibe die Funktion in die .Rprofile
RUN echo "install_and_check <- function(pkg) { \
              if (!requireNamespace(pkg, quietly = TRUE)) { \
                  install.packages(pkg, repos='http://cran.us.r-project.org'); \
                  if (!requireNamespace(pkg, quietly = TRUE)) stop(paste('Failed to install', pkg)); \
              } \
          }" >> ~/.Rprofile

# Installiere die benötigten Pakete mit der Funktion
RUN R -e "install_and_check('httr')"

# Arbeitsverzeichnis setzen
WORKDIR /app

# Kopiere das R-Skript
COPY main.r /app/main.r

# Starte das Skript beim Container-Run
CMD ["Rscript", "/app/main.r"]