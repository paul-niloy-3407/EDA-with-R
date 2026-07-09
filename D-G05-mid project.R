# Install if not installed
install.packages("tidyverse")
install.packages("moments")
install.packages("corrplot")

# Load libraries
library(tidyverse)
library(moments)
library(corrplot)

library(readr)

file_id <- "1QBkrF-waQtZdRKXCQbuCnYsythc-2ggS"

url <- paste0("https://drive.google.com/uc?id=", file_id)

dataset <- read_csv(url)

head(dataset)

dim(dataset)

str(dataset)

summary(dataset)

#Mean
sapply(dataset[,sapply(dataset,is.numeric)], mean)

#Median
sapply(dataset[,sapply(dataset,is.numeric)], median)

#Mode
mode_function <- function(x){
  ux <- unique(x)
  ux[which.max(tabulate(match(x, ux)))]
}

sapply(dataset[,sapply(dataset,is.numeric)], mode_function)

#SD
sapply(dataset[,sapply(dataset,is.numeric)], sd)

#Minimum and Maximum
sapply(dataset[,sapply(dataset,is.numeric)], min)
sapply(dataset[,sapply(dataset,is.numeric)], max)

#Count
nrow(dataset)

#Skewness
sapply(dataset[,sapply(dataset,is.numeric)], skewness)

#Histogram
numeric_cols <- dataset %>% select_if(is.numeric)

for(col in names(numeric_cols)){
  
  p <- ggplot(dataset, aes(x = .data[[col]])) +
    geom_histogram(bins = 30, fill = "steelblue") +
    theme_minimal() +
    labs(title = paste("Histogram of", col))
  
  print(p)
  
}

#Boxplot
for(col in names(numeric_cols)){
  
  p <- ggplot(dataset, aes(y = .data[[col]])) +
    geom_boxplot(fill = "orange") +
    theme_minimal() +
    labs(title = paste("Boxplot of", col))
  
  print(p)
  
}

#Bar Chart
cat_cols <- dataset %>% select_if(is.character)

for(col in names(cat_cols)){
  
  p <- ggplot(dataset, aes(x = .data[[col]])) +
    geom_bar(fill = "darkgreen") +
    theme_minimal() +
    labs(title = paste("Frequency of", col))
  
  print(p)
  
}

#Correlation Matrix Heatmap
cor_matrix <- cor(dataset %>% select_if(is.numeric))

corrplot(cor_matrix,
         method="color",
         type="upper",
         tl.col="black",
         tl.srt=45)

#Scatter Plots
ggplot(dataset, aes(x=bmi, y=charges)) +
  geom_point(color="blue") +
  theme_minimal() +
  labs(title="BMI vs Charges")

ggplot(dataset, aes(x=age, y=charges)) +
  geom_point(color="red") +
  theme_minimal() +
  labs(title="Age vs Charges")

#Boxplot
#Smoker vs Insurance Charges
ggplot(dataset, aes(x=smoker, y=charges, fill=smoker)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title="Charges by Smoker")

#Boxplot
#Sex vs Insurance Charges
ggplot(dataset, aes(x=sex, y=charges, fill=sex)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title="Charges by Gender")

#Boxplot
#Region vs Insurance Charges
ggplot(dataset, aes(x=region, y=charges, fill=region)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title="Charges by Region")