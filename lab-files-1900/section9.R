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

################################################
##
##    Lab 09: Dependent samples (T-test, ANOVA)
##
################################################


## Welcome to Week 9 of Psych 1900 Section!
## This week we'll continue to work with t-tests and ANOVAs, but using dependent/repeated samples.

# First, let's install and load a few packages. 

# 'PairedData' is a package that has a bunch of datasets which are conducive to working with dependent-sample analysis.
  if (!require("PairedData")) {install.packages("PairedData"); require("PairedData")}  
# reshape allows formatting of data between wide and long formats
  if (!require("reshape")) {install.packages("reshape"); require("reshape")}
# ANOVA package extends aov() functionality
  if (!require("ez")) {install.packages("ez"); require("ez")}  


# A note on dependent samples:
# Dependent samples generally occur in one of two cases:
#   1. You are measuring the same thing at two different points in time
#       eg. Headache intensity before and after taking aspirin
#   2. You are measuring the same thing on two different, but related, measures
#       eg. Angle of flexion and extension of a certain muscle


##  I. Paired-sample t-tests (aka dependent-sample t-tests)

# We'll use a small dataset from Pruzek & Helmreich (2009), 
# which measured the weights of girls before and after treatment for anorexia. 
#
# This dataset is truncated and loaded via the PairedData package.
# You can use the data() function to load a dataset that comes installed via a package. Here, our data is called 'Anorexia'.
# With data(), you do NOT need to save the output as a variable. A dataframe called 'Anorexia' is created automatically!

data(Anorexia)
Anorexia
View(Anorexia)
# We can still use a t-test with dependent samples across two measurements, but with some minor modifications.
# Remember, a t-test looks at mean differences between two groups, taking the variance within each group into account.
# For independent-sample t-test, two groups are made up of totally separate observations (recall BMW vs Ford).


#     1. What are the two 'groups' in the Anorexia data?  
#         - Why do we say these groups are dependent?
#         - Do you expect the variance between these groups to be greater than, less than, 
#           or about the same as the variance between two independent groups? Why?
#         - Based on your answers above, why does it make sense to compute independent and dependent sample t-tests
#           using different (but related) formulas?


#     2. Generate histograms and boxplots for both groups. 
#         - Put both histograms in the same plot window (same window, separate plots)
#         - Put both groups' box plots on the same plot (same window, same plot)
#           Use the two-argument version of boxplot(), eg. boxplot(var1, var2)
#
#         Bonus: You can generate this same boxplot with only one argument - what is it?
#           Hint: Which columns in the data frame did you use to make the boxplot? 
#                 How many columns were left unused?


#     3. What is a good research question we can ask of this data?
#        Generate null and alternative hypotheses which can be evaluated with a t-test.


# One assumption of all t-tests is that the dependent variable has a normal distribution.
# Here, our dependent variable is the difference between Prior-Tx and Post-Tx weights.


#     4.  Check if dependent variable is normally distributed. Use two different visualizations and two tests.
#         Hint1:  This involves a few steps. Start with math and name your DV 'tx.diff'


# We can still use t.test() for paired-sample t-tests, with two minor adjustments:
#   - use a two-argument version of t.test()
#   - add an additional argument: paired = TRUE


#     5. Compute a paired-sample t-test to evaluate your hypotheses.
#         - Save the output in a variable: anorex.t
#         - Look at the results. Can you reject your null hypothesis?


# Note: If your data seriously violates t-test assumptions, you can run a non-parametric paired-sample t-test.
#       This is called a Wilcoxon test. Use wilcox.test() to run this analysis, with exactly the same
#       arguments as you used with t.test() for a parametric (regular) paired-sample t-test.
#       We won't spend too much time on the Wilcoxon, but you should know it's out there. 


#     6. Compute a Wilcoxon test on the Anorexia data.


##  II. Repeated-measures ANOVA (aka dependent-samples ANOVA)

# Repeated-measures ANOVA is just an extension of dependent-samples t-test, when there are more than 2 groups.

# Here, we'll use a very simple example dataset which lists the prices of groceries across four supermarkets.


#     7. Load this dataset into a variable: grocery
#         - Data URL: http://people.fas.harvard.edu/~mair/datasets/groceries.txt
#         - Note: this file has headers, and you don't have to worry about the 'sep' argument.
#         - Look carefully at the filename in this URL. Should you use read.csv() or read.table?
#         - View your data. What are the 'groups' in the data?
             

# Right now, the data is in a format where the prices for each store are listed in their own column.
# For ANOVA, we want the data in a different format. (Look back to the cog.dis data from last week.)
#
# The melt() function in the 'reshape' package is a very useful tool for re-formatting data.
# The 'one-group-one-column' format (which our data is currently in) is called 'wide' format.
# We want the data in 'long' format, where all the prices are in one long column, and all of the store
# names are in another long column. 
# melt() helps us to do this:

grocery.long <- melt(grocery, id.vars = "subject")     ## long form
colnames(grocery.long) <- c("subject", "store", "price")
grocery.long


#     8. Generate a box plot with prices on the y-axis, and each store represented on the x-axis.
#         Use the formula syntax - refer to section 8 code for a refresher.


# Computing a dependent-samples ANOVA is easy with the ezANOVA() function, from the 'ez' package.
# There are a ton of arguments to ezANOVA, so we'll give you the code to run it (just this once!)

fitaov <- ezANOVA(grocery.long, dv = price, wid = subject, within = store)
fitaov

# There's also a non-parametric version for dependent-samples ANOVA, called the Friedman test.
# As with non-parametric dependent-samples t-tests, you don't need to know too much about it,
# at least for this class, but here's the code to run one in case you need it some time.

friedman.test(grocery$price, grocery$store, grocery$subject)  


# III. Further practice

#     9. Load the IceSkating dataset that comes with the PairedData package, using data().
#         This dataset gives the speed measurement (m/sec) for seven ice-skating dancers, 
#         using the return leg in flexion or in extension.
#         - Are flexion and extension dependent measures? Explain your reasoning.
#         - Decide on a research question to ask of this data.
#         - Generate null and alternative hypotheses, then check for normality.
#         - Compute the appropriate dependent-samples test to test your hypotheses.
#         - Can you reject your null hypothesis, based on the results? Report your findings.


## END SECTION 9
