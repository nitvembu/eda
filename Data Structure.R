#Source R Practice 1:  Phillips, N. D. (2016). Chapter 8. Yarrr! The pirate’s guide to R. https://bookdown.org/ndphillips/YaRrr/what-are-matrices-and-dataframes.html

##Matrix
#Creating a matrix by combining vectors using the cbind and rbind function  
x <- 1:5
y <- 6:10
z <- 11:15
#Matrix with x,y,z as columns
cbind(x, y, z)
#Matrix with x,y,z as rows
rbind(x,y,z)

#Matricies cannot contain both character vectors and numbers. It will modify numbers into characters if we try.
cbind(c(1, 2, 3, 4, 5),
      c("a", "b", "c", "d", "e"))

#Matricies can also be created using the matrix function in R
matrix(data = 1:10,
       nrow = 5,
       ncol = 2)

matrix(data = 1:10,
       nrow = 2,
       ncol = 5)

#In the matrix function, values can also filled by rows instead of columns
matrix(data = 1:10,
       nrow = 2,
       ncol = 5,
       byrow = TRUE)

##Dataframe
#Creating a dataframe with columns of different datatypes
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23))
survey
str(survey)

#By default, strings are automatically converted to factors. To prevent that, set stringsAsFactors as FALSE
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "sex" = c("m", "m", "m", "f", "f"),
                     "age" = c(99, 46, 23, 54, 23),
                     stringsAsFactors = FALSE)
str(survey)

#Print list of datasets already available 
library(help = "datasets")

##Matrix and dataframe functions

#To see the first few rows of the dataframe, head() is used.
head(ChickWeight)

#To see the last few rows of the dataframe, tail() is used.
tail(ChickWeight)

#To open the entire dataframe in a new window, view() is used.
View(ChickWeight)

#To print the summary statistics of a dataframe, summary() is used.
summary(ToothGrowth)

#To print the internal structure of the dataframe, str() is used.
str(ToothGrowth)

##Dataframe column names

#To print the column names of the dataframes, names() is used.
names(ToothGrowth)

#To get the vector of just the len column, $ operator is used.
ToothGrowth$len

#Descriptive statistics on columns of dataframes can be calculated by applying vector functions such as mean() or table()
mean(ToothGrowth$len)
table(ToothGrowth$supp)

head(ToothGrowth[c("len", "supp")])

#Adding new columns and creating a new dataframe
survey <- data.frame("index" = c(1, 2, 3, 4, 5),
                     "age" = c(24, 25, 42, 56, 22))

survey

#Add a new column called sex to the dataframe survey
survey$sex <- c("m", "m", "f", "f", "m")

survey

#The names() function can be used to rename columns in dataframe
names(df)[1] <- "a"

names(df)[2] <- "b"

names(survey)[1] <- "participant.number"

#Using column indicies to change column names can be error prone. Therefore, it is better to use logical indexing.
names(survey)[names(survey) == "age"] <- "years"
survey

##Slicing Dataframes
#Slicing is the process of conditionally selecting specific rows and columns of the dataset.

#Data in dataframes can be accessed using brackets. 
#Returns row 1
ToothGrowth[1,]

#Returns 3rd column
ToothGrowth[,3]

#Returns rows 1:6 and column 2
ToothGrowth[1:6, 2]

#Returns rows 1:3 and columns 1:3
ToothGrowth[1:3, c(1,3)]

#Logical operators can be used to slice data based on conditions
#Here a new dataframe with only rows of ToothGrowth where supp = VC is created
ToothGrowth.VC <- ToothGrowth[ToothGrowth$supp == "VC", ]

#Here a new dataframe with only rows of ToothGrowth where supp = OJ and dose <1 is created
ToothGrowth.OJ.a <- ToothGrowth[ToothGrowth$supp == "OJ" &
                                 ToothGrowth$dose < 1, ]

#The subset() in R is also used to slice data from dataframes.
#In the below example, a subset of ToothGrowth where len < 20, supp = OJ and dose >= 1 is created.
subset(x = ToothGrowth,
      subset = len < 20 &
        supp == "OJ" &
        dose >= 1)

#In the below example, a subset of ToothGrowth where len > 30 AND supp == "VC" is created but only columns len and dose are retained.
subset(x = ToothGrowth,
       subset = len > 30 & supp == "VC",
       select = c(len, dose))

##Combining slicing with functions
#Slicing functions can be combined with statistical functions

#In the below example, mean tooth length of Guinea pigs given OJ is calculated.
oj <- subset(x = ToothGrowth,
             subset = supp == "OJ")
mean(oj$len)

#An alternate method to do this is using logical indexing.
oj <- ToothGrowth[ToothGrowth$supp == "OJ",]
mean(oj$len)

