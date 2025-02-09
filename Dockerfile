# Basis-Image mit R
FROM rocker/r-ver:latest

# Installiere Abhängigkeiten
RUN R -e "install.packages('httr')"

# Arbeitsverzeichnis setzen
WORKDIR /app

# Kopiere das R-Skript
COPY main.r /app/main.r

# Starte das Skript beim Container-Run
CMD ["Rscript", "/app/main.r"]