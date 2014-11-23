################################################################################
##
##    Psychology 1900
##    Introduction to Statistics for the Behavioral Sciences
##
##    Semester: Fall 2014
##    Course Instructor: Patrick Mair          <  mair@fas.harvard.edu   >
##    Teaching Fellows:  Marie-Christine Nizzi <  mnizzi@fas.harvard.edu >
##                       Andrew Reece          <  reece@g.harvard.edu    >
##
################################################################################

############################################
##
##    Lab 03: - Plots
##              - Histogram
##              - Scatterplot
##              - Bar chart
##              - Box plot
##
############################################


## Welcome to Week 3 of Psych 1900 Section!

# This week we're exploring data visualization methods in R.
# Why visualize your data?  Because it's hard to understand what a spreadsheet of numbers means.
# Pictures are worth 1,000 data points!
#
# There are lots of different ways to visualize data.  We'll learn how to make a few of the most
# basic plots today, using R.

## 1. Histogram

# A histogram displays the frequency of each numerical value across a range of values.
# The function hist() generates a histogram in the Plots window.

?hist


#     1. List the required argument(s) for hist().


# As an example, we can look at Olympic medal counts between 2000 and 2012.
#     Data source: http://www.tableausoftware.com/public/community/sample-data-sets

# Let's say we want to look at the relationship between athlete age and Olympic performance.

# load Olympics data

oly <- read.csv( 'http://www.people.fas.harvard.edu/~reece/1900/olympics.csv', header=TRUE ) 

#* Protip *#
#   If you know you want to read a .csv file, 
#   you can use read.csv() insetad of read.table().
#   It saves having to enter in a few extra arguments.

View( oly ) 
head( oly )


#     2.  What does each row of data represent?  


#     3.  What does each column of data represent?


#     4.  You can think of each row of data as having its own little story to tell.
#         Write down the story of row #1.


# We can see from View(oly) that there's a column called 'Age'.
# Access a specific data column in a variable using the $ sign:

oly$Age

View( oly$Age )
head( oly$Age )

# I'm not going to write View() and head() each time, just remember you can always use them!

# Now make a histogram of the Age column

hist( oly$Age )

# Good! You made a histogram.

# But it looks a little funny - let's make it nicer.
# For instance, there are only a handful of bars, but there are many more ages in our data.

# To increase the number of bars in a histogram, use the 'breaks' argument.
# (We could figure out exactly how many different ages are in our data, but for now let's just 
# say we want a bar for 50 different ages.)

hist( oly$Age, breaks=50 )

#* Protip *#
# Remember that you can put each argument on its own line. 
# When we have a lot of arguments, it can be helpful so they don't all get jumbled together.

hist( oly$Age, 
      breaks=50 )

# This plot looks better. But...our x-axis doesn't start at 0. 
# I guess you could argue that Olympic athletes are at least tweens, 
# so there's no need to have really young ages represented. 
# But it's good practice to always have axes start at 0, when possible. 
# Also, it looks like our y-axis is not high enough for some of the bars.
#
# So, let's set the upper and lower limits of the y- and x-axis with the arguments ylim and xlim.

  
#     5. Plot Age in a histogram with the following constraints:
#     
#       y-axis lower limit = 0
#       y-axis upper limit = 800
#       x-axis lower limit = 0
#       x-axis upper limit = 70
#

hist( oly$Age, breaks=50, ylim=???, ???, las=1 )

#       Hint: ylim and xlim both need a collection of two numbers,
#             so you can't just write xlim=0,100
#             What is the function that we use to create a collection of numbers?
#             Check part 4.) of the code from section 1 if you're stuck.


#     6.  What story is this histogram telling? 
#         Can you know from this graph how many medals were won by each age group?


# I added an extra argument to the function call, called 'las'.  
# The las argument takes 4 possible values: 0, 1, 2, and 3.


#     7.  Make a histogram using each of the possible las values.  What happens?


# Finally, let's add some titles and axis labels. You can use these commands with any plot in R.


#     8.  Add the following arguments to your function:
#
#         las=1,
#         main="Frequency of Olympic medalists by age",
#         xlab="Age (in years)", 
#         ylab="Frequency"


# Maybe I'm just being picky, but the font sizes look all out-of-whack. Must fix!
#
# 'cex' is an argument that controls font type and size and such for all plot labels.
# There are a few different versions of cex, and we'll use three of them here.


#     9. Add the following arguments to your function:
#         cex.axis=.8,
#         cex.main=.9,
#         cex.lab=.8


#     10. Try putting in different values for the cex arguments and see what happens.


# You are now hist() pros.  You're totally hist()erical!


## 2. Scatterplot

# A scatterplot compares two metric variables against each other.
# It's a way of visualizing the relationship, or correlation, between two variables.
# Use the plot() function to make a scatterplot.