#The code below in an even simpler way of doing this.
mean(ToothGrowth$len[ToothGrowth$supp == "OJ"])

#When using multiple columns from a dataframe, the with() simplies the code by allowing us to refer a dataframe at the beginning of the line and then R assumes that every further object is the object that was referred to in the beginning.
health <- data.frame("age" = c(32, 24, 43, 19, 43),
                     "height" = c(1.75, 1.65, 1.50, 1.92, 1.80),
                     "weight" = c(70, 65, 62, 79, 85))

health

#BMI
health$weight / health$height ^ 2

#In the above code, instead of having to type the name of the health dataframe everytime, with() is used.
with(health, height / weight ^ 2)

#Example 2
health$weight + health$height / health$age + 2 * health$height
with(health, weight + height / age + 2 * height)

#Exercise
#1. Combine the data into a single dataframe. Complete all the following exercises from the dataframe!
data <- data.frame(
  name = c("Astrid", "Lea", "Sarina", "Remon", "Lea",
           "Babice", "Jonas", "Wendy", "Niveditha", "Gioia"), sex = c("female", "male", "male", "male", "female",
                                                                      "male", "female", "female", "male", "female"),
  age = c(30, 25, 25, 29, 31, 30, 33, 35, 25, 34),
  superhero = c("Batman", "Superman", "Batman", "Spiderman", "Batman",
                "Antman", "Batman", "Superman", "Maggott", "Superman"
  ),
  tattoos = c(11, 15, 12, 12, 17, 12, 9, 13, 9, 9)
)

#2.What is the median age of the 10 pirates?
median(data$age)

#3.What was the mean age of female and male pirates separately?
mean(data$age[data$sex == "female"])
mean(data$age[data$sex == "male"])

#4.What was the most number of tattoos owned by a male pirate?
max(data$tattoos[data$sex == "male"])

#5.What percent of pirates under the age of 32 were female?
data32 <- subset(x = data,
                   subset = age < 32)
mean(data32$sex == "female")

#6.What percent of female pirates are under the age of 32?
data.female <- subset(x = data,
                      subset = sex == "female")
mean(data.female$age < "32")

#7.Add a new column to the dataframe called tattoos.per.year which shows how many tattoos each pirate has for each year in their life.
data$tattoos.per.year <- with(data, tattoos / age)

#8.Which pirate had the most number of tattoos per year?
with(data, name[tattoos.per.year == max(tattoos.per.year)])

#9.What are the names of the female pirates whose favorite superhero is Superman?
subset(x = data,
       subset = sex == "female" &
         superhero == "Superman", select = name)

#10.What was the median number of tattoos of pirates over the age of 20 whose favorite superhero is Spiderman?
median(data$tattoos[data$age > 30 & data$superhero == "Spiderman"])

#Source R Practice 2: Chapter 20 from https://r4ds.had.co.nz/vectors.html
library(tidyverse)

#Vectors have two properties - type and length
typeof(letters)
x <- list("a", "b", 1:10)
length(x)

#Logical vectors are constructed using comparison operators and have three possible values - FALSE, TRUE, NA.
1:10 %% 3 == 0
c(TRUE, TRUE, FALSE, NA)

#Numeric vectors
typeof(1)

#Numbers are double by default. To create an integer, an L is placed after the number
typeof(1)
typeof(1L)
1.5L

x <- sqrt(2) ^ 2
x

#Integer has special value NA, while doubles have NA, NaN, Inf and -Inf.
c(-1, 0, 1) / 0

#Character vector
if(!require(pryr)){
  install.packages("pryr")
}
library(pryr)
#Size of the character string
x <- "This is a reasonably long string."
pryr::object_size(x)


y <- rep(x, 1000)
pryr::object_size(y)

##Exercise 20.3.5
#1.Describe the difference between is.finite(x) and !is.infinite(x).
#The `is.finite()` function only considers non-missing numeric values to be finite.
#The is.infinite() considers `Inf` and `-Inf` to be infinite, and everything else, including non-missing numbers, `NA`, and `NaN` to not be infinite.

#2.Read the source code for dplyr::near() (Hint: to see the source code, drop the ()). How does it work?
#Used to compare whether two floating point numbers are equal.

#3.Brainstorm at least four functions that allow you to convert a double to an integer. How do they differ? Be precise.
#floor(n)
#as.integer(n)
#round(x)
#`%/%`(x, 1)

#4.What functions from the readr package allow you to turn a string into logical, integer, and double vector?
#parse_logical(c)
#parse_integer(x)

