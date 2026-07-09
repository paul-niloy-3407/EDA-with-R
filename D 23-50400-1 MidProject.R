
# Install and load required packages
packages <- c("readr", "dplyr", "ggplot2", "moments", "reshape2", "GGally", "corrplot")

# Install packages if not already installed
installed_packages <- rownames(installed.packages())
for (pkg in packages) {
  if (!(pkg %in% installed_packages)) {
    install.packages(pkg)
  }
  library(pkg, character.only = TRUE)
}

library(googledrive)
library(readr)


file_id <- "14EIXBBIoe-pYF_O_jBdSN__d1bN8g_e5"


url <- paste0("https://drive.google.com/uc?id=", file_id)


dataset <- read_csv(url, show_col_types = FALSE)

# View the first few rows of the dataset
head(dataset)


# TASK A: DATA UNDERSTANDING


# 1) Display first few rows
head(dataset)

# 2) Show shape (rows x columns)
cat("Rows:", nrow(dataset), "\n")
cat("Columns:", ncol(dataset), "\n")

# 3) Show column names
names(dataset)

# 4) Display data types + identify categorical and numerical columns
str(dataset)

# Identifying numerical and categorical columns
numeric_cols <- names(dataset)[sapply(dataset, is.numeric)]
categorical_cols <- names(dataset)[sapply(dataset, function(x) is.character(x) || is.factor(x))]

cat("\nNumeric Columns:\n")
print(numeric_cols)

cat("\nCategorical Columns:\n")
print(categorical_cols)

# Convert character columns to factor for categorical variables
dataset[categorical_cols] <- lapply(dataset[categorical_cols], as.factor)

# 5) Descriptive statistics (mean, median, mode, std, min, max, skewness)
get_mode <- function(x) {
  x <- x[!is.na(x)]
  if (length(x) == 0) return(NA)
  freq_table <- table(x)
  names(freq_table)[which.max(freq_table)]
}

desc_stats <- data.frame(
  Feature  = numeric_cols,
  Count    = sapply(dataset[numeric_cols], function(x) sum(!is.na(x))),
  Mean     = sapply(dataset[numeric_cols], function(x) mean(x, na.rm = TRUE)),
  Median   = sapply(dataset[numeric_cols], function(x) median(x, na.rm = TRUE)),
  Mode     = sapply(dataset[numeric_cols], get_mode),
  Std      = sapply(dataset[numeric_cols], function(x) sd(x, na.rm = TRUE)),
  Min      = sapply(dataset[numeric_cols], function(x) min(x, na.rm = TRUE)),
  Max      = sapply(dataset[numeric_cols], function(x) max(x, na.rm = TRUE)),
  Skewness = sapply(dataset[numeric_cols], function(x) moments::skewness(x, na.rm = TRUE)),
  Kurtosis = sapply(dataset[numeric_cols], function(x) moments::kurtosis(x, na.rm = TRUE))
)

# Displaying descriptive statistics
print(desc_stats)

# Frequency count for categorical columns
for (col in categorical_cols) {
  cat("\n-----------------------------\n")
  cat("Frequency (Top 10) for:", col, "\n")
  print(head(sort(table(dataset[[col]]), decreasing = TRUE), 10))
}


# TASK B: EXPLORATORY DATA ANALYSIS

# 1) Univariate Analysis
# a) Numeric distributions: Histogram + Boxplot
for (col in numeric_cols) {
  # Histogram
  p1 <- ggplot(dataset, aes(x = .data[[col]])) +
    geom_histogram(bins = 30, fill = "steelblue") +
    theme_minimal() +
    labs(title = paste("Histogram of", col), x = col, y = "Count")
  print(p1)  # Explicitly print the histogram
  
  # Boxplot
  p2 <- ggplot(dataset, aes(y = .data[[col]])) +
    geom_boxplot(fill = "orange") +
    theme_minimal() +
    labs(title = paste("Boxplot of", col), y = col)
  print(p2)  # Explicitly print the boxplot
}

# b) Categorical frequency: Bar chart
for (col in categorical_cols) {
  print(
    ggplot(dataset, aes(x = .data[[col]])) +
      geom_bar(fill = "darkgreen") +
      theme_minimal() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
      labs(title = paste("Bar Chart of", col), x = col, y = "Frequency")
  )
}

# 2) Bivariate Analysis
# a) Correlation matrix (numeric columns) + heatmap
numeric_data <- dataset %>% select(where(is.numeric))

if (ncol(numeric_data) >= 2) {
  cor_matrix <- cor(numeric_data, use = "complete.obs")
  cor_matrix
  
  cor_melt <- reshape2::melt(cor_matrix)
  
  ggplot(cor_melt, aes(Var1, Var2, fill = value)) +
    geom_tile() +
    scale_fill_gradient2(low = "blue", high = "red", mid = "white") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
    labs(title = "Correlation Heatmap", x = "", y = "")
}

# b) Scatter plot matrix for numeric columns
if (ncol(numeric_data) >= 2) {
  GGally::ggpairs(dataset, columns = numeric_cols)
}

# c) Boxplots between categorical and numeric features
# Using the first two categorical columns for simplicity
cat2 <- categorical_cols[1:min(2, length(categorical_cols))]

for (c_col in cat2) {
  for (n_col in numeric_cols) {
    print(
      ggplot(dataset, aes(x = .data[[c_col]], y = .data[[n_col]])) +
        geom_boxplot() +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
        labs(title = paste("Boxplot:", n_col, "by", c_col), x = c_col, y = n_col)
    )
  }
}

# 3) Identifying patterns, skewness, and possible outliers
# Skewness report
skew_report <- desc_stats[order(-abs(desc_stats$Skewness)), c("Feature", "Skewness")]
skew_report

# Outlier count using IQR rule
outlier_count_iqr <- function(x) {
  x <- x[!is.na(x)]
  if (length(x) < 4) return(0)
  q1 <- quantile(x, 0.25)
  q3 <- quantile(x, 0.75)
  iqr <- q3 - q1
  lower <- q1 - 1.5 * iqr
  upper <- q3 + 1.5 * iqr
  sum(x < lower | x > upper)
}

outliers <- data.frame(
  Feature = numeric_cols,
  Outlier_Count = sapply(dataset[numeric_cols], outlier_count_iqr)
)

outliers[order(-outliers$Outlier_Count), ]