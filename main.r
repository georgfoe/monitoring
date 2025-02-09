library(httr)

url <- "https://ntfy.georgfoerster.info/alerts"
message <- "Hallo Welt!"

response <- POST(url, body = message, encode = "text")

if (status_code(response) == 200) {
  print("Nachricht erfolgreich gesendet.")
} else {
  print(paste("Fehler:", status_code(response)))
}
