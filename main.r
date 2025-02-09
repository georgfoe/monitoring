library(httr)

# ntfy Server-URL
ntfy_url <- "https://ntfy.georgfoerster.info/test-topic"

# Nachricht senden
response <- POST(
  url = ntfy_url,
  body = "Testnachricht von R",
  encode = "raw",
  content_type("text/plain")
)

# Response prüfen
print(content(response, as = "text"))