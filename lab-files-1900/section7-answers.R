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
##    Lab 07: - Chi-Squares and Data Munging
##
############################################


## Welcome to Week 7 of Psych 1900 Section!
## This week we'll work with data cleaning and organization methods, and introduce the Chi-square.

# First, install the vcd package, and load it with the library() function.
# (If you need a reminder on how to install and load packages, check section 2 code, around line 78.)

##  I. Working with data (aka 'data munging')

# We're going to work with the survey data that you provided last week. 


#     1.  Load the survey dataset into a variable named 'classdata'. 
#         - Use read.csv(), data has headers.
#         - Data URL: http://www.people.fas.harvard.edu/~reece/1900/f14-1900-classdata.csv
#         - Download the PDF of the actual survey: http://www.people.fas.harvard.edu/~reece/1900/f14-1900-survey.pdf


df <- read.csv('http://www.people.fas.harvard.edu/~reece/1900/f14-1900-classdata.csv', header=T)
View(df)
# Data feel a bit more personal when you can get a feel for the stories that they tell.
# Often, simple descriptive statistics can go a long way toward giving you a better sense for your data.

# Note: Keep in mind that the dataset has converted everything to a number - even for survey questions that have textual answers. 
# So for instance, a reponse of '1' on the Stalking variable corresponds to the answer: 'It's creepy, I don't do it.' 
# Remember to refer to the PDF copy of the survey when you need to interpret an answer back to its original text.


#     2.  Find answers to the following questions. 
#         Remember to check for missing values, and exclude when necessary. (See Section 4 code, around line 73, for a refresher.)
#         (There's more than one way to find each answer, use whatever approach you most prefer - just don't count by hand!)
#
#         - What is the second-most-common class year in this course? ('class year' means: fresh, soph, jr, sr)
#         - What is highest and lowest number of close friends reported?
#         - What is the modal number of drinks per week in this sample?
#         - Who do most people in this sample think is funniest?


hist(df$Year)
range(df$CloseFrnds, na.rm=T)
hist(df$DrinksWk)
table(df$Funny)

# There are lots of potentially interesting research questions we might ask of this data.
# Real people give real data, so there's always something to be discovered!
# Today we'll consider the following research question:
#   Is there a relationship between believing you are an awesome dancer, and being an emotional person?


#     3.  Find the variable names in the classdata data frame that correspond to these survey items.
#         - store the awesome dancer data in a variable called 'dance'
#         - store the emotional data in a variable called 'emo'

dance <- df$SelfReport_3
emo <- df$SelfReport_5

# The table() function provides a table of frequencies for each possible value of a variable. It's kind of like
# a numbery version of hist(), when you use it for just one variable. It comes in handy when we have two variables,
# and we want to have a 2-D table where we can observe the frequencies for each combination of variable values.


#     4.  Generate a table of the dance variable. Then make a histogram of the dance variable.
#         Do the same for the emo variable.
#         Look at the range of response values listed in the survey PDF.
#         What do the highest and lowest reponse values represent, in words?

table(dance)
hist(dance)
# 0 = not at all true, 4 = totally true

# Look at the range of values reported in your table, and compare them to the range of possible values in the survey itself.
# You'll notice they're off by 1 - the survey goes from 0 to 4, but our data range from 1 to 5. 
# This is just an artifact of the survey software used, so don't worry too much about it. 
# But it's always good to check for this sort of thing when you are collecting your own data - it's easy to have little glitches like
# this cause big problems if they go unnoticed! For now, just keep in mind that the scale is shifted up by one in our data.


# All of the self-report variables (including our chosen items, dance and emo) are ranked on a 0 to 4 scale. 
# To keep things simple, we'll re-categorize the responses into two categories: low (1-3) and high (4-5).
# We can do this using the cut() function. cut() chops up a variable into pieces, marked by break points of our choosing.
# Here, our break points are: 1 to 3, and 3 to 5. 
# Because of the way cut() is designed, we need to pick points just outside our upper and lower bounds, so we'll actually use:
# 0.9 to 3, and 3 to 5.1. cut() takes two required arguments: the variable to cut, and the break points.
# Here's how we can cut our dance variable:

  dance2 <- cut(dance, breaks = c(0.999, 3, 5.1), labels = c("bad", "good"))