?plot

 
#     9. List the required argument(s) for plot().


# Visually, a scatterplot looks like a bunch of bubbles that have been 'scattered' around.
# Each bubble is one value in your data.  If the two variables you've chosen are related, 
# then the bubbles will form a clear pattern.

# We'll look at a dataset containing the SAT and ACT scores of 700 students.
#   Data source: https://sapa-project.org/, via psych package

# The SAT has Verbal and Quantitative sections. We can use a scatter plot to see if 
# there is a correlation between performance on the two sections.


# The SAT/ACT data file is stored at the following URL:
# "http://www.people.fas.harvard.edu/~reece/1900/sat.csv"


#     10. Load the data into a variable called 'sat'


#     11. Make a scatterplot with the SATV variable on the x-axis, and SATQ variable on y-axis.


#     12. Add a main title, x-axis label, and y-axis label.
#
#           Make title: "SAT Verbal vs Quantitative"
#           Make x-axis label: "Verbal"
#           Make y-axis label: "Quantitative"


#     13. Does it look like there is a correlation between SATV and SATQ?
#         If so, what kind of correlation is it?  If not, describe what you see.


## 3. Bar charts

# Bar charts plot categorical variables against metric variables. 
# Use the barplot() function to make a barplot.

?barplot

# Note: The barplot Help page may be a little confusing. For now, just remember
#       that there's only one required argument: a variable that contains the
#       count of each of the categories in your x-axis.
# 
# Example: barplot( my.variable )

# To demonstrate barplots, we'll use a dataset that Facebook recently released to the public.
# It details the total number of requests for FB users' private information, made
# by government agencies around the world, in the first 6 months of 2013.
#       Data source: https://www.facebook.com/about/government_requests/download.php


# The Facebook data file is stored at the following URL:
# "http://www.people.fas.harvard.edu/~reece/1900/facebook.csv"


#     14. Load the data into a variable called 'fb'


# To simplify a bit, we'll limit our data to only those countries which made over 1000 requests.
# (You're not expected to know how to do this - just execute the line below.)

fb <- fb[ fb$total.requests > 1000, ]


#     15. View() this new, shorter dataset. What variables are included?


#     16. Make a barplot of the total.requests variable.


# Now let's label each country and add a title.


#     17. Add these arguments to your function:
#
#        names.arg = fb$country,
#        main="Governments being creepy, Jan-Jun 2013",
#        cex.main=.8)


# Hmm, that doesn't look quite right. Do you remember the argument that flips axis label orientation?
# Hint: Look back to the histogram section.

      
#      18. Turn the orientation of the x-axis labels so they are perpendicular with the x-axis.


# We can use cex to shrink text size.


#     19. Add the following arguments to your function:
#         cex.main=.8, 
#         cex.names=.65,
#         cex.axis=.8


# Okay, that's looking good. One last thing: let's add color!
# rainbow() is actually a built-in function in R, which is another reason R is great.


#     20. Add the following argument to your function:
#       col=rainbow(6)


#     21. What happens if you put in a value for rainbow that's less than the number of bars in our graph?


#* Protip *#
# You can also specify colors as a collection of strings:
# eg. col=c("red","green","yellow","blue","orange","darkorchid4")

# That's right, darkorchid4 is a thing.  R actually has over 600 colors to choose from!
# You can see the full list by calling the function colors() (with no arguments)

colors()


## 4. Box plots

# Box plots allow you to see the spread of values associated with categorical variables.
# Use the boxplot() function to make a box plot.

# - The 'box' in a box plot is made from the 1st quartile (bottom of the box) and 3rd quartile (top of the box). 
# - The thick bar inside the box is the median (2nd quartile).
# - The ends of the 'whiskers' (ie. the horizontal lines at the ends of the dashed lines)
#   represent points which are at a distance of 1.5x the length of the box (inter-quartile range), away 
#   from the box.  If the most extreme data point in your data is less than that distance from the box,
#   the whisker will stop at that data point, instead.
# - Bubbles that show up outside of the whiskers are considered to be outliers.

# We can go back to our SAT/ACT dataset for an example.
# Say we want to see the range of scores on the SAT Quantitative section, as it occurs in men and women.

boxplot( SATQ ~ gender, data=sat )

# 1 = male and 2 = female, so let's put in readable labels:

boxplot( SATQ ~ gender, 
         data=sat, 
         names=c("male","female") )
 
# See that funny squiggle? We use that a lot in R. 
# Always put your y-axis variable before the squiggle, and your x-axis variable after the squiggle.  
# (Y-axis here is metric, X-axis is categorical.)


#     15. Is the median score higher for men or women?


#     16. Which gender has a larger interquartile range? How do you know?


## Awesome job.  You're done for today.

## END SECTION 3 ##