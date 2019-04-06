# Coursera Swirl Exercises 
# Getting and Cleaning Data
# Manipulating Data with dplyr

### wrote path2csv and cran to local files in order to work offline

path2csv <- "C:/Users/joewa/OneDrive/Documents/R/win-library/3.4/swirl/Courses/Getting_and_Cleaning_Data/Manipulating_Data_with_dplyr/2014-07-08.csv"
write.csv(cran, "cran.csv")
write.csv(cran2, "cran2.csv")
write.csv(cran3, "cran3.csv")

mydf <- read.csv(path2csv, stringsAsFactors = FALSE)

dim(mydf)

#### [1] 225468  11

head(mydf)

# X       date     time   size r_version r_arch      r_os      package version country ip_id
# 1 1 2014-07-08 00:54:41  80589     3.1.0 x86_64   mingw32    htmltools   0.2.4      US     1
# 2 2 2014-07-08 00:59:53 321767     3.1.0 x86_64   mingw32      tseries 0.10-32      US     2
# 3 3 2014-07-08 00:47:13 748063     3.1.0 x86_64 linux-gnu        party  1.0-15      US     3
# 4 4 2014-07-08 00:48:05 606104     3.1.0 x86_64 linux-gnu        Hmisc  3.14-4      US     3
# 5 5 2014-07-08 00:46:50  79825     3.0.2 x86_64 linux-gnu       digest   0.6.4      CA     4
# 6 6 2014-07-08 00:48:04  77681     3.1.0 x86_64 linux-gnu randomForest   4.6-7      US     3

library(dplyr)
packageVersion("dplyr")

#### [1] '0.7.8'

cran <- tbl_df(mydf)

rm("mydf")

## remove and rm can be used to remove objects. These can be specified successively as character strings, 
### or in the character vector list, or through a combination of both. All objects thus specified will be removed.

cran

#### A tibble: 225,468 x 11

#        X date       time        size r_version r_arch r_os      package      version country ip_id
#    <int> <chr>      <chr>      <int> <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
# 1     1 2014-07-08 00:54:41   80589 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
# 2     2 2014-07-08 00:59:53  321767 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
# 3     3 2014-07-08 00:47:13  748063 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
# 4     4 2014-07-08 00:48:05  606104 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
# 5     5 2014-07-08 00:46:50   79825 3.0.2     x86_64 linux-gnu digest       0.6.4   CA          4
# 6     6 2014-07-08 00:48:04   77681 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
# 7     7 2014-07-08 00:48:35  393754 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
# 8     8 2014-07-08 00:47:30   28216 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
# 9     9 2014-07-08 00:54:58    5928 NA        NA     NA        Rcpp         0.10.4  CN          6
# 10    10 2014-07-08 00:15:35 2206029 3.0.2     x86_64 linux-gnu hflights     0.1     US          7

#### ... with 225,458 more rows

?select

## select() keeps only the variables you mention; rename() keeps all variables.

select(cran, ip_id, package, country)

#### A tibble: 225,468 x 3

#    ip_id package      country
#   <int> <chr>        <chr>  
# 1     1 htmltools    US     
# 2     2 tseries      US     
# 3     3 party        US     
# 4     3 Hmisc        US     
# 5     4 digest       CA     
# 6     3 randomForest US     
# 7     3 plyr         US     
# 8     5 whisker      US     
# 9     6 Rcpp         CN     
#10     7 hflights     US     

#### ... with 225,458 more rows

5:20

####  [1]  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

select(cran, r_arch:country)

#### A tibble: 225,468 x 5

#   r_arch r_os      package      version country
#   <chr>  <chr>     <chr>        <chr>   <chr>  
# 1 x86_64 mingw32   htmltools    0.2.4   US     
# 2 x86_64 mingw32   tseries      0.10-32 US     
# 3 x86_64 linux-gnu party        1.0-15  US     
# 4 x86_64 linux-gnu Hmisc        3.14-4  US     
# 5 x86_64 linux-gnu digest       0.6.4   CA     
# 6 x86_64 linux-gnu randomForest 4.6-7   US     
# 7 x86_64 linux-gnu plyr         1.8.1   US     
# 8 x86_64 linux-gnu whisker      0.3-2   US     
# 9 NA     NA        Rcpp         0.10.4  CN     
#10 x86_64 linux-gnu hflights     0.1     US     

#### ... with 225,458 more rows

