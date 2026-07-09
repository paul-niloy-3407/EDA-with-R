#List of required packages
packages <- c("ggplot2", "dplyr", "scales", "tidyr","GGally")

# Install any packages that are not already installed
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

data("mtcars")
head(mtcars)

ggplot(mtcars, aes(x = hp, y = mpg)) +
  geom_point() +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  labs(title = "HP vs MPG", x = "Horsepower", y = "Miles per Gallon")

ggplot(mtcars, aes(y = mpg)) +
  geom_boxplot(fill = "tomato") +
  labs(title = "Boxplot of Miles per Gallon", y = "MPG")

ggcorr(mtcars, label = TRUE)

# --- Handling Missing Values ---

# Check how many NA values are in each column
colSums(is.na(mtcars))

# Create a new dataframe with rows containing NA values removed
mtcars_clean <- na.omit(mtcars)

# Verify that there are no more NA values
cat("Total NA values after cleaning:", sum(is.na(mtcars_clean)), "\n")

# --- Handling Duplicates ---

# Check for any duplicated rows in the entire dataset
cat("Total duplicated rows:", sum(duplicated(mtcars_clean)), "\n")

# Although there are no duplicates in this case, here is how you would remove them:
# mtcars_clean <- distinct(msleep_clean)
mtcars_clean <- mtcars_clean[!duplicated(mtcars_clean), ]

mtcars_filtered <- mtcars_clean %>% filter(mpg > 20)

mtcars_selected <- mtcars_filtered %>% select(mpg, hp, wt)

mtcars_mutated <- mtcars_selected %>%
  mutate(power_to_weight = hp / wt)

mtcars_scaled <- mtcars_selected %>%
  mutate(across(c(mpg, hp, wt), ~ scale(.)[,1]))
head(mtcars_scaled)

library(readr)

file_id <- "1xn9ulzCX2n6KLYd1Ul_C7qNetH94pitb"
url <- paste0("https://drive.google.com/uc?id=", file_id)

dataset <- read_csv(url)

head(dataset)

#Basic Inspection
dim(dataset)      # rows, columns
names(dataset)    # column names
str(dataset)      # data types
summary(dataset)  # quick stats
head(dataset)

#Missing Values
colSums(is.na(dataset))   # missing count per column

#numeric: replace NA with mean/median

#categorical: replace NA with mode / “Unknown”
dataset$Daily_Return[is.na(dataset$Daily_Return)] <- 
  median(dataset$Daily_Return, na.rm = TRUE)

dataset$Volatility_30[is.na(dataset$Volatility_30)] <- 
  median(dataset$Volatility_30, na.rm = TRUE)

#Convert Categorical Variable
dataset$Day_of_Week <- as.factor(dataset$Day_of_Week)
dataset$Quarter <- as.factor(dataset$Quarter)

#Histogram (Stock Price)
library(ggplot2)

ggplot(dataset, aes(x = Price)) +
  geom_histogram(fill = "steelblue", bins = 30) +
  theme_minimal()

#Box Plot (Daily Return)
ggplot(dataset, aes(y = Daily_Return)) +
  geom_boxplot(fill = "orange") +
  theme_minimal()

#Stock Activity by Day of week
ggplot(dataset, aes(x = Day_of_Week)) +
  geom_bar(fill = "darkgreen") +
  theme_minimal()

#Correlation Matrix
numeric_cols <- sapply(dataset, is.numeric)

cor_matrix <- cor(dataset[, numeric_cols], use = "complete.obs")

cor_matrix

#Correlation HeatMap
library(reshape2)

cor_melt <- melt(cor_matrix)

ggplot(cor_melt, aes(Var1, Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(low = "blue", high = "red", mid = "white") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

#Time Trend Visualization
ggplot(dataset, aes(x = Year, y = Price)) +
  geom_line(color = "blue") +
  theme_minimal()

#Yearly Average Trend
library(dplyr)

yearly_avg <- dataset %>%
  group_by(Year) %>%
  summarise(Avg_Price = mean(Price, na.rm = TRUE))

ggplot(yearly_avg, aes(x = Year, y = Avg_Price)) +
  geom_line(color = "darkred") +
  theme_minimal() +
  labs(title = "Yearly Average Stock Price Trend")

#Moving Average Trend
ggplot(dataset, aes(x = Date)) +
  geom_line(aes(y = Price), color = "gray") +
  geom_line(aes(y = MA_30), color = "red") +
  geom_line(aes(y = MA_90), color = "blue") +
  theme_minimal() +
  labs(title = "Price with Moving Averages")

#Volatility Trend
ggplot(dataset, aes(x = Date, y = Volatility_30)) +
  geom_line(color = "purple") +
  theme_minimal() +
  labs(title = "30-Day Volatility Trend")