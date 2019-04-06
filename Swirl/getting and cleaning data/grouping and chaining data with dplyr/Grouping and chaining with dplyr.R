# Coursera - Getting and cleaning data
# swirl - grouping and chaining data with dplyr

cran <- tbl_df(mydf)

rm("mydf")

cran

#### A tibble: 225,468 x 11

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
# 9     9 2014-07-08 00:54:58    5928 NA        NA     NA        Rcpp         0.10.4  CN          6
#10    10 2014-07-08 00:15:35 2206029 3.0.2     x86_64 linux-gnu hflights     0.1     US          7

#### ... with 225,458 more rows

## group_by

?group_by

### Most data operations are done on groups defined by variables. 
### group_by() takes an existing tbl and converts it into a grouped tbl 
### where operations are performed "by group". ungroup() removes grouping.

by_package <- group_by(cran, package)

by_package

#### A tibble: 225,468 x 11
#### Groups:   package [6,023]

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
# 9     9 2014-07-08 00:54:58    5928 NA        NA     NA        Rcpp         0.10.4  CN          6
#10    10 2014-07-08 00:15:35 2206029 3.0.2     x86_64 linux-gnu hflights     0.1     US          7

#### ... with 225,458 more rows

summarize(by_package, mean(size))

#### A tibble: 6,023 x 2

#   package     `mean(size)`
#   <chr>              <dbl>
# 1 A3                62195.
# 2 abc             4826665 
# 3 abcdeFBA         455980.
# 4 ABCExtremes       22904.
# 5 ABCoptim          17807.
# 6 ABCp2             30473.
# 7 abctools        2589394 
# 8 abd              453631.
# 9 abf2              35693.
#10 abind             32939.

#### ... with 6,013 more rows

pack_sum <- summarize(by_package,
                      count = n(),
                      unique = n_distinct(ip_id),
                      countries = n_distinct(country),
                      avg_bytes = mean(size)
)

pack_sum

#### A tibble: 6,023 x 5

#   package     count unique countries avg_bytes
#   <chr>       <int>  <int>     <int>     <dbl>
# 1 A3             25     24        10    62195.
# 2 abc            29     25        16  4826665 
# 3 abcdeFBA       15     15         9   455980.
# 4 ABCExtremes    18     17         9    22904.
# 5 ABCoptim       16     15         9    17807.
# 6 ABCp2          18     17        10    30473.
# 7 abctools       19     19        11  2589394 
# 8 abd            17     16        10   453631.
# 9 abf2           13     13         9    35693.
#10 abind         396    365        50    32939.

#### ... with 6,013 more rows

quantile(pack_sum$count, probs = 0.99)

####    99% 
#### 679.56 

top_counts <- filter(pack_sum, count > 679)
top_counts

#### A tibble: 61 x 5

#   package    count unique countries avg_bytes
#   <chr>      <int>  <int>     <int>     <dbl>
# 1 bitops      1549   1408        76    28715.
# 2 car         1008    837        64  1229122.
# 3 caTools      812    699        64   176589.
# 4 colorspace  1683   1433        80   357411.
# 5 data.table   680    564        59  1252721.
# 6 DBI         2599    492        48   206933.
# 7 devtools     769    560        55   212933.
# 8 dichromat   1486   1257        74   134732.
# 9 digest      2210   1894        83   120549.
#10 doSNOW       740     75        24     8364.

#### ... with 51 more rows

View(top_counts)

#### A tibble: 61 x 5

#   package    count unique countries avg_bytes
#   <chr>      <int>  <int>     <int>     <dbl>
# 1 bitops      1549   1408        76    28715.
# 2 car         1008    837        64  1229122.
# 3 caTools      812    699        64   176589.
# 4 colorspace  1683   1433        80   357411.
# 5 data.table   680    564        59  1252721.
# 6 DBI         2599    492        48   206933.
# 7 devtools     769    560        55   212933.
# 8 dichromat   1486   1257        74   134732.
# 9 digest      2210   1894        83   120549.
#10 doSNOW       740     75        24     8364.