select(cran, country:r_arch)

#### A tibble: 225,468 x 5

#   country version package      r_os      r_arch
#   <chr>   <chr>   <chr>        <chr>     <chr> 
# 1 US      0.2.4   htmltools    mingw32   x86_64
# 2 US      0.10-32 tseries      mingw32   x86_64
# 3 US      1.0-15  party        linux-gnu x86_64
# 4 US      3.14-4  Hmisc        linux-gnu x86_64
# 5 CA      0.6.4   digest       linux-gnu x86_64
# 6 US      4.6-7   randomForest linux-gnu x86_64
# 7 US      1.8.1   plyr         linux-gnu x86_64
# 8 US      0.3-2   whisker      linux-gnu x86_64
# 9 CN      0.10.4  Rcpp         NA        NA    
#10 US      0.1     hflights     linux-gnu x86_64

#### ... with 225,458 more rows

cran

#### A tibble: 225,468 x 11

#        X date       time        size r_version r_arch r_os      package      version country ip_id
#    <int> <chr>      <chr>      <int> <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
# 1     1 2014-07-08 00:54:41   80589 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
# 2     2 2014-07-08 00:59:53  321767 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
# 3     3 2014-07-08 00:47:13  748063 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
# 4     4 2014-07-08 00:48:05  606104 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
# 5     5 2014-07-08 00:46:50   79825 3.0.2     x86_64 linux-gnu digest       0.6.4   CA          4
# 6     6 2014-07-08 00:48:04   77681 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
# 7     7 2014-07-08 00:48:35  393754 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
# 8     8 2014-07-08 00:47:30   28216 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
# 9     9 2014-07-08 00:54:58    5928 NA        NA     NA        Rcpp         0.10.4  CN          6
# 10    10 2014-07-08 00:15:35 2206029 3.0.2     x86_64 linux-gnu hflights     0.1     US          7

#### ... with 225,458 more rows

select(cran, -time)

#### A tibble: 225,468 x 10

#        X date          size r_version r_arch r_os      package      version country ip_id
#    <int> <chr>        <int> <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
# 1     1 2014-07-08    80589 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
# 2     2 2014-07-08   321767 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
# 3     3 2014-07-08   748063 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
# 4     4 2014-07-08   606104 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
# 5     5 2014-07-08    79825 3.0.2     x86_64 linux-gnu digest       0.6.4   CA          4
# 6     6 2014-07-08    77681 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
# 7     7 2014-07-08   393754 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
# 8     8 2014-07-08    28216 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
# 9     9 2014-07-08     5928 NA        NA     NA        Rcpp         0.10.4  CN          6
# 10    10 2014-07-08 2206029 3.0.2     x86_64 linux-gnu hflights     0.1     US          7

#### ... with 225,458 more rows

-5:20
####  [1] -5 -4 -3 -2 -1  0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20

-(5:20)
####  [1]  -5  -6  -7  -8  -9 -10 -11 -12 -13 -14 -15 -16 -17 -18 -19 -20

select(cran, -(X:size))

#### A tibble: 225,468 x 7

#   r_version r_arch r_os      package      version country ip_id
#   <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
# 1 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
# 2 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
# 3 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
# 4 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
# 5 3.0.2     x86_64 linux-gnu digest       0.6.4   CA          4
# 6 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
# 7 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
# 8 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
# 9 NA        NA     NA        Rcpp         0.10.4  CN          6
#10 3.0.2     x86_64 linux-gnu hflights     0.1     US          7

#### ... with 225,458 more rows

## filter

filter(cran, package=="swirl")

#### A tibble: 820 x 11

