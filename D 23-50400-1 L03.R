#List of required packages
packages <- c("dplyr", "readr")

# Install any packages that are not already installed
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

# Load and inspect the iris dataset
head(iris)

str(iris)

# Get a comprehensive summary
summary(iris)

# Calculate mean
mean(iris$Sepal.Length)

# Calculate median
median(iris$Sepal.Length)

# To find the mode, create a table of frequencies
freq_table <- table(iris$Sepal.Length)
# Find the name of the most frequent value
names(freq_table)[which.max(freq_table)]

# Calculate the range
range_val <- range(iris$Sepal.Length)
max(range_val) - min(range_val)

# Calculate variance
var(iris$Sepal.Length)

# Calculate standard deviation
sd(iris$Sepal.Length)

# Calculate the Interquartile Range
IQR(iris$Sepal.Length)

# Get specific quantiles (e.g., 25th and 75th percentiles)
quantile(iris$Sepal.Length, probs = c(0.25, 0.75))

# Calculate mean, sd, and count for each species
iris %>%
  group_by(Species) %>%
  summarise(
    count = n(),
    mean_sepal_length = mean(Sepal.Length),
    sd_sepal_length = sd(Sepal.Length),
    mean_petal_length = mean(Petal.Length),
    sd_petal_length = sd(Petal.Length)
  )

pairs(iris[, 1:4], main = "Scatterplot Matrix of Iris Data", col = iris$Species)

url <- "https://drive.google.com/uc?id=13GbqRtZciTHr2qcDGcDEPnuGqttY83w4"
library(readr)
library(dplyr)
dataset <- read_csv(url)

head(dataset)
str(dataset)
summary(dataset)

#Mean
mean(dataset$Hours_Studied, na.rm = TRUE)

#Median
median(dataset$Hours_Studied, na.rm = TRUE)

#Mode
freq_table <- table(dataset$Hours_Studied)
names(freq_table)[which.max(freq_table)]

#Range
range_val <- range(dataset$Hours_Studied, na.rm = TRUE)
max(range_val) - min(range_val)

#Variance
var(dataset$Hours_Studied, na.rm = TRUE)

#Standard Deviation
sd(dataset$Hours_Studied, na.rm = TRUE)

#Interquartile Range (IQR)
IQR(dataset$Hours_Studied, na.rm = TRUE)

#25th & 75th Percentiles
quantile(dataset$Hours_Studied, probs = c(0.25, 0.75), na.rm = TRUE)


#Group by Gender
dataset %>%
  group_by(Gender) %>%
  summarise(
    count = n(),
    mean_hours_studied = mean(Hours_Studied, na.rm = TRUE),
    sd_hours_studied = sd(Hours_Studied, na.rm = TRUE),
    mean_sleep_hours = mean(Sleep_Hours, na.rm = TRUE),
    sd_sleep_hours = sd(Sleep_Hours, na.rm = TRUE)
  )

#Group by School Type
dataset %>%
  group_by(School_Type) %>%
  summarise(
    count = n(),
    mean_hours_studied = mean(Hours_Studied, na.rm = TRUE),
    sd_hours_studied = sd(Hours_Studied, na.rm = TRUE),
    mean_sleep_hours = mean(Sleep_Hours, na.rm = TRUE),
    sd_sleep_hours = sd(Sleep_Hours, na.rm = TRUE)
  )

numeric_data <- dataset %>% select(where(is.numeric))
pairs(numeric_data, main = "Scatterplot Matrix of Student Performance Data")