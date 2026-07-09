age <- 24
if (age > 18) {
  print("Eligible to Vote")
}

age <- 24
if (age > 18) {
  print("Eligible to Vote")
} else {
  print("Not eligible to Vote")
}

CGPA <- 3.93
if (CGPA >= 3.95) {
  print("Gold Medal")
} else if (CGPA >= 3.85) {
  print("Bronge Medal")
} else if (CGPA >= 3.75) {
  print("Silver Medal")
} else {
  print("No Medal")
}

for (i in 10:15) {
  print(paste("Iteration", i))
}

#repeat Loop (with break)
id <- 5
repeat {
  print(id)
  id <- id + 1
  if (id > 10) break
}

#next Statement (skip to next iteration)
for (id in 10:1) {
  if (id == 7) next
  print(id)
}

#break Statement (exit the loop)
for (id in 10:15) {
  if (id == 14) break
  print(id)
}

#mean()
CGPA <- c(3.94, 3.45, 3.76, 3.54, 3.99)
mean(CGPA)  # Output: 3.736

sum(CGPA)  # Output: 18.68

length(CGPA)  # Output: 5

#round()
value <- 9.3692485
round(value, 4)  # Output: 9.3692

paste("R is awesome")  # Output: "Hello World"

#Simple function to add two numbers
add_numbers <- function(a, b) {
  return(a + b)
}

add_numbers(50, 30)  # Output: 80

#Function to check if a number is even
is_even <- function(x) {
  if (x %% 2 == 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

is_even(100)  # Output: TRUE

#Function with default parameter
greet <- function(name = "Niloy") {
  paste("Hello", name)
}

greet()         # Output: "Hello User"

greet("Abir")   # Output: "Hello Abir"

#Anonymous (Lambda) Function with sapply()
numbers <- 1:5
squared <- sapply(numbers, function(x) x^2)
print(squared)  # Output: 1 4 9 16 25

#Reading a CSV File
data <- read.csv("E:\\Semester 9 (Spring 25-26)\\IDS_Lab\\Titanic Modified.csv")
head(data)

#Reading a Text File (tab-delimited)
data <- read.table("E:\\Semester 9 (Spring 25-26)\\IDS_Lab\\Sample.txt", header = TRUE, sep = "\t")
head(data)

#Reading Data from a URL
url <- "https://people.sc.fsu.edu/~jburkardt/data/csv/airtravel.csv"
data <- read.csv(url)
head(data)

#Exercise 1
score <- 82

if (score >= 90) {
  print("Excellent")
} else if (score >= 75) {
  print("Good")
} else if (score >= 50) {
  print("Pass")
} else {
  print("Fail")
}

#Exercise 2
numbers <- 1:10

for (i in numbers) {
  print(i * i)
}

#Exercise 3
count <- 1

while (count < 20) {
  if (count %% 2 == 0) {
    print(count)
  }
  count <- count + 1
}

#Exercise 4
multiply <- function(a, b) {
  return(a * b)
}

multiply(4, 5)

#Exercise 5
calculate_stats <- function(x) {
  list(
    mean = mean(x),
    median = median(x),
    sd = sd(x)
  )
}

nums <- c(10, 20, 30, 40, 50)
calculate_stats(nums)


#Exercise 6
grade_result <- function(score) {
  if (score >= 90) {
    print("A")
  } else if (score >= 75) {
    print("B")
  } else if (score >= 50) {
    print("C")
  } else {
    print("F")
  }
}

grade_result(95)
grade_result(80)
grade_result(60)
grade_result(30)


#Exercise 7
data <- read.csv("E:\\Semester 9 (Spring 25-26)\\IDS_Lab\\students.csv")
head(data)
str(data)