#Tidy Data
#Week 5 Source: https://r4ds.had.co.nz/tidy-data.html

#Before analysis, the most important step is to organize the data i.e to tidy the data. R's tidyverse package has a multitude of functions to assist with this process.

#Install and load packages
if (!require("tidyverse")) install.packages("tidyverse")
library(tidyverse)
if (!require("ggplot2")) install.packages("ggplot2")
library(ggplot2)
if (!require("magrittr")) install.packages("magrittr")
library(magrittr)

#The same data can be represented in many different forms. The examples below of table1, table2, table3, table4a and table4b all have the same data but represented differently.
table1
table2
table3
table4a
table4b

#The difference in representation causes difference in usability of these datasets. It is important to create one easily usable tidy dataset.
#The three rules to make a tidy dataset are:
  #1.Each variable must have its own column.
  #2.Each observation must have its own row.
  #3.Each value must have its own cell.

#table1 is tidy and it is easy to perform operations such as mutation and summarisation on it.
#Example to compute rate per 10,000
table1 %>% 
  mutate(rate = cases / population * 10000)

#Example to compute case per year
table1 %>% 
  count(year, wt = cases)

#Example to represent the changes over time visually
ggplot(table1, aes(year, cases)) + 
  geom_line(aes(group = country), colour = "grey50") + 
  geom_point(aes(colour = country))

#Exercise 12.2.1
#1.Using prose, describe how the variables and observations are organised in each of the sample tables.
#In table1, rows are a country and year combination, while columns are cases and population.
#In table2, rows are a country, year and type combination, while the column count has the values of the type (population or cases)
#In table3, rows are a county and year combination, and the column rate provides the value for cases and population in a cases/population format.
#In tabl4a, the data contains the values of the cases where the columns are represented by the year.
#In table4b, the data contains values of population where columns are years.

#2.Compute the rate for table2, and table4a + table4b. You will need to perform four operations:

  #Extract the number of TB cases per country per year.
  #Extract the matching population per country per year.
  #Divide cases by population, and multiply by 10000.
  #Store back in the appropriate place.
  #Which representation is easiest to work with? Which is hardest? Why?

#Extract population and cases
t2c <- filter(table2, type == "cases") %>%
  arrange(country, year)
colnames(t2c)[4] = "cases"
t2p <- filter(table2, type == "population") %>%
  arrange(country, year)
colnames(t2p)[4] = "population"

#calculate per capita
t2c_per_cap <- data.frame(
  year = t2c$year,
  country = t2c$country,
  cases = t2c$cases,
  population = t2p$population
) %>%
  mutate(cases_per_cap = (cases / population) * 10000) %>%
  select(country, year, cases_per_cap)


t2c_per_cap$type <- "cases per cap"
colnames(t2c_per_cap)[3] = "count"

rbind(table2, t2c_per_cap) %>%
  arrange(country, year, type, count)

#3. Recreate the plot showing change in cases over time using table2 instead of table1. What do you need to do first?
table2 %>%
  filter(type == "cases") %>%
  ggplot(aes(year, count)) +
  geom_line(aes(group = country), colour = "black") +
  geom_point(aes(colour = country)) +
  scale_x_continuous(breaks = unique(table2$year)) 

##Spreading and gathering
#When column names are values of a variable rather than the names of variables, gathering is needed.
#In this example, the columns 1999 and 2000 which should be column values are made so using gather()
table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")

#Similarly, in table4a, the year column names are converted to column values of a column called year. The column values of 1999 and 2000 become a new column value.
table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")

#The tidied table4a and table4b can be merged using left_join()
tidy4a <- table4a %>% 
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b)

#When an observation is scattered across mulitple rows, then spreading is used.
#The column with the variable name is the key column and the column wit the multiple variables is the value column, as shown in the example below.
table2 %>%
  spread(key = type, value = count)

#Exercise 12.3.3
#1.Why are gather() and spread() not perfectly symmetrical? Carefully consider the following example:
stocks <- tibble(
  year   = c(2015, 2015, 2016, 2016),
  half  = c(   1,    2,     1,    2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks %>% 
  spread(year, return) %>% 
  gather("year", "return", `2015`:`2016`)

#The datatypes are not maintained in the spread() and gather() functions. The symmetry can be maintained by using the convert = TRUE option in both functions.

#2.Why does this code fail?
#table4a %>% 
#gather(1999, 2000, key = "year", value = "cases")

#There are no quotes surrounding column names 1999 and 2000, and they get treated as numbers.

#3.Why does spreading this tibble fail? How could you add a new column to fix the problem?
# people <- tribble(
#   ~name,             ~key,    ~value,
#   #-----------------|--------|------
#   "Phillip Woods",   "age",       45,
#   "Phillip Woods",   "height",   186,
#   "Phillip Woods",   "age",       50,
#   "Jessica Cordero", "age",       37,
#   "Jessica Cordero", "height",   156
# )

#The name and key columns do not have distinct values.This could be fixed by adding a row number or observation column.

#4.Tidy the simple tibble below. Do you need to spread or gather it? What are the variables?
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
#Use gather()
preg %>%
  gather(male, female, key = "sex", value = "count")

##Separating and uniting
#separate() splits a single column into multiple ones. 
table3 %>% 
  separate(rate, into = c("cases", "population"))

#This seperation can be based on a character if specified.
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")

##convert=TRUE option is available with separate also, to convert/preserve data types.
#Here population which contains numbers are converted to the required type
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)

#The index where the column value has to separated can also be mentioned in the function.
#In this example, the last two digits of the year are separated
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2)

