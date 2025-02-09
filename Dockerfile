# Verwende eine einfache R Installation
FROM rocker/r-ver:latest

# Aktualisiere die Paketlisten und installiere benötigte Pakete
RUN apt-get update -qq && \
    apt-get install -y libssl-dev libcurl4-gnutls-dev zlib1g-dev libsodium-dev cron && \
    rm -rf /var/lib/apt/lists/*

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

# Erstelle den Crontab-Eintrag
RUN echo "*/1 * * * * root Rscript /app/main.r" > /etc/cron.d/maincron

# Setze Berechtigungen für den Crontab
RUN chmod 0644 /etc/cron.d/maincron && crontab /etc/cron.d/maincron

# Starte den Cron-Dienst im Vordergrund
CMD ["Rscript", "/app/main.r"]
