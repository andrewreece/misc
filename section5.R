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
##    Lab 05: - Regression, part 1
##
############################################


## Welcome to Week 5 of Psych 1900 Section!
## This week we're going to work with linear regression.


## I. Investigating the data


# We'll start by loading in a real-world dataset from the fashion industry.

# Background: A fashion student collected data from 231 models. 
#             For each model she asked them their salary per day on days when they were working, 
#             their age, how many years they had worked as a model, and then got a panel of experts 
#             from modeling agencies to rate the attractiveness of each model as a percentage, 
#             with 100% being perfectly attractive.


#       1.  Load the following dataset into a variable called 'supermodel', and address the following points: 
#
#           - use read.table() 
#           - you don't need to specify the 'sep' argument, but this data file does have headers
#           
#           Dataset URL: http://people.fas.harvard.edu/~mair/datasets/Supermodel.dat


#########  IMPORTANT NOTE  ##########
#
#       When you load data using read.table() or read.csv(), you get something called a "data frame".
#       Just like an Excel spreadsheet uses columns and rows as a kind of framework for holding data, 
#       data frames have that column-row structure too.  That's why it's called a data 'frame'.
#
#       We'll use this term, 'data frame', from now on to distinguish between the variable that you load your data into, 
#       and the variables represented inside that data. (Otherwise, everything just ends up getting called 'a variable', 
#       which can get confusing.)
#
#       For example, 'supermodel' is a data frame. 
#       The columns of data held in supermodel are the variables in our data.
#
######################################


#       2.  How many variables are there in the supermodel data frame?  
#           What are the names of these variables?
#           
#           Bonus:  This is data from the UK. How much would you guess one unit represents in the metric SALARY variable? 
#                   (In other words, if one datapoint had a '1.0' in the SALARY column, 
#                    how much do you think that means that model is reporting as a daily wage?)      


#       3.  Make histograms for the AGE and SALARY variables. 
#
#           - Use range() to find the minimum and maximum age and salary represented in the data.

#           - Bonus:  Display the two histograms in the same plot window, side-by-side. ( Hint: par() )
#           - Bonus:  Display the two histograms in the same plot window, one above the other.
#           (If you do this bonus, reset the plot window once you're done, using par(mfrow=c(1,1)) .)


# NOTE: R likes to display numbers in scientific notation. 
#
# If you would rather just see numbers, you can turn it off using:
    options(scipen=999)
# If you want to turn scientific notation back on, use:
    options(scipen=0)


#       4. Make a scatterplot with the AGE and SALARY variables.
#
#         - Which variable would you place on the x-axis?  Why?
#         - Make meaningful labels for the x-axis and y-axis. Add a title.
#         - What is the age of the highest-paid model?
#         - Do you think there is a correlation between the two variables? If so, in which direction?
#
#         Bonus (harder):  
#                 Find the mean BEAUTY rating. 
#                 Now add these two arguments to your plot() function, inserting mean beauty where noted: 
#                   col=ifelse(supermodel$BEAUTY <= REPLACE_THIS_WITH_AVG_BEAUTY, "black", "magenta")
#                   pch=ifelse(supermodel$BEAUTY <= REPLACE_THIS_WITH_AVG_BEAUTY, 4, 2)
#                 What additional information is now shown on this plot?  
#                 What would you have expected to see here?


#       5. Compute a correlation coefficient between model age and salary.
#
#         - Use qqnorm() and ks.test() to check the normality of these two variables. What do you see?
#         - Compute a correlation with both Pearson's and Spearman's coefficients. 
#           Is one coefficient more appropriate than the other here? Why or why not?


#       6.  Define a null and alternative hypothesis that describes your prediction for 
#           the impact of age on salary, based on the data in this sample.


##  II. Linear Regression


# Now that we've looked at the data and developed a hypothesis, we can test it with regression.
# Use the lm() function to compute linear regression in R.

# You can use ?lm to see the help page for this function, but there's a lot of stuff there we won't go into.
# For now, learn to use lm() with the following syntax:

#   lm( DV ~ IV, data = NAME_OF_DATA_FRAME )

#   This computes a linear regression of the DV variable onto the IV variable. 

#   A quick refresher on DV vs IV:
#   DV = 'dependent variable', IV = 'independent variable'
#   You are interested in the impact of the IV on the DV.
#   Here, we want to know the impact of AGE on SALARY. 

#   If you specify the 'data' argument using the name of your data frame, 
#   you don't need to use $ syntax with your variables - you can just use their names directly.

    lm( SALARY ~ AGE, data = supermodel)

#   (You can also just leave out the data argument and use $ syntax instead - it's the same either way.)

    lm( supermodel$SALARY ~ supermodel$AGE )

#   A note on lm() syntax:
#
#   It's a little odd at first to see our IV listed after our DV in the lm() function. 
#   After all, with plot(), we input the x-axis variable first (which is usually our IV), and the y-axis variable after that.
#
#   But in lm(), we use something called 'formula' notation, which uses that little squiggle (~).
#   Formula notation puts our DV first, before the squiggle, and our IV after the squiggle. 
#
#   If it helps, you can just remember that squiggles are slightly weird, so it makes sense 
#   that the order of variables with squiggle syntax is slightly weird, too.
#   You can also remember that in regression, we say "Y is regressed on X", or "DV is regressed on IV"
#   So the squiggle just means "is regressed on". 


#   Now let's assign the output of lm() to a variable in R:

my.output <-  lm( SALARY ~ AGE, data = supermodel)

#   Simply accessing that variable doesn't give us much, 
#   although we do get the regression coefficient and intercept for AGE:

my.output

# The summary() function is more informative.

summary(my.output)

# We can get confidence intervals for the AGE regression coefficient with confint():

confint(my.output)


#       7. Find the following statistics:
#
#         - Regression coefficient estimate for AGE
#         - 95% confidence interval for AGE regression coefficient
#         - Intercept value (What does this value represent, practically?)
#         - The t-value and p-value for AGE coefficient 
#         - R-squared value (adjusted and non-adjusted) for the regression model
#
#         Bonus:  Run the following lines of code:
#
#                 cor(supermodel$AGE,supermodel$SALARY)
#                 sqrt(summary(my.output)$r.squared)
#                 
#                 cor(supermodel$AGE,supermodel$SALARY)^2
#                 summary(my.output)$r.squared
#
#                 Why do the values in each pair come out equal to one another? 


#       8.  What percent of the variance in SALARY is explained by AGE? 
#           What statistic tells you this information? 


#       9.  Does age have a significant impact on salary?
#           Can you reject or fail to reject the null hypothesis, based on this finding?



## This is a day's work well done.  Excellent work!
## Next time we'll continue exploring the world of high fashion, with multiple regression.


## END SECTION 5