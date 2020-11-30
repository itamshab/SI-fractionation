2020-11-30

  - [POM fraction amounts](#pom-fraction-amounts)
      - [fPOM amounts](#fpom-amounts)
      - [oPOM amounts](#opom-amounts)
      - [Total POM amounts](#total-pom-amounts)

## POM fraction amounts

### fPOM amounts

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/fPOM-1.png)<!-- -->![](fractions_files/figure-gfm/fPOM-2.png)<!-- -->

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/fPOM-3.png)<!-- -->

    ## Warning: Removed 1 rows containing non-finite values (stat_boxplot).
    
    ## Warning: Removed 1 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/fPOM-4.png)<!-- -->

    ##                                Df Sum Sq Mean Sq F value   Pr(>F)    
    ## treatment                       1    2.4     2.4   0.069    0.794    
    ## water_content                   1 1409.9  1409.9  40.914 8.57e-09 ***
    ## litter                          1  697.9   697.9  20.251 2.17e-05 ***
    ## treatment:water_content         1    0.3     0.3   0.007    0.931    
    ## treatment:litter                1   13.4    13.4   0.389    0.535    
    ## water_content:litter            1   18.2    18.2   0.529    0.469    
    ## treatment:water_content:litter  1   51.8    51.8   1.502    0.224    
    ## Residuals                      84 2894.7    34.5                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 1 observation deleted due to missingness

    ##                                Df Sum Sq Mean Sq F value  Pr(>F)    
    ## treatment                       1   14.5    14.5   0.499  0.4840    
    ## water_content                   1   95.1    95.1   3.265  0.0787 .  
    ## litter                          1  626.1   626.1  21.500 4.1e-05 ***
    ## treatment:water_content         1   67.1    67.1   2.304  0.1373    
    ## treatment:litter                1    1.8     1.8   0.060  0.8073    
    ## water_content:litter            1    0.0     0.0   0.001  0.9726    
    ## treatment:water_content:litter  1   63.4    63.4   2.176  0.1485    
    ## Residuals                      38 1106.5    29.1                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 1 observation deleted due to missingness

    ##                                Df Sum Sq Mean Sq F value  Pr(>F)    
    ## treatment                       1    3.5     3.5   0.156  0.6949    
    ## water_content                   1 1881.6  1881.6  84.069 3.6e-11 ***
    ## litter                          1  151.7   151.7   6.780  0.0131 *  
    ## treatment:water_content         1   92.8    92.8   4.147  0.0487 *  
    ## treatment:litter                1   33.3    33.3   1.487  0.2301    
    ## water_content:litter            1   43.3    43.3   1.934  0.1724    
    ## treatment:water_content:litter  1    0.5     0.5   0.023  0.8813    
    ## Residuals                      38  850.5    22.4                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Ca treatment does not affect fPOM in any water content/litter treatnebt
combination fPOM amount seems to decrease from begininng to end of
incubation at high water content but remain similar at low water
content. his result fits delta13C-CO2 data that shows higher delta
values at higher water content.

### oPOM amounts

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/oPOM-1.png)<!-- -->![](fractions_files/figure-gfm/oPOM-2.png)<!-- -->

    ## Warning: Removed 1 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/oPOM-3.png)<!-- -->

    ## Warning: Removed 1 rows containing non-finite values (stat_boxplot).
    
    ## Warning: Removed 1 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/oPOM-4.png)<!-- -->

    ##                                Df Sum Sq Mean Sq F value   Pr(>F)    
    ## treatment                       1   18.3    18.3   1.475    0.228    
    ## water_content                   1    0.4     0.4   0.036    0.850    
    ## litter                          1  478.5   478.5  38.508 1.98e-08 ***
    ## treatment:water_content         1    1.4     1.4   0.114    0.736    
    ## treatment:litter                1   29.2    29.2   2.348    0.129    
    ## water_content:litter            1    6.6     6.6   0.533    0.467    
    ## treatment:water_content:litter  1    0.0     0.0   0.003    0.956    
    ## Residuals                      84 1043.8    12.4                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 1 observation deleted due to missingness

    ##                                Df Sum Sq Mean Sq F value   Pr(>F)    
    ## treatment                       1    0.0     0.0   0.003   0.9567    
    ## water_content                   1   26.5    26.5   3.216   0.0809 .  
    ## litter                          1  362.0   362.0  43.868 7.99e-08 ***
    ## treatment:water_content         1    9.6     9.6   1.166   0.2870    
    ## treatment:litter                1   91.9    91.9  11.140   0.0019 ** 
    ## water_content:litter            1    2.6     2.6   0.315   0.5777    
    ## treatment:water_content:litter  1    3.8     3.8   0.465   0.4996    
    ## Residuals                      38  313.6     8.3                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 1 observation deleted due to missingness

    ##                                Df Sum Sq Mean Sq F value   Pr(>F)    
    ## treatment                       1  38.58   38.58   8.343  0.00636 ** 
    ## water_content                   1  15.41   15.41   3.332  0.07580 .  
    ## litter                          1 130.40  130.40  28.200 5.02e-06 ***
    ## treatment:water_content         1  32.84   32.84   7.102  0.01124 *  
    ## treatment:litter                1   0.66    0.66   0.143  0.70784    
    ## water_content:litter            1  28.43   28.43   6.148  0.01771 *  
    ## treatment:water_content:litter  1   5.50    5.50   1.190  0.28220    
    ## Residuals                      38 175.72    4.62                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### Total POM amounts

    ## Warning: Removed 2 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/total%20POM-1.png)<!-- -->![](fractions_files/figure-gfm/total%20POM-2.png)<!-- -->

    ## Warning: Removed 2 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/total%20POM-3.png)<!-- -->

    ## Warning: Removed 18 rows containing non-finite values (stat_boxplot).

    ## Warning: Removed 18 rows containing missing values (geom_point).

![](fractions_files/figure-gfm/total%20POM-4.png)<!-- -->

    ##                                Df Sum Sq Mean Sq F value   Pr(>F)    
    ## treatment                       1     28    27.6   0.640    0.426    
    ## water_content                   1   1518  1518.1  35.218 6.58e-08 ***
    ## litter                          1   2444  2444.4  56.707 5.56e-11 ***
    ## treatment:water_content         1      1     0.6   0.013    0.909    
    ## treatment:litter                1    103   102.8   2.385    0.126    
    ## water_content:litter            1      0     0.3   0.007    0.932    
    ## treatment:water_content:litter  1     37    37.1   0.861    0.356    
    ## Residuals                      83   3578    43.1                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 2 observations deleted due to missingness

    ##                                Df Sum Sq Mean Sq F value   Pr(>F)    
    ## treatment                       1    7.2     7.2   0.187   0.6680    
    ## water_content                   1  258.9   258.9   6.763   0.0133 *  
    ## litter                          1 2003.0  2003.0  52.321 1.39e-08 ***
    ## treatment:water_content         1   14.7    14.7   0.384   0.5393    
    ## treatment:litter                1   91.8    91.8   2.397   0.1301    
    ## water_content:litter            1    0.1     0.1   0.002   0.9659    
    ## treatment:water_content:litter  1   26.4    26.4   0.691   0.4113    
    ## Residuals                      37 1416.5    38.3                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 2 observations deleted due to missingness

    ##                                Df Sum Sq Mean Sq F value   Pr(>F)    
    ## treatment                       1   18.9    18.9   0.688    0.412    
    ## water_content                   1 1556.5  1556.5  56.832 4.65e-09 ***
    ## litter                          1  563.5   563.5  20.575 5.59e-05 ***
    ## treatment:water_content         1   15.2    15.2   0.556    0.460    
    ## treatment:litter                1   24.6    24.6   0.898    0.349    
    ## water_content:litter            1    1.6     1.6   0.057    0.813    
    ## treatment:water_content:litter  1    9.3     9.3   0.341    0.563    
    ## Residuals                      38 1040.7    27.4                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