#       X date       time       size r_version r_arch r_os         package version country ip_id
#   <int> <chr>      <chr>     <int> <chr>     <chr>  <chr>        <chr>   <chr>   <chr>   <int>
# 1    27 2014-07-08 00:17:16 105350 3.0.2     x86_64 mingw32      swirl   2.2.9   US         20
# 2   156 2014-07-08 00:22:53  41261 3.1.0     x86_64 linux-gnu    swirl   2.2.9   US         66
# 3   358 2014-07-08 00:13:42 105335 2.15.2    x86_64 mingw32      swirl   2.2.9   CA        115
# 4   593 2014-07-08 00:59:45 105465 3.1.0     x86_64 darwin13.1.0 swirl   2.2.9   MX        162
# 5   831 2014-07-08 00:55:27 105335 3.0.3     x86_64 mingw32      swirl   2.2.9   US         57
# 6   997 2014-07-08 00:33:06  41261 3.1.0     x86_64 mingw32      swirl   2.2.9   US         70
# 7  1023 2014-07-08 00:35:36 106393 3.1.0     x86_64 mingw32      swirl   2.2.9   BR        248
# 8  1144 2014-07-08 00:00:39 106534 3.0.2     x86_64 linux-gnu    swirl   2.2.9   US        261
# 9  1402 2014-07-08 00:41:41  41261 3.1.0     i386   mingw32      swirl   2.2.9   US        234
#10  1424 2014-07-08 00:44:49 106393 3.1.0     x86_64 linux-gnu    swirl   2.2.9   US        301

#### ... with 810 more rows

filter(cran, r_version == "3.1.1", country == "US")

#### A tibble: 1,588 x 11

#       X date       time        size r_version r_arch r_os         package      version country ip_id
#   <int> <chr>      <chr>      <int> <chr>     <chr>  <chr>        <chr>        <chr>   <chr>   <int>
# 1  2216 2014-07-08 00:48:58  385112 3.1.1     x86_64 darwin13.1.0 colorspace   1.2-4   US        191
# 2 17332 2014-07-08 03:39:57  197459 3.1.1     x86_64 darwin13.1.0 httr         0.3     US       1704
# 3 17465 2014-07-08 03:25:38   23259 3.1.1     x86_64 darwin13.1.0 snow         0.3-13  US         62
# 4 18844 2014-07-08 03:59:17  190594 3.1.1     x86_64 darwin13.1.0 maxLik       1.2-0   US       1533
# 5 30182 2014-07-08 04:13:15   77683 3.1.1     i386   mingw32      randomForest 4.6-7   US        646
# 6 30193 2014-07-08 04:06:26 2351969 3.1.1     i386   mingw32      ggplot2      1.0.0   US          8
# 7 30195 2014-07-08 04:07:09  299080 3.1.1     i386   mingw32      fExtremes    3010.81 US       2010
# 8 30217 2014-07-08 04:32:04  568036 3.1.1     i386   mingw32      rJava        0.9-6   US         98
# 9 30245 2014-07-08 04:10:41  526858 3.1.1     i386   mingw32      LPCM         0.44-8  US          8
#10 30354 2014-07-08 04:32:51 1763717 3.1.1     i386   mingw32      mgcv         1.8-1   US       2122

#### ... with 1,578 more rows

?Comparison

## Binary operators which allow the comparison of values in atomic vectors.

### Usage

### x < y
### x > y
### x <= y
### x >= y
### x == y
### x != y

filter(cran, r_version <= "3.0.2", country == "IN")

#### A tibble: 4,139 x 11

#       X date       time         size r_version r_arch r_os      package       version   country ip_id
#   <int> <chr>      <chr>       <int> <chr>     <chr>  <chr>     <chr>         <chr>     <chr>   <int>
# 1   348 2014-07-08 00:44:04 10218907 3.0.0     x86_64 mingw32   BH            1.54.0-2  IN        112
# 2  9990 2014-07-08 02:11:32   397497 3.0.2     x86_64 linux-gnu equateIRT     1.1       IN       1054
# 3  9991 2014-07-08 02:11:32   119199 3.0.2     x86_64 linux-gnu ggdendro      0.1-14    IN       1054
# 4  9992 2014-07-08 02:11:33    81779 3.0.2     x86_64 linux-gnu dfcrm         0.2-2     IN       1054
# 5 10022 2014-07-08 02:19:45  1557078 2.15.0    x86_64 mingw32   RcppArmadillo 0.4.320.0 IN       1060
# 6 10023 2014-07-08 02:19:46  1184285 2.15.1    i686   linux-gnu forecast      5.4       IN       1060
# 7 10189 2014-07-08 02:38:06   908854 3.0.2     x86_64 linux-gnu editrules     2.7.2     IN       1054
# 8 10199 2014-07-08 02:38:28   178436 3.0.2     x86_64 linux-gnu energy        1.6.1     IN       1054
# 9 10200 2014-07-08 02:38:29    51811 3.0.2     x86_64 linux-gnu ENmisc        1.2-7     IN       1054
#10 10201 2014-07-08 02:38:29    65245 3.0.2     x86_64 linux-gnu entropy       1.2.0     IN       1054

