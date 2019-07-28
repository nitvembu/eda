# eda
Exploratory Data Analysis (EDA) R Practice

There are several advanced statistical methods or machine learning techniques to analyze large datasets. However, the most important step is the exploratory data analysis where data is looked at from different angles using simple statistical methods and visualizations, as well as cleaned, to highlight the important aspects of the data. This code repository is a compilation of various R code snippets for different aspects of EDA such as data cleaning, missing data handling, data structures, data visualization, cluster analysis etc, that are used to evaluate the structure and integrity of the available data.

The repository consists of the following eleven files.

1. Importing Saving Managing Data.R : Management of R objects such as loading data, saving to different formats, viewing directory and exporting to external files are covered here. 
Source: https://bookdown.org/ndphillips/YaRrr/importingdata.html

2. EDA Checklist.R : This covers a handy list of steps to go through when looking at a dataset for the first time for EDA. The dataset used (attached as ozone.csv.zip) is a modified version of the air pollution dataset from the EPA containing hourly ozone levels in the United States for the year 2014. Some code that could be used with the original dataset is also provided in a commented form.
Source: https://bookdown.org/rdpeng/exdata/exploratory-data-analysis-checklist.html

3. Data Structure.R : Data can be stored in different forms in R (examples - dataframes, vectors). The various forms available and the operations that could be performed on them to slice dice and combine the data are covered here.
Source: https://bookdown.org/ndphillips/YaRrr/what-are-matrices-and-dataframes.html, https://r4ds.had.co.nz/vectors.html

4. Tidy Data.R : Organizing the data upfront saves lot of times and allows one to focus on the analytical questions that we want the data to answer. The uses of the tidyr package is covered here.
Source: https://r4ds.had.co.nz/tidy-data.html

5. Tidy in Markdown.Rmd : As a continuation of the Tidy Data.R file, examples of imputing data and converting data from wide to long and vice-versa are provided in an R Markdown format. Data used is attached as religion_income.csv.

6. Data Transformation.Rmd : As a form of prepping the data for analysis, data will need to be reordered, column might have to be renamed, simple summaries or new variables will need to be created. These are covered in this code file which is in a R markdown form.
Source: https://r4ds.had.co.nz/transform.html

7. Data Visualisation.Rmd : Visualizing the data can provide more information than most other formats. The R tidyverse package is used create plots and take advantage of the ability to add additional layers or grammer to plots.
Source: https://r4ds.had.co.nz/data-visualisation.html

8. Plotting Systems and Graphic Devices.Rmd : The three different plotting systems namely base plotting system, the lattice system, and the ggplot2 system are addressed here, along with the graphical devices in which these plottings can be made to appear. 
Source: https://bookdown.org/rdpeng/exdata/plotting-systems.html, https://bookdown.org/rdpeng/exdata/graphics-devices.html

9. Cluster Analysis.Rmd : Clustering techniques are used to identify similar groups of observations within the data. K-means clustering and hierarchical clustering are popular clustering techniques and the steps to perform them are covered here.
Source: https://uc-r.github.io/kmeans_clustering, https://uc-r.github.io/hc_clustering

10. Principal Component Analysis.Rmd : Finally, the variation in the dataset with several variables can be viewed with the help of principal component analysis (PCA). The steps to perform PCA and visualize the results are covered here.
Source: https://www.datacamp.com/community/tutorials/pca-analysis-r

11. Model Diagnostics.Rmd : When regression models are created to do advance analysis on the data, there are always some underlying assumptions made. This file covers assessment of model assumptions and identification of outliers.
Source: http://daviddalpiaz.github.io/appliedstats/model-diagnostics.html#unusual-observations

