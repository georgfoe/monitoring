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

iteration = 0

while (TRUE) {

  alert(sprintf("Iteration Nr. %i", iteration))

}