#### ... with 4,129 more rows

filter(cran, country == "US" | country == "IN")

#### A tibble: 95,283 x 11

#       X date       time        size r_version r_arch r_os      package      version country ip_id
#   <int> <chr>      <chr>      <int> <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
# 1     1 2014-07-08 00:54:41   80589 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
# 2     2 2014-07-08 00:59:53  321767 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
# 3     3 2014-07-08 00:47:13  748063 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
# 4     4 2014-07-08 00:48:05  606104 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
# 5     6 2014-07-08 00:48:04   77681 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
# 6     7 2014-07-08 00:48:35  393754 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
# 7     8 2014-07-08 00:47:30   28216 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
# 8    10 2014-07-08 00:15:35 2206029 3.0.2     x86_64 linux-gnu hflights     0.1     US          7
# 9    11 2014-07-08 00:15:25  526858 3.0.2     x86_64 linux-gnu LPCM         0.44-8  US          8
#10    12 2014-07-08 00:14:45 2351969 2.14.1    x86_64 linux-gnu ggplot2      1.0.0   US          8

#### ... with 95,273 more rows

filter(cran, size > 100500, r_os == "linux-gnu")

#### A tibble: 33,683 x 11

#       X date       time        size r_version r_arch r_os      package  version country ip_id
#   <int> <chr>      <chr>      <int> <chr>     <chr>  <chr>     <chr>    <chr>   <chr>   <int>
# 1     3 2014-07-08 00:47:13  748063 3.1.0     x86_64 linux-gnu party    1.0-15  US          3
# 2     4 2014-07-08 00:48:05  606104 3.1.0     x86_64 linux-gnu Hmisc    3.14-4  US          3
# 3     7 2014-07-08 00:48:35  393754 3.1.0     x86_64 linux-gnu plyr     1.8.1   US          3
# 4    10 2014-07-08 00:15:35 2206029 3.0.2     x86_64 linux-gnu hflights 0.1     US          7
# 5    11 2014-07-08 00:15:25  526858 3.0.2     x86_64 linux-gnu LPCM     0.44-8  US          8
# 6    12 2014-07-08 00:14:45 2351969 2.14.1    x86_64 linux-gnu ggplot2  1.0.0   US          8
# 7    14 2014-07-08 00:15:35 3097729 3.0.2     x86_64 linux-gnu Rcpp     0.9.7   VE         10
# 8    15 2014-07-08 00:14:37  568036 3.1.0     x86_64 linux-gnu rJava    0.9-6   US         11
# 9    16 2014-07-08 00:15:50 1600441 3.1.0     x86_64 linux-gnu RSQLite  0.11.4  US          7
#10    18 2014-07-08 00:26:59  186685 3.1.0     x86_64 linux-gnu ipred    0.9-3   DE         13

#### ... with 33,673 more rows

is.na(c(3, 5, NA, 10))

#### [1] FALSE FALSE  TRUE FALSE

!is.na(c(3, 5, NA, 10))

#### [1]  TRUE  TRUE FALSE  TRUE

filter(cran, !is.na(r_version))

#### A tibble: 207,205 x 11

#       X date       time        size r_version r_arch r_os      package      version country ip_id
#   <int> <chr>      <chr>      <int> <chr>     <chr>  <chr>     <chr>        <chr>   <chr>   <int>
# 1     1 2014-07-08 00:54:41   80589 3.1.0     x86_64 mingw32   htmltools    0.2.4   US          1
# 2     2 2014-07-08 00:59:53  321767 3.1.0     x86_64 mingw32   tseries      0.10-32 US          2
# 3     3 2014-07-08 00:47:13  748063 3.1.0     x86_64 linux-gnu party        1.0-15  US          3
# 4     4 2014-07-08 00:48:05  606104 3.1.0     x86_64 linux-gnu Hmisc        3.14-4  US          3
# 5     5 2014-07-08 00:46:50   79825 3.0.2     x86_64 linux-gnu digest       0.6.4   CA          4
# 6     6 2014-07-08 00:48:04   77681 3.1.0     x86_64 linux-gnu randomForest 4.6-7   US          3
# 7     7 2014-07-08 00:48:35  393754 3.1.0     x86_64 linux-gnu plyr         1.8.1   US          3
# 8     8 2014-07-08 00:47:30   28216 3.0.2     x86_64 linux-gnu whisker      0.3-2   US          5
# 9    10 2014-07-08 00:15:35 2206029 3.0.2     x86_64 linux-gnu hflights     0.1     US          7
#10    11 2014-07-08 00:15:25  526858 3.0.2     x86_64 linux-gnu LPCM         0.44-8  US          8

