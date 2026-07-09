# Creating Different Types of Vectors
# Numeric Vector
number <- c(1, 2.5, 3, 4.5, 5, 7.9, 1.1)
print(number)

# Character Vector
character <- c("Apple", "Banana", "Cherry", "Mango")
print(character)

# Logical Vector
logical_vector <- c(TRUE, FALSE, TRUE, FALSE, TRUE, FALSE)
print(logical_vector)

# Vector Operations
# Arithmetic Operations
vector_1 <- c(20, 40, 60)
vector_2 <- c(10, 30, 50)

sum_vector <- vector_1 + vector_2  # Element-wise addition
production_vector <- vector_1 * vector_2 # Element-wise multiplication

print(sum_vector)   # Output: 30 70 110
print(production_vector)  # Output: 200 1200 3000

# Accessing Elements in a Vector
# Create a vector
number_vector <- c(10, 20, 30, 40, 50, 60, 70, 80)

# Access elements using index (1-based index)
print(number_vector[5])  # Output: 50

# Access multiple elements
print(number_vector[c(1, 3, 5)])  # Output: 10 30 50

# Access elements using a condition
print(number_vector[number_vector > 50])  # Output: 60 70 80

# Modifying a Vector
# Modify an element
number_vector[2] <- 500
print(number_vector)  # Output: 10 100 30 40 50

# Append new elements
number_vector <- c(number_vector, 90, 100)
print(number_vector)  # Output: 10 500 30 40 50 60 70 80 90 100

# Vector Functions
vector_1 <- c(5, 10, 15, 20, 25, 30, 35, 40, 45, 50)

# Length of the vector
print(length(vector_1))  # Output: 10

# Sum of all elements
print(sum(vector_1))  # Output: 275

# Mean (average) of elements
print(mean(vector_1))  # Output: 27.5

# Sorting a vector
sorted_vec <- sort(vector_1, decreasing = TRUE)
print(sorted_vec)  # Output: 50 45 40 35 30 25 20 15 10  5

# Sorting a vector
sorted_vec <- sort(vector_1, decreasing = FALSE)
print(sorted_vec)  # Output: 5 10 15 20 25 30 35 40 45 50

# Sequence and Repetition in Vectors
# Sequence from 1 to 20
seq_vec <- seq(1, 20, by = 3)  # Steps of 3
print(seq_vec)  # Output: 1  4  7 10 13 16 19

# Repeat elements
rep_vec <- rep(c(2, 4, 6), times = 5)  # Repeat entire vector
print(rep_vec)  # Output: 2 4 6 2 4 6 2 4 6 2 4 6 2 4 6

# Creating a 3x3 matrix (filled column-wise by default)
matrix_1 <- matrix(10:18, nrow = 3, ncol = 3)
print(matrix_1)

# Filling a Matrix Row-Wise
matrix_1 <- matrix(10:50, nrow = 5, byrow = TRUE)
print(matrix_1)

# Naming Rows and Columns
# Creating a matrix
mat <- matrix(1:9, nrow = 3)

# Assigning row and column names
rownames(matrix_1) <- c("Row1", "Row2", "Row3", "Row4", "Row5")
colnames(matrix_1) <- c("Col1", "Col2", "Col3", "Col4", "Col5", "Col6", "Col7", "Col8", "Col9")

print(matrix_1)

# Accessing Elements in a Matrix
# Create a 3x3 matrix
matrix_2 <- matrix(1:9, nrow = 3)

# Access element at row 2, column 3
print(matrix_2[2, 3])  # Output: 8

# Access entire row 1
print(matrix_1[1, ])  # Output: 10   11   12   13   14   15   16   17   18 

# Access entire column 2
print(matrix_2[, 2])  # Output: 4 5 6

# Matrix Arithmetic
mat1 <- matrix(10:13, nrow = 2)
mat2 <- matrix(15:18, nrow = 2)

# Matrix addition
sum_mat <- mat1 + mat2
print(sum_mat)

# Matrix multiplication (element-wise)
prod_mat <- mat1 * mat2
print(prod_mat)

# Matrix multiplication (dot product)
dot_prod_mat <- mat1 %*% mat2  # %*% for matrix multiplication
print(dot_prod_mat)

#Transpose and Inverse of a Matrix
# Transpose of a matrix
t_mat <- t(mat1)
print(t_mat)

# Inverse of a matrix (for square matrices)
square_mat <- matrix(c(2, 3, 1, 4), nrow = 2)
inv_mat <- solve(square_mat)
print(inv_mat)

# Creating an array with dimensions (3x3x2)
arr <- array(1:18, dim = c(3, 3, 2))
print(arr)

# Accessing Elements in an Array
# Create a 3x3x2 array
arr <- array(1:18, dim = c(3, 3, 2))

# Access element at [2nd row, 3rd column, 1st layer]
print(arr[2, 3, 1])  # Output: 8

# Access entire 2nd row from Layer 1
print(arr[2, , 1])

# Access entire 3rd column from Layer 2
print(arr[, 3, 2])

#Performing Operations on Arrays
# Creating two 3x3x2 arrays
arr1 <- array(1:18, dim = c(3, 3, 2))
arr2 <- array(19:36, dim = c(3, 3, 2))

# Element-wise addition
sum_arr <- arr1 + arr2
print(sum_arr)

# Element-wise multiplication
prod_arr <- arr1 * arr2
print(prod_arr)