# Note: It's good to rename our newly-cut variable, because we may still want to refer to our original 'dance' variable in the future.

# Now we can use table() again to see the proportions between our two new categories.

  table(dance2)
 

#     5.  Cut the emo variable into a new variable: emo2
#         - Use the break points specified above.
#         - Label the two cut categories as "low" and "high".
#         - Check the table output of emo.cut. How many highly emotional people are there in this sample?


emo2 <- cut(emo, breaks = c(0.999, 3, 5.1), labels = c("low", "high"))
table(emo2)

# Time to make some null and alternative hypotheses. 
# Let's say our null hypothesis is: belief in one's dancing skillz and being an emotional person are independent.
# That means our alternative hypothesis is: belief in one's dancing skillz and being emotional have some dependency.

# Now that we have two variables to compare, we can use table() to look at the observed frequencies in each cell of
# the 2x2 table formed by emo2 and dance2. We'll save the output of table() in a variable, called 'emodance'.

  emodance <- table(emo2, dance2)
  emodance

# We can get the total number of observations with sum()

  sum(emodance)            

# margin.table() gives us marginal frequencies each variable.

  margin.table(emodance, 1)                     
  margin.table(emodance, 2)                    

# Compare this with the regular table() function for each variable:

  table(emo2)
  table(dance2)

# Why does it make sense that margin.table and table() give the same values here?

# prop.table() gives the relative frequencies of each cell in our 2x2 table.
# (This is equivalent to reporting the percentage of overall responses accounted for in each cell.)

  prop.table(emodance)                         

# Remember our old friend, barplot()?  
# Here we can just enter our table variable (emodance) into the barplot() function, and it will display bars for both variables. 
#This version of barplot() has a few extra arguments needed, so we've provided the code for you. 
# Try and understand what each argument is doing.  
# In particular, try running the same bar plot, but with beside set to FALSE. Which version do you think conveys the data better?

barplot(emodance, main = "Grouped Bar Chart", xlab = "Dancer", legend.text = rownames(emodance), 
       beside = TRUE, args.legend = list(x = "topright", title = "Emotional"))


#     6.  Based on the barplot, do you predict that the two variables are dependent or independent?
#         Explain your reasoning.


# We can also display our observed frequencies with a mosaic plot, using the mosaic() function.

mosaic(emodance, main = "Mosaic Plot EmoDance")         

# Now that we've had a good look at our observed data, it's time to test our hypothesis.
#
# We can use a Chi-squared test, with the chisq.test() function. 
#
# Recall that Chi-squared compares the observed frequencies in each cell of a table, against what one would 
# expect if the variables were completely independent. If the difference between observed and expected isn't 
# significantly different than zero, then the variables display independence, and the 
# Chi-squared test will report a p-value above 0.05.

emodance.chi <- chisq.test(emodance)
emodance.chi

# Use the 'expected' variable produced by chisq.test() to see the table of expected frequencies, under the null hypothesis.

emodance.chi$expected

# Now compare this with our observed frequencies table:

emodance


#     7. Based on the results of the Chi-squared test, can we reject our null hypothesis?


# We can also look at residuals:

emodance.chi$residuals      

# You may recall from the lecture slides that a Chi-Squared test was accompanied by a mosaic plot with residuals shading.
# This is generated by adding the argument: shade = TRUE to the mosaic() function call.

mosaic(emodance, main = "Mosaic Plot Emo-Dance", shade = TRUE)       

# Since the residuals are so small, there's no shading here. Sorry.


#     8.  Further practice
#         Pick two more categorical variables from the class survey data.
#         Re-categorize them if needed, using the cut() function, generate null and alternative hypotheses,
#         and perform a Chi-squared analysis. Generate a grouped bar chart, a mosaic plot, and a residual-shaded mosaic plot.


## END SECTION 7