#### ... with 207,195 more rows

cran2 <- select(cran, size:ip_id)

#### reducing the columns in cran via cran2 by the columns size to ip_id

## arrange

arrange(cran2, ip_id)

#### this arranges cran2 dataframe by the column "ip_id" in ascending order

#### A tibble: 225,468 x 8

#     size r_version r_arch r_os         package     version country ip_id
#    <int> <chr>     <chr>  <chr>        <chr>       <chr>   <chr>   <int>
# 1  80589 3.1.0     x86_64 mingw32      htmltools   0.2.4   US          1
# 2 180562 3.0.2     x86_64 mingw32      yaml        2.1.13  US          1
# 3 190120 3.1.0     i386   mingw32      babel       0.2-6   US          1
# 4 321767 3.1.0     x86_64 mingw32      tseries     0.10-32 US          2
# 5  52281 3.0.3     x86_64 darwin10.8.0 quadprog    1.5-5   US          2
# 6 876702 3.1.0     x86_64 linux-gnu    zoo         1.7-11  US          2
# 7 321764 3.0.2     x86_64 linux-gnu    tseries     0.10-32 US          2
# 8 876702 3.1.0     x86_64 linux-gnu    zoo         1.7-11  US          2
# 9 321768 3.1.0     x86_64 mingw32      tseries     0.10-32 US          2
#10 784093 3.1.0     x86_64 linux-gnu    strucchange 1.5-0   US          2

#### ... with 225,458 more rows

arrange(cran2, desc(ip_id))

#### this arranges cran2 dataframe by the column "ip_id" in descending order

#### A tibble: 225,468 x 8

#      size r_version r_arch r_os         package      version country ip_id
#     <int> <chr>     <chr>  <chr>        <chr>        <chr>   <chr>   <int>
# 1    5933 NA        NA     NA           CPE          1.4.2   CN      13859
# 2  569241 3.1.0     x86_64 mingw32      multcompView 0.1-5   US      13858
# 3  228444 3.1.0     x86_64 mingw32      tourr        0.5.3   NZ      13857
# 4  308962 3.1.0     x86_64 darwin13.1.0 ctv          0.7-9   CN      13856
# 5  950964 3.0.3     i386   mingw32      knitr        1.6     CA      13855
# 6   80185 3.0.3     i386   mingw32      htmltools    0.2.4   CA      13855
# 7 1431750 3.0.3     i386   mingw32      shiny        0.10.0  CA      13855
# 8 2189695 3.1.0     x86_64 mingw32      RMySQL       0.9-3   US      13854
# 9 4818024 3.1.0     i386   mingw32      igraph       0.7.1   US      13853
#10  197495 3.1.0     x86_64 mingw32      coda         0.16-1  US      13852

#### ... with 225,458 more rows

arrange(cran2, package, ip_id)

#### arrange allows us to sort by two variables.  in the above example, cran2 is sorted 
#### by package first and if there are the same values for multiple rows, then we will sort by ip_id

#### A tibble: 225,468 x 8

#    size r_version r_arch r_os         package version country ip_id
#   <int> <chr>     <chr>  <chr>        <chr>   <chr>   <chr>   <int>
# 1 71677 3.0.3     x86_64 darwin10.8.0 A3      0.9.2   CN       1003
# 2 71672 3.1.0     x86_64 linux-gnu    A3      0.9.2   US       1015
# 3 71677 3.1.0     x86_64 mingw32      A3      0.9.2   IN       1054
# 4 70438 3.0.1     x86_64 darwin10.8.0 A3      0.9.2   CN       1513
# 5 71677 NA        NA     NA           A3      0.9.2   BR       1526
# 6 71892 3.0.2     x86_64 linux-gnu    A3      0.9.2   IN       1542
# 7 71677 3.1.0     x86_64 linux-gnu    A3      0.9.2   ZA       2925
# 8 71672 3.1.0     x86_64 mingw32      A3      0.9.2   IL       3889
# 9 71677 3.0.3     x86_64 mingw32      A3      0.9.2   DE       3917
#10 71672 3.1.0     x86_64 mingw32      A3      0.9.2   US       4219

