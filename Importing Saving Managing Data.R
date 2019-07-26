#Source: Chapter 9 - https://bookdown.org/ndphillips/YaRrr/importingdata.html

#Saves various objects into myimage.RData
a <- data.frame(id = 1:5, sex = c("m", "m", "f", "f", "m"), score = c(51, 20, 67, 52, 42))
b = "DEF"
c = mean(a$score)
d = table(a$sex)
save(a, b, c, d, file = "~/Downloads/myimage.RData")

#Write data as a .txt file that is tab-seperated
write.table(x = a, file = "~/Downloads/mytable.txt",sep = "\t")

#Reads a text file that is tab seperated and has a header row. It also tells R not to convert strings to factors.
read.table(file = "~/Downloads/mydata.txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

#Read a text file from the web url
fromweb <- read.table(file = 'http://goo.gl/jTNf6P',
                      sep = '\t',
                      header = TRUE)
fromweb

#Saves all objects in the workspace to myimage.RData
save.image(file = "~/Downloads/myimage.RData")

#Loads objects in the file myimage.RData
load(file = "~/Downloads/myimage.RData")

#Display all objects in the current workspace
ls()

#Return current working directory
getwd()

#Change the working directory to a specified file location
setwd(file = "/Users/nithyavembu/Library/Mobile Documents/com~apple~CloudDocs/Harrisburg/EDA/R")

#Return the names of all files in the working directory
list.files()

#Remove object b from workspace
rm(b)

#Remove all objects from workspace - this operation cannot be undone
rm(list = ls())

