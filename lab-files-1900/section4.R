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
##    Lab 04: - Correlation
##                - Pearson's r
##                - Spearman's rho
##            - Hypothesis Testing
##
############################################


## Welcome to Week 4 of Psych 1900 Section!
## This week we're going to do our first full analysis of a dataset. Momentous!

# First, we need to install and load a package.  Run this following line of code.

if (!require("beanplot")) {install.packages("beanplot"); require("beanplot")}  ## package for beanplot


## I. Pearson Correlation

# Correlation identifies relationships between two metric variables. 
# Height and weight are positively correlated, for example, meaning that taller people tend to weigh more.
# Alcohol intake and coordination are negatively correlated - the more you drink, the harder it is to walk straight.


#     1.  There are three kinds of linear correlation. (We just saw examples of two of the three, above.)
#           - positive correlation
#           - negative correlation
#           - no correlation
#         Come up with an example of each kind of linear correlation.
#
#         Bonus: What might a non-linear correlation look like? 
#         Hint:  Consider the Riddle of the Sphinx. (http://www.answers.com/Q/What_is_the_riddle_of_The_Sphinx)


## Today we'll look at a dataset that compares the physical size of someone's brain against their IQ and physiology.

## Remember: You can always look at code from previous sections if you can't remember how to do something.

#     2.  Load the following dataset into a variable called: bsiq      (short for 'Brain Size IQ')
#         - Use read.table(), not read.csv()
#         - There are headers in this dataset, so make sure to declare this with the proper argument to read.table()
#         - The data in this file are separated by tabs, not commas.  (Sometimes called a TSV instead of CSV.)
#         - We need to tell read.table() about this, so add the argument: sep = "\t"
#
#         Dataset: http://www.people.fas.harvard.edu/~mair/datasets/BrainSizeIQ.csv


#     3. View the content of bsiq.  
#
#      - How many categories of data are there? How many entries are there in this dataset?
#       - What is the Weight value for the second row of data?  What does this mean?


#     4. Execute this function: dim( bsiq )
#
#       What does the output of the dim() function tell you? 
#       ( If you're stuck, compare your answer to the first part of 3. )


## Missing values are important to keep an eye on in your data. 
# R marks missing values as "NA".
# Some R functions won't run properly if you don't tell them ahead of time that data is missing.  
# Sometimes you may see arguments to functions like: "na.rm = TRUE"
# That argument tells R to remove ("rm") any NA values before carrying out the function on your data.

## Here are the names of each variable in bsiq, along with a brief description.

  #  Gender: Male or Female
  #  FSIQ: Full Scale IQ scores based on the four Wechsler (1981) subtests
  #  VIQ: Verbal IQ scores based on the four Wechsler (1981) subtests
  #  PIQ: Performance IQ scores based on the four Wechsler (1981) subtests
  #  Weight: body weight in pounds
  #  Height: height in inches
  #  MRI_Count: total pixel Count from the 18 MRI scans 

## We are specifically interested in the MRI_Count variable.
# An MRI generates an image of a brain. Just like with a digital camera, the images are made up of pixels.
# A bigger image takes up more pixels, so pixel count is essentially a measure of physical brain size.

## We can look at some descriptive statistics of MRI_Count:

summary(bsiq$MRI_Count)             
sd(bsiq$MRI_Count)


#     5.  What statistics does the summary() function provide? 
#         What statistic does the sd() function provide?


#     6.  Make a histogram of MRI_Count, with the following specifications:
#         - 10 breaks
#         - Plot title: "MRI Histogram"
#         - X axis label: "MRI Count"


#     7.  Make a boxplot of MRI_Count, with plot title: "MRI Box Plot"


## A nice alternative to box plots are bean plots! 
beanplot( bsiq$MRI_Count, col = "#CAB2D6", border = "#CAB2D6", main = "MRI Beanplot" )

## We want to compare MRI_Count with other metric variables in our data, to look for correlations.
#  First we'll compare with the Height variable.


#     8.  What is your prediction for the relationship between MRI_Count and Height?
#         Formally declare your null hypothesis and your alternative hypothesis.


#     9.  Run the same set of descriptive statistics and visualizations for Height as you did with MRI_Count.
#         - summary(), sd(), hist(), boxplot(), beanplot()
#     
#         What happened with sd()?  Why do you think this happened?
#         Try running it again, but add the argument: na.rm = TRUE
#         What does sd() output now?


## Now that we have a better sense for MRI_Count and Height, let's look at how they relate to each other.

#     10. Make a scatterplot with the following specifications:
#         - MRI_Count on the x-axis, Height on the y-axis
#         - Plot label: "Brain Size and Body Height"
#         - X-axis label: "MRI Pixel Count"
#         - Y-axis label: "Body Height"
#         - Make all points blue!
#
#         Now add the argument: pch=19.  What happens?  
#         Try pch with 2, 3, 4, and 5. Pick one you like and stick with it.


#     11. Based on your scatterplot, what kind of correlation do you predict between MRI_Count and Height?
#         Is this in line with your first guess from question 8?


## Now compute the correlation statistic between MRI_Count and Height.
#  We'll use the cor() function to get the Pearson's correlation coefficient.