#### ... with 225,458 more rows

arrange(cran2, country, desc(r_version), ip_id)

#### the above allows us to sort cran2 by country, then descending by r_version, finally by ip_id

#### A tibble: 225,468 x 8

#      size r_version r_arch r_os      package       version   country ip_id
#     <int> <chr>     <chr>  <chr>     <chr>         <chr>     <chr>   <int>
# 1 1556858 3.1.1     i386   mingw32   RcppArmadillo 0.4.320.0 A1       2843
# 2 1823512 3.1.0     x86_64 linux-gnu mgcv          1.8-1     A1       2843
# 3   15732 3.1.0     i686   linux-gnu grnn          0.1.0     A1       3146
# 4 3014840 3.1.0     x86_64 mingw32   Rcpp          0.11.2    A1       3146
# 5  660087 3.1.0     i386   mingw32   xts           0.9-7     A1       3146
# 6  522261 3.1.0     i386   mingw32   FNN           1.1       A1       3146
# 7  522263 3.1.0     i386   mingw32   FNN           1.1       A1       3146
# 8 1676627 3.1.0     x86_64 linux-gnu rgeos         0.3-5     A1       3146
# 9 2118530 3.1.0     x86_64 linux-gnu spacetime     1.1-0     A1       3146
#10 2217180 3.1.0     x86_64 mingw32   gstat         1.0-19    A1       3146

#### ... with 225,458 more rows


cran3 <- select(cran, ip_id, package, size)
cran3

#### A tibble: 225,468 x 3

# ip_id package         size
# <int> <chr>          <int>
#   1     1 htmltools      80589
#   2     2 tseries       321767
#   3     3 party         748063
#   4     3 Hmisc         606104
#   5     4 digest         79825
#   6     3 randomForest   77681
#   7     3 plyr          393754
#   8     5 whisker        28216
#   9     6 Rcpp            5928
#  10     7 hflights     2206029

#### ... with 225,458 more rows

## mutate

mutate(cran3, size_mb = size/2^20)

#### A tibble: 225,468 x 4

#   ip_id package         size size_mb
#   <int> <chr>          <int>   <dbl>
# 1     1 htmltools      80589 0.0769 
# 2     2 tseries       321767 0.307  
# 3     3 party         748063 0.713  
# 4     3 Hmisc         606104 0.578  
# 5     4 digest         79825 0.0761 
# 6     3 randomForest   77681 0.0741 
# 7     3 plyr          393754 0.376  
# 8     5 whisker        28216 0.0269 
# 9     6 Rcpp            5928 0.00565
#10     7 hflights     2206029 2.10   

#### ... with 225,458 more rows

mutate(cran3, size_mb = size/2^20, size_gb = size_mb / 2^10)

#### A tibble: 225,468 x 5

#   ip_id package         size size_mb    size_gb
#   <int> <chr>          <int>   <dbl>      <dbl>
# 1     1 htmltools      80589 0.0769  0.0000751 
# 2     2 tseries       321767 0.307   0.000300  
# 3     3 party         748063 0.713   0.000697  
# 4     3 Hmisc         606104 0.578   0.000564  
# 5     4 digest         79825 0.0761  0.0000743 
# 6     3 randomForest   77681 0.0741  0.0000723 
# 7     3 plyr          393754 0.376   0.000367  
# 8     5 whisker        28216 0.0269  0.0000263 
# 9     6 Rcpp            5928 0.00565 0.00000552
#10     7 hflights     2206029 2.10    0.00205   

#### ... with 225,458 more rows

mutate(cran3, correct_size = size + 1000)

#### A tibble: 225,468 x 4

#   ip_id package         size correct_size
#   <int> <chr>          <int>        <dbl>
# 1     1 htmltools      80589        81589
# 2     2 tseries       321767       322767
# 3     3 party         748063       749063
# 4     3 Hmisc         606104       607104
# 5     4 digest         79825        80825
# 6     3 randomForest   77681        78681
# 7     3 plyr          393754       394754
# 8     5 whisker        28216        29216
# 9     6 Rcpp            5928         6928
#10     7 hflights     2206029      2207029

#### ... with 225,458 more rows

## summarize 

summarize(cran, avg_bytes = mean(size))

#### A tibble: 1 x 1

#   avg_bytes
#       <dbl>
# 1   844086.

# fin