#### ... with 51 more rows

#### pack_sum, filtered by count > 679

top_counts_sorted <- arrange(top_counts, desc(count))

View(top_counts_sorted)

#### top_counts sorted by count in descending order

#### A tibble: 61 x 5

#   package  count unique countries avg_bytes
#   <chr>    <int>  <int>     <int>     <dbl>
# 1 ggplot2   4602   1680        81  2427716.
# 2 Rcpp      3195   2044        84  2512100.
# 3 plyr      2908   1754        81   799123.
# 4 rJava     2773    963        70   633522.
# 5 DBI       2599    492        48   206933.
# 6 LPCM      2335     17        10   526814.
# 7 stringr   2267   1948        82    65277.
# 8 digest    2210   1894        83   120549.
# 9 reshape2  2032   1652        76   330128.
#10 foreach   1984    485        53   358070.

#### ... with 51 more rows

quantile(pack_sum$unique, probs = 0.99)
#### 99% 
#### 465 

top_unique <- filter(pack_sum, unique > 465)
View(top_unique)

top_unique

#### A tibble: 60 x 5

#   package    count unique countries avg_bytes
#   <chr>      <int>  <int>     <int>     <dbl>
# 1 bitops      1549   1408        76    28715.
# 2 car         1008    837        64  1229122.
# 3 caTools      812    699        64   176589.
# 4 colorspace  1683   1433        80   357411.
# 5 data.table   680    564        59  1252721.
# 6 DBI         2599    492        48   206933.
# 7 devtools     769    560        55   212933.
# 8 dichromat   1486   1257        74   134732.
# 9 digest      2210   1894        83   120549.
#10 e1071        562    482        61   743154.

#### ... with 50 more rows

top_unique_sorted <- arrange(top_unique, desc(unique))
View(top_unique_sorted)

#### A tibble: 60 x 5

#   package      count unique countries avg_bytes
#   <chr>        <int>  <int>     <int>     <dbl>
# 1 Rcpp          3195   2044        84  2512100.
# 2 stringr       2267   1948        82    65277.
# 3 digest        2210   1894        83   120549.
# 4 plyr          2908   1754        81   799123.
# 5 ggplot2       4602   1680        81  2427716.
# 6 reshape2      2032   1652        76   330128.
# 7 RColorBrewer  1890   1584        79    22764.
# 8 colorspace    1683   1433        80   357411.
# 9 bitops        1549   1408        76    28715.
#10 scales        1726   1408        77   126819.

#### ... with 50 more rows

top_countries <- filter(pack_sum, countries > 60)
result1 <- arrange(top_countries, desc(countries), avg_bytes)

#### the following is an inefficient version of the summarization

result2 <-
  arrange(
    filter(
      summarize(
        group_by(cran,
                 package
        ),
        count = n(),
        unique = n_distinct(ip_id),
        countries = n_distinct(country),
        avg_bytes = mean(size)
      ),
      countries > 60
    ),
    desc(countries),
    avg_bytes
  )

#### the following is an efficient version of the summarization

result3 <-
  cran %>%
  group_by(package) %>%
  summarize(count = n(),
            unique = n_distinct(ip_id),
            countries = n_distinct(country),
            avg_bytes = mean(size)
  ) %>%
  filter(countries > 60) %>%
  arrange(desc(countries), avg_bytes)

## Efficient Code

cran %>%
  select(ip_id, country, package, size) %>%
  print()
submit()

#### adding more

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  print()
submit()

#### a little bit more

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  print()
submit()

#### and a bit more

cran %>%
  select(ip_id, country, package, size) %>%
  mutate(size_mb = size / 2^20) %>%
  filter(size_mb <= 0.5) %>%
  arrange(desc(size_mb)) %>%
  print()

submit()

# fin
