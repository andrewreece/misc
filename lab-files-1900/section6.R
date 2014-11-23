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
##    Lab 05: - Regression, part 2
##
############################################


## Welcome to Week 6 of Psych 1900 Section!
## This week we're going to work with multiple regression.

# We'll use the same supermodel dataset from Section 5.
# Here's a refresher on the details of that data:

# Supermodel Dataset Background: 
#   A fashion student collected data from 231 models. 
#   For each model she asked them their salary per day on days when they were working, 
#   their age, how many years they had worked as a model, and then got a panel of experts 
#   from modeling agencies to rate the attractiveness of each model as a percentage, 
#   with 100% being perfectly attractive.


##   I. Building Intuition for multiple regression

#       1.  Load the supermodel dataset into a variable called 'supermodel'. 
#
#           - use read.table() 
#           - you don't need to specify the 'sep' argument, but this data file does have headers
#           
#           Dataset URL: http://people.fas.harvard.edu/~mair/datasets/Supermodel.dat


##   A note on regression and "best fit": 
#
#     One way to think about linear regression is that it draws a straight line through all the dots on your scatter plot.
#     This is the line that, on average, is the shortest distance away from each individual data point. 
#     We call this "the line of best fit".
#
#     Imagine you wanted to build a straight road through a neighborhood, so that the road was as close as it could be to 
#     each house in that neighborhood. You could make the road so that it came really close to a couple of houses, but then it 
#     might be really far away from other houses. The best road would find the perfect balance between distances to each house.
#     That doesn't mean that the road will be exactly the same distance from each house - some houses will be closer and some
#     farther away.  What "best fit" means is that your road goes through the neighborhood on exactly the straight line that
#     minimizes the average distance from each house. 


#       2.  Complete these steps for each of the following independent variables: AGE, YEARS, BEAUTY.
#           (Meaning, go through all these steps with AGE, then go through them again with YEARS, then BEAUTY.)

#           i.    Make a scatter plot with SALARY on the y-axis, and IV on the x-axis. 
#           ii.   Run a linear regression with SALARY as DV.  
#                   Save each model as a variable: model.<IV_NAME_HERE> 
#                   (Eg. model.AGE)
#           iii.  Determine whether the IV has a significant impact on the DV.
#           iv.   Draw a line of best fit on your scatter plot, using the following line of code
#                 Insert the correct variables where indicated. 
#                 ( Meaning, if it says <INSERT_X_HERE>, delete <INSERT_X_HERE> and replace with variable X )
#
#                   lines(<INSERT_IV_HERE>, predict(<INSERT_MODEL_VARIABLE_HERE>), col = "<INSERT_FAVORITE_R_COLOR_HERE!>")
#           v.    Compare best fit lines with your findings from iii.)  What connection do you see?
#
#           Bonus (harder):  
#                   What kind of shape does the scatterplot for SALARY ~ BEAUTY suggest? 
#                   We can evaluate non-linear fits with lm(). 
#                   Run lm() with SALARY as DV and BEAUTY as IV, but use I(BEAUTY^2) instead of BEAUTY for IV.
#                   If the data really do follow a non-linear shape, we will see the line of best fit change with lines()
#                   Now run lines, exactly as before - use BEAUTY, not I(BEAUTY^2) for IV. Use the new model variable name.
#                   Does the line of best fit differ?  Does this surprise you?  How might you explain this finding? 
#                   Hint: Look at the density of bubbles in the upper and lower regions of the scatterplot.


## Protip: Use pairs() to see all scatterplots at once. 

pairs(~ supermodel$SALARY + supermodel$AGE + supermodel$YEARS + supermodel$BEAUTY)


#       3.  Based on your work in #2, what do you expect to see in a multiple regression, using all IVs at once?
#           Meaning, which variables would you predict to have a significant impact on SALARY?


##    II. Multiple Regression

#   We can use lm() for multiple predictors. Use the + sign to indicate multiple predictors in a model.
#   Example: lm( DV ~ IV.1 + IV.2 + IV.3 )


#       4.  Run a multiple regression with: SALARY as DV; AGE, YEARS, and BEAUTY as IVs.
#           Save this as variable: model.multi
#
#           - Look at the model output with summary()
#           - Which IVs have a significant impact on SALARY?
#           - What percent of the variance in SALARY is accounted for in this model?


## Protip: It doesn't matter what order you list your IVs for lm().  (Try it and see!)


#       5.  Run a multiple regression with: SALARY as DV; AGE, YEARS as IVs.
#           Save this as variable: model.age.year
#
#           - What percent of the variance in SALARY is accounted for in this model?
#           - Compare this with the effect size in model.multi. 
#             What does this tell you about the usefulness of including BEAUTY in the model?


#       6.  In general, what have you learned about the importance of beauty in this sample?
#           What matters most (out of the variables we have observed) for making money as a model in this sample?


##  III. Checking assumptions 

#   Normality of residuals is an important indicator for the validity of a linear regression.
#   It's the same set of tools for evaluating normality as we've used in the past:
#       histogram, Q-Q plot, KS test, and SW test. (see section 4 code for a refresher)
#   The only new technique we'll introduce here is how to extract residuals from a regression model variable.
#   Use rstandard() to extract standardized residuals from a variable that holds the results of an lm() command.
#   Example: rstandard(model.1)


#       7.  Extract the residuals from model.multi, and check for normality.
#           What did you find?  What does this mean about the inferences you can make from this model?


#   We can also make a scatterplot with fitted values vs standardized residuals. 
#   The pattern of residuals should be totally random. (What would it mean if the pattern was not random?)
#
#   To get fitted values from a regression model, use fitted.values(). Insert your model variable as an argument.
#   You can save fitted values as a variable and enter the variable into plot() as you normally would,
#   or you can run the fitted.values() function directly inside plot(). 


#       8.  Plot the fitted values from model.multi against the standardized residuals.
#           Make sure to label your x-axis ('Fitted Values') and y-axis ('Standardized Residuals').


## IV.  Further practice

#   Chapter 7 in the Field book talks all about regression.  You should read it!  One of the datasets Field uses is
#   related to music sales. Run through the same steps you completed in this section, but use the album sales data:
#   http://www.sagepub.com/dsur/study/DSUR%20Data%20Files/Chapter%207/Album%20Sales%202.dat
#
#   In particular, pay attention to the normality of residuals in this data, and compare them with the normality
#   of residuals in the supermodel data. For which dataset can you safely make population-level inferences, based on
#   the output of your regression analysis?


## Awesome job.  This is one of the rare instances where regress leads to progress!


## END SECTION 6