#unite() performs the opposite of separate() and combines multiple columns into one.
table5 %>% 
  unite(new, century, year)

#Separators can be included to distinguish the multiple columns
table5 %>% 
  unite(new, century, year, sep = "")

##Exercise 12.4.3
#1.What do the extra and fill arguments do in separate()? Experiment with the various options for the following two toy datasets.
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>% 
  separate(x, c("one", "two", "three"))

#When there are too many values available, extra tells what needs to be done to them (example - drop or merge). 
#Fill is used to indicate what happens when there are too few (example - fill missing values from the right or left).

#2.Both unite() and separate() have a remove argument. What does it do? Why would you set it to FALSE?
#Remove indicates whether you keep or drop input columns from the old dataframes that were united or separated.

#3.Compare and contrast separate() and extract(). Why are there three variations of separation (by position, by separator, and with groups), but only one unite?
#There are many ways to split the columns, and therefore there are many options available. Separate() can be used to separate based on a character separator vector and use regular expressions to extract particular string from column and then separate.
#Multiple columns can be chosen for merging but there is only one way to unite them.

##Missing values
#Values can be missing explicitly (flagged as NA) or implicitly by simply not being present in the data.
#In the example below missing data is specified explicitly by NA and implicitly where the first quarter data for 2016 does not exist.
stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(   1,    2,    3,    4,    2,    3,    4),
  return = c(1.88, 0.59, 0.35,   NA, 0.92, 0.17, 2.66)
)

#Changing representation of the data can help identify missing values better
stocks %>% 
  spread(year, return)

#Missing values can be converted from explicity to implicit by removing them using na.rm = TRUE in gather()
stocks %>% 
  spread(year, return) %>% 
  gather(year, return, `2015`:`2016`, na.rm = TRUE)

#complete() helps finding all unique columns and fills up missing values with NA
stocks %>% 
  complete(year, qtr)

#When data is missing on purpose to make data entry easier, fill() can be used to carry forward previous values.
treatment <- tribble(
  ~ person,           ~ treatment, ~response,
  "Derrick Whitmore", 1,           7,
  NA,                 2,           10,
  NA,                 3,           9,
  "Katherine Burke",  1,           4
)
treatment %>% 
  fill(person)

#Exercise 12.5.1
#1.Compare and contrast the fill arguments to spread() and complete().
#In spread, fill argument indicates what the missing values should be replaced with. In complete(), the fill value is a named list instead of NA.

#2.What does the direction argument to fill() do?
#It indicates whether missing values should be replaced by previous non-missing values or the next ones.

##Case Study
#using tidyr::who dataset
who

#The first three letters of the columns seem to indicate whether it is old or new cases of TB. The next two letters describe the type of TB. The 6th letter gives sex of patients as m or f. The rest of the numbers give age group.

#Columns country, iso2 and so3 are redundant. year should also be a variable
who1 <- who %>% 
  gather(new_sp_m014:newrel_f65, key = "key", value = "cases", na.rm = TRUE)
who1

who1 %>% 
  count(key)

#To  keep it uniform the columns called newrel and modified.
who2 <- who1 %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel"))
who2

#Then the coded values in the columns are separated
who3 <- who2 %>% 
  separate(key, c("new", "type", "sexage"), sep = "_")
who3

#The new, iso2 and iso3 are dropped
who3 %>% 
  count(new)
who4 <- who3 %>% 
  select(-new, -iso2, -iso3)

#The sexage column is separated into sex and age
who5 <- who4 %>% 
  separate(sexage, c("sex", "age"), sep = 1)
who5

#The above steps can be combined into one piece of complex code as given below.
who %>%
  gather(key, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) %>%
  separate(key, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

#Exercise 12.6.1
#1. In this case study I set na.rm = TRUE just to make it easier to check that we had the correct values. Is this reasonable? Think about how missing values are represented in this dataset. 
#Are there implicit missing values? What's the difference between an NA and zero?
#Ans:NA indicates missing data while zero represents zero cases. na.rm = TRUE is used once it is determined how missing values are indicated. 
#Here missing values are explicitly represented by zero and implicity by missing values (example country that is not available for a year)

who %>%
  complete(country, year)

who1 %>%
  filter(cases == 0)

#2.What happens if you neglect the mutate() step? (mutate(key = stringr::str_replace(key, "newrel", "new_rel")))
#There is a too few values warning, and the type, sex and age values will not get split accurately.

#3.I claimed that iso2 and iso3 were redundant with country. Confirm this claim.
#All three columns are representing the same data in long and short formats.

#4.For each country, year, and sex compute the total number of cases of TB. Make an informative visualisation of the data.
who5 %>%
  group_by(country, year, sex) %>%
  filter(year > 1995) %>%
  summarise(cases = sum(cases)) %>%
  unite(cs, country, sex, remove = FALSE) %>%
  ggplot() +
  geom_line(mapping = aes(x = year, y = cases, group = cs, colour = sex))

