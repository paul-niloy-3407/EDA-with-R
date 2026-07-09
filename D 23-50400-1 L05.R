
# Required packages
packages <- c(
  "rvest",
  "httr",
  "xml2",
  "dplyr",
  "writexl",
  "progress",
  "stringr"
)

installed_packages <- rownames(installed.packages())

for(pkg in packages){
  if(!(pkg %in% installed_packages)){
    install.packages(pkg)
  }
  library(pkg, character.only=TRUE)
}



url <- "https://www.bbc.com/bengali"

page <- read_html(url)

# Get article links from homepage
nodes <- page %>%
  html_elements("a")

titles <- nodes %>%
  html_text(trim=TRUE)

links <- nodes %>%
  html_attr("href")

# Convert relative links to absolute
links <- url_absolute(links, url)

title_link <- data.frame(
  title=titles,
  link=links,
  stringsAsFactors=FALSE
)

# Keep only actual BBC news article links
title_link <- title_link %>%
  filter(
    !is.na(link),
    title!="",
    str_detect(link,"bbc.com/bengali"),
    !duplicated(link)
  )

print(head(title_link))
cat("Articles found:", nrow(title_link), "\n")



get_article <- function(link){
  
  tryCatch({
    
    page <- read_html(link)
    
    # Article title
    article_title <- page %>%
      html_element("h1") %>%
      html_text(trim=TRUE)
    
    # BBC article body paragraphs
    article_text <- page %>%
      html_elements("main p") %>%
      html_text(trim=TRUE) %>%
      paste(collapse=" ")
    
    if(article_text==""){
      article_text <- page %>%
        html_elements("article p") %>%
        html_text(trim=TRUE) %>%
        paste(collapse=" ")
    }
    
    data.frame(
      title=article_title,
      content=article_text,
      link=link,
      stringsAsFactors=FALSE
    )
    
  }, error=function(e){
    
    message(paste("Failed:",link))
    return(NULL)
    
  })
  
}


pb <- progress_bar$new(
  format=" Scraping [:bar] :percent | :current/:total",
  total=length(title_link$link),
  clear=FALSE,
  width=60
)

articles <- list()


for(i in seq_along(title_link$link)){
  
  Sys.sleep(2)   # polite delay
  
  articles[[i]] <- get_article(
    title_link$link[i]
  )
  
  pb$tick()
}


articles_df <- bind_rows(articles)

articles_df <- articles_df %>%
  filter(
    !is.na(content),
    content!=""
  )

# Excel character limit
articles_df$content <- substr(
  articles_df$content,
  1,
  32760
)


filename <- paste0(
  "bbc_bangla_articles_",
  format(Sys.time(),"%Y-%m-%d_%H-%M-%S"),
  ".xlsx"
)

write_xlsx(
  articles_df,
  filename
)

cat("\nSaved:",filename,"\n")
getwd()