library(httr)


alert <- function(msg) {

# ntfy Server-URL
ntfy_url <- "https://ntfy.georgfoerster.info/alerts"

# Nachricht senden
response <- POST(
  url = ntfy_url,
  body = msg,
  encode = "raw",
  content_type("text/plain")
)
}

alert("Jetzt wurde der Container geupdated.")