cor.pearson <- cor(bsiq$MRI_Count, bsiq$Height, use = "complete.obs")
cor.pearson


#     12. What is the value of the correlation coefficient? 
#         Explain what this coefficient means in relationship to MRI_Count and Height.
#         (Meaning, use normal language and explain to someone else in your group.)


#     13. Why did we include the argument: use = "complete.obs" with cor()?
#         Hint: Look at the 'use' argument description on the help page for cor().


## The correlation coefficient is useful, but we want to evaluate our hypothesis.
#  Null hypothesis: Correlation between MRI_Count and Height is not statistically different than zero.
#  Alt  hypothesis: Correlation is statistically significant.
#  To test these hypotheses, we need a way to determine statistical significance.
#  We can use the cor.test() function for this.

cor.test(bsiq$MRI_Count, bsiq$Height)        


#     14. According to the p-value for our test statistic, can we reject the null hypothesis?
#         Look at the 95% confidence interval. Explain what it means to someone else in your group.


## Pearson's "r", as the correlation coefficient is called, is very well-known and easy to interpret, 
#  so in general it is a good statistic to use when identifying correlations. 
#  However, it doesn't do very well when your data looks weird, so always check if you 
#  have anything unusual going on in your data before you assume it's safe to proceed.
#
#  Why is it important to check the normality of your data?
#  Almost all statistical tests operate under a set of assumptions. 
#
#  The more assumptions you make about your data, the more you can narrow down your focus, 
#  and so you can (generally) be more exact and accurate in your analysis. 
#
#  "Parametric" statistical tests make several assumptions about data which allows them to be highly 
#  specific. Most common statistical tests are parametric tests.
#
#  On the other hand, "non-parametric" tests make far fewer assumptions about your data, and you can 
#  use non-parametric tests even when you have messy or irregular data. They tend to be less specific though.

## For example, Pearson's correlation test performs best under a handful of assumptions.  
#  Let's see if it is safe to make these assumptions about our data.

## Our variables should be (roughly) normally distributed.  Like a bell curve, more or less.


#     15. Make histograms of MRI_Count and Height, but first enter this line of code:
#
          op <- par(mfrow = c(1,2))
#
#         Now make the histograms.  What changed?
#         Use the following line of code to reset the Plot window.
#
          par(op)


## Okay, the histograms look normal-ish. But histograms can be misleading, depending on how many breaks are set.
#  Better to use a Q-Q plot!

op <- par(mfrow = c(1,2))

qq.mri <- qqnorm(bsiq$MRI_Count)  

abline( lm( qq.mri$y ~ qq.mri$x ) )


#     16. What did the abline() function do? 
#         - Don't worry about understanding the lm() argument for now. We'll see more of lm() later.
#         
#         Bonus: Make the abline green.


#     17. Make a Q-Q plot for the Height variable.  Assign it to the variable: qq.height
#         - Add: lm(qq.height$y ~ qq.height$x)   as an argument to abline (just like in the previous example)


## Remember to reset the Plot window.  What was the function that did this earlier?

## Q-Q plot looks good. We can conduct a few more tests of normality.

# The first test is called 'Kolmogorov-Smirnov'. "KS test" for short.

ks.test(bsiq$MRI_Count, "pnorm", mean = mean(bsiq$MRI_Count), sd = sd(bsiq$MRI_Count))  
ks.test(bsiq$Height, "pnorm", mean = mean(bsiq$Height, na.rm = TRUE), sd = sd(bsiq$Height, na.rm = TRUE))

# Another test is called the Shapiro-Wilks test. "SW test" for short.
# You can read more about KS and SW tests in the Field book.

shapiro.test(bsiq$MRI_Count)        
shapiro.test(bsiq$Height) 

## All of these tests for normality of our data have checked out.
#  That means we can feel confident that our correlation coefficient is accurate,
#  and we can decide whether to reject or not reject the null hypothesis based on our analysis.


## 2. Spearman correlation

## In this example we'll work with a different kind of correlation coefficient, called "Spearmans' rho".
#  Spearman correlation is used when data is irregular in some way, in which case Pearson's coefficient is unreliable.

## We'll use the same brain scan dataset.  
#  This time, we want to examine the relationship between brain size and IQ.


#     18. What relationship do you predict between these two variables?
#         Formally declare your null and alternative hypotheses.


#     19. Make a scatterplot with the following specifications:
#         - MRI_Count on the x-axis, FSIQ on the y-axis
#         - Plot label: "Brain Size and IQ"
#         - X-axis label: "MRI Pixel Count"
#         - Y-axis label: "Wechsler IQ"
#
#         What kind of relationship do you see?  Does anything look weird?


#     20. Check for normality of data with both variables (MRI_Count and FSIQ)
#         Use the following methods:
#           - histogram
#           - Q-Q plot
#           - Kolmogorov-Smirnov test
#           - Shapiro-Wilk test


#     21. Now compute the Spearman correlation coefficient.  
#         Use cor.test(), but add the argument: method = "spearman"


#     22. Based on your findings, do you reject or fail to reject your null hypothesis?


#     23. Write up a short description of both of the hypothesis tests you conducted today
#         Include results, relevant test statistics, and your final conclusions.


## Congratulations! You just completed your first full statistical analysis. You did a great job.


## END SECTION 4