# Applying Functions to Arrays
# Creating an array
arr <- array(1:18, dim = c(3, 3, 2))

# Sum of all elements in the array
print(sum(arr))

# Mean of all elements
print(mean(arr))

# Apply function to each row (margin = 1)
apply(arr, MARGIN = 1, FUN = sum)

# Apply function to each column (margin = 2)
apply(arr, MARGIN = 2, FUN = mean)

# Creating a simple data frame
df <- data.frame(
  ID = c(101, 102, 103, 104),
  NAme = c("Niloy", "Joy", "Charlie", "David"),
  Age = c(23, 25, 22, 24),
  Score = c(89.5, 76.0, 91.2, 88.8),
  Passed = c(TRUE, FALSE, TRUE, TRUE)
)

# Print the data frame
print(df)

# Accessing Elements in a Data Frame
# Access a single column
print(df$Name)  # Output: Alice Bob Charlie David

# Access a specific row (row 2)
print(df[2, ])  

# Access a specific element (Row 3, Column "Score")
print(df[3, "Score"])  # Output: 91.2

# Access multiple columns
print(df[, c("Name", "Score")])  

# Access multiple rows
print(df[1:2, ])  # First two rows

# Add a new column 'Grade'
df$Grade <- c("A", "B", "A+", "A-")
print(df)

# Filter students who passed
passed_students <- df[df$Passed == TRUE, ]
print(passed_students)

# Filter students with Score > 85
high_scorers <- df[df$Score > 85, ]
print(high_scorers)

# Sorting by Age (Ascending)
df_sorted <- df[order(df$Age), ]
print(df_sorted)

# Sorting by Score (Descending)
df_sorted_desc <- df[order(-df$Score), ]
print(df_sorted_desc)

# Changing a value (Changing Bob’s Score to 80)
df$Score[df$Name == "Bob"] <- 80
print(df)

# Renaming column names
colnames(df) <- c("Student_ID", "Student_Name", "Student_Age", "Exam_Score", "Passed_Exam", "Final_Grade")
print(df)

# Remove a column
df$Grade <- NULL
print(df)

# Remove a row (removing row 2)
df <- df[-2, ]
print(df)

# Get summary statistics
summary(df)

# Get structure of the data frame
str(df)

# Creating a list with different data types
my_list <- list(
  Name = "Alice",
  Age = 25,
  Scores = c(90, 85, 88),
  Passed = TRUE
)

# Print the list
print(my_list)

# Access by index
print(my_list[[1]])  # Output: "Alice"

# Access by name
print(my_list$Scores)  # Output: 90 85 88

# Access specific elements within a list item
print(my_list$Scores[2])  # Output: 85

# Change an element
my_list$Age <- 26
print(my_list$Age)  # Output: 26

# Add a new element
my_list$Country <- "USA"
print(my_list)

# Remove an element
my_list$Passed <- NULL
print(my_list)

# Creating a list with a matrix and a data frame
my_complex_list <- list(
  Numbers = c(1, 2, 3, 4),
  Matrix = matrix(1:9, nrow = 3),
  DataFrame = data.frame(ID = c(101, 102), Name = c("Bob", "Charlie"))
)

# Print the list
print(my_complex_list)

# Access elements inside the matrix
print(my_complex_list$Matrix[2, 3])  # Access row 2, column 3

list1 <- list(A = 1:5, B = "Hello")
list2 <- list(C = c(TRUE, FALSE), D = matrix(1:4, nrow = 2))

# Merge lists
merged_list <- c(list1, list2)
print(merged_list)

# Convert list to data frame
list_to_df <- data.frame(
  Name = c("Alice", "Bob"),
  Age = c(25, 27),
  Score = c(89, 92)
)

print(list_to_df)

#Exercise 1
scores <- sample(50:100, 8, replace = TRUE)


scores


min_score <- min(scores)
max_score <- max(scores)
mean_score <- mean(scores)
median_score <- median(scores)


min_score
max_score
mean_score
median_score


cities <- c("Dhaka", "Tokyo", "London", "Paris", "Istanbul")


cities

#Exercise2
student_info <- list(
  name = "Niloy",
  age = 22,
  grades = c(85, 90, 88)
)

student_info$age

student_info$grades[2]

#Exercise3
matrix_4x4 <- matrix(1:16, nrow = 4, ncol = 4)

matrix_4x4[3, ]

matrix_4x4[, 2]

sum(diag(matrix_4x4))

#Exercise 4
students <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "David"),
  Math = c(85, 78, 92, 88),
  English = c(90, 82, 95, 87)
)

str(students)

students$English

students$Average <- (students$Math + students$English) / 2

#Exercise 5
blood_group <- factor(c("A", "B", "O", "AB", "A", "O"))

levels(blood_group)

table(blood_group)

#Exercise 6
class <- data.frame(
  Name = c("Alice", "Bob", "Charlie", "David", "Eva"),
  Age = c(20, 21, 19, 22, 20),
  Gender = factor(c("Female", "Male", "Male", "Male", "Female")),
  Scores = I(list(
    c(85, 88, 90),
    c(70, 75, 78),
    c(92, 95, 94),
    c(80, 82, 79),
    c(88, 90, 91)
  ))
)

avg_scores <- sapply(class$Scores, mean)

class$Name[avg_scores > 80]

table(class$Gender)




