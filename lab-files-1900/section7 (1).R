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

###########################################################################
##
##    Lab 07: - Practicing the Research Cycle (using Chi-Squared analysis)
##
###########################################################################


## Welcome to Week 7 of Psych 1900 Section!
## This week we'll work with data cleaning and organization methods, and introduce Chi-squared analysis.
## We will go through each step of the research process - this is good practice for your final project!


# First, install the vcd package, and load it with the library() function. We need this package for mosaic plots.
# (If you need a reminder on how to install and load packages, check section 2 code, around line 78.)

##  I. Working with data (aka 'data munging')

# Note: 'To munge' means to adjust and re-organize data. 
#       Some kids at MIT made up the word about 40 years ago. Now it's a common term in data science.
#       http://en.wikipedia.org/wiki/Mung_(computer_term)

# Today we're going to work with the survey data that you provided last week. 


#     1.  Load the survey dataset into a variable named 'classdata'. 
#         - Use read.csv(), data has headers.
#         - Data URL: http://www.people.fas.harvard.edu/~reece/1900/f14-1900-classdata.csv
#         - Download the PDF of the actual survey: http://www.people.fas.harvard.edu/~reece/1900/f14-1900-survey.pdf


# Data feel a bit more personal when you can get a sense for the stories that they have to tell.
# Often, simple descriptive statistics can go a long way toward giving you a better feel for your data.

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


# There are lots of potentially interesting research questions we might ask of this data.
# Real people give real data, so there's always something to be discovered!
# Today we'll consider the following research question:
#
##   Is there a relationship between believing you are an awesome dancer, and being an emotional person?


#     3.  Find the variable names in the classdata data frame that correspond to these survey items.
#         - store the awesome dancer data in a variable called 'dance'
#         - store the emotional data in a variable called 'emo'


# The table() function provides a table of frequencies for each possible value of a variable. 
#
#   eg. table(my.variable)
#
# table() is like a numbery version of hist(), when you use it for just one variable. 
# But it especially comes in handy when we have two variables, and we want to have a 2-D table of frequency counts 
# for each combination of variable values.
# 
#   eg. table( my.first.var, my.second.var )


#     4.  Generate a table of the dance variable. Then make a histogram of the dance variable.
#         Do the same for the emo variable.
#         Look at the range of response values listed in the survey PDF.
#         What do the highest and lowest reponse values represent, in words?


# Look at the range of values reported in your table, and compare them to the range of possible values in the survey itself.
# You'll notice they're off by 1 - the survey goes from 0 to 4, but our data range from 1 to 5. 
# This is just an artifact of the survey software used, so don't worry too much about it. 
# But it's always good to check for this sort of thing when you are collecting your own data - it's easy to have little glitches like
# this cause big problems if they go unnoticed! For now, just keep in mind that the scale is shifted up by one in our data.


## II. Operationalize the problem

# Ok, so we have a research question.  But now how exactly do we want to go about finding our answer?

# All of the self-report variables (including our chosen items, dance and emo) are ranked on a 0 to 4 scale. 
# To keep things simple, we'll re-categorize the responses into two categories: low (1-3) and high (4-5).

## Note:  In general, be careful about splitting up variables into chunks - especially with metric variables.  
#         Say you have SAT scores, and you want to use the scores as a predictor of some other variable (say, GPA). 
#         If you lump all the scores into 'high' and 'low' categories, you now have a categorical variable, whereas before you 
#         had a metric variable. This conversion often comes along with a loss of information, and you should have a principled reason 
#         for manipulating your data like this. If you have a metric variable, it is usually best to keep it metric in your analyses.
#         In this case, our variables are techincally ordinal, and so we are making a subjective choice as to how to define 'low' and 
#         'high' cutoffs.  We could just as easily have said that low = 1-2, and high = 3-5. For the purposes of this example, we won't 
#         worry too much about the choice of cutoff point. 
#         But as researchers, you should always be able to justify the choices you make when manipulating your data.

# We can re-categorize using the cut() function. cut() chops up a variable into pieces, marked by break points of our choosing.
# Here, our break points are: 1 to 3, and 3 to 5. 
# Because of the way cut() is designed, we need to pick points just outside our upper and lower bounds, so we'll actually use:
# 0.9 to 3, and 3 to 5.1. 
# cut() takes two required arguments: the variable to cut, and the break points.
# Here's how we can cut our dance variable:

  dance2 <- cut(dance, breaks = c(0.999, 3, 5.1), labels = c("bad", "good"))

# Note: It's good to rename our newly-cut variable, because we may still want to refer to our original 'dance' variable in the future.

# Now we can use table() again to see the proportions between our two new categories.

  table(dance2)
 

#     5.  Cut the emo variable into a new variable: emo2
#         - Use the break points specified above.
#         - Label the two cut categories as "low" and "high".
#         - Check the table output of emo.cut. How many highly emotional people are there in this sample?


## III. Hypothesis generation

# Time to make some null and alternative hypotheses. 
# Let's say our null hypothesis is: belief in one's dancing skillz and being an emotional person are independent.
# That means our alternative hypothesis is: belief in one's dancing skillz and being emotional have some dependency.


#     6.  Could we have decided to make our null hypothesis that the two variables are dependent?
#         Why does it make more sense to set our null and alternative hypotheses the way we chose?


## IV. Descriptives & Plots

# Note: Looking at descriptive statistics and visualizations are important throughout the entire research cycle. 
#       Once we have a formal hypothesis and operationalized data, it makes sense to look at specific descriptives.
#       But as you can see, we also used descriptive statistics to first get a feel for our new dataset. It's always a good thing.

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


## V. Testing our hypothesis.

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


## VI. Interpretation


#     7.  Based on the results of the Chi-squared test, can we reject our null hypothesis?
#
#         Did the results of the test match your predictions from looking at the bar plot?
#         What can you say about the relationship between visual inspection of data and statistical analysis, based on these results?


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