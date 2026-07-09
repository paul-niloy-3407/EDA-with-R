
library(readxl)
library(dplyr)
library(stringr)
library(tm)
library(wordcloud)
library(SnowballC)

setwd("C:/Users/Niloy Paul/Desktop/WordClouds")

files <- list.files(
  pattern="^bbc_bangla_articles.*\\.xlsx$",
  full.names=TRUE
)

if(length(files)==0){
  stop("No BBC Bangla Excel file found.")
}

latest_file <- files[
  which.max(file.info(files)$mtime)
]

cat("Reading:",latest_file,"\n")

df <- read_excel(latest_file)



df <- df %>%
  mutate(
    category = str_extract(
      link,
      "bengali/[^/?]+"
    ) %>%
      str_replace("bengali/","")
  )

table(df$category)


bangla_stopwords <- c(
  "এই","ওই","একটি","এবং","করে","করা",
  "তিনি","তারা","আমি","আমরা","আপনি",
  "যে","যা","তার","তাদের","ছিল","হয়",
  "হয়ে","থেকে","দিকে","জন্য","সঙ্গে",
  "কিন্তু","আর","বা","না","তো","এ",
  "ও","ই","কি","কে","যখন","পর",
  "বলে","করেন","করেছে","হচ্ছে"
)



clean_corpus <- function(text_vector){
  
  text_vector <- na.omit(text_vector)
  
  corpus <- VCorpus(
    VectorSource(text_vector)
  )
  
  corpus <- tm_map(
    corpus,
    content_transformer(tolower)
  )
  
  corpus <- tm_map(
    corpus,
    removePunctuation
  )
  
  corpus <- tm_map(
    corpus,
    removeNumbers
  )
  
  corpus <- tm_map(
    corpus,
    removeWords,
    bangla_stopwords
  )
  
  corpus <- tm_map(
    corpus,
    stripWhitespace
  )
  
  return(corpus)
}


categories <- unique(df$category)

for(category_name in categories){
  
  cat(
    "\nCreating:",
    category_name,
    "\n"
  )
  
  cat_data <- df %>%
    filter(
      category==category_name
    )
  
  if(nrow(cat_data)==0) next
  
  corpus <- clean_corpus(
    cat_data$content
  )
  
  dtm <- TermDocumentMatrix(corpus)
  
  m <- as.matrix(dtm)
  
  word_freq <- sort(
    rowSums(m),
    decreasing=TRUE
  )
  
  if(length(word_freq)==0) next
  
  png(
    paste0(
      "bbc_wordcloud_",
      category_name,
      ".png"
    ),
    width=1200,
    height=900
  )
  
  wordcloud(
    words=names(word_freq),
    freq=word_freq,
    max.words=100,
    random.order=FALSE
  )
  
  title(
    paste(
      "BBC Bangla -",
      category_name
    )
  )
  
  dev.off()
}


list.files(
  pattern="bbc_wordcloud_.*\\.png$"
)

getwd()