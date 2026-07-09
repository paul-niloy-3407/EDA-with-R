#List of required packages
packages <- c(c("rvest", "httr", "xml2", "dplyr","writexl","progress"))

# Install any packages that are not already installed
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

url <- "https://www.prothomalo.com/"
page <- read_html(url)

# Select <a> inside <h3>
nodes <- page %>% html_elements("h3 a")

# Extract title (text)
titles <- nodes %>% html_text(trim = TRUE)

# Extract links (href)
links <- nodes %>% html_attr("href")

# Convert relative URLs to absolute
links <- url_absolute(links, url)

# Combine into dataframe
title_link <- data.frame(
  title = titles,
  link = links,
  stringsAsFactors = FALSE
)
title_link <- title_link %>%
  filter(!is.na(link), title != "")
head(title_link)

get_article <- function(link) {
  tryCatch({
    
    page <- read_html(link)
    
    # Title (usually <h1>)
    title <- page %>%
      html_element("h1") %>%
      html_text(trim = TRUE)
    
    # Content (paragraphs)
    content <- page %>%
      html_elements("p") %>%
      html_text(trim = TRUE) %>%
      paste(collapse = " ")
    
    data.frame(
      title = title,
      content = content,
      link = link,
      stringsAsFactors = FALSE
    )
    
  }, error = function(e) {
    message(paste("Failed:", link))
    return(NULL)
  })
}

pb <- progress_bar$new(
  format = "  Scraping [:bar] :percent | :current/:total",
  total = length(title_link$link),
  clear = FALSE,
  width = 60
)

articles <- list()

for (i in seq_along(title_link$link)) {
  
  Sys.sleep(2)
  articles[[i]] <- get_article(title_link$link[i])
  
  pb$tick()
}

articles_df <- dplyr::bind_rows(articles)

articles_df <- articles_df %>%
  filter(!is.na(content), content != "")

articles_df$content <- substr(articles_df$content, 1, 32760)

filename <- paste0(
  "prothomalo_articles_",
  format(Sys.time(), "%Y-%m-%d_%H-%M-%S"),
  ".xlsx"
)

write_xlsx(articles_df, filename)
getwd()