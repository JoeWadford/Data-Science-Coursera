# week 3 Coursera: Data Science Specialization
# R Programming - Swirl lapply and sapply exercise 

### used the flags dataset from swirl
setwd("/Users/joewa/OneDrive/Desktop/Coursera/Swirl/lapply, sapply, vapply, tapply")

### wrote the flags dataset to a csv using write.csv(flags, "flags.csv")

## exploring the Flags dataset from the UCI Machine Learning Repository 

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

dim(flags)
#### [1] 194 30

viewinfo()

class(flags)
#### [1] "data.frame"

## exploring the class of each column of the FLags dataset

cls_list <- lapply(flags, class)

cls_list

	# $name
  	# [1] "factor"

	# $landmass
	# [1] "integer"

	# $zone
	# [1] "integer"

	# $area
	# [1] "integer"

	# $population
	# [1] "integer"

	# $language
	# [1] "integer"

	# $religion
	# [1] "integer"

	# $bars
	# [1] "integer"

	# $stripes
	# [1] "integer"

	# $colours
	# [1] "integer"

	# $red
	# [1] "integer"

	# $green
	# [1] "integer"

	# $blue
	# [1] "integer"

	# $gold
	# [1] "integer"

	# $white
	# [1] "integer"

	# $black
	# [1] "integer"

	# $orange
	# [1] "integer"

	# $mainhue
	# [1] "factor"

	# $circles
	# [1] "integer"

	# $crosses
	# [1] "integer"

	# $saltires
	# [1] "integer"

	# $quarters
	# [1] "integer"

	# $sunstars
	# [1] "integer"

	# $crescent
	# [1] "integer"

	# $triangle
	# [1] "integer"

	# $icon
	# [1] "integer"

	# $animate
	# [1] "integer"

	# $text
	# [1] "integer"

	# $topleft
	# [1] "factor"

	# $botright
	# [1] "factor"

class(cls_list)
#### [1] "list"

## changing the format of cls_list

as.character(cls_list)
	
	# [1] "factor"  "integer" "integer" "integer" "integer" "integer" "integer" "integer" "integer" "integer" "integer"
	# [12] "integer" "integer" "integer" "integer" "integer" "integer" "factor"  "integer" "integer" "integer" "integer"
	# [23] "integer" "integer" "integer" "integer" "integer" "integer" "factor"  "factor"


cls_vect <- sapply(flags, class)

class(cls_vect)
#### [1] "character"

# Quiz Questions

## How many flags have orange in them?

sum(flags$orange)
#### [1] 26


## What is the sum of the individual colors?

flag_colors <- flags[, 11:17]

head(flag_colors)
	
	#     red green blue gold white black orange
	# 1   1     1    0    1     1     1      0
	# 2   1     0    0    1     0     1      0
	# 3   1     1    0    0     1     0      0
	# 4   1     0    1    1     1     0      1
	# 5   1     0    1    1     0     0      0
	# 6   1     0    0    1     0     1      0


lapply(flag_colors, sum)
	
	# $red
	# [1] 153

	# $green
	# [1] 91

	# $blue
	# [1] 99

	# $gold
 	# [1] 91

	# $white
	# [1] 146

	# $black
	# [1] 52

	# $orange
	# [1] 26


sapply(flag_colors, sum)
	
	#    red  green   blue   gold  white  black orange 
 	#   153     91     99     91    146     52     26 


## What is the the proportion of flags containing each color?

sapply(flag_colors, mean)
	
	#       red     green      blue      gold     white     black    orange 
	# 0.7886598 0.4690722 0.5103093 0.4690722 0.7525773 0.2680412 0.1340206 


## exploring the matrix aspect of sapply

flag_shapes <- flags[, 19:23]
flag_shapes
#### 194 rows of flag shapes: circles, crosses, saltires, quarters, sunstars

## What is the min and max times each shape appears on the flags?

lapply(flag_shapes, range)
	
	# $circles
	# [1] 0 4

	# $crosses
	# [1] 0 2

	# $saltires
	# [1] 0 1

	# $quarters
	# [1] 0 4

	# $sunstars
	# [1]  0 50    


shape_mat <- sapply(flag_shapes, range)

shape_mat    
	
	#      circles crosses saltires quarters sunstars
	# [1,]       0       0        0        0        0
	# [2,]       4       2        1        4       50

    
class(shape_mat)
#### [1] "matrix"
    
## when sapply = lapply and the unique function
    
unique_vals <- lapply(flags, unique)

unique_vals  
#### lists all the unique values

sapply(unique_vals, length)
	
	# name   landmass       zone       area population   language   religion       bars    stripes    colours        red 
	# 194          6          4        136         48         10          8          5         12          8          2 
	# green       blue       gold      white      black     orange    mainhue    circles    crosses   saltires   quarters 
	# 2          2          2          2          2          2          8          4          3          2          3 
	# sunstars   crescent   triangle       icon    animate       text    topleft   botright 
	# 14          2          2          2          2          2          7          8 


sapply(flags, unique)
#### displays all unique values

## unique functions with lapply and sapply

lapply(unique_vals, function(elem) elem[2])


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