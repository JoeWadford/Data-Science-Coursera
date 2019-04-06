# week 3 - Coursera:  R Programming
# Swirl assignment:  vapply and tapply

setwd("C:/Users/joewa/OneDrive/Desktop/Coursera/Swirl/lapply, sapply, vapply, tapply")
read.csv("flags.csv")


## exploring the flag dataset

dim(flags)
#### [1] 194 30

head(flags)
  #             name landmass zone area population language religion bars stripes colours red green blue gold white black
  # 1    Afghanistan        5    1  648         16       10        2    0       3       5   1     1    0    1     1     1
  # 2        Albania        3    1   29          3        6        6    0       0       3   1     0    0    1     0     1
  # 3        Algeria        4    1 2388         20        8        2    2       0       3   1     1    0    0     1     0
  # 4 American-Samoa        6    3    0          0        1        1    0       0       5   1     0    1    1     1     0
  # 5        Andorra        3    1    0          0        6        0    3       0       3   1     0    1    1     0     0
  # 6         Angola        4    2 1247          7       10        5    0       2       3   1     0    0    1     0     1
  #    orange mainhue circles crosses saltires quarters sunstars crescent triangle icon animate text topleft botright
  # 1      0   green       0       0        0        0        1        0        0    1       0    0   black    green
  # 2      0     red       0       0        0        0        1        0        0    0       1    0     red      red
  # 3      0   green       0       0        0        0        1        1        0    0       0    0   green    white
  # 4      1    blue       0       0        0        0        0        0        1    1       1    0    blue      red
  # 5      0    gold       0       0        0        0        0        0        0    0       0    0    blue      red
  # 6      0     red       0       0        0        0        1        0        0    1       0    0     red    black

str(flags)
#### internal structure of flags dataset

summary(flags)
#### summary of flags

sapply(flags, unique)
#### displays the unique values in flags

# intro to vapply

vapply(flags, class, character(1))
  #   name   landmass       zone       area population   language   religion       bars    stripes    colours        red 
  # "factor"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer" 
  #  green       blue       gold      white      black     orange    mainhue    circles    crosses   saltires   quarters 
  # "integer"  "integer"  "integer"  "integer"  "integer"  "integer"   "factor"  "integer"  "integer"  "integer"  "integer" 
  # sunstars   crescent   triangle       icon    animate       text    topleft   botright 
  # "integer"  "integer"  "integer"  "integer"  "integer"  "integer"   "factor"   "factor" 

sapply(flags, class)
  #   name   landmass       zone       area population   language   religion       bars    stripes    colours        red 
  # "factor"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer"  "integer" 
  #  green       blue       gold      white      black     orange    mainhue    circles    crosses   saltires   quarters 
  # "integer"  "integer"  "integer"  "integer"  "integer"  "integer"   "factor"  "integer"  "integer"  "integer"  "integer" 
  # sunstars   crescent   triangle       icon    animate       text    topleft   botright 
  # "integer"  "integer"  "integer"  "integer"  "integer"  "integer"   "factor"   "factor"


# further exploring the flags dataset with tapply

table(flags$landmass)
  #  1  2  3  4  5  6 
  # 31 17 35 52 39 20 


table(flags$animate)
  #   0   1
  # 155  39

tapply(flags$animate, flags$landmass, mean)
  #         1         2         3         4         5         6 
  # 0.4193548 0.1764706 0.1142857 0.1346154 0.1538462 0.3000000


tapply(flags$population, flags$red, summary)
  # `$0`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.00    0.00    3.00   27.63    9.00  684.00 

  # $`1`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.0     0.0     4.0    22.1    15.0  1008.0 


tapply(flags$population, flags$landmass, summary)
  # $`1`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.00    0.00    0.00   12.29    4.50  231.00 

  # $`2`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.00    1.00    6.00   15.71   15.00  119.00 

  # $`3`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.00    0.00    8.00   13.86   16.00   61.00 

  # $`4`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.000   1.000   5.000   8.788   9.750  56.000 

  # $`5`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.00    2.00   10.00   69.18   39.00 1008.00 

  # $`6`
  # Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
  # 0.00    0.00    0.00   11.30    1.25  157.00 