##Coercion
#Vectors can be converted to another explicitly (example - as.logical(), as.integer() etc) or implictly (example - using logical vector in a numeric function).
#Example of implicit coercion
x <- sample(20, 100, replace = TRUE)
y <- x > 10
sum(y) 
mean(y)

#When creating a vector with multiple types, the most complex type supercedes others.
typeof(c(TRUE, 1L))
typeof(c(1L, 1.5))
typeof(c(1.5, "a"))

#Test functions
#During vector operations, the shorter vector is recycled to the same length as the longer vector. 
#This property is particularly useful in operations mixing scalars and vectors.
sample(10) + 100
runif(10) > 0.5
1:10 + 1:2
1:10 + 1:3

#In tidyverse, the vector recycling is possible only with scalars. For other types, rep() needs to be used.
tibble(x = 1:4, y = rep(1:2, 2))
tibble(x = 1:4, y = rep(1:2, each = 2))

#All vectors can be named using the following two methods - c() and purrr::set_names().
c(x = 1, y = 2, z = 4)
set_names(1:3, c("a", "b", "c"))

#filter() works only with tibbles and not for subsetting vectors. '[' is used to subset vectors.
x <- c("one", "two", "three", "four", "five")
x[c(3, 2, 5)]

x[c(1, 1, 5, 5, 5, 2)]

#Negative values will drop the values at the specified indicies.
x[c(-1, -3, -5)]
#Note: negative and positive indicies should not be mixed. Example x[c(1, -1)] will result in an error.

#Subsetting with logical vectors will retain values that evaluate to TRUE.
#Example to find all non missing values of x
x <- c(10, 3, NA, 5, 8, 1, NA)
x[!is.na(x)]

#Example to find all even or missing values of x
x[x %% 2 == 0]

#In a named-vector, subsetting can be done with a character vector
x <- c(abc = 1, def = 2, xyz = 5)
x[c("xyz", "def")]

#Exercise 20.4.6
#1.What does mean(is.na(x)) tell you about a vector x? What about sum(!is.finite(x))?
#mean(is.na(x)) gives the average of missing values in that vector
#sum(!is.finite(x)) gives the total number of infinite values in x

#2.Carefully read the documentation of is.vector(). What does it actually test for? Why does is.atomic() not agree with the definition of atomic vectors above?
#is.atomic tests for objects that are logical, integer, complex, character numeric and raw. 
#is.vector will return true if the object has either no attributes or only the set of attribute names

##Recursive vectors(lists)

#List can be created using list()
x <- list(1, 2, 3)
x

#Structure of the list can be viewed using str()
str(x)

x_named <- list(a = 1, b = 2, c = 3)
str(x_named)

#Lists can be a mix of objects
y <- list("a", 1L, 1.5, TRUE)
str(y)

#Lists can contain other lists
z <- list(list(1, 2), list(3, 4))
str(z)

#Lists can be subsetted in three different ways
#First is using '['
a <- list(a = 1:3, b = "a string", c = pi, d = list(-1, -5))
str(a[1:2])
str(a[4])

#Second, single components can be extracted with [[
str(a[[1]])
str(a[[4]])

#Third, named elements of the list can be subsetted using $
a$a
a[["a"]]

##Attributes
#Attributes are named vectors that can be attached to any object. They can be used to attach metadata.
#Three important attributes are names, dimensions and classes.
x <- 1:10
attr(x, "greeting")

attr(x, "greeting") <- "Hi!"
attr(x, "farewell") <- "Bye!"
attributes(x)

##Augmented vectors
#Factors
#When categorical data needs to be represented by a fixed number of options, factors are used.
x <- factor(c("ab", "cd", "ab"), levels = c("ab", "cd", "ef"))
typeof(x)
attributes(x)

#Dates and Date-time
#Dates are numeric vectors that represent number of days starting Jan 1 1970
x <- as.Date("1971-01-01")
unclass(x)
typeof(x)
attributes(x)

#Date-times represent number of second since Jan 1 1970.
x <- lubridate::ymd_hm("1970-01-01 01:00")
unclass(x)
typeof(x)
attributes(x)

attr(x, "tzone") <- "US/Pacific"
x

#Tibbles
#Tibbles are augmented lists in which all elements of the dataframe are of same length.
df <- data.frame(x = 1:5, y = 5:1)
typeof(df)
attributes(df)

#Exercise 20.7.4
#1.What does hms::hms(3600) return? How does it print? What primitive type is the augmented vector built on top of? What attributes does it use?
# The output is 01:00:00. It returns time in "%H:%M:%S" format. The primitive type is double.

#2.Try and make a tibble that has columns with different lengths. What happens?
#It will throw an error since the columns must be of same length.

#3.Based on the definition above, is it ok to have a list as a column of a tibble?
#Yes. It can, as long as it has the same length as other columns.
