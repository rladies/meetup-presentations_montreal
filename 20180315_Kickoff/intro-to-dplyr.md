What is dplyr?
--------------

-   wrangling/cleaning/manipulation
-   human readable
-   best when paired with the piping operator %&gt;%

Install and load dplyr
----------------------

    #install.packages("dplyr")
    library(dplyr)

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

Example data
------------

-   We'll use a dataset on life expectancy for black and white Americans
    to practice using `dplyr`
-   Let's start by importing these data into R

<!-- -->

    # Read in the dataset
    BlackWhite_results <- read.csv("./BlackWhite_results.csv")

Take a peak
-----------

-   Let's use RStudio's viewer to look at these data.
-   Click the table icon next to BlackWhite\_results in the environment
    tab or run `View(BlackWhite_results)`
-   If you aren't using RStudio, you can use `head(BlackWhite_results)`
    to see the first six lines of data

<!-- -->

    dim(BlackWhite_results)

    ## [1] 3600   24

    names(BlackWhite_results)

    ##  [1] "X.2"               "X.1"               "X"                
    ##  [4] "stratum.id"        "LE_white_lcl"      "LE_white_med"     
    ##  [7] "LE_white_ucl"      "LE_white_mean"     "LE_black_lcl"     
    ## [10] "LE_black_med"      "LE_black_ucl"      "LE_black_mean"    
    ## [13] "LE_wbgap_lcl"      "LE_wbgap_med"      "LE_wbgap_ucl"     
    ## [16] "LE_wbgap_mean"     "state"             "year"             
    ## [19] "sex"               "Census_Region"     "Census_Division"  
    ## [22] "stabbrs"           "state.map.order"   "stabbrs.map.order"

So. many. variables.
--------------------

Let's only keep a subset for further use.

dplyr select() to keep or discard variables
-------------------------------------------

-   `select()` is used to select a subset of variables from an existing
    data frame.
-   You can explicitly select the variables you'd like to keep, or
    "negatively" `select()` (i.e, remove) variables you'd like
    to discard.

<!-- -->

    subset <- select(BlackWhite_results, 
                     LE_white_mean, LE_black_mean,
                     state, year, sex, stabbrs)

    names(subset)

    ## [1] "LE_white_mean" "LE_black_mean" "state"         "year"         
    ## [5] "sex"           "stabbrs"

    dim(subset)

    ## [1] 3600    6

dplyr select() to keep or discard variables (columns)
-----------------------------------------------------

Write this another way using the **piping** operator (%&gt;%)

    subset2 <- BlackWhite_results %>% 
      select(LE_white_mean, LE_black_mean,
             state, year, sex, stabbrs)

Confirm that `subset` and `subset2` are identical:

    identical(subset, subset2)

    ## [1] TRUE

    BlackWhite_results <- subset2

dplyr mutate() to add a new variable
------------------------------------

-   What if you wanted to calculate the difference (in years) between
    the life expectancy for blacks and whites?

<!-- -->

    BlackWhite_results <- BlackWhite_results %>% 
      mutate(diff = LE_white_mean - LE_black_mean)

dplyr mutate() to add a new variable
------------------------------------

-   Take a peak to see the calculated difference

<!-- -->

    BlackWhite_results %>% select(LE_white_mean, LE_black_mean, 
                                  diff, state, year, sex) 

    ##      LE_white_mean LE_black_mean        diff          state year    sex
    ## 1         75.75853      67.96007  7.79846292        Alabama 1969 Female
    ## 2         66.60871      59.47522  7.13349227        Alabama 1969   Male
    ## 3         75.89518      68.24888  7.64629587        Alabama 1970 Female
    ## 4         66.74232      59.91964  6.82268580        Alabama 1970   Male
    ## 5         76.15512      68.91674  7.23838081        Alabama 1971 Female
    ## 6         66.89219      60.17679  6.71539537        Alabama 1971   Male
    ## 7         76.32144      69.28151  7.03992794        Alabama 1972 Female
    ## 8         67.02548      60.42309  6.60238507        Alabama 1972   Male
    ## 9         76.44783      69.63352  6.81430968        Alabama 1973 Female
    ## 10        67.15409      60.71493  6.43916253        Alabama 1973   Male
    ## 11        76.79049      70.38436  6.40613323        Alabama 1974 Female
    ## 12        67.55659      61.22624  6.33034629        Alabama 1974   Male
    ## 13        77.29689      71.07740  6.21948327        Alabama 1975 Female
    ## 14        68.14426      61.66476  6.47950731        Alabama 1975   Male
    ## 15        77.55473      71.39301  6.16172141        Alabama 1976 Female
    ## 16        68.44788      61.94473  6.50315821        Alabama 1976   Male
    ## 17        77.85269      71.86206  5.99062424        Alabama 1977 Female
    ## 18        68.67268      62.35982  6.31285799        Alabama 1977   Male
    ## 19        78.05702      72.37988  5.67714264        Alabama 1978 Female
    ## 20        69.05321      62.71122  6.34198853        Alabama 1978   Male
    ## 21        78.24542      72.76807  5.47735164        Alabama 1979 Female
    ## 22        69.37810      63.20842  6.16968256        Alabama 1979   Male
    ## 23        78.33321      72.95365  5.37956224        Alabama 1980 Female
    ## 24        69.71024      63.53193  6.17830902        Alabama 1980   Male
    ## 25        78.42696      73.32639  5.10056983        Alabama 1981 Female
    ## 26        69.99901      63.99539  6.00362321        Alabama 1981   Male
    ## 27        78.56469      73.57380  4.99089344        Alabama 1982 Female
    ## 28        70.26289      64.36852  5.89437803        Alabama 1982   Male
    ## 29        78.64092      73.59530  5.04562203        Alabama 1983 Female
    ## 30        70.46988      64.63255  5.83732722        Alabama 1983   Male
    ## 31        78.55518      73.52727  5.02790930        Alabama 1984 Female
    ## 32        70.58465      64.71068  5.87397289        Alabama 1984   Male
    ## 33        78.50161      73.51463  4.98697930        Alabama 1985 Female
    ## 34        70.62305      64.69266  5.93038337        Alabama 1985   Male
    ## 35        78.63556      73.58970  5.04586389        Alabama 1986 Female
    ## 36        70.71239      64.74245  5.96994770        Alabama 1986   Male
    ## 37        78.75004      73.69941  5.05062748        Alabama 1987 Female
    ## 38        70.85862      64.78478  6.07383876        Alabama 1987   Male
    ## 39        78.64258      73.75238  4.89019906        Alabama 1988 Female
    ## 40        70.96599      64.62219  6.34379953        Alabama 1988   Male
    ## 41        78.78045      73.83139  4.94906078        Alabama 1989 Female
    ## 42        71.08621      64.57172  6.51449700        Alabama 1989   Male
    ## 43        78.92186      73.96738  4.95447230        Alabama 1990 Female
    ## 44        71.25969      64.58506  6.67462503        Alabama 1990   Male
    ## 45        78.99744      74.10522  4.89222063        Alabama 1991 Female
    ## 46        71.42637      64.59074  6.83563313        Alabama 1991   Male
    ## 47        79.17180      74.29121  4.88058087        Alabama 1992 Female
    ## 48        71.66270      64.82603  6.83667542        Alabama 1992   Male
    ## 49        78.88148      74.32927  4.55221265        Alabama 1993 Female
    ## 50        71.79174      64.97918  6.81255531        Alabama 1993   Male
    ## 51        78.90500      74.48654  4.41846184        Alabama 1994 Female
    ## 52        71.89220      65.09336  6.79884447        Alabama 1994   Male
    ## 53        78.86275      74.60033  4.26241974        Alabama 1995 Female
    ## 54        71.94325      65.22518  6.71806961        Alabama 1995   Male
    ## 55        78.83851      74.66717  4.17133943        Alabama 1996 Female
    ## 56        72.00976      65.52882  6.48093927        Alabama 1996   Male
    ## 57        78.75176      74.73332  4.01844154        Alabama 1997 Female
    ## 58        72.17952      65.91540  6.26412420        Alabama 1997   Male
    ## 59        78.65569      74.67385  3.98184119        Alabama 1998 Female
    ## 60        72.29706      66.26115  6.03591050        Alabama 1998   Male
    ## 61        78.54932      74.73741  3.81190697        Alabama 1999 Female
    ## 62        72.41598      66.46885  5.94713432        Alabama 1999   Male
    ## 63        78.52014      74.78353  3.73660138        Alabama 2000 Female
    ## 64        72.48677      66.72354  5.76323086        Alabama 2000   Male
    ## 65        78.45314      74.79779  3.65535055        Alabama 2001 Female
    ## 66        72.63828      66.95869  5.67958695        Alabama 2001   Male
    ## 67        78.35059      74.72285  3.62773369        Alabama 2002 Female
    ## 68        72.66682      67.17611  5.49070621        Alabama 2002   Male
    ## 69        78.25865      74.82016  3.43848697        Alabama 2003 Female
    ## 70        72.71479      67.29026  5.42453250        Alabama 2003   Male
    ## 71        78.35989      74.96662  3.39327509        Alabama 2004 Female
    ## 72        72.77970      67.48123  5.29847125        Alabama 2004   Male
    ## 73        78.27544      75.14125  3.13418977        Alabama 2005 Female
    ## 74        72.85913      67.61564  5.24348303        Alabama 2005   Male
    ## 75        78.43935      75.39469  3.04466694        Alabama 2006 Female
    ## 76        72.92815      67.80190  5.12624607        Alabama 2006   Male
    ## 77        78.54737      75.69449  2.85287346        Alabama 2007 Female
    ## 78        73.00856      68.15256  4.85600815        Alabama 2007   Male
    ## 79        78.48083      75.97046  2.51036737        Alabama 2008 Female
    ## 80        73.16572      68.50613  4.65959017        Alabama 2008   Male
    ## 81        78.64204      76.26862  2.37341741        Alabama 2009 Female
    ## 82        73.31535      68.90634  4.40900671        Alabama 2009   Male
    ## 83        78.63861      76.41028  2.22833317        Alabama 2010 Female
    ## 84        73.38637      69.26360  4.12276419        Alabama 2010   Male
    ## 85        78.63421      76.59918  2.03503223        Alabama 2011 Female
    ## 86        73.41588      69.38126  4.03461517        Alabama 2011   Male
    ## 87        78.58081      76.69125  1.88956056        Alabama 2012 Female
    ## 88        73.46015      69.53077  3.92938314        Alabama 2012   Male
    ## 89        78.68862      76.79254  1.89608050        Alabama 2013 Female
    ## 90        73.33767      69.53734  3.80033013        Alabama 2013   Male
    ## 91        76.33516      73.02677  3.30838942        Arizona 1969 Female
    ## 92        67.88692      62.61985  5.26707360        Arizona 1969   Male
    ## 93        76.42114      73.13520  3.28593796        Arizona 1970 Female
    ## 94        68.12493      63.00469  5.12023518        Arizona 1970   Male
    ## 95        76.65022      73.24284  3.40737823        Arizona 1971 Female
    ## 96        68.40227      63.32161  5.08065300        Arizona 1971   Male
    ## 97        77.05871      73.32980  3.72890860        Arizona 1972 Female
    ## 98        68.80020      63.57041  5.22979188        Arizona 1972   Male
    ## 99        77.31499      73.47873  3.83625976        Arizona 1973 Female
    ## 100       69.06261      63.90984  5.15277230        Arizona 1973   Male
    ## 101       77.80500      73.46276  4.34224544        Arizona 1974 Female
    ## 102       69.54296      64.08203  5.46092852        Arizona 1974   Male
    ## 103       78.21851      73.51800  4.70051038        Arizona 1975 Female
    ## 104       70.10208      64.54259  5.55948944        Arizona 1975   Male
    ## 105       78.59146      73.61634  4.97511160        Arizona 1976 Female
    ## 106       70.55662      65.00477  5.55185761        Arizona 1976   Male
    ## 107       78.89447      73.73428  5.16018924        Arizona 1977 Female
    ## 108       70.81217      65.39799  5.41417866        Arizona 1977   Male
    ## 109       78.95280      74.01566  4.93713357        Arizona 1978 Female
    ## 110       70.97189      65.70755  5.26434015        Arizona 1978   Male
    ## 111       79.15211      74.37022  4.78188679        Arizona 1979 Female
    ## 112       71.21981      65.91988  5.29993682        Arizona 1979   Male
    ## 113       79.09699      74.62407  4.47291689        Arizona 1980 Female
    ## 114       71.30611      66.26445  5.04165750        Arizona 1980   Male
    ## 115       79.33205      74.87943  4.45262587        Arizona 1981 Female
    ## 116       71.61224      66.61658  4.99565738        Arizona 1981   Male
    ## 117       79.42451      75.19298  4.23152806        Arizona 1982 Female
    ## 118       71.93587      67.02696  4.90890951        Arizona 1982   Male
    ## 119       79.57474      75.25585  4.31889107        Arizona 1983 Female
    ## 120       72.22496      67.19177  5.03318587        Arizona 1983   Male
    ## 121       79.61300      75.52769  4.08531757        Arizona 1984 Female
    ## 122       72.28398      67.51974  4.76423857        Arizona 1984   Male
    ## 123       79.65462      75.71476  3.93986700        Arizona 1985 Female
    ## 124       72.43034      67.80086  4.62947909        Arizona 1985   Male
    ## 125       79.79537      75.75907  4.03630001        Arizona 1986 Female
    ## 126       72.57760      67.90497  4.67263062        Arizona 1986   Male
    ## 127       79.74020      75.65355  4.08664830        Arizona 1987 Female
    ## 128       72.60541      67.94833  4.65708628        Arizona 1987   Male
    ## 129       79.86981      75.53121  4.33860287        Arizona 1988 Female
    ## 130       72.77015      67.99202  4.77813011        Arizona 1988   Male
    ## 131       80.01101      75.55401  4.45699726        Arizona 1989 Female
    ## 132       73.02106      68.01214  5.00891655        Arizona 1989   Male
    ## 133       80.23219      75.69865  4.53354411        Arizona 1990 Female
    ## 134       73.19368      68.08190  5.11177633        Arizona 1990   Male
    ## 135       80.46544      75.80183  4.66360391        Arizona 1991 Female
    ## 136       73.45276      68.20342  5.24933749        Arizona 1991   Male
    ## 137       80.58915      76.07553  4.51361879        Arizona 1992 Female
    ## 138       73.47660      68.37087  5.10573089        Arizona 1992   Male
    ## 139       80.40261      76.27859  4.12401901        Arizona 1993 Female
    ## 140       73.46324      68.65553  4.80770625        Arizona 1993   Male
    ## 141       80.49133      76.44911  4.04221626        Arizona 1994 Female
    ## 142       73.68753      68.81370  4.87382878        Arizona 1994   Male
    ## 143       80.57889      76.68826  3.89063703        Arizona 1995 Female
    ## 144       73.93029      69.17614  4.75414340        Arizona 1995   Male
    ## 145       80.63812      76.76495  3.87317607        Arizona 1996 Female
    ## 146       74.25524      69.61262  4.64262071        Arizona 1996   Male
    ## 147       80.69614      76.84099  3.85515050        Arizona 1997 Female
    ## 148       74.74753      69.92947  4.81805444        Arizona 1997   Male
    ## 149       80.76359      76.84964  3.91394613        Arizona 1998 Female
    ## 150       74.86956      70.24606  4.62349405        Arizona 1998   Male
    ## 151       80.75415      76.89702  3.85712925        Arizona 1999 Female
    ## 152       74.90806      70.65595  4.25210611        Arizona 1999   Male
    ## 153       80.81160      77.00467  3.80693205        Arizona 2000 Female
    ## 154       75.13409      71.05840  4.07568695        Arizona 2000   Male
    ## 155       80.88469      77.30627  3.57842137        Arizona 2001 Female
    ## 156       75.24049      71.41439  3.82610770        Arizona 2001   Male
    ## 157       80.79628      77.70170  3.09457210        Arizona 2002 Female
    ## 158       75.18778      71.86841  3.31936627        Arizona 2002   Male
    ## 159       80.87158      77.72280  3.14878070        Arizona 2003 Female
    ## 160       75.38763      72.22682  3.16081626        Arizona 2003   Male
    ## 161       81.03090      77.92437  3.10653104        Arizona 2004 Female
    ## 162       75.60321      72.66129  2.94191990        Arizona 2004   Male
    ## 163       80.95809      78.19569  2.76239500        Arizona 2005 Female
    ## 164       75.63437      72.99522  2.63914772        Arizona 2005   Male
    ## 165       81.14981      78.41683  2.73297832        Arizona 2006 Female
    ## 166       75.96955      73.14262  2.82693141        Arizona 2006   Male
    ## 167       81.58380      78.54280  3.04100531        Arizona 2007 Female
    ## 168       76.43979      73.56460  2.87518419        Arizona 2007   Male
    ## 169       81.94120      78.79485  3.14634718        Arizona 2008 Female
    ## 170       76.83722      73.97770  2.85952060        Arizona 2008   Male
    ## 171       82.31123      78.94661  3.36462250        Arizona 2009 Female
    ## 172       77.27908      74.40640  2.87267639        Arizona 2009   Male
    ## 173       82.43070      79.19605  3.23464890        Arizona 2010 Female
    ## 174       77.44601      74.65515  2.79085913        Arizona 2010   Male
    ## 175       82.32946      79.21949  3.10997006        Arizona 2011 Female
    ## 176       77.51098      74.81421  2.69677285        Arizona 2011   Male
    ## 177       82.54546      79.12824  3.41721502        Arizona 2012 Female
    ## 178       77.58833      74.93810  2.65022959        Arizona 2012   Male
    ## 179       82.60941      79.11807  3.49134549        Arizona 2013 Female
    ## 180       77.81555      74.87462  2.94093184        Arizona 2013   Male
    ## 181       76.52843      70.67526  5.85317260       Arkansas 1969 Female
    ## 182       67.72258      62.18900  5.53358298       Arkansas 1969   Male
    ## 183       76.66928      70.92849  5.74078839       Arkansas 1970 Female
    ## 184       67.83461      62.37543  5.45918829       Arkansas 1970   Male
    ## 185       76.81523      71.17513  5.64009600       Arkansas 1971 Female
    ## 186       67.91519      62.63977  5.27541908       Arkansas 1971   Male
    ## 187       76.85985      71.36953  5.49032045       Arkansas 1972 Female
    ## 188       67.98296      62.83535  5.14761179       Arkansas 1972   Male
    ## 189       76.96751      71.64570  5.32180992       Arkansas 1973 Female
    ## 190       68.16029      62.94170  5.21858455       Arkansas 1973   Male
    ## 191       77.26028      72.01527  5.24501528       Arkansas 1974 Female
    ## 192       68.50910      63.24643  5.26266441       Arkansas 1974   Male
    ## 193       77.78555      72.37269  5.41286054       Arkansas 1975 Female
    ## 194       68.84396      63.61967  5.22428810       Arkansas 1975   Male
    ## 195       78.10684      72.69221  5.41463785       Arkansas 1976 Female
    ## 196       69.29281      64.04583  5.24698507       Arkansas 1976   Male
    ## 197       78.30885      73.07898  5.22987048       Arkansas 1977 Female
    ## 198       69.69073      64.29508  5.39564850       Arkansas 1977   Male
    ## 199       78.41405      73.47260  4.94144692       Arkansas 1978 Female
    ## 200       70.01411      64.49976  5.51435149       Arkansas 1978   Male
    ## 201       78.67112      73.70437  4.96674411       Arkansas 1979 Female
    ## 202       70.27625      64.75135  5.52489739       Arkansas 1979   Male
    ## 203       78.69531      73.84848  4.84683330       Arkansas 1980 Female
    ## 204       70.34853      64.85664  5.49188880       Arkansas 1980   Male
    ## 205       78.81978      74.17974  4.64003506       Arkansas 1981 Female
    ## 206       70.55306      65.02961  5.52344849       Arkansas 1981   Male
    ## 207       78.90682      74.29560  4.61121831       Arkansas 1982 Female
    ## 208       70.70369      65.23114  5.47254690       Arkansas 1982   Male
    ## 209       78.89100      74.14246  4.74853471       Arkansas 1983 Female
    ## 210       70.68654      65.34509  5.34145471       Arkansas 1983   Male
    ## 211       78.83395      74.05984  4.77410806       Arkansas 1984 Female
    ## 212       70.72387      65.25444  5.46942894       Arkansas 1984   Male
    ## 213       78.78564      73.92525  4.86038025       Arkansas 1985 Female
    ## 214       70.74545      65.27885  5.46660146       Arkansas 1985   Male
    ## 215       78.89633      73.90799  4.98834498       Arkansas 1986 Female
    ## 216       70.89340      65.18543  5.70797051       Arkansas 1986   Male
    ## 217       78.86264      73.82661  5.03603199       Arkansas 1987 Female
    ## 218       71.01309      65.08153  5.93156685       Arkansas 1987   Male
    ## 219       78.82779      73.81190  5.01589310       Arkansas 1988 Female
    ## 220       71.16249      64.93113  6.23135637       Arkansas 1988   Male
    ## 221       78.95028      73.85767  5.09260768       Arkansas 1989 Female
    ## 222       71.39366      64.81322  6.58043296       Arkansas 1989   Male
    ## 223       79.09428      73.93008  5.16420662       Arkansas 1990 Female
    ## 224       71.57401      64.72213  6.85187495       Arkansas 1990   Male
    ## 225       79.12612      73.94525  5.18086944       Arkansas 1991 Female
    ## 226       71.68582      64.63861  7.04720610       Arkansas 1991   Male
    ## 227       79.17780      74.01808  5.15971913       Arkansas 1992 Female
    ## 228       71.75535      64.68121  7.07413887       Arkansas 1992   Male
    ## 229       79.00325      73.98698  5.01626849       Arkansas 1993 Female
    ## 230       71.71290      64.80032  6.91257460       Arkansas 1993   Male
    ## 231       79.07423      74.17007  4.90415631       Arkansas 1994 Female
    ## 232       71.87293      64.98520  6.88772945       Arkansas 1994   Male
    ## 233       79.09565      74.16359  4.93205577       Arkansas 1995 Female
    ## 234       72.03712      65.16295  6.87416705       Arkansas 1995   Male
    ## 235       79.02219      74.31453  4.70765619       Arkansas 1996 Female
    ## 236       72.18263      65.50663  6.67600325       Arkansas 1996   Male
    ## 237       78.83576      74.26791  4.56785041       Arkansas 1997 Female
    ## 238       72.25293      65.75484  6.49808988       Arkansas 1997   Male
    ## 239       78.81472      74.27865  4.53607079       Arkansas 1998 Female
    ## 240       72.44804      66.02806  6.41998444       Arkansas 1998   Male
    ## 241       78.76741      74.30802  4.45938892       Arkansas 1999 Female
    ## 242       72.59283      66.37793  6.21489952       Arkansas 1999   Male
    ## 243       78.74775      74.35238  4.39536435       Arkansas 2000 Female
    ## 244       72.71483      66.60525  6.10958599       Arkansas 2000   Male
    ## 245       78.76043      74.43497  4.32545675       Arkansas 2001 Female
    ## 246       72.81820      66.83527  5.98292992       Arkansas 2001   Male
    ## 247       78.68936      74.48232  4.20703819       Arkansas 2002 Female
    ## 248       72.88430      66.96973  5.91456454       Arkansas 2002   Male
    ## 249       78.76038      74.71419  4.04619299       Arkansas 2003 Female
    ## 250       73.09400      67.05900  6.03500128       Arkansas 2003   Male
    ## 251       78.89069      74.89235  3.99834718       Arkansas 2004 Female
    ## 252       73.29755      67.24530  6.05224126       Arkansas 2004   Male
    ## 253       78.94193      74.94779  3.99413887       Arkansas 2005 Female
    ## 254       73.36726      67.41230  5.95496689       Arkansas 2005   Male
    ## 255       79.09106      75.11267  3.97839493       Arkansas 2006 Female
    ## 256       73.53340      67.64524  5.88816044       Arkansas 2006   Male
    ## 257       79.07334      75.31807  3.75527282       Arkansas 2007 Female
    ## 258       73.63523      67.95512  5.68010749       Arkansas 2007   Male
    ## 259       78.94732      75.57886  3.36845989       Arkansas 2008 Female
    ## 260       73.61592      68.19017  5.42574862       Arkansas 2008   Male
    ## 261       79.13756      75.73592  3.40164442       Arkansas 2009 Female
    ## 262       73.68882      68.53224  5.15658072       Arkansas 2009   Male
    ## 263       79.10983      75.94195  3.16788304       Arkansas 2010 Female
    ## 264       73.72675      68.83822  4.88853092       Arkansas 2010   Male
    ## 265       78.93495      76.11961  2.81533994       Arkansas 2011 Female
    ## 266       73.77240      69.01227  4.76013237       Arkansas 2011   Male
    ## 267       78.90528      76.21607  2.68920663       Arkansas 2012 Female
    ## 268       73.77933      69.19678  4.58254158       Arkansas 2012   Male
    ## 269       78.88448      76.27456  2.60992523       Arkansas 2013 Female
    ## 270       73.80713      69.24120  4.56593195       Arkansas 2013   Male
    ## 271       75.61137      71.10311  4.50826839     California 1969 Female
    ## 272       68.24766      63.11662  5.13103732     California 1969   Male
    ## 273       75.84916      71.35243  4.49672805     California 1970 Female
    ## 274       68.59865      63.40647  5.19217631     California 1970   Male
    ## 275       76.05663      71.77241  4.28421873     California 1971 Female
    ## 276       68.88162      63.68740  5.19421626     California 1971   Male
    ## 277       76.35680      71.99438  4.36241462     California 1972 Female
    ## 278       70.31368      63.94911  6.36456320     California 1972   Male
    ## 279       76.54274      72.32209  4.22065255     California 1973 Female
    ## 280       69.30995      64.22637  5.08358817     California 1973   Male
    ## 281       76.97124      72.67064  4.30060544     California 1974 Female
    ## 282       69.69121      64.50240  5.18880438     California 1974   Male
    ## 283       77.39540      73.11948  4.27592103     California 1975 Female
    ## 284       70.04753      64.79229  5.25524433     California 1975   Male
    ## 285       77.62148      73.43815  4.18332899     California 1976 Female
    ## 286       70.41912      64.97195  5.44716922     California 1976   Male
    ## 287       78.08499      73.72798  4.35700887     California 1977 Female
    ## 288       70.82118      65.27505  5.54613536     California 1977   Male
    ## 289       78.19838      73.97074  4.22764371     California 1978 Female
    ## 290       70.91838      65.30669  5.61168740     California 1978   Male
    ## 291       78.37076      73.96876  4.40200182     California 1979 Female
    ## 292       71.07621      65.39553  5.68067087     California 1979   Male
    ## 293       78.16407      73.88139  4.28267797     California 1980 Female
    ## 294       71.11893      65.41693  5.70200843     California 1980   Male
    ## 295       78.46501      74.03942  4.42559177     California 1981 Female
    ## 296       71.54479      65.74955  5.79523983     California 1981   Male
    ## 297       78.61585      74.14398  4.47187275     California 1982 Female
    ## 298       71.75172      66.01643  5.73529061     California 1982   Male
    ## 299       78.78659      74.22103  4.56555740     California 1983 Female
    ## 300       72.12644      66.32592  5.80052112     California 1983   Male
    ## 301       78.73962      74.21745  4.52216225     California 1984 Female
    ## 302       72.06465      66.19083  5.87381655     California 1984   Male
    ## 303       78.72396      74.19715  4.52681468     California 1985 Female
    ## 304       72.01504      66.07378  5.94126409     California 1985   Male
    ## 305       78.93284      74.12923  4.80361791     California 1986 Female
    ## 306       72.20432      65.76723  6.43709479     California 1986   Male
    ## 307       78.85457      73.90033  4.95423950     California 1987 Female
    ## 308       72.19173      65.54532  6.64640608     California 1987   Male
    ## 309       78.77147      73.79586  4.97561018     California 1988 Female
    ## 310       72.24736      65.56983  6.67753573     California 1988   Male
    ## 311       78.94818      73.90157  5.04661028     California 1989 Female
    ## 312       72.37734      65.53354  6.84379742     California 1989   Male
    ## 313       79.37807      74.29218  5.08588119     California 1990 Female
    ## 314       72.64591      65.86735  6.77855923     California 1990   Male
    ## 315       79.69066      74.54225  5.14840512     California 1991 Female
    ## 316       72.93671      65.73026  7.20645286     California 1991   Male
    ## 317       79.89161      74.67413  5.21747846     California 1992 Female
    ## 318       73.18238      65.85162  7.33076301     California 1992   Male
    ## 319       79.83639      74.66835  5.16803211     California 1993 Female
    ## 320       73.21654      65.76640  7.45014794     California 1993   Male
    ## 321       79.87545      74.77256  5.10289071     California 1994 Female
    ## 322       73.38440      66.06341  7.32099178     California 1994   Male
    ## 323       80.07046      74.99749  5.07296918     California 1995 Female
    ## 324       73.69254      66.71032  6.98221962     California 1995   Male
    ## 325       80.16597      75.17496  4.99101157     California 1996 Female
    ## 326       74.39381      67.61460  6.77921223     California 1996   Male
    ## 327       80.21535      75.43225  4.78310289     California 1997 Female
    ## 328       74.92630      68.59932  6.32698708     California 1997   Male
    ## 329       80.27112      75.54896  4.72215863     California 1998 Female
    ## 330       75.25034      69.13555  6.11478877     California 1998   Male
    ## 331       80.42761      75.65831  4.76929960     California 1999 Female
    ## 332       75.62267      69.63672  5.98594675     California 1999   Male
    ## 333       80.64899      76.00860  4.64039287     California 2000 Female
    ## 334       75.83614      69.88504  5.95109871     California 2000   Male
    ## 335       80.69506      76.12897  4.56608718     California 2001 Female
    ## 336       75.94105      69.95077  5.99028164     California 2001   Male
    ## 337       80.86604      76.23299  4.63305280     California 2002 Female
    ## 338       76.09015      69.96988  6.12026827     California 2002   Male
    ## 339       80.94667      76.41568  4.53098966     California 2003 Female
    ## 340       76.16323      70.19597  5.96726404     California 2003   Male
    ## 341       81.33738      76.68942  4.64795425     California 2004 Female
    ## 342       76.59084      70.46576  6.12508187     California 2004   Male
    ## 343       81.44743      76.94013  4.50730464     California 2005 Female
    ## 344       76.68469      70.72547  5.95921890     California 2005   Male
    ## 345       81.68578      77.16841  4.51737468     California 2006 Female
    ## 346       76.81648      71.22006  5.59642190     California 2006   Male
    ## 347       82.08203      77.52959  4.55244226     California 2007 Female
    ## 348       77.27828      71.78570  5.49257516     California 2007   Male
    ## 349       82.26575      77.94231  4.32343938     California 2008 Female
    ## 350       77.60489      72.50589  5.09899872     California 2008   Male
    ## 351       82.70853      78.49702  4.21150687     California 2009 Female
    ## 352       77.94163      73.09345  4.84818448     California 2009   Male
    ## 353       82.82861      78.93503  3.89357985     California 2010 Female
    ## 354       78.25793      73.61546  4.64246963     California 2010   Male
    ## 355       82.86605      79.05075  3.81529211     California 2011 Female
    ## 356       78.31488      73.81598  4.49889771     California 2011   Male
    ## 357       83.03270      79.29562  3.73708569     California 2012 Female
    ## 358       78.44007      74.04030  4.39977591     California 2012   Male
    ## 359       83.06183      79.50595  3.55587764     California 2013 Female
    ## 360       78.41147      74.08218  4.32928165     California 2013   Male
    ## 361       76.34942      72.08219  4.26722665       Colorado 1969 Female
    ## 362       68.80111      64.39803  4.40308202       Colorado 1969   Male
    ## 363       76.55851      72.31106  4.24744965       Colorado 1970 Female
    ## 364       68.91035      64.81388  4.09646949       Colorado 1970   Male
    ## 365       76.69491      72.48582  4.20908295       Colorado 1971 Female
    ## 366       69.15192      65.20468  3.94724276       Colorado 1971   Male
    ## 367       76.99567      72.67777  4.31790384       Colorado 1972 Female
    ## 368       69.29327      65.44425  3.84902102       Colorado 1972   Male
    ## 369       77.06383      72.95840  4.10543010       Colorado 1973 Female
    ## 370       69.49156      65.69571  3.79585543       Colorado 1973   Male
    ## 371       77.59144      73.35566  4.23578286       Colorado 1974 Female
    ## 372       70.05510      66.11747  3.93762997       Colorado 1974   Male
    ## 373       78.18986      73.67495  4.51491611       Colorado 1975 Female
    ## 374       70.49642      66.46888  4.02753914       Colorado 1975   Male
    ## 375       78.37987      73.86496  4.51491169       Colorado 1976 Female
    ## 376       70.79054      66.80188  3.98866323       Colorado 1976   Male
    ## 377       78.66947      74.21721  4.45225479       Colorado 1977 Female
    ## 378       71.18453      67.00528  4.17925546       Colorado 1977   Male
    ## 379       78.87402      74.43414  4.43988617       Colorado 1978 Female
    ## 380       71.46924      67.19432  4.27492082       Colorado 1978   Male
    ## 381       79.10932      74.67490  4.43441127       Colorado 1979 Female
    ## 382       71.68427      67.39391  4.29036016       Colorado 1979   Male
    ## 383       79.22198      74.94054  4.28144140       Colorado 1980 Female
    ## 384       71.96865      67.59329  4.37535576       Colorado 1980   Male
    ## 385       79.22861      75.35904  3.86957292       Colorado 1981 Female
    ## 386       72.16569      67.84027  4.32542107       Colorado 1981   Male
    ## 387       79.41086      75.73081  3.68004670       Colorado 1982 Female
    ## 388       72.39389      68.08676  4.30713105       Colorado 1982   Male
    ## 389       79.67227      75.79254  3.87972634       Colorado 1983 Female
    ## 390       72.72121      68.24918  4.47202933       Colorado 1983   Male
    ## 391       79.43395      75.68857  3.74538624       Colorado 1984 Female
    ## 392       73.01519      68.50655  4.50864166       Colorado 1984   Male
    ## 393       79.66307      75.69157  3.97149870       Colorado 1985 Female
    ## 394       73.21455      68.66982  4.54472421       Colorado 1985   Male
    ## 395       79.71284      75.81314  3.89970325       Colorado 1986 Female
    ## 396       73.38862      68.74866  4.63995644       Colorado 1986   Male
    ## 397       79.82284      75.90607  3.91676679       Colorado 1987 Female
    ## 398       73.45832      68.87428  4.58403966       Colorado 1987   Male
    ## 399       79.87479      76.03389  3.84090605       Colorado 1988 Female
    ## 400       73.56891      69.01205  4.55685918       Colorado 1988   Male
    ## 401       80.22725      76.12834  4.09891187       Colorado 1989 Female
    ## 402       73.83456      69.04236  4.79219972       Colorado 1989   Male
    ## 403       80.29404      76.27981  4.01422319       Colorado 1990 Female
    ## 404       74.01208      69.15834  4.85374600       Colorado 1990   Male
    ## 405       80.33213      76.36289  3.96923477       Colorado 1991 Female
    ## 406       74.12946      69.20171  4.92774437       Colorado 1991   Male
    ## 407       80.54754      76.38655  4.16098750       Colorado 1992 Female
    ## 408       74.30225      69.34834  4.95391624       Colorado 1992   Male
    ## 409       80.43346      76.32955  4.10391094       Colorado 1993 Female
    ## 410       74.47180      69.45417  5.01762922       Colorado 1993   Male
    ## 411       80.59488      76.24849  4.34639557       Colorado 1994 Female
    ## 412       74.63090      69.73587  4.89503123       Colorado 1994   Male
    ## 413       80.55634      76.26714  4.28919795       Colorado 1995 Female
    ## 414       74.81308      70.04164  4.77143192       Colorado 1995   Male
    ## 415       80.42932      76.46174  3.96757949       Colorado 1996 Female
    ## 416       75.11494      70.45450  4.66044425       Colorado 1996   Male
    ## 417       80.59560      76.44944  4.14616407       Colorado 1997 Female
    ## 418       75.45330      70.86285  4.59045329       Colorado 1997   Male
    ## 419       80.59944      76.52271  4.07673363       Colorado 1998 Female
    ## 420       75.63342      71.23525  4.39817610       Colorado 1998   Male
    ## 421       80.61467      76.74863  3.86604434       Colorado 1999 Female
    ## 422       75.85603      71.56317  4.29286491       Colorado 1999   Male
    ## 423       80.72208      77.02808  3.69400183       Colorado 2000 Female
    ## 424       76.08963      71.86890  4.22073484       Colorado 2000   Male
    ## 425       80.61906      77.36418  3.25487874       Colorado 2001 Female
    ## 426       76.18632      72.24418  3.94213645       Colorado 2001   Male
    ## 427       80.69304      77.60913  3.08391133       Colorado 2002 Female
    ## 428       76.10570      72.50468  3.60101941       Colorado 2002   Male
    ## 429       80.81923      77.82560  2.99363005       Colorado 2003 Female
    ## 430       76.33478      72.76518  3.56960015       Colorado 2003   Male
    ## 431       81.36144      78.22880  3.13263184       Colorado 2004 Female
    ## 432       76.64509      73.20706  3.43803481       Colorado 2004   Male
    ## 433       81.35205      78.48845  2.86359667       Colorado 2005 Female
    ## 434       76.80692      73.49900  3.30791266       Colorado 2005   Male
    ## 435       81.57330      79.01296  2.56034128       Colorado 2006 Female
    ## 436       77.18657      73.77045  3.41611802       Colorado 2006   Male
    ## 437       81.81383      79.31345  2.50037856       Colorado 2007 Female
    ## 438       77.32956      74.01758  3.31198580       Colorado 2007   Male
    ## 439       81.85562      79.50519  2.35043090       Colorado 2008 Female
    ## 440       77.47664      74.12637  3.35027795       Colorado 2008   Male
    ## 441       82.16596      79.74368  2.42228133       Colorado 2009 Female
    ## 442       77.78008      74.28412  3.49596347       Colorado 2009   Male
    ## 443       82.27205      79.76894  2.50310807       Colorado 2010 Female
    ## 444       78.00535      74.51389  3.49146525       Colorado 2010   Male
    ## 445       82.40245      79.76018  2.64226501       Colorado 2011 Female
    ## 446       78.06313      74.71306  3.35006827       Colorado 2011   Male
    ## 447       82.53527      79.81738  2.71788845       Colorado 2012 Female
    ## 448       78.22452      74.80897  3.41554718       Colorado 2012   Male
    ## 449       82.60998      80.00867  2.60130554       Colorado 2013 Female
    ## 450       78.37070      74.78922  3.58147102       Colorado 2013   Male
    ## 451       76.47760      71.15791  5.31969424    Connecticut 1969 Female
    ## 452       69.50021      63.09528  6.40492506    Connecticut 1969   Male
    ## 453       76.77799      71.31697  5.46101813    Connecticut 1970 Female
    ## 454       69.69640      63.34781  6.34859210    Connecticut 1970   Male
    ## 455       77.06337      71.57865  5.48472136    Connecticut 1971 Female
    ## 456       69.97978      63.80900  6.17077384    Connecticut 1971   Male
    ## 457       77.24125      71.99620  5.24505039    Connecticut 1972 Female
    ## 458       70.09304      64.06556  6.02747285    Connecticut 1972   Male
    ## 459       77.41472      72.27179  5.14293792    Connecticut 1973 Female
    ## 460       70.27600      64.41064  5.86536359    Connecticut 1973   Male
    ## 461       77.80592      72.56764  5.23827725    Connecticut 1974 Female
    ## 462       70.62742      64.51327  6.11415551    Connecticut 1974   Male
    ## 463       78.19723      73.02042  5.17680867    Connecticut 1975 Female
    ## 464       70.95579      64.78620  6.16959176    Connecticut 1975   Male
    ## 465       78.28651      73.51811  4.76840538    Connecticut 1976 Female
    ## 466       71.24947      65.03112  6.21835504    Connecticut 1976   Male
    ## 467       78.61064      73.92850  4.68214028    Connecticut 1977 Female
    ## 468       71.57795      65.47379  6.10415936    Connecticut 1977   Male
    ## 469       78.76010      74.15004  4.61005826    Connecticut 1978 Female
    ## 470       71.80963      65.63267  6.17695777    Connecticut 1978   Male
    ## 471       79.03240      74.40337  4.62902983    Connecticut 1979 Female
    ## 472       71.90152      65.85220  6.04932270    Connecticut 1979   Male
    ## 473       78.98701      74.77736  4.20965703    Connecticut 1980 Female
    ## 474       71.99104      65.92817  6.06286844    Connecticut 1980   Male
    ## 475       79.28181      74.89907  4.38274078    Connecticut 1981 Female
    ## 476       72.23752      65.87413  6.36339619    Connecticut 1981   Male
    ## 477       79.49411      74.97705  4.51705389    Connecticut 1982 Female
    ## 478       72.46327      65.94888  6.51438465    Connecticut 1982   Male
    ## 479       79.49281      75.06701  4.42580616    Connecticut 1983 Female
    ## 480       72.73598      65.93652  6.79945436    Connecticut 1983   Male
    ## 481       79.54047      74.79862  4.74184611    Connecticut 1984 Female
    ## 482       72.85597      66.07496  6.78101126    Connecticut 1984   Male
    ## 483       79.57498      74.93449  4.64049026    Connecticut 1985 Female
    ## 484       73.03099      65.91199  7.11899915    Connecticut 1985   Male
    ## 485       79.72043      75.04600  4.67442789    Connecticut 1986 Female
    ## 486       73.31852      65.94437  7.37414654    Connecticut 1986   Male
    ## 487       79.85528      75.28724  4.56803704    Connecticut 1987 Female
    ## 488       73.52005      65.88007  7.63998547    Connecticut 1987   Male
    ## 489       79.96591      75.54063  4.42528340    Connecticut 1988 Female
    ## 490       73.68576      65.85532  7.83043540    Connecticut 1988   Male
    ## 491       80.31618      75.70660  4.60957757    Connecticut 1989 Female
    ## 492       74.01056      65.89458  8.11597650    Connecticut 1989   Male
    ## 493       80.59371      75.80493  4.78877751    Connecticut 1990 Female
    ## 494       74.34835      66.23551  8.11284459    Connecticut 1990   Male
    ## 495       80.74276      76.05957  4.68318704    Connecticut 1991 Female
    ## 496       74.46744      66.37866  8.08878293    Connecticut 1991   Male
    ## 497       80.81305      76.16379  4.64926037    Connecticut 1992 Female
    ## 498       74.60022      66.24426  8.35595630    Connecticut 1992   Male
    ## 499       80.76474      76.21444  4.55030158    Connecticut 1993 Female
    ## 500       74.67854      66.01895  8.65959282    Connecticut 1993   Male
    ## 501       80.82951      76.25073  4.57877322    Connecticut 1994 Female
    ## 502       74.84503      66.14768  8.69735138    Connecticut 1994   Male
    ## 503       80.88602      76.53008  4.35594739    Connecticut 1995 Female
    ## 504       75.00623      67.02695  7.97927949    Connecticut 1995   Male
    ## 505       80.87900      76.95780  3.92119850    Connecticut 1996 Female
    ## 506       75.33531      68.03423  7.30107516    Connecticut 1996   Male
    ## 507       80.98967      77.15003  3.83963421    Connecticut 1997 Female
    ## 508       75.56187      69.26950  6.29237008    Connecticut 1997   Male
    ## 509       81.04310      77.34356  3.69953531    Connecticut 1998 Female
    ## 510       75.81809      69.89295  5.92514783    Connecticut 1998   Male
    ## 511       81.22208      77.80617  3.41591120    Connecticut 1999 Female
    ## 512       76.06772      70.42759  5.64013301    Connecticut 1999   Male
    ## 513       81.27641      78.15795  3.11846316    Connecticut 2000 Female
    ## 514       76.21889      70.82942  5.38946998    Connecticut 2000   Male
    ## 515       81.39986      78.48818  2.91167826    Connecticut 2001 Female
    ## 516       76.52585      71.33530  5.19054236    Connecticut 2001   Male
    ## 517       81.59850      78.87951  2.71898747    Connecticut 2002 Female
    ## 518       76.61072      71.95167  4.65905376    Connecticut 2002   Male
    ## 519       81.85153      79.12592  2.72560965    Connecticut 2003 Female
    ## 520       76.94005      72.51916  4.42088856    Connecticut 2003   Male
    ## 521       82.16116      79.41667  2.74448862    Connecticut 2004 Female
    ## 522       77.20055      72.88651  4.31404340    Connecticut 2004   Male
    ## 523       82.19408      79.81453  2.37955575    Connecticut 2005 Female
    ## 524       77.46340      73.29788  4.16552415    Connecticut 2005   Male
    ## 525       82.42115      80.18354  2.23761122    Connecticut 2006 Female
    ## 526       77.68332      73.78193  3.90139364    Connecticut 2006   Male
    ## 527       82.69099      80.52904  2.16194303    Connecticut 2007 Female
    ## 528       77.98322      74.20674  3.77647571    Connecticut 2007   Male
    ## 529       82.80365      80.95782  1.84583174    Connecticut 2008 Female
    ## 530       78.21930      74.68782  3.53147704    Connecticut 2008   Male
    ## 531       83.01767      81.02307  1.99460259    Connecticut 2009 Female
    ## 532       78.44503      75.06888  3.37615011    Connecticut 2009   Male
    ## 533       83.17750      81.10921  2.06828664    Connecticut 2010 Female
    ## 534       78.51534      75.32887  3.18647225    Connecticut 2010   Male
    ## 535       83.07907      81.23767  1.84139458    Connecticut 2011 Female
    ## 536       78.45360      75.64022  2.81337697    Connecticut 2011   Male
    ## 537       83.18146      81.40807  1.77339063    Connecticut 2012 Female
    ## 538       78.51445      76.06916  2.44528875    Connecticut 2012   Male
    ## 539       83.20599      81.47938  1.72661038    Connecticut 2013 Female
    ## 540       78.52162      76.14938  2.37224270    Connecticut 2013   Male
    ## 541       75.79413      68.33574  7.45839363       Delaware 1969 Female
    ## 542       67.94021      60.37713  7.56307442       Delaware 1969   Male
    ## 543       75.88782      68.71775  7.17006850       Delaware 1970 Female
    ## 544       68.14231      60.62613  7.51618585       Delaware 1970   Male
    ## 545       76.00052      69.05817  6.94234315       Delaware 1971 Female
    ## 546       68.42865      60.97227  7.45637927       Delaware 1971   Male
    ## 547       76.27012      69.38668  6.88343445       Delaware 1972 Female
    ## 548       68.59101      61.26180  7.32921019       Delaware 1972   Male
    ## 549       76.54564      69.81140  6.73423654       Delaware 1973 Female
    ## 550       68.81631      61.75797  7.05834213       Delaware 1973   Male
    ## 551       76.76110      70.28841  6.47269161       Delaware 1974 Female
    ## 552       69.18242      62.21969  6.96273242       Delaware 1974   Male
    ## 553       77.12886      70.76935  6.35951228       Delaware 1975 Female
    ## 554       69.50355      62.72605  6.77749447       Delaware 1975   Male
    ## 555       77.31114      71.13245  6.17869652       Delaware 1976 Female
    ## 556       69.81272      63.18840  6.62431871       Delaware 1976   Male
    ## 557       77.55898      71.39967  6.15931066       Delaware 1977 Female
    ## 558       70.14772      63.47821  6.66950752       Delaware 1977   Male
    ## 559       77.74616      71.74372  6.00244130       Delaware 1978 Female
    ## 560       70.38784      63.69762  6.69022086       Delaware 1978   Male
    ## 561       77.87782      71.95861  5.91920966       Delaware 1979 Female
    ## 562       70.55373      63.91780  6.63593303       Delaware 1979   Male
    ## 563       77.90181      72.16679  5.73502150       Delaware 1980 Female
    ## 564       70.78769      64.18986  6.59782908       Delaware 1980   Male
    ## 565       77.98897      72.45174  5.53723633       Delaware 1981 Female
    ## 566       71.01196      64.49699  6.51497692       Delaware 1981   Male
    ## 567       78.21122      72.55802  5.65320175       Delaware 1982 Female
    ## 568       71.23983      64.77461  6.46522879       Delaware 1982   Male
    ## 569       78.33422      72.67178  5.66244300       Delaware 1983 Female
    ## 570       71.55251      65.06116  6.49135134       Delaware 1983   Male
    ## 571       78.40238      72.69653  5.70584401       Delaware 1984 Female
    ## 572       71.70166      65.24409  6.45756539       Delaware 1984   Male
    ## 573       78.21468      72.91024  5.30443652       Delaware 1985 Female
    ## 574       71.75824      65.40626  6.35198496       Delaware 1985   Male
    ## 575       78.29063      73.03133  5.25930058       Delaware 1986 Female
    ## 576       71.82633      65.58675  6.23957902       Delaware 1986   Male
    ## 577       78.32696      73.10271  5.22425243       Delaware 1987 Female
    ## 578       72.04459      65.83258  6.21200204       Delaware 1987   Male
    ## 579       78.34425      73.28310  5.06115309       Delaware 1988 Female
    ## 580       72.29945      65.91413  6.38532024       Delaware 1988   Male
    ## 581       78.51900      73.47397  5.04502902       Delaware 1989 Female
    ## 582       72.58595      66.01759  6.56836047       Delaware 1989   Male
    ## 583       78.69025      73.71678  4.97346843       Delaware 1990 Female
    ## 584       72.86682      66.18318  6.68364056       Delaware 1990   Male
    ## 585       78.80420      74.02751  4.77669511       Delaware 1991 Female
    ## 586       73.06980      66.37393  6.69587028       Delaware 1991   Male
    ## 587       79.00122      74.44106  4.56016323       Delaware 1992 Female
    ## 588       73.30807      66.47026  6.83780875       Delaware 1992   Male
    ## 589       79.16975      74.71635  4.45340559       Delaware 1993 Female
    ## 590       73.39694      66.38098  7.01595715       Delaware 1993   Male
    ## 591       79.29911      74.99678  4.30232835       Delaware 1994 Female
    ## 592       73.47920      66.28766  7.19153688       Delaware 1994   Male
    ## 593       79.40195      75.07654  4.32540809       Delaware 1995 Female
    ## 594       73.77600      66.49552  7.28048706       Delaware 1995   Male
    ## 595       79.50683      75.29328  4.21355035       Delaware 1996 Female
    ## 596       73.99304      67.15315  6.83988947       Delaware 1996   Male
    ## 597       79.59753      75.53162  4.06590548       Delaware 1997 Female
    ## 598       74.16853      68.04623  6.12230004       Delaware 1997   Male
    ## 599       79.73451      75.71679  4.01772318       Delaware 1998 Female
    ## 600       74.39281      68.44366  5.94914270       Delaware 1998   Male
    ## 601       79.73816      75.94230  3.79585954       Delaware 1999 Female
    ## 602       74.59685      68.79403  5.80281570       Delaware 1999   Male
    ## 603       79.69315      75.96048  3.73267315       Delaware 2000 Female
    ## 604       74.67505      69.21702  5.45803480       Delaware 2000   Male
    ## 605       79.77394      76.12965  3.64428774       Delaware 2001 Female
    ## 606       74.84301      69.57820  5.26480628       Delaware 2001   Male
    ## 607       79.92769      76.46916  3.45853008       Delaware 2002 Female
    ## 608       75.10095      69.84632  5.25463129       Delaware 2002   Male
    ## 609       80.08196      76.51990  3.56205957       Delaware 2003 Female
    ## 610       75.19744      69.99155  5.20588256       Delaware 2003   Male
    ## 611       80.38521      76.64445  3.74075890       Delaware 2004 Female
    ## 612       75.26454      70.34460  4.91993885       Delaware 2004   Male
    ## 613       80.41843      76.86836  3.55007021       Delaware 2005 Female
    ## 614       75.39727      70.71887  4.67840353       Delaware 2005   Male
    ## 615       80.63190      77.48583  3.14607288       Delaware 2006 Female
    ## 616       75.69860      71.23193  4.46666456       Delaware 2006   Male
    ## 617       80.76632      77.88918  2.87713349       Delaware 2007 Female
    ## 618       75.85857      71.73170  4.12686641       Delaware 2007   Male
    ## 619       80.84667      78.22420  2.62247077       Delaware 2008 Female
    ## 620       75.98434      72.07705  3.90728857       Delaware 2008   Male
    ## 621       80.89471      78.37754  2.51716443       Delaware 2009 Female
    ## 622       76.15479      72.34986  3.80493476       Delaware 2009   Male
    ## 623       80.95636      78.70043  2.25592721       Delaware 2010 Female
    ## 624       76.25548      72.57254  3.68293844       Delaware 2010   Male
    ## 625       81.00576      78.85999  2.14576445       Delaware 2011 Female
    ## 626       76.38038      72.86230  3.51808126       Delaware 2011   Male
    ## 627       81.16874      78.67187  2.49687310       Delaware 2012 Female
    ## 628       76.56191      73.01377  3.54814113       Delaware 2012   Male
    ## 629       81.29083      78.90761  2.38321972       Delaware 2013 Female
    ## 630       76.59031      73.14436  3.44594853       Delaware 2013   Male
    ## 631       76.58049      67.50260  9.07788912        Florida 1969 Female
    ## 632       68.08487      58.53977  9.54510203        Florida 1969   Male
    ## 633       76.93795      68.00815  8.92979997        Florida 1970 Female
    ## 634       68.48784      58.71770  9.77013790        Florida 1970   Male
    ## 635       77.29357      68.55162  8.74195284        Florida 1971 Female
    ## 636       68.88467      59.12151  9.76316622        Florida 1971   Male
    ## 637       77.27081      68.81955  8.45125721        Florida 1972 Female
    ## 638       68.99880      59.60607  9.39272375        Florida 1972   Male
    ## 639       77.34809      69.35652  7.99156507        Florida 1973 Female
    ## 640       69.14764      60.03745  9.11018888        Florida 1973   Male
    ## 641       77.98317      70.40791  7.57526859        Florida 1974 Female
    ## 642       69.80068      60.81779  8.98288436        Florida 1974   Male
    ## 643       78.70266      71.26871  7.43394643        Florida 1975 Female
    ## 644       70.48258      61.61112  8.87145610        Florida 1975   Male
    ## 645       78.98323      71.84043  7.14279266        Florida 1976 Female
    ## 646       70.86416      62.26399  8.60016889        Florida 1976   Male
    ## 647       79.17161      72.12637  7.04524023        Florida 1977 Female
    ## 648       71.22651      62.57355  8.65295789        Florida 1977   Male
    ## 649       79.26985      72.68869  6.58115489        Florida 1978 Female
    ## 650       71.37216      62.99482  8.37734501        Florida 1978   Male
    ## 651       79.45161      72.65797  6.79363851        Florida 1979 Female
    ## 652       71.46876      63.10553  8.36323654        Florida 1979   Male
    ## 653       79.39485      72.69767  6.69718313        Florida 1980 Female
    ## 654       71.34822      63.19181  8.15641182        Florida 1980   Male
    ## 655       79.40866      72.79736  6.61129983        Florida 1981 Female
    ## 656       71.52878      63.57664  7.95214613        Florida 1981   Male
    ## 657       79.75754      73.45118  6.30635862        Florida 1982 Female
    ## 658       72.00144      64.09404  7.90739920        Florida 1982   Male
    ## 659       79.85074      73.44696  6.40378244        Florida 1983 Female
    ## 660       72.17939      64.33052  7.84887012        Florida 1983   Male
    ## 661       80.05746      73.37354  6.68392525        Florida 1984 Female
    ## 662       72.41621      64.49743  7.91877984        Florida 1984   Male
    ## 663       80.01413      73.20152  6.81260930        Florida 1985 Female
    ## 664       72.44018      64.55924  7.88093678        Florida 1985   Male
    ## 665       80.14717      73.19181  6.95536258        Florida 1986 Female
    ## 666       72.72158      64.30497  8.41660308        Florida 1986   Male
    ## 667       80.27094      73.12543  7.14550929        Florida 1987 Female
    ## 668       72.81509      63.86794  8.94715145        Florida 1987   Male
    ## 669       80.33508      73.15016  7.18492170        Florida 1988 Female
    ## 670       72.85365      63.73469  9.11895604        Florida 1988   Male
    ## 671       80.62509      73.24983  7.37526441        Florida 1989 Female
    ## 672       73.10999      63.85535  9.25463526        Florida 1989   Male
    ## 673       80.90747      73.69824  7.20922748        Florida 1990 Female
    ## 674       73.38889      64.32186  9.06703010        Florida 1990   Male
    ## 675       81.12207      74.15759  6.96447798        Florida 1991 Female
    ## 676       73.62107      64.99636  8.62470928        Florida 1991   Male
    ## 677       81.05162      74.21440  6.83721764        Florida 1992 Female
    ## 678       73.80711      65.29695  8.51016346        Florida 1992   Male
    ## 679       80.92763      74.06076  6.86687235        Florida 1993 Female
    ## 680       73.73430      65.36806  8.36624147        Florida 1993   Male
    ## 681       81.03872      74.19352  6.84520536        Florida 1994 Female
    ## 682       73.84612      65.45573  8.39038676        Florida 1994   Male
    ## 683       81.07594      74.07547  7.00046979        Florida 1995 Female
    ## 684       74.01210      65.72074  8.29136465        Florida 1995   Male
    ## 685       81.24366      74.57602  6.66763717        Florida 1996 Female
    ## 686       74.57117      66.86152  7.70964947        Florida 1996   Male
    ## 687       81.29238      75.05521  6.23717624        Florida 1997 Female
    ## 688       75.08489      67.96233  7.12256053        Florida 1997   Male
    ## 689       81.22080      75.26802  5.95277941        Florida 1998 Female
    ## 690       75.27491      68.56584  6.70906937        Florida 1998   Male
    ## 691       81.06625      75.34577  5.72048056        Florida 1999 Female
    ## 692       75.33935      68.87127  6.46808769        Florida 1999   Male
    ## 693       81.19225      75.59039  5.60185717        Florida 2000 Female
    ## 694       75.33725      69.35436  5.98289192        Florida 2000   Male
    ## 695       81.14228      75.57688  5.56539363        Florida 2001 Female
    ## 696       75.34156      69.75721  5.58434556        Florida 2001   Male
    ## 697       81.20689      75.94602  5.26086939        Florida 2002 Female
    ## 698       75.50737      70.05713  5.45024296        Florida 2002   Male
    ## 699       81.33592      76.37625  4.95967269        Florida 2003 Female
    ## 700       75.60596      70.49877  5.10719099        Florida 2003   Male
    ## 701       81.46619      76.94522  4.52096049        Florida 2004 Female
    ## 702       75.85131      70.87511  4.97620144        Florida 2004   Male
    ## 703       81.69162      77.29607  4.39554644        Florida 2005 Female
    ## 704       75.91884      71.28445  4.63438713        Florida 2005   Male
    ## 705       81.93685      77.66833  4.26851756        Florida 2006 Female
    ## 706       76.11398      71.75135  4.36262763        Florida 2006   Male
    ## 707       82.24115      78.34766  3.89349576        Florida 2007 Female
    ## 708       76.45008      72.25211  4.19797080        Florida 2007   Male
    ## 709       82.32866      78.92531  3.40334905        Florida 2008 Female
    ## 710       76.60881      72.78499  3.82382142        Florida 2008   Male
    ## 711       82.66145      79.32476  3.33668545        Florida 2009 Female
    ## 712       76.94303      73.39002  3.55300729        Florida 2009   Male
    ## 713       82.66505      79.67094  2.99411022        Florida 2010 Female
    ## 714       77.11811      74.03607  3.08203708        Florida 2010   Male
    ## 715       82.98443      80.45005  2.53437423        Florida 2011 Female
    ## 716       77.47140      74.60381  2.86758917        Florida 2011   Male
    ## 717       83.02688      80.63376  2.39311978        Florida 2012 Female
    ## 718       77.77323      74.84163  2.93160325        Florida 2012   Male
    ## 719       83.09470      80.75242  2.34228281        Florida 2013 Female
    ## 720       77.93839      74.96368  2.97470858        Florida 2013   Male
    ## 721       75.68576      67.72852  7.95723720        Georgia 1969 Female
    ## 722       66.09154      58.38124  7.71030282        Georgia 1969   Male
    ## 723       75.72122      68.26981  7.45140873        Georgia 1970 Female
    ## 724       66.24938      58.74539  7.50399523        Georgia 1970   Male
    ## 725       75.82031      68.85494  6.96537126        Georgia 1971 Female
    ## 726       66.60612      59.46781  7.13830627        Georgia 1971   Male
    ## 727       76.06182      69.15043  6.91139438        Georgia 1972 Female
    ## 728       66.66907      59.69092  6.97815246        Georgia 1972   Male
    ## 729       76.26848      69.51539  6.75308685        Georgia 1973 Female
    ## 730       66.86558      60.23527  6.63030799        Georgia 1973   Male
    ## 731       76.66319      70.24536  6.41782847        Georgia 1974 Female
    ## 732       67.39073      60.97260  6.41813548        Georgia 1974   Male
    ## 733       77.22338      71.21167  6.01170583        Georgia 1975 Female
    ## 734       67.99476      61.83875  6.15601558        Georgia 1975   Male
    ## 735       77.54867      71.62109  5.92758682        Georgia 1976 Female
    ## 736       68.41011      62.20961  6.20050320        Georgia 1976   Male
    ## 737       77.73128      71.80121  5.93006259        Georgia 1977 Female
    ## 738       68.72914      62.54532  6.18381177        Georgia 1977   Male
    ## 739       77.90013      72.23540  5.66473337        Georgia 1978 Female
    ## 740       68.99940      62.80490  6.19450262        Georgia 1978   Male
    ## 741       78.10059      72.52524  5.57534555        Georgia 1979 Female
    ## 742       69.36445      63.15158  6.21286439        Georgia 1979   Male
    ## 743       78.27290      72.53809  5.73480921        Georgia 1980 Female
    ## 744       69.68870      63.46636  6.22233770        Georgia 1980   Male
    ## 745       78.35986      72.86873  5.49112592        Georgia 1981 Female
    ## 746       69.96679      63.85831  6.10847594        Georgia 1981   Male
    ## 747       78.57448      73.48440  5.09008033        Georgia 1982 Female
    ## 748       70.27190      64.44035  5.83154613        Georgia 1982   Male
    ## 749       78.37255      73.51884  4.85370929        Georgia 1983 Female
    ## 750       70.40216      64.61554  5.78662004        Georgia 1983   Male
    ## 751       78.43429      73.42247  5.01181670        Georgia 1984 Female
    ## 752       70.56522      64.74361  5.82161179        Georgia 1984   Male
    ## 753       78.37598      73.37822  4.99775742        Georgia 1985 Female
    ## 754       70.59255      64.63057  5.96198377        Georgia 1985   Male
    ## 755       78.40753      73.37858  5.02895061        Georgia 1986 Female
    ## 756       70.72944      64.61538  6.11405565        Georgia 1986   Male
    ## 757       78.51218      73.41182  5.10035599        Georgia 1987 Female
    ## 758       70.83202      64.53260  6.29941874        Georgia 1987   Male
    ## 759       78.61465      73.28698  5.32767164        Georgia 1988 Female
    ## 760       71.03594      64.26143  6.77450258        Georgia 1988   Male
    ## 761       78.77148      73.47402  5.29745862        Georgia 1989 Female
    ## 762       71.26326      64.16452  7.09874272        Georgia 1989   Male
    ## 763       79.06398      73.79832  5.26565507        Georgia 1990 Female
    ## 764       71.53989      64.34126  7.19863228        Georgia 1990   Male
    ## 765       79.30468      74.04288  5.26180217        Georgia 1991 Female
    ## 766       71.86371      64.34513  7.51858722        Georgia 1991   Male
    ## 767       79.42110      74.21928  5.20182554        Georgia 1992 Female
    ## 768       72.22832      64.68013  7.54819704        Georgia 1992   Male
    ## 769       79.26196      74.23530  5.02665908        Georgia 1993 Female
    ## 770       72.28343      64.75215  7.53128155        Georgia 1993   Male
    ## 771       79.34390      74.53887  4.80502552        Georgia 1994 Female
    ## 772       72.45041      65.01396  7.43645086        Georgia 1994   Male
    ## 773       79.24866      74.44451  4.80415667        Georgia 1995 Female
    ## 774       72.76028      65.37733  7.38295131        Georgia 1995   Male
    ## 775       79.29343      74.68502  4.60841358        Georgia 1996 Female
    ## 776       73.01539      66.01953  6.99585454        Georgia 1996   Male
    ## 777       79.30569      74.94361  4.36208328        Georgia 1997 Female
    ## 778       73.36587      66.77775  6.58812116        Georgia 1997   Male
    ## 779       79.36531      75.03209  4.33322361        Georgia 1998 Female
    ## 780       73.49651      67.35952  6.13698912        Georgia 1998   Male
    ## 781       79.22882      75.17053  4.05828785        Georgia 1999 Female
    ## 782       73.62468      67.64640  5.97827862        Georgia 1999   Male
    ## 783       79.08083      75.18578  3.89505291        Georgia 2000 Female
    ## 784       73.67798      67.95035  5.72763137        Georgia 2000   Male
    ## 785       79.06729      75.28413  3.78315235        Georgia 2001 Female
    ## 786       73.79080      68.28853  5.50226529        Georgia 2001   Male
    ## 787       79.11796      75.30210  3.81585296        Georgia 2002 Female
    ## 788       73.88677      68.56282  5.32395106        Georgia 2002   Male
    ## 789       79.15332      75.51683  3.63648778        Georgia 2003 Female
    ## 790       74.03988      68.92025  5.11962485        Georgia 2003   Male
    ## 791       79.41179      75.89901  3.51277555        Georgia 2004 Female
    ## 792       74.29450      69.27389  5.02060572        Georgia 2004   Male
    ## 793       79.61063      76.20203  3.40860600        Georgia 2005 Female
    ## 794       74.48852      69.71713  4.77138814        Georgia 2005   Male
    ## 795       79.85180      76.65130  3.20049914        Georgia 2006 Female
    ## 796       74.73515      70.00256  4.73259363        Georgia 2006   Male
    ## 797       80.00643      77.00366  3.00276819        Georgia 2007 Female
    ## 798       75.00539      70.40389  4.60149171        Georgia 2007   Male
    ## 799       80.03349      77.29850  2.73498768        Georgia 2008 Female
    ## 800       75.26780      70.93931  4.32849271        Georgia 2008   Male
    ## 801       80.24465      77.73204  2.51261098        Georgia 2009 Female
    ## 802       75.47460      71.55784  3.91675799        Georgia 2009   Male
    ## 803       80.22350      78.10497  2.11853865        Georgia 2010 Female
    ## 804       75.60575      72.11809  3.48765731        Georgia 2010   Male
    ## 805       80.31316      78.45665  1.85650956        Georgia 2011 Female
    ## 806       75.82665      72.59952  3.22713517        Georgia 2011   Male
    ## 807       80.36418      78.74154  1.62264674        Georgia 2012 Female
    ## 808       75.91240      72.79381  3.11858741        Georgia 2012   Male
    ## 809       80.48709      78.77349  1.71360153        Georgia 2013 Female
    ## 810       75.85608      72.81148  3.04459412        Georgia 2013   Male
    ## 811       74.84184      67.22357  7.61826865       Illinois 1969 Female
    ## 812       67.53939      58.12616  9.41322980       Illinois 1969   Male
    ## 813       75.15819      67.39071  7.76748147       Illinois 1970 Female
    ## 814       67.70012      58.25184  9.44828610       Illinois 1970   Male
    ## 815       75.38447      67.98764  7.39683795       Illinois 1971 Female
    ## 816       68.04816      58.92245  9.12571167       Illinois 1971   Male
    ## 817       75.50946      68.34600  7.16346030       Illinois 1972 Female
    ## 818       68.12502      59.34942  8.77559527       Illinois 1972   Male
    ## 819       75.85476      68.85386  7.00090083       Illinois 1973 Female
    ## 820       68.30874      59.59451  8.71423078       Illinois 1973   Male
    ## 821       76.34447      69.40848  6.93598641       Illinois 1974 Female
    ## 822       68.62321      59.99424  8.62896469       Illinois 1974   Male
    ## 823       77.04468      70.25725  6.78743072       Illinois 1975 Female
    ## 824       69.15379      60.44431  8.70948517       Illinois 1975   Male
    ## 825       77.17428      70.81762  6.35665677       Illinois 1976 Female
    ## 826       69.48256      61.13304  8.34951852       Illinois 1976   Male
    ## 827       77.41530      71.30784  6.10745879       Illinois 1977 Female
    ## 828       69.78131      61.81279  7.96852447       Illinois 1977   Male
    ## 829       77.60432      71.74931  5.85501486       Illinois 1978 Female
    ## 830       70.07730      62.28600  7.79130163       Illinois 1978   Male
    ## 831       77.93467      71.95773  5.97694063       Illinois 1979 Female
    ## 832       70.29172      62.41690  7.87482024       Illinois 1979   Male
    ## 833       78.03317      72.01012  6.02305464       Illinois 1980 Female
    ## 834       70.62167      62.75635  7.86531716       Illinois 1980   Male
    ## 835       78.31693      72.34302  5.97391493       Illinois 1981 Female
    ## 836       70.97022      63.23650  7.73371241       Illinois 1981   Male
    ## 837       78.49919      72.54244  5.95675563       Illinois 1982 Female
    ## 838       71.38059      63.41076  7.96983438       Illinois 1982   Male
    ## 839       78.54095      72.61110  5.92985137       Illinois 1983 Female
    ## 840       71.57707      63.55512  8.02194973       Illinois 1983   Male
    ## 841       78.70396      72.90967  5.79428849       Illinois 1984 Female
    ## 842       71.88632      63.83182  8.05450064       Illinois 1984   Male
    ## 843       78.72678      72.70449  6.02229294       Illinois 1985 Female
    ## 844       72.00941      63.71702  8.29238052       Illinois 1985   Male
    ## 845       78.83547      72.53334  6.30212888       Illinois 1986 Female
    ## 846       72.08146      63.43385  8.64760780       Illinois 1986   Male
    ## 847       78.95325      72.50132  6.45192941       Illinois 1987 Female
    ## 848       72.33820      63.23538  9.10282106       Illinois 1987   Male
    ## 849       78.93882      72.24133  6.69748551       Illinois 1988 Female
    ## 850       72.37169      62.74581  9.62588203       Illinois 1988   Male
    ## 851       79.23522      72.40740  6.82781761       Illinois 1989 Female
    ## 852       72.64454      62.58978 10.05476459       Illinois 1989   Male
    ## 853       79.47308      72.54085  6.93223234       Illinois 1990 Female
    ## 854       72.93349      62.42473 10.50875670       Illinois 1990   Male
    ## 855       79.56199      72.78562  6.77637756       Illinois 1991 Female
    ## 856       73.09582      62.44448 10.65134487       Illinois 1991   Male
    ## 857       79.86259      73.08059  6.78199408       Illinois 1992 Female
    ## 858       73.40585      62.61096 10.79488569       Illinois 1992   Male
    ## 859       79.69355      72.97447  6.71908636       Illinois 1993 Female
    ## 860       73.31420      62.61329 10.70091530       Illinois 1993   Male
    ## 861       79.72058      73.10498  6.61559565       Illinois 1994 Female
    ## 862       73.42485      62.87999 10.54486206       Illinois 1994   Male
    ## 863       79.75788      73.07409  6.68378763       Illinois 1995 Female
    ## 864       73.65477      63.38777 10.26699621       Illinois 1995   Male
    ## 865       79.95640      73.51234  6.44405754       Illinois 1996 Female
    ## 866       74.18561      64.06571 10.11989070       Illinois 1996   Male
    ## 867       80.27523      73.98125  6.29397958       Illinois 1997 Female
    ## 868       74.61532      64.96013  9.65518450       Illinois 1997   Male
    ## 869       80.25022      74.14437  6.10585176       Illinois 1998 Female
    ## 870       74.76221      65.35430  9.40791146       Illinois 1998   Male
    ## 871       80.09632      74.02104  6.07527183       Illinois 1999 Female
    ## 872       74.75505      65.66245  9.09259695       Illinois 1999   Male
    ## 873       80.22551      74.25570  5.96980084       Illinois 2000 Female
    ## 874       75.01028      66.43371  8.57656891       Illinois 2000   Male
    ## 875       80.43325      74.40298  6.03027154       Illinois 2001 Female
    ## 876       75.31181      66.86514  8.44667572       Illinois 2001   Male
    ## 877       80.49935      74.56988  5.92947051       Illinois 2002 Female
    ## 878       75.37034      67.11744  8.25290275       Illinois 2002   Male
    ## 879       80.64923      74.82166  5.82757336       Illinois 2003 Female
    ## 880       75.69766      67.42680  8.27085602       Illinois 2003   Male
    ## 881       80.93471      75.16688  5.76782657       Illinois 2004 Female
    ## 882       76.03521      68.06827  7.96694938       Illinois 2004   Male
    ## 883       80.96309      75.57985  5.38323973       Illinois 2005 Female
    ## 884       76.21059      68.19874  8.01185642       Illinois 2005   Male
    ## 885       81.19920      76.18887  5.01032707       Illinois 2006 Female
    ## 886       76.47375      68.54007  7.93368592       Illinois 2006   Male
    ## 887       81.47705      76.53711  4.93993934       Illinois 2007 Female
    ## 888       76.84176      68.94633  7.89542582       Illinois 2007   Male
    ## 889       81.39560      76.84220  4.55339716       Illinois 2008 Female
    ## 890       76.81094      69.48374  7.32719158       Illinois 2008   Male
    ## 891       81.81601      77.39735  4.41866166       Illinois 2009 Female
    ## 892       77.17717      69.89039  7.28678452       Illinois 2009   Male
    ## 893       82.00547      77.67936  4.32610810       Illinois 2010 Female
    ## 894       77.35462      70.33636  7.01825823       Illinois 2010   Male
    ## 895       81.97862      77.87699  4.10163308       Illinois 2011 Female
    ## 896       77.39441      70.51836  6.87605371       Illinois 2011   Male
    ## 897       82.13415      77.95870  4.17545839       Illinois 2012 Female
    ## 898       77.47753      70.70034  6.77718593       Illinois 2012   Male
    ## 899       82.19068      77.93243  4.25824948       Illinois 2013 Female
    ## 900       77.57719      70.92115  6.65603928       Illinois 2013   Male
    ## 901       75.15817      69.27180  5.88636465        Indiana 1969 Female
    ## 902       67.54994      61.56779  5.98215105        Indiana 1969   Male
    ## 903       75.38703      69.33114  6.05589154        Indiana 1970 Female
    ## 904       67.81793      61.95679  5.86113658        Indiana 1970   Male
    ## 905       75.62443      69.56078  6.06364815        Indiana 1971 Female
    ## 906       68.00966      62.15306  5.85659319        Indiana 1971   Male
    ## 907       75.71855      69.98154  5.73701752        Indiana 1972 Female
    ## 908       68.18095      62.33950  5.84144622        Indiana 1972   Male
    ## 909       75.94945      70.32112  5.62832927        Indiana 1973 Female
    ## 910       68.36138      62.46970  5.89167320        Indiana 1973   Male
    ## 911       76.43502      70.75576  5.67925427        Indiana 1974 Female
    ## 912       68.85149      62.69044  6.16104363        Indiana 1974   Male
    ## 913       77.02017      71.16792  5.85224757        Indiana 1975 Female
    ## 914       69.29489      63.19959  6.09529617        Indiana 1975   Male
    ## 915       77.15854      71.66535  5.49319328        Indiana 1976 Female
    ## 916       69.52536      63.62839  5.89696515        Indiana 1976   Male
    ## 917       77.39655      72.15522  5.24133033        Indiana 1977 Female
    ## 918       69.67750      63.88168  5.79582550        Indiana 1977   Male
    ## 919       77.59927      72.52793  5.07134421        Indiana 1978 Female
    ## 920       69.93843      64.16363  5.77480423        Indiana 1978   Male
    ## 921       77.79958      72.71651  5.08306730        Indiana 1979 Female
    ## 922       70.27736      64.37542  5.90194252        Indiana 1979   Male
    ## 923       77.93870      72.85835  5.08034996        Indiana 1980 Female
    ## 924       70.67149      64.61369  6.05779889        Indiana 1980   Male
    ## 925       78.12008      73.30267  4.81740776        Indiana 1981 Female
    ## 926       70.90947      64.93289  5.97657930        Indiana 1981   Male
    ## 927       78.29971      73.57401  4.72569996        Indiana 1982 Female
    ## 928       71.21242      65.04776  6.16465955        Indiana 1982   Male
    ## 929       78.35419      73.69498  4.65920229        Indiana 1983 Female
    ## 930       71.33640      65.27841  6.05798458        Indiana 1983   Male
    ## 931       78.55374      73.70183  4.85191450        Indiana 1984 Female
    ## 932       71.47701      65.39374  6.08327260        Indiana 1984   Male
    ## 933       78.63598      73.62217  5.01380901        Indiana 1985 Female
    ## 934       71.54555      65.47273  6.07282418        Indiana 1985   Male
    ## 935       78.63601      73.64259  4.99342449        Indiana 1986 Female
    ## 936       71.58753      65.47526  6.11226743        Indiana 1986   Male
    ## 937       78.76138      73.74248  5.01889893        Indiana 1987 Female
    ## 938       71.83868      65.54154  6.29714128        Indiana 1987   Male
    ## 939       78.78174      73.67182  5.10991321        Indiana 1988 Female
    ## 940       72.00320      65.61917  6.38402562        Indiana 1988   Male
    ## 941       78.95958      73.64396  5.31562361        Indiana 1989 Female
    ## 942       72.32225      65.73768  6.58456905        Indiana 1989   Male
    ## 943       79.11496      73.79628  5.31868160        Indiana 1990 Female
    ## 944       72.46198      65.82077  6.64120227        Indiana 1990   Male
    ## 945       79.19895      73.81545  5.38349667        Indiana 1991 Female
    ## 946       72.75299      65.74839  7.00459747        Indiana 1991   Male
    ## 947       79.34937      73.89828  5.45108789        Indiana 1992 Female
    ## 948       72.87627      65.73600  7.14027007        Indiana 1992   Male
    ## 949       79.14937      73.92030  5.22907398        Indiana 1993 Female
    ## 950       72.86651      65.78037  7.08613511        Indiana 1993   Male
    ## 951       79.11222      74.02603  5.08619258        Indiana 1994 Female
    ## 952       73.04149      65.78716  7.25433545        Indiana 1994   Male
    ## 953       79.16145      74.07702  5.08443305        Indiana 1995 Female
    ## 954       73.21305      65.99588  7.21717377        Indiana 1995   Male
    ## 955       79.24492      74.20850  5.03641994        Indiana 1996 Female
    ## 956       73.46437      66.31183  7.15254056        Indiana 1996   Male
    ## 957       79.25610      74.52163  4.73447089        Indiana 1997 Female
    ## 958       73.65661      66.57033  7.08628040        Indiana 1997   Male
    ## 959       79.31792      74.49614  4.82177667        Indiana 1998 Female
    ## 960       73.80899      66.83043  6.97856368        Indiana 1998   Male
    ## 961       79.07810      74.61134  4.46675944        Indiana 1999 Female
    ## 962       73.89101      67.17551  6.71550135        Indiana 1999   Male
    ## 963       79.13184      74.78741  4.34442929        Indiana 2000 Female
    ## 964       73.94926      67.51950  6.42975295        Indiana 2000   Male
    ## 965       79.25918      75.02981  4.22937099        Indiana 2001 Female
    ## 966       74.12137      67.66124  6.46012880        Indiana 2001   Male
    ## 967       79.31828      75.17076  4.14751645        Indiana 2002 Female
    ## 968       74.28232      67.95433  6.32798379        Indiana 2002   Male
    ## 969       79.43960      75.34011  4.09948650        Indiana 2003 Female
    ## 970       74.39364      68.13160  6.26203717        Indiana 2003   Male
    ## 971       79.63400      75.65463  3.97937435        Indiana 2004 Female
    ## 972       74.67326      68.48805  6.18521051        Indiana 2004   Male
    ## 973       79.67609      75.87228  3.80380979        Indiana 2005 Female
    ## 974       74.71808      68.77882  5.93925891        Indiana 2005   Male
    ## 975       79.89308      76.15630  3.73677314        Indiana 2006 Female
    ## 976       74.86349      69.09171  5.77178263        Indiana 2006   Male
    ## 977       80.15661      76.46103  3.69557802        Indiana 2007 Female
    ## 978       75.17792      69.58192  5.59599647        Indiana 2007   Male
    ## 979       80.06426      76.63206  3.43220427        Indiana 2008 Female
    ## 980       75.15585      69.93243  5.22342574        Indiana 2008   Male
    ## 981       80.22337      76.89502  3.32834956        Indiana 2009 Female
    ## 982       75.30056      70.23466  5.06589842        Indiana 2009   Male
    ## 983       80.24229      77.11291  3.12938273        Indiana 2010 Female
    ## 984       75.30488      70.42423  4.88065168        Indiana 2010   Male
    ## 985       80.16170      77.16699  2.99470579        Indiana 2011 Female
    ## 986       75.26143      70.53904  4.72239138        Indiana 2011   Male
    ## 987       80.10141      77.25090  2.85051093        Indiana 2012 Female
    ## 988       75.24867      70.50333  4.74533396        Indiana 2012   Male
    ## 989       80.06808      77.13796  2.93012145        Indiana 2013 Female
    ## 990       75.19556      70.40369  4.79187205        Indiana 2013   Male
    ## 991       76.85421      70.70028  6.15393118           Iowa 1969 Female
    ## 992       69.05055      61.86835  7.18220076           Iowa 1969   Male
    ## 993       76.98188      70.78447  6.19741448           Iowa 1970 Female
    ## 994       69.20843      62.24192  6.96651380           Iowa 1970   Male
    ## 995       77.19168      71.02125  6.17043507           Iowa 1971 Female
    ## 996       69.29905      62.60654  6.69250697           Iowa 1971   Male
    ## 997       77.25098      71.27116  5.97982009           Iowa 1972 Female
    ## 998       69.41252      63.04805  6.36447245           Iowa 1972   Male
    ## 999       77.65426      71.54872  6.10553555           Iowa 1973 Female
    ## 1000      69.71558      63.42175  6.29383916           Iowa 1973   Male
    ## 1001      78.04776      71.78061  6.26714388           Iowa 1974 Female
    ## 1002      70.05918      63.77627  6.28291197           Iowa 1974   Male
    ## 1003      78.55980      72.06268  6.49712071           Iowa 1975 Female
    ## 1004      70.45779      64.07515  6.38264339           Iowa 1975   Male
    ## 1005      78.80751      72.32115  6.48636569           Iowa 1976 Female
    ## 1006      70.84897      64.37287  6.47610121           Iowa 1976   Male
    ## 1007      79.26914      72.65231  6.61683027           Iowa 1977 Female
    ## 1008      71.25841      64.73006  6.52835595           Iowa 1977   Male
    ## 1009      79.44922      72.89843  6.55078478           Iowa 1978 Female
    ## 1010      71.45790      65.07022  6.38767410           Iowa 1978   Male
    ## 1011      79.72882      73.12326  6.60556446           Iowa 1979 Female
    ## 1012      71.78872      65.39631  6.39240528           Iowa 1979   Male
    ## 1013      79.88583      73.28480  6.60102823           Iowa 1980 Female
    ## 1014      72.01252      65.65595  6.35656276           Iowa 1980   Male
    ## 1015      80.06253      73.44227  6.62025245           Iowa 1981 Female
    ## 1016      72.36667      66.00098  6.36569486           Iowa 1981   Male
    ## 1017      80.23730      73.67978  6.55751607           Iowa 1982 Female
    ## 1018      72.51945      66.27001  6.24943254           Iowa 1982   Male
    ## 1019      80.20711      73.86677  6.34034546           Iowa 1983 Female
    ## 1020      72.66016      66.59654  6.06361751           Iowa 1983   Male
    ## 1021      80.24416      73.99496  6.24920122           Iowa 1984 Female
    ## 1022      72.91475      66.93792  5.97682740           Iowa 1984   Male
    ## 1023      80.22702      74.12658  6.10044143           Iowa 1985 Female
    ## 1024      73.00991      67.19155  5.81836606           Iowa 1985   Male
    ## 1025      80.37516      74.20915  6.16600444           Iowa 1986 Female
    ## 1026      73.27330      67.41217  5.86112826           Iowa 1986   Male
    ## 1027      80.49792      74.36988  6.12803655           Iowa 1987 Female
    ## 1028      73.34113      67.61574  5.72538794           Iowa 1987   Male
    ## 1029      80.47698      74.55706  5.91991979           Iowa 1988 Female
    ## 1030      73.46549      67.68822  5.77727208           Iowa 1988   Male
    ## 1031      80.63595      74.64509  5.99086189           Iowa 1989 Female
    ## 1032      73.80294      67.76631  6.03663892           Iowa 1989   Male
    ## 1033      80.84607      74.61334  6.23273108           Iowa 1990 Female
    ## 1034      73.99520      67.83735  6.15784657           Iowa 1990   Male
    ## 1035      80.89995      74.62023  6.27972073           Iowa 1991 Female
    ## 1036      74.17245      67.86222  6.31022423           Iowa 1991   Male
    ## 1037      81.11960      74.72593  6.39367382           Iowa 1992 Female
    ## 1038      74.41502      68.01677  6.39824474           Iowa 1992   Male
    ## 1039      80.84966      74.75933  6.09032043           Iowa 1993 Female
    ## 1040      74.45362      68.07626  6.37736010           Iowa 1993   Male
    ## 1041      81.05148      74.69942  6.35206199           Iowa 1994 Female
    ## 1042      74.56964      68.21245  6.35719906           Iowa 1994   Male
    ## 1043      80.97833      74.77669  6.20164333           Iowa 1995 Female
    ## 1044      74.79331      68.44850  6.34480322           Iowa 1995   Male
    ## 1045      81.03180      74.93724  6.09456248           Iowa 1996 Female
    ## 1046      75.05610      68.80460  6.25149791           Iowa 1996   Male
    ## 1047      81.17018      75.11443  6.05574536           Iowa 1997 Female
    ## 1048      75.20601      69.22618  5.97982608           Iowa 1997   Male
    ## 1049      81.05715      75.31309  5.74405459           Iowa 1998 Female
    ## 1050      75.39115      69.56598  5.82516467           Iowa 1998   Male
    ## 1051      81.05624      75.52826  5.52797951           Iowa 1999 Female
    ## 1052      75.63370      69.90663  5.72707520           Iowa 1999   Male
    ## 1053      81.18641      75.72588  5.46052611           Iowa 2000 Female
    ## 1054      75.83461      70.19604  5.63856808           Iowa 2000   Male
    ## 1055      81.28731      75.90674  5.38057120           Iowa 2001 Female
    ## 1056      76.05944      70.47528  5.58416144           Iowa 2001   Male
    ## 1057      81.30545      76.08334  5.22210902           Iowa 2002 Female
    ## 1058      76.18426      70.84216  5.34210610           Iowa 2002   Male
    ## 1059      81.42361      76.29752  5.12608871           Iowa 2003 Female
    ## 1060      76.36987      71.18277  5.18710473           Iowa 2003   Male
    ## 1061      81.72437      76.49180  5.23256626           Iowa 2004 Female
    ## 1062      76.61548      71.49149  5.12398407           Iowa 2004   Male
    ## 1063      81.64999      76.79136  4.85862731           Iowa 2005 Female
    ## 1064      76.68193      71.79975  4.88217382           Iowa 2005   Male
    ## 1065      81.74611      76.98641  4.75970247           Iowa 2006 Female
    ## 1066      76.93235      72.04010  4.89224770           Iowa 2006   Male
    ## 1067      81.88488      77.12782  4.75705814           Iowa 2007 Female
    ## 1068      77.04838      72.26816  4.78022622           Iowa 2007   Male
    ## 1069      81.70773      77.20919  4.49854788           Iowa 2008 Female
    ## 1070      77.00993      72.44278  4.56715505           Iowa 2008   Male
    ## 1071      81.95548      77.29933  4.65614235           Iowa 2009 Female
    ## 1072      77.19607      72.57533  4.62074095           Iowa 2009   Male
    ## 1073      82.04445      77.24953  4.79491337           Iowa 2010 Female
    ## 1074      77.27083      72.65535  4.61547265           Iowa 2010   Male
    ## 1075      82.00817      77.16763  4.84053664           Iowa 2011 Female
    ## 1076      77.33071      72.72361  4.60709878           Iowa 2011   Male
    ## 1077      82.03839      77.03349  5.00489156           Iowa 2012 Female
    ## 1078      77.33964      72.70426  4.63537966           Iowa 2012   Male
    ## 1079      82.06347      76.94141  5.12205614           Iowa 2013 Female
    ## 1080      77.28503      72.72021  4.56482656           Iowa 2013   Male
    ## 1081      76.90280      70.49984  6.40295941         Kansas 1969 Female
    ## 1082      69.15339      63.20739  5.94599653         Kansas 1969   Male
    ## 1083      77.22673      70.69221  6.53451734         Kansas 1970 Female
    ## 1084      69.39660      63.46461  5.93198180         Kansas 1970   Male
    ## 1085      77.32224      70.93168  6.39055982         Kansas 1971 Female
    ## 1086      69.54997      63.68760  5.86237041         Kansas 1971   Male
    ## 1087      77.51627      71.00507  6.51119957         Kansas 1972 Female
    ## 1088      69.68403      63.95279  5.73123425         Kansas 1972   Male
    ## 1089      77.65007      71.17373  6.47634379         Kansas 1973 Female
    ## 1090      69.84756      64.28544  5.56211501         Kansas 1973   Male
    ## 1091      78.02873      71.36617  6.66256174         Kansas 1974 Female
    ## 1092      70.13444      64.62190  5.51253689         Kansas 1974   Male
    ## 1093      78.34584      71.71705  6.62879463         Kansas 1975 Female
    ## 1094      70.58757      64.82797  5.75959429         Kansas 1975   Male
    ## 1095      78.46940      71.82476  6.64464433         Kansas 1976 Female
    ## 1096      70.87037      64.95350  5.91687158         Kansas 1976   Male
    ## 1097      78.93960      72.07192  6.86767654         Kansas 1977 Female
    ## 1098      71.20158      65.12717  6.07441604         Kansas 1977   Male
    ## 1099      79.04594      72.43108  6.61486880         Kansas 1978 Female
    ## 1100      71.51031      65.38396  6.12635151         Kansas 1978   Male
    ## 1101      79.29842      72.75184  6.54657712         Kansas 1979 Female
    ## 1102      71.75330      65.69565  6.05765421         Kansas 1979   Male
    ## 1103      79.38976      72.92716  6.46259764         Kansas 1980 Female
    ## 1104      71.85401      65.98311  5.87089921         Kansas 1980   Male
    ## 1105      79.56182      73.15757  6.40425008         Kansas 1981 Female
    ## 1106      72.05793      66.40004  5.65789189         Kansas 1981   Male
    ## 1107      79.69814      73.35731  6.34083386         Kansas 1982 Female
    ## 1108      72.19773      66.76048  5.43725108         Kansas 1982   Male
    ## 1109      79.89764      73.51903  6.37861882         Kansas 1983 Female
    ## 1110      72.33147      66.99346  5.33800540         Kansas 1983   Male
    ## 1111      79.79418      73.66911  6.12506568         Kansas 1984 Female
    ## 1112      72.54039      67.18347  5.35692257         Kansas 1984   Male
    ## 1113      79.89842      73.86717  6.03125271         Kansas 1985 Female
    ## 1114      72.77836      67.29196  5.48639877         Kansas 1985   Male
    ## 1115      79.97872      74.11266  5.86606028         Kansas 1986 Female
    ## 1116      73.00370      67.27983  5.72386224         Kansas 1986   Male
    ## 1117      80.05396      74.37557  5.67838702         Kansas 1987 Female
    ## 1118      73.20566      67.27517  5.93048810         Kansas 1987   Male
    ## 1119      79.98165      74.45950  5.52214248         Kansas 1988 Female
    ## 1120      73.31753      67.36645  5.95108275         Kansas 1988   Male
    ## 1121      80.18045      74.51511  5.66533613         Kansas 1989 Female
    ## 1122      73.60765      67.46254  6.14511167         Kansas 1989   Male
    ## 1123      80.36051      74.53638  5.82413209         Kansas 1990 Female
    ## 1124      73.76507      67.32831  6.43675693         Kansas 1990   Male
    ## 1125      80.53927      74.55075  5.98852018         Kansas 1991 Female
    ## 1126      73.94785      67.18101  6.76683281         Kansas 1991   Male
    ## 1127      80.54252      74.69382  5.84869436         Kansas 1992 Female
    ## 1128      74.17010      67.08517  7.08492806         Kansas 1992   Male
    ## 1129      80.33208      74.68058  5.65149597         Kansas 1993 Female
    ## 1130      74.17301      66.94722  7.22579709         Kansas 1993   Male
    ## 1131      80.35715      74.76663  5.59051991         Kansas 1994 Female
    ## 1132      74.33365      66.88968  7.44397404         Kansas 1994   Male
    ## 1133      80.32063      74.81355  5.50708118         Kansas 1995 Female
    ## 1134      74.41263      66.98642  7.42621101         Kansas 1995   Male
    ## 1135      80.40956      74.83815  5.57140905         Kansas 1996 Female
    ## 1136      74.51686      67.19972  7.31714558         Kansas 1996   Male
    ## 1137      80.47689      74.96848  5.50840884         Kansas 1997 Female
    ## 1138      74.64012      67.46790  7.17222179         Kansas 1997   Male
    ## 1139      80.36861      75.05166  5.31695942         Kansas 1998 Female
    ## 1140      74.76760      67.76382  7.00377227         Kansas 1998   Male
    ## 1141      80.26048      75.12060  5.13988675         Kansas 1999 Female
    ## 1142      74.89874      68.10486  6.79387647         Kansas 1999   Male
    ## 1143      80.15720      75.06480  5.09240215         Kansas 2000 Female
    ## 1144      75.02755      68.32254  6.70500113         Kansas 2000   Male
    ## 1145      80.21936      75.07560  5.14376594         Kansas 2001 Female
    ## 1146      75.16005      68.44936  6.71068981         Kansas 2001   Male
    ## 1147      80.18225      75.13380  5.04844950         Kansas 2002 Female
    ## 1148      75.25194      68.63612  6.61582390         Kansas 2002   Male
    ## 1149      80.31174      75.26124  5.05049698         Kansas 2003 Female
    ## 1150      75.50409      68.84445  6.65963427         Kansas 2003   Male
    ## 1151      80.57231      75.40616  5.16614935         Kansas 2004 Female
    ## 1152      75.78766      68.97131  6.81635084         Kansas 2004   Male
    ## 1153      80.56384      75.58614  4.97770362         Kansas 2005 Female
    ## 1154      75.81894      69.15674  6.66219894         Kansas 2005   Male
    ## 1155      80.66802      75.71545  4.95256871         Kansas 2006 Female
    ## 1156      76.01173      69.50204  6.50968756         Kansas 2006   Male
    ## 1157      80.78957      75.94685  4.84272072         Kansas 2007 Female
    ## 1158      76.11413      69.96806  6.14606644         Kansas 2007   Male
    ## 1159      80.85521      76.16126  4.69394772         Kansas 2008 Female
    ## 1160      76.15455      70.35190  5.80264763         Kansas 2008   Male
    ## 1161      81.19939      76.38479  4.81460193         Kansas 2009 Female
    ## 1162      76.39574      70.73900  5.65674228         Kansas 2009   Male
    ## 1163      81.21644      76.58728  4.62916477         Kansas 2010 Female
    ## 1164      76.38985      70.99207  5.39777854         Kansas 2010   Male
    ## 1165      81.09097      76.68145  4.40952501         Kansas 2011 Female
    ## 1166      76.45596      71.23844  5.21752044         Kansas 2011   Male
    ## 1167      81.21746      76.68557  4.53189543         Kansas 2012 Female
    ## 1168      76.49950      71.36875  5.13074472         Kansas 2012   Male
    ## 1169      81.16532      76.68201  4.48330813         Kansas 2013 Female
    ## 1170      76.60368      71.38902  5.21466218         Kansas 2013   Male
    ## 1171      75.00773      69.01223  5.99550646       Kentucky 1969 Female
    ## 1172      66.68049      60.24671  6.43377606       Kentucky 1969   Male
    ## 1173      75.19793      69.09313  6.10479888       Kentucky 1970 Female
    ## 1174      66.84153      60.50012  6.34141337       Kentucky 1970   Male
    ## 1175      75.32324      69.24845  6.07478493       Kentucky 1971 Female
    ## 1176      67.02700      60.70358  6.32342292       Kentucky 1971   Male
    ## 1177      75.51426      69.49312  6.02114236       Kentucky 1972 Female
    ## 1178      67.02108      61.08626  5.93481739       Kentucky 1972   Male
    ## 1179      75.67116      69.84016  5.83100287       Kentucky 1973 Female
    ## 1180      67.16237      61.71596  5.44640876       Kentucky 1973   Male
    ## 1181      76.08335      70.38177  5.70157631       Kentucky 1974 Female
    ## 1182      67.58411      62.31918  5.26493325       Kentucky 1974   Male
    ## 1183      76.55833      70.86529  5.69304437       Kentucky 1975 Female
    ## 1184      67.94691      62.77663  5.17027945       Kentucky 1975   Male
    ## 1185      76.90636      71.30059  5.60576500       Kentucky 1976 Female
    ## 1186      68.35809      63.12352  5.23456399       Kentucky 1976   Male
    ## 1187      77.07277      71.37363  5.69913982       Kentucky 1977 Female
    ## 1188      68.51105      63.33784  5.17320687       Kentucky 1977   Male
    ## 1189      77.22809      71.51088  5.71721648       Kentucky 1978 Female
    ## 1190      68.86873      63.56629  5.30244891       Kentucky 1978   Male
    ## 1191      77.57112      71.80121  5.76991717       Kentucky 1979 Female
    ## 1192      69.28661      63.93729  5.34932405       Kentucky 1979   Male
    ## 1193      77.55779      72.14801  5.40978760       Kentucky 1980 Female
    ## 1194      69.34762      64.23714  5.11047713       Kentucky 1980   Male
    ## 1195      77.72473      72.48293  5.24180437       Kentucky 1981 Female
    ## 1196      69.63485      64.69639  4.93845520       Kentucky 1981   Male
    ## 1197      77.92151      72.70205  5.21945738       Kentucky 1982 Female
    ## 1198      69.85037      65.01343  4.83693847       Kentucky 1982   Male
    ## 1199      77.97956      72.80620  5.17335550       Kentucky 1983 Female
    ## 1200      69.89014      65.18531  4.70482879       Kentucky 1983   Male
    ## 1201      78.14367      72.89484  5.24883843       Kentucky 1984 Female
    ## 1202      70.09087      65.41030  4.68056761       Kentucky 1984   Male
    ## 1203      77.99455      72.95892  5.03563008       Kentucky 1985 Female
    ## 1204      70.20319      65.58946  4.61373122       Kentucky 1985   Male
    ## 1205      78.10130      73.16075  4.94054853       Kentucky 1986 Female
    ## 1206      70.30519      65.82673  4.47846027       Kentucky 1986   Male
    ## 1207      78.14738      73.35319  4.79419100       Kentucky 1987 Female
    ## 1208      70.43468      66.01813  4.41655403       Kentucky 1987   Male
    ## 1209      78.08645      73.45683  4.62961791       Kentucky 1988 Female
    ## 1210      70.55148      66.07402  4.47745960       Kentucky 1988   Male
    ## 1211      78.18723      73.69161  4.49562034       Kentucky 1989 Female
    ## 1212      70.83242      66.18952  4.64290270       Kentucky 1989   Male
    ## 1213      78.41534      73.82958  4.58576730       Kentucky 1990 Female
    ## 1214      71.02756      66.37084  4.65672839       Kentucky 1990   Male
    ## 1215      78.57001      74.05139  4.51861769       Kentucky 1991 Female
    ## 1216      71.19308      66.48895  4.70412823       Kentucky 1991   Male
    ## 1217      78.68499      74.27045  4.41453832       Kentucky 1992 Female
    ## 1218      71.37174      66.70983  4.66190848       Kentucky 1992   Male
    ## 1219      78.44669      74.24858  4.19810510       Kentucky 1993 Female
    ## 1220      71.40181      66.79373  4.60807713       Kentucky 1993   Male
    ## 1221      78.45026      74.27310  4.17716253       Kentucky 1994 Female
    ## 1222      71.54806      66.84389  4.70417333       Kentucky 1994   Male
    ## 1223      78.57019      74.33550  4.23469325       Kentucky 1995 Female
    ## 1224      71.71285      66.99619  4.71666157       Kentucky 1995   Male
    ## 1225      78.60799      74.37289  4.23510112       Kentucky 1996 Female
    ## 1226      71.91900      67.27614  4.64286077       Kentucky 1996   Male
    ## 1227      78.54488      74.38800  4.15687501       Kentucky 1997 Female
    ## 1228      72.03490      67.60125  4.43364965       Kentucky 1997   Male
    ## 1229      78.43402      74.45218  3.98183846       Kentucky 1998 Female
    ## 1230      72.29516      67.97797  4.31718397       Kentucky 1998   Male
    ## 1231      78.29703      74.52878  3.76825111       Kentucky 1999 Female
    ## 1232      72.29056      68.25057  4.03998564       Kentucky 1999   Male
    ## 1233      78.26336      74.68687  3.57648988       Kentucky 2000 Female
    ## 1234      72.35173      68.50269  3.84904126       Kentucky 2000   Male
    ## 1235      78.18933      74.92253  3.26679714       Kentucky 2001 Female
    ## 1236      72.40291      68.73383  3.66907786       Kentucky 2001   Male
    ## 1237      78.16488      74.94808  3.21680009       Kentucky 2002 Female
    ## 1238      72.36702      68.94766  3.41935351       Kentucky 2002   Male
    ## 1239      78.27527      75.19916  3.07611475       Kentucky 2003 Female
    ## 1240      72.57193      69.11650  3.45542702       Kentucky 2003   Male
    ## 1241      78.55035      75.51140  3.03895197       Kentucky 2004 Female
    ## 1242      72.84081      69.39082  3.44998684       Kentucky 2004   Male
    ## 1243      78.49922      75.75566  2.74355938       Kentucky 2005 Female
    ## 1244      72.87415      69.65707  3.21707311       Kentucky 2005   Male
    ## 1245      78.66244      76.02289  2.63955355       Kentucky 2006 Female
    ## 1246      73.03671      69.86399  3.17271244       Kentucky 2006   Male
    ## 1247      78.74235      76.25125  2.49109045       Kentucky 2007 Female
    ## 1248      73.24570      70.13699  3.10870945       Kentucky 2007   Male
    ## 1249      78.59289      76.51018  2.08270475       Kentucky 2008 Female
    ## 1250      73.29792      70.46853  2.82938400       Kentucky 2008   Male
    ## 1251      78.64852      76.64575  2.00277311       Kentucky 2009 Female
    ## 1252      73.44954      70.74884  2.70069348       Kentucky 2009   Male
    ## 1253      78.67488      76.82947  1.84540275       Kentucky 2010 Female
    ## 1254      73.41642      71.07229  2.34412437       Kentucky 2010   Male
    ## 1255      78.59753      77.01960  1.57793601       Kentucky 2011 Female
    ## 1256      73.40119      71.30786  2.09333592       Kentucky 2011   Male
    ## 1257      78.55579      77.19897  1.35681753       Kentucky 2012 Female
    ## 1258      73.42421      71.39438  2.02983350       Kentucky 2012   Male
    ## 1259      78.66502      77.39148  1.27354072       Kentucky 2013 Female
    ## 1260      73.47023      71.50153  1.96870023       Kentucky 2013   Male
    ## 1261      75.33293      67.90375  7.42917405      Louisiana 1969 Female
    ## 1262      66.52545      60.23410  6.29135443      Louisiana 1969   Male
    ## 1263      75.49754      68.46814  7.02940412      Louisiana 1970 Female
    ## 1264      66.71931      60.50050  6.21880611      Louisiana 1970   Male
    ## 1265      75.70848      69.02153  6.68694544      Louisiana 1971 Female
    ## 1266      67.07762      61.06293  6.01469427      Louisiana 1971   Male
    ## 1267      75.85354      69.34479  6.50874797      Louisiana 1972 Female
    ## 1268      67.12078      61.21731  5.90347781      Louisiana 1972   Male
    ## 1269      75.93206      69.72392  6.20813731      Louisiana 1973 Female
    ## 1270      67.25066      61.32313  5.92753475      Louisiana 1973   Male
    ## 1271      76.39289      70.46801  5.92488313      Louisiana 1974 Female
    ## 1272      67.59717      61.84484  5.75232704      Louisiana 1974   Male
    ## 1273      76.73612      70.94937  5.78674663      Louisiana 1975 Female
    ## 1274      67.97660      62.13352  5.84307860      Louisiana 1975   Male
    ## 1275      76.84660      71.13718  5.70942158      Louisiana 1976 Female
    ## 1276      68.27017      62.34248  5.92769166      Louisiana 1976   Male
    ## 1277      77.13126      71.39961  5.73164401      Louisiana 1977 Female
    ## 1278      68.58339      62.38926  6.19412386      Louisiana 1977   Male
    ## 1279      77.34834      71.66378  5.68456237      Louisiana 1978 Female
    ## 1280      68.81319      62.72469  6.08849157      Louisiana 1978   Male
    ## 1281      77.52326      72.13860  5.38465578      Louisiana 1979 Female
    ## 1282      69.10183      62.98372  6.11810584      Louisiana 1979   Male
    ## 1283      77.66325      72.23668  5.42657201      Louisiana 1980 Female
    ## 1284      69.31482      63.33121  5.98360323      Louisiana 1980   Male
    ## 1285      77.65982      72.57962  5.08020146      Louisiana 1981 Female
    ## 1286      69.60963      63.64129  5.96833821      Louisiana 1981   Male
    ## 1287      77.75235      72.89907  4.85327532      Louisiana 1982 Female
    ## 1288      69.98308      64.02676  5.95631669      Louisiana 1982   Male
    ## 1289      78.01188      72.85796  5.15392312      Louisiana 1983 Female
    ## 1290      70.27396      64.32630  5.94766170      Louisiana 1983   Male
    ## 1291      78.22723      73.12390  5.10332975      Louisiana 1984 Female
    ## 1292      70.44179      64.76078  5.68100617      Louisiana 1984   Male
    ## 1293      78.26025      73.13159  5.12866053      Louisiana 1985 Female
    ## 1294      70.63769      64.86062  5.77706369      Louisiana 1985   Male
    ## 1295      78.50839      73.26347  5.24491871      Louisiana 1986 Female
    ## 1296      70.90129      64.87091  6.03038543      Louisiana 1986   Male
    ## 1297      78.58352      73.20859  5.37492693      Louisiana 1987 Female
    ## 1298      71.01359      64.86690  6.14669334      Louisiana 1987   Male
    ## 1299      78.47150      73.12747  5.34403679      Louisiana 1988 Female
    ## 1300      70.98858      64.71031  6.27827512      Louisiana 1988   Male
    ## 1301      78.56807      73.16850  5.39956893      Louisiana 1989 Female
    ## 1302      71.18870      64.42177  6.76693354      Louisiana 1989   Male
    ## 1303      78.65815      73.43094  5.22720512      Louisiana 1990 Female
    ## 1304      71.32059      64.15262  7.16796701      Louisiana 1990   Male
    ## 1305      78.71548      73.63926  5.07622278      Louisiana 1991 Female
    ## 1306      71.36038      64.09847  7.26190370      Louisiana 1991   Male
    ## 1307      78.84650      73.75776  5.08874484      Louisiana 1992 Female
    ## 1308      71.61043      64.19912  7.41130935      Louisiana 1992   Male
    ## 1309      78.74955      73.66523  5.08431613      Louisiana 1993 Female
    ## 1310      71.67961      64.07537  7.60423349      Louisiana 1993   Male
    ## 1311      78.81628      73.78210  5.03418074      Louisiana 1994 Female
    ## 1312      71.89766      64.43568  7.46197531      Louisiana 1994   Male
    ## 1313      78.81716      73.94237  4.87479349      Louisiana 1995 Female
    ## 1314      72.07758      64.73914  7.33844433      Louisiana 1995   Male
    ## 1315      78.86647      74.10305  4.76341331      Louisiana 1996 Female
    ## 1316      72.32331      65.13123  7.19207794      Louisiana 1996   Male
    ## 1317      78.89793      74.02632  4.87160854      Louisiana 1997 Female
    ## 1318      72.57362      65.61109  6.96252765      Louisiana 1997   Male
    ## 1319      78.83491      73.94610  4.88880898      Louisiana 1998 Female
    ## 1320      72.81754      65.97351  6.84403238      Louisiana 1998   Male
    ## 1321      78.75000      73.92257  4.82743482      Louisiana 1999 Female
    ## 1322      72.82456      66.33424  6.49032016      Louisiana 1999   Male
    ## 1323      78.82148      73.96513  4.85634649      Louisiana 2000 Female
    ## 1324      72.95474      66.43208  6.52265202      Louisiana 2000   Male
    ## 1325      78.79030      73.95783  4.83246977      Louisiana 2001 Female
    ## 1326      72.99673      66.58106  6.41567352      Louisiana 2001   Male
    ## 1327      78.72903      74.04453  4.68449474      Louisiana 2002 Female
    ## 1328      73.01867      66.63902  6.37964352      Louisiana 2002   Male
    ## 1329      78.65861      74.09888  4.55972693      Louisiana 2003 Female
    ## 1330      73.08135      66.64271  6.43863865      Louisiana 2003   Male
    ## 1331      78.71837      74.20956  4.50880583      Louisiana 2004 Female
    ## 1332      73.14539      66.61537  6.53001908      Louisiana 2004   Male
    ## 1333      78.60117      74.13679  4.46437282      Louisiana 2005 Female
    ## 1334      73.02457      66.69008  6.33448768      Louisiana 2005   Male
    ## 1335      79.03989      74.60610  4.43378499      Louisiana 2006 Female
    ## 1336      73.31002      67.18952  6.12049735      Louisiana 2006   Male
    ## 1337      79.13843      75.14948  3.98894239      Louisiana 2007 Female
    ## 1338      73.57205      67.80253  5.76951609      Louisiana 2007   Male
    ## 1339      79.21818      75.50119  3.71699130      Louisiana 2008 Female
    ## 1340      73.75202      68.40763  5.34439099      Louisiana 2008   Male
    ## 1341      79.50565      75.91249  3.59315762      Louisiana 2009 Female
    ## 1342      74.09441      68.82975  5.26466759      Louisiana 2009   Male
    ## 1343      79.59478      76.22205  3.37272469      Louisiana 2010 Female
    ## 1344      74.29902      69.26481  5.03421464      Louisiana 2010   Male
    ## 1345      79.56819      76.51938  3.04880676      Louisiana 2011 Female
    ## 1346      74.47941      69.47625  5.00316286      Louisiana 2011   Male
    ## 1347      79.54153      76.57725  2.96428785      Louisiana 2012 Female
    ## 1348      74.46460      69.50452  4.96007429      Louisiana 2012   Male
    ## 1349      79.50511      76.58321  2.92190508      Louisiana 2013 Female
    ## 1350      74.45148      69.41318  5.03830233      Louisiana 2013   Male
    ## 1351      75.43256      69.08011  6.35244674       Maryland 1969 Female
    ## 1352      67.90258      60.47229  7.43029028       Maryland 1969   Male
    ## 1353      75.71254      69.52306  6.18947972       Maryland 1970 Female
    ## 1354      68.06158      60.83719  7.22439053       Maryland 1970   Male
    ## 1355      76.08172      70.14579  5.93593146       Maryland 1971 Female
    ## 1356      68.42477      61.34104  7.08373226       Maryland 1971   Male
    ## 1357      76.18044      70.73674  5.44370527       Maryland 1972 Female
    ## 1358      68.62823      62.03236  6.59587748       Maryland 1972   Male
    ## 1359      76.46454      71.50539  4.95915104       Maryland 1973 Female
    ## 1360      68.94088      62.65297  6.28790323       Maryland 1973   Male
    ## 1361      76.78384      72.10103  4.68281567       Maryland 1974 Female
    ## 1362      69.13955      63.10015  6.03939947       Maryland 1974   Male
    ## 1363      77.17700      72.48972  4.68727934       Maryland 1975 Female
    ## 1364      69.53243      63.50197  6.03046207       Maryland 1975   Male
    ## 1365      77.24723      72.59265  4.65457204       Maryland 1976 Female
    ## 1366      69.90689      63.88895  6.01794541       Maryland 1976   Male
    ## 1367      77.55506      72.91936  4.63570187       Maryland 1977 Female
    ## 1368      70.26336      64.56474  5.69861763       Maryland 1977   Male
    ## 1369      77.74612      73.20793  4.53819289       Maryland 1978 Female
    ## 1370      70.45170      64.75521  5.69649247       Maryland 1978   Male
    ## 1371      77.95732      73.41608  4.54123843       Maryland 1979 Female
    ## 1372      70.75531      64.95696  5.79835259       Maryland 1979   Male
    ## 1373      77.90556      73.58386  4.32170324       Maryland 1980 Female
    ## 1374      70.92584      65.14070  5.78513628       Maryland 1980   Male
    ## 1375      78.18967      73.78123  4.40843675       Maryland 1981 Female
    ## 1376      71.20294      65.39873  5.80421084       Maryland 1981   Male
    ## 1377      78.34673      73.95874  4.38798839       Maryland 1982 Female
    ## 1378      71.51773      65.57284  5.94488861       Maryland 1982   Male
    ## 1379      78.29604      74.11589  4.18014990       Maryland 1983 Female
    ## 1380      71.63366      65.73911  5.89454892       Maryland 1983   Male
    ## 1381      78.39284      74.12159  4.27124750       Maryland 1984 Female
    ## 1382      71.74696      65.81926  5.92770215       Maryland 1984   Male
    ## 1383      78.45383      74.03840  4.41542256       Maryland 1985 Female
    ## 1384      71.81199      65.74604  6.06594156       Maryland 1985   Male
    ## 1385      78.49238      73.92714  4.56523960       Maryland 1986 Female
    ## 1386      71.98249      65.60483  6.37766672       Maryland 1986   Male
    ## 1387      78.56899      73.93656  4.63243163       Maryland 1987 Female
    ## 1388      72.26150      65.41326  6.84824239       Maryland 1987   Male
    ## 1389      78.67765      73.95717  4.72048093       Maryland 1988 Female
    ## 1390      72.52732      65.23008  7.29724469       Maryland 1988   Male
    ## 1391      78.99458      74.17609  4.81849156       Maryland 1989 Female
    ## 1392      72.95838      65.23612  7.72226273       Maryland 1989   Male
    ## 1393      79.25102      74.41121  4.83981566       Maryland 1990 Female
    ## 1394      73.26142      65.24889  8.01252456       Maryland 1990   Male
    ## 1395      79.54149      74.68805  4.85343472       Maryland 1991 Female
    ## 1396      73.56813      65.20442  8.36370681       Maryland 1991   Male
    ## 1397      79.75014      74.79121  4.95892948       Maryland 1992 Female
    ## 1398      73.78098      65.09966  8.68132687       Maryland 1992   Male
    ## 1399      79.75864      74.75069  5.00795283       Maryland 1993 Female
    ## 1400      73.88533      64.79233  9.09300365       Maryland 1993   Male
    ## 1401      79.76990      74.95658  4.81332165       Maryland 1994 Female
    ## 1402      74.09577      65.02751  9.06825955       Maryland 1994   Male
    ## 1403      79.84633      75.12385  4.72247306       Maryland 1995 Female
    ## 1404      74.25991      65.09930  9.16060513       Maryland 1995   Male
    ## 1405      79.98898      75.23909  4.74989011       Maryland 1996 Female
    ## 1406      74.52390      65.74432  8.77958067       Maryland 1996   Male
    ## 1407      80.04444      75.42040  4.62403612       Maryland 1997 Female
    ## 1408      74.89355      66.64776  8.24578784       Maryland 1997   Male
    ## 1409      80.13882      75.57887  4.55994634       Maryland 1998 Female
    ## 1410      75.10449      67.19415  7.91033578       Maryland 1998   Male
    ## 1411      80.07493      75.60947  4.46545295       Maryland 1999 Female
    ## 1412      75.22305      67.59242  7.63063229       Maryland 1999   Male
    ## 1413      80.04681      75.77117  4.27563615       Maryland 2000 Female
    ## 1414      75.36026      68.11220  7.24805592       Maryland 2000   Male
    ## 1415      80.20051      75.95717  4.24334097       Maryland 2001 Female
    ## 1416      75.51867      68.48830  7.03037526       Maryland 2001   Male
    ## 1417      80.38462      76.13192  4.25270538       Maryland 2002 Female
    ## 1418      75.70365      68.83006  6.87359163       Maryland 2002   Male
    ## 1419      80.56984      76.49882  4.07102013       Maryland 2003 Female
    ## 1420      75.83085      69.00158  6.82926559       Maryland 2003   Male
    ## 1421      80.91895      76.92178  3.99716282       Maryland 2004 Female
    ## 1422      76.19523      69.54515  6.65007717       Maryland 2004   Male
    ## 1423      80.99690      77.27552  3.72138022       Maryland 2005 Female
    ## 1424      76.38892      70.08669  6.30222970       Maryland 2005   Male
    ## 1425      81.28239      77.63208  3.65031037       Maryland 2006 Female
    ## 1426      76.64779      70.56407  6.08372138       Maryland 2006   Male
    ## 1427      81.44583      78.06211  3.38371911       Maryland 2007 Female
    ## 1428      76.79444      70.92829  5.86615055       Maryland 2007   Male
    ## 1429      81.67768      78.43587  3.24181168       Maryland 2008 Female
    ## 1430      76.99714      71.37557  5.62156798       Maryland 2008   Male
    ## 1431      81.90066      78.84981  3.05084835       Maryland 2009 Female
    ## 1432      77.31606      72.00887  5.30718722       Maryland 2009   Male
    ## 1433      82.06695      79.19162  2.87532503       Maryland 2010 Female
    ## 1434      77.63631      72.77604  4.86027522       Maryland 2010   Male
    ## 1435      82.15950      79.59497  2.56453955       Maryland 2011 Female
    ## 1436      77.70842      73.30535  4.40306567       Maryland 2011   Male
    ## 1437      82.20296      79.84431  2.35864551       Maryland 2012 Female
    ## 1438      77.77655      73.52950  4.24704897       Maryland 2012   Male
    ## 1439      82.20901      79.92163  2.28737649       Maryland 2013 Female
    ## 1440      77.71240      73.58994  4.12245106       Maryland 2013   Male
    ## 1441      75.56886      71.42555  4.14330039  Massachusetts 1969 Female
    ## 1442      68.22483      61.86683  6.35799689  Massachusetts 1969   Male
    ## 1443      75.91472      71.64551  4.26920904  Massachusetts 1970 Female
    ## 1444      68.39421      62.06488  6.32933165  Massachusetts 1970   Male
    ## 1445      76.15055      71.89290  4.25765952  Massachusetts 1971 Female
    ## 1446      68.76903      62.41469  6.35434503  Massachusetts 1971   Male
    ## 1447      76.44000      72.48976  3.95024316  Massachusetts 1972 Female
    ## 1448      68.84052      62.89990  5.94061728  Massachusetts 1972   Male
    ## 1449      76.75631      73.06032  3.69599256  Massachusetts 1973 Female
    ## 1450      68.91233      63.43264  5.47969740  Massachusetts 1973   Male
    ## 1451      77.19380      73.75279  3.44101499  Massachusetts 1974 Female
    ## 1452      69.32330      64.19777  5.12553284  Massachusetts 1974   Male
    ## 1453      77.76616      74.30703  3.45913320  Massachusetts 1975 Female
    ## 1454      69.85932      64.98447  4.87484546  Massachusetts 1975   Male
    ## 1455      77.84390      74.70665  3.13724564  Massachusetts 1976 Female
    ## 1456      70.33961      65.64898  4.69062905  Massachusetts 1976   Male
    ## 1457      78.43722      75.09104  3.34618778  Massachusetts 1977 Female
    ## 1458      70.83777      66.16598  4.67178869  Massachusetts 1977   Male
    ## 1459      78.56834      75.39721  3.17112600  Massachusetts 1978 Female
    ## 1460      71.05379      66.61193  4.44185393  Massachusetts 1978   Male
    ## 1461      78.69818      75.75129  2.94688823  Massachusetts 1979 Female
    ## 1462      71.28419      67.10937  4.17482198  Massachusetts 1979   Male
    ## 1463      78.44027      75.90713  2.53313919  Massachusetts 1980 Female
    ## 1464      71.34529      67.27858  4.06671621  Massachusetts 1980   Male
    ## 1465      78.90677      76.08519  2.82157742  Massachusetts 1981 Female
    ## 1466      71.67846      67.54022  4.13823550  Massachusetts 1981   Male
    ## 1467      79.05401      76.14279  2.91121427  Massachusetts 1982 Female
    ## 1468      71.86065      67.82346  4.03719171  Massachusetts 1982   Male
    ## 1469      79.01926      76.20730  2.81196670  Massachusetts 1983 Female
    ## 1470      71.96464      68.04680  3.91784006  Massachusetts 1983   Male
    ## 1471      78.96860      76.17845  2.79015109  Massachusetts 1984 Female
    ## 1472      72.01372      68.14343  3.87029586  Massachusetts 1984   Male
    ## 1473      79.02131      76.12350  2.89780815  Massachusetts 1985 Female
    ## 1474      72.20228      68.10731  4.09496988  Massachusetts 1985   Male
    ## 1475      79.06697      76.19492  2.87204815  Massachusetts 1986 Female
    ## 1476      72.43086      68.15921  4.27165180  Massachusetts 1986   Male
    ## 1477      79.25717      76.36870  2.88846205  Massachusetts 1987 Female
    ## 1478      72.60670      68.22625  4.38044935  Massachusetts 1987   Male
    ## 1479      79.28294      76.60441  2.67853021  Massachusetts 1988 Female
    ## 1480      72.69143      68.12427  4.56716506  Massachusetts 1988   Male
    ## 1481      79.81115      76.80133  3.00982628  Massachusetts 1989 Female
    ## 1482      73.20548      68.36787  4.83760745  Massachusetts 1989   Male
    ## 1483      80.04172      77.05715  2.98457343  Massachusetts 1990 Female
    ## 1484      73.58344      68.44335  5.14008711  Massachusetts 1990   Male
    ## 1485      80.22712      77.15273  3.07438258  Massachusetts 1991 Female
    ## 1486      73.80749      68.64465  5.16284381  Massachusetts 1991   Male
    ## 1487      80.33984      77.39646  2.94338297  Massachusetts 1992 Female
    ## 1488      73.86710      68.83946  5.02764113  Massachusetts 1992   Male
    ## 1489      80.15444      77.59674  2.55770467  Massachusetts 1993 Female
    ## 1490      73.95233      69.01724  4.93509197  Massachusetts 1993   Male
    ## 1491      80.36980      77.49869  2.87110998  Massachusetts 1994 Female
    ## 1492      74.22771      69.15701  5.07069434  Massachusetts 1994   Male
    ## 1493      80.41424      77.73271  2.68153471  Massachusetts 1995 Female
    ## 1494      74.56932      69.55654  5.01277897  Massachusetts 1995   Male
    ## 1495      80.55513      77.97608  2.57904908  Massachusetts 1996 Female
    ## 1496      74.91753      70.46383  4.45369947  Massachusetts 1996   Male
    ## 1497      80.68221      78.29922  2.38299099  Massachusetts 1997 Female
    ## 1498      75.29835      71.34939  3.94895299  Massachusetts 1997   Male
    ## 1499      80.72672      78.65843  2.06829428  Massachusetts 1998 Female
    ## 1500      75.48110      71.95184  3.52925738  Massachusetts 1998   Male
    ## 1501      80.77818      78.87327  1.90491051  Massachusetts 1999 Female
    ## 1502      75.65240      72.41715  3.23524325  Massachusetts 1999   Male
    ## 1503      80.75179      79.06691  1.68488158  Massachusetts 2000 Female
    ## 1504      75.77691      72.82069  2.95622524  Massachusetts 2000   Male
    ## 1505      80.76650      79.19759  1.56891576  Massachusetts 2001 Female
    ## 1506      75.92460      73.15080  2.77380221  Massachusetts 2001   Male
    ## 1507      80.90376      79.53655  1.36721074  Massachusetts 2002 Female
    ## 1508      75.95146      73.41136  2.54009388  Massachusetts 2002   Male
    ## 1509      81.12042      79.89150  1.22891523  Massachusetts 2003 Female
    ## 1510      76.20145      73.73761  2.46383980  Massachusetts 2003   Male
    ## 1511      81.41496      80.48968  0.92527981  Massachusetts 2004 Female
    ## 1512      76.58792      74.13283  2.45509806  Massachusetts 2004   Male
    ## 1513      81.63984      80.89151  0.74833449  Massachusetts 2005 Female
    ## 1514      76.82528      74.67989  2.14539138  Massachusetts 2005   Male
    ## 1515      81.81783      81.52730  0.29053265  Massachusetts 2006 Female
    ## 1516      77.11570      75.21788  1.89781337  Massachusetts 2006   Male
    ## 1517      82.08512      82.17339 -0.08827844  Massachusetts 2007 Female
    ## 1518      77.32823      75.81294  1.51528261  Massachusetts 2007   Male
    ## 1519      82.16718      82.60573 -0.43854604  Massachusetts 2008 Female
    ## 1520      77.52440      76.33541  1.18899544  Massachusetts 2008   Male
    ## 1521      82.58281      82.97472 -0.39190524  Massachusetts 2009 Female
    ## 1522      77.80109      76.85544  0.94564333  Massachusetts 2009   Male
    ## 1523      82.68700      83.29440 -0.60740159  Massachusetts 2010 Female
    ## 1524      77.93935      77.20562  0.73372587  Massachusetts 2010   Male
    ## 1525      82.68885      83.37496 -0.68611110  Massachusetts 2011 Female
    ## 1526      77.96133      77.78395  0.17738068  Massachusetts 2011   Male
    ## 1527      82.79262      83.71670 -0.92407943  Massachusetts 2012 Female
    ## 1528      78.19791      78.18598  0.01193578  Massachusetts 2012   Male
    ## 1529      82.71067      83.82573 -1.11506162  Massachusetts 2013 Female
    ## 1530      78.18757      78.13959  0.04797459  Massachusetts 2013   Male
    ## 1531      75.24131      69.40836  5.83294955       Michigan 1969 Female
    ## 1532      67.96122      60.65385  7.30737089       Michigan 1969   Male
    ## 1533      75.43970      69.61739  5.82230762       Michigan 1970 Female
    ## 1534      68.13365      60.71371  7.41994595       Michigan 1970   Male
    ## 1535      75.74952      69.85081  5.89870566       Michigan 1971 Female
    ## 1536      68.26162      60.50214  7.75947886       Michigan 1971   Male
    ## 1537      75.80608      70.15629  5.64979167       Michigan 1972 Female
    ## 1538      68.39168      60.49193  7.89975548       Michigan 1972   Male
    ## 1539      76.13707      70.58044  5.55663342       Michigan 1973 Female
    ## 1540      68.65165      60.56207  8.08957487       Michigan 1973   Male
    ## 1541      76.53783      71.27629  5.26154472       Michigan 1974 Female
    ## 1542      69.04003      61.04563  7.99440249       Michigan 1974   Male
    ## 1543      76.99421      71.94453  5.04968126       Michigan 1975 Female
    ## 1544      69.49169      61.80488  7.68680542       Michigan 1975   Male
    ## 1545      77.08925      72.24714  4.84211454       Michigan 1976 Female
    ## 1546      69.70458      62.42859  7.27599344       Michigan 1976   Male
    ## 1547      77.58344      72.55702  5.02642040       Michigan 1977 Female
    ## 1548      70.04434      63.05906  6.98528721       Michigan 1977   Male
    ## 1549      77.75472      72.59761  5.15711358       Michigan 1978 Female
    ## 1550      70.35771      63.47399  6.88371877       Michigan 1978   Male
    ## 1551      78.08117      72.86149  5.21967958       Michigan 1979 Female
    ## 1552      70.72366      63.68847  7.03518662       Michigan 1979   Male
    ## 1553      78.13435      72.81652  5.31782473       Michigan 1980 Female
    ## 1554      70.97194      63.72433  7.24760865       Michigan 1980   Male
    ## 1555      78.24964      72.85273  5.39690977       Michigan 1981 Female
    ## 1556      71.16408      63.82067  7.34341362       Michigan 1981   Male
    ## 1557      78.41532      72.98446  5.43086224       Michigan 1982 Female
    ## 1558      71.40028      63.87779  7.52249152       Michigan 1982   Male
    ## 1559      78.37272      72.97510  5.39761277       Michigan 1983 Female
    ## 1560      71.61352      63.99705  7.61647648       Michigan 1983   Male
    ## 1561      78.49469      73.01214  5.48255438       Michigan 1984 Female
    ## 1562      71.79716      63.86690  7.93025996       Michigan 1984   Male
    ## 1563      78.52184      73.11747  5.40437120       Michigan 1985 Female
    ## 1564      71.79265      63.52716  8.26549123       Michigan 1985   Male
    ## 1565      78.42599      73.01498  5.41101249       Michigan 1986 Female
    ## 1566      71.94449      63.43415  8.51034297       Michigan 1986   Male
    ## 1567      78.59616      73.09873  5.49743369       Michigan 1987 Female
    ## 1568      72.26013      63.43961  8.82052240       Michigan 1987   Male
    ## 1569      78.73246      73.03920  5.69326336       Michigan 1988 Female
    ## 1570      72.46827      63.79472  8.67354758       Michigan 1988   Male
    ## 1571      79.14673      73.18511  5.96162251       Michigan 1989 Female
    ## 1572      72.89289      63.79008  9.10281183       Michigan 1989   Male
    ## 1573      79.33505      73.42843  5.90662293       Michigan 1990 Female
    ## 1574      73.13585      63.95590  9.17995257       Michigan 1990   Male
    ## 1575      79.46435      73.53234  5.93201388       Michigan 1991 Female
    ## 1576      73.35713      64.07327  9.28386709       Michigan 1991   Male
    ## 1577      79.72623      73.63309  6.09314369       Michigan 1992 Female
    ## 1578      73.62277      64.27505  9.34772721       Michigan 1992   Male
    ## 1579      79.58654      73.58956  5.99697847       Michigan 1993 Female
    ## 1580      73.66216      64.30231  9.35985148       Michigan 1993   Male
    ## 1581      79.61669      73.68511  5.93157713       Michigan 1994 Female
    ## 1582      73.90853      64.45855  9.44998165       Michigan 1994   Male
    ## 1583      79.70250      73.78756  5.91494336       Michigan 1995 Female
    ## 1584      74.12035      64.91685  9.20350065       Michigan 1995   Male
    ## 1585      79.77681      74.05629  5.72052011       Michigan 1996 Female
    ## 1586      74.35513      65.64171  8.71342447       Michigan 1996   Male
    ## 1587      79.90740      74.11811  5.78928715       Michigan 1997 Female
    ## 1588      74.57326      66.17342  8.39984375       Michigan 1997   Male
    ## 1589      79.78433      74.25837  5.52596310       Michigan 1998 Female
    ## 1590      74.62327      66.47180  8.15146840       Michigan 1998   Male
    ## 1591      79.74599      74.16438  5.58161192       Michigan 1999 Female
    ## 1592      74.75131      66.56600  8.18530775       Michigan 1999   Male
    ## 1593      79.82081      74.30571  5.51509949       Michigan 2000 Female
    ## 1594      74.93755      66.93635  8.00119663       Michigan 2000   Male
    ## 1595      80.04475      74.41841  5.62633575       Michigan 2001 Female
    ## 1596      75.11965      67.29952  7.82013289       Michigan 2001   Male
    ## 1597      80.09698      74.50375  5.59322232       Michigan 2002 Female
    ## 1598      75.26843      67.56003  7.70839623       Michigan 2002   Male
    ## 1599      80.28192      74.86202  5.41989870       Michigan 2003 Female
    ## 1600      75.52595      67.96025  7.56570185       Michigan 2003   Male
    ## 1601      80.50359      75.16074  5.34285572       Michigan 2004 Female
    ## 1602      75.84939      68.23389  7.61550234       Michigan 2004   Male
    ## 1603      80.50118      75.43023  5.07094445       Michigan 2005 Female
    ## 1604      75.96568      68.36186  7.60382265       Michigan 2005   Male
    ## 1605      80.77889      75.78170  4.99719083       Michigan 2006 Female
    ## 1606      76.13518      68.70770  7.42748388       Michigan 2006   Male
    ## 1607      80.90418      76.07053  4.83365205       Michigan 2007 Female
    ## 1608      76.20827      68.98324  7.22503948       Michigan 2007   Male
    ## 1609      80.85545      76.25231  4.60313757       Michigan 2008 Female
    ## 1610      76.29943      69.32768  6.97174745       Michigan 2008   Male
    ## 1611      81.18616      76.71726  4.46889681       Michigan 2009 Female
    ## 1612      76.48448      69.67445  6.81002709       Michigan 2009   Male
    ## 1613      81.16176      76.83711  4.32465096       Michigan 2010 Female
    ## 1614      76.56773      70.03936  6.52837284       Michigan 2010   Male
    ## 1615      81.14986      77.01756  4.13230399       Michigan 2011 Female
    ## 1616      76.59413      70.14690  6.44722627       Michigan 2011   Male
    ## 1617      81.20996      77.03517  4.17478610       Michigan 2012 Female
    ## 1618      76.68538      70.14343  6.54195500       Michigan 2012   Male
    ## 1619      81.14700      77.06992  4.07708184       Michigan 2013 Female
    ## 1620      76.57896      70.21778  6.36118713       Michigan 2013   Male
    ## 1621      77.10256      73.07862  4.02394622      Minnesota 1969 Female
    ## 1622      69.50907      66.07314  3.43592732      Minnesota 1969   Male
    ## 1623      77.26805      73.17075  4.09729560      Minnesota 1970 Female
    ## 1624      69.72056      66.17110  3.54945943      Minnesota 1970   Male
    ## 1625      77.52307      73.26988  4.25319119      Minnesota 1971 Female
    ## 1626      69.92861      66.25642  3.67219134      Minnesota 1971   Male
    ## 1627      77.68771      73.39012  4.29759436      Minnesota 1972 Female
    ## 1628      70.04341      66.30449  3.73891876      Minnesota 1972   Male
    ## 1629      78.02832      73.46820  4.56012314      Minnesota 1973 Female
    ## 1630      70.40500      66.50869  3.89630583      Minnesota 1973   Male
    ## 1631      78.36495      73.59316  4.77178906      Minnesota 1974 Female
    ## 1632      70.81630      66.76183  4.05446771      Minnesota 1974   Male
    ## 1633      78.97028      73.69178  5.27850269      Minnesota 1975 Female
    ## 1634      71.17433      66.87563  4.29870353      Minnesota 1975   Male
    ## 1635      79.31914      73.66887  5.65027184      Minnesota 1976 Female
    ## 1636      71.43719      66.93932  4.49787458      Minnesota 1976   Male
    ## 1637      79.72641      73.86558  5.86082391      Minnesota 1977 Female
    ## 1638      71.81830      67.07271  4.74559412      Minnesota 1977   Male
    ## 1639      79.80870      74.13324  5.67546110      Minnesota 1978 Female
    ## 1640      71.98729      67.07993  4.90735654      Minnesota 1978   Male
    ## 1641      80.15667      74.35130  5.80537045      Minnesota 1979 Female
    ## 1642      72.48377      67.25846  5.22530993      Minnesota 1979   Male
    ## 1643      80.13673      74.56001  5.57671424      Minnesota 1980 Female
    ## 1644      72.67031      67.48270  5.18761026      Minnesota 1980   Male
    ## 1645      80.50741      74.84100  5.66640960      Minnesota 1981 Female
    ## 1646      72.93555      67.63922  5.29632992      Minnesota 1981   Male
    ## 1647      80.57828      75.07424  5.50404112      Minnesota 1982 Female
    ## 1648      73.20142      68.08865  5.11277216      Minnesota 1982   Male
    ## 1649      80.46233      75.29869  5.16363381      Minnesota 1983 Female
    ## 1650      73.33504      68.37767  4.95737195      Minnesota 1983   Male
    ## 1651      80.57574      75.72708  4.84865685      Minnesota 1984 Female
    ## 1652      73.59657      68.61668  4.97988568      Minnesota 1984   Male
    ## 1653      80.36059      75.85274  4.50785226      Minnesota 1985 Female
    ## 1654      73.72387      68.71238  5.01148637      Minnesota 1985   Male
    ## 1655      80.46986      75.90288  4.56697447      Minnesota 1986 Female
    ## 1656      73.81242      68.75071  5.06171278      Minnesota 1986   Male
    ## 1657      80.63626      76.03292  4.60333589      Minnesota 1987 Female
    ## 1658      74.16016      68.68156  5.47859942      Minnesota 1987   Male
    ## 1659      80.66961      76.20008  4.46953131      Minnesota 1988 Female
    ## 1660      74.26933      68.59168  5.67765306      Minnesota 1988   Male
    ## 1661      81.08246      76.46377  4.61869082      Minnesota 1989 Female
    ## 1662      74.64298      68.63375  6.00923513      Minnesota 1989   Male
    ## 1663      81.16489      76.68661  4.47827267      Minnesota 1990 Female
    ## 1664      74.78024      68.61036  6.16987909      Minnesota 1990   Male
    ## 1665      81.29881      76.79610  4.50271079      Minnesota 1991 Female
    ## 1666      74.85562      68.72819  6.12743452      Minnesota 1991   Male
    ## 1667      81.38180      76.94616  4.43564245      Minnesota 1992 Female
    ## 1668      75.14013      68.87626  6.26387153      Minnesota 1992   Male
    ## 1669      81.27159      77.04118  4.23040700      Minnesota 1993 Female
    ## 1670      75.15878      68.96991  6.18886997      Minnesota 1993   Male
    ## 1671      81.38534      77.00134  4.38399967      Minnesota 1994 Female
    ## 1672      75.32773      69.11317  6.21456437      Minnesota 1994   Male
    ## 1673      81.33593      77.10647  4.22945806      Minnesota 1995 Female
    ## 1674      75.47810      69.41849  6.05961696      Minnesota 1995   Male
    ## 1675      81.54145      77.32857  4.21287529      Minnesota 1996 Female
    ## 1676      75.79956      69.78868  6.01087936      Minnesota 1996   Male
    ## 1677      81.69049      77.56879  4.12170414      Minnesota 1997 Female
    ## 1678      76.11965      70.17426  5.94538388      Minnesota 1997   Male
    ## 1679      81.71239      77.96271  3.74968234      Minnesota 1998 Female
    ## 1680      76.38798      70.50512  5.88286542      Minnesota 1998   Male
    ## 1681      81.58771      78.19754  3.39017513      Minnesota 1999 Female
    ## 1682      76.50716      70.91507  5.59209209      Minnesota 1999   Male
    ## 1683      81.78881      78.60698  3.18182588      Minnesota 2000 Female
    ## 1684      76.82021      71.44308  5.37713306      Minnesota 2000   Male
    ## 1685      81.94659      78.87066  3.07593470      Minnesota 2001 Female
    ## 1686      77.00262      72.07395  4.92867245      Minnesota 2001   Male
    ## 1687      82.00753      79.12161  2.88592351      Minnesota 2002 Female
    ## 1688      77.16654      72.70327  4.46327366      Minnesota 2002   Male
    ## 1689      82.31034      79.37344  2.93689955      Minnesota 2003 Female
    ## 1690      77.49746      73.43955  4.05790442      Minnesota 2003   Male
    ## 1691      82.58167      79.60820  2.97347567      Minnesota 2004 Female
    ## 1692      77.83716      73.94224  3.89491760      Minnesota 2004   Male
    ## 1693      82.62860      80.07669  2.55191011      Minnesota 2005 Female
    ## 1694      78.03065      74.34242  3.68823349      Minnesota 2005   Male
    ## 1695      82.94508      80.32056  2.62451232      Minnesota 2006 Female
    ## 1696      78.35532      74.76758  3.58774794      Minnesota 2006   Male
    ## 1697      83.12258      80.56984  2.55273719      Minnesota 2007 Female
    ## 1698      78.53077      75.15593  3.37484153      Minnesota 2007   Male
    ## 1699      83.04234      80.83069  2.21165489      Minnesota 2008 Female
    ## 1700      78.64241      75.67607  2.96634495      Minnesota 2008   Male
    ## 1701      83.31668      81.05762  2.25905283      Minnesota 2009 Female
    ## 1702      78.83302      76.23840  2.59462215      Minnesota 2009   Male
    ## 1703      83.21503      81.00308  2.21194630      Minnesota 2010 Female
    ## 1704      78.86720      76.60201  2.26518901      Minnesota 2010   Male
    ## 1705      83.19855      80.95826  2.24028353      Minnesota 2011 Female
    ## 1706      78.90815      76.72477  2.18337401      Minnesota 2011   Male
    ## 1707      83.32579      80.82376  2.50203940      Minnesota 2012 Female
    ## 1708      79.01163      76.64439  2.36724180      Minnesota 2012   Male
    ## 1709      83.40674      80.66777  2.73896435      Minnesota 2013 Female
    ## 1710      79.01646      76.52605  2.49040874      Minnesota 2013   Male
    ## 1711      75.46952      67.57617  7.89335282    Mississippi 1969 Female
    ## 1712      66.20184      59.68832  6.51352453    Mississippi 1969   Male
    ## 1713      75.70869      68.14007  7.56861463    Mississippi 1970 Female
    ## 1714      66.49737      60.04478  6.45258818    Mississippi 1970   Male
    ## 1715      76.11390      68.69301  7.42088757    Mississippi 1971 Female
    ## 1716      66.58658      60.73962  5.84696068    Mississippi 1971   Male
    ## 1717      76.32745      69.11493  7.21252416    Mississippi 1972 Female
    ## 1718      66.76901      61.06127  5.70774241    Mississippi 1972   Male
    ## 1719      76.52094      69.55386  6.96708185    Mississippi 1973 Female
    ## 1720      67.08012      61.29429  5.78583142    Mississippi 1973   Male
    ## 1721      76.90325      70.23664  6.66660820    Mississippi 1974 Female
    ## 1722      67.52818      62.14094  5.38723535    Mississippi 1974   Male
    ## 1723      77.30958      70.86197  6.44760217    Mississippi 1975 Female
    ## 1724      67.96457      62.52042  5.44415141    Mississippi 1975   Male
    ## 1725      77.49651      71.41056  6.08594921    Mississippi 1976 Female
    ## 1726      68.20629      63.03553  5.17076267    Mississippi 1976   Male
    ## 1727      77.74914      71.97851  5.77063238    Mississippi 1977 Female
    ## 1728      68.60135      63.54516  5.05619037    Mississippi 1977   Male
    ## 1729      77.95518      72.42943  5.52575393    Mississippi 1978 Female
    ## 1730      68.81977      63.81462  5.00515176    Mississippi 1978   Male
    ## 1731      78.18112      72.81052  5.37060415    Mississippi 1979 Female
    ## 1732      69.09681      63.92799  5.16881663    Mississippi 1979   Male
    ## 1733      78.26945      73.07882  5.19063249    Mississippi 1980 Female
    ## 1734      69.30843      64.08219  5.22624221    Mississippi 1980   Male
    ## 1735      78.35069      73.42897  4.92171560    Mississippi 1981 Female
    ## 1736      69.49028      64.56445  4.92583021    Mississippi 1981   Male
    ## 1737      78.44257      73.62763  4.81494242    Mississippi 1982 Female
    ## 1738      69.72662      64.94238  4.78424565    Mississippi 1982   Male
    ## 1739      78.48053      73.73430  4.74623456    Mississippi 1983 Female
    ## 1740      69.92182      65.13608  4.78574052    Mississippi 1983   Male
    ## 1741      78.53866      73.80320  4.73546010    Mississippi 1984 Female
    ## 1742      70.09166      65.18718  4.90448759    Mississippi 1984   Male
    ## 1743      78.55913      73.85391  4.70522051    Mississippi 1985 Female
    ## 1744      70.20992      65.15921  5.05071086    Mississippi 1985   Male
    ## 1745      78.64702      73.93538  4.71163450    Mississippi 1986 Female
    ## 1746      70.40747      65.29697  5.11050559    Mississippi 1986   Male
    ## 1747      78.67873      73.90506  4.77366728    Mississippi 1987 Female
    ## 1748      70.54605      65.21036  5.33568744    Mississippi 1987   Male
    ## 1749      78.72516      73.88233  4.84282892    Mississippi 1988 Female
    ## 1750      70.60360      65.19412  5.40947366    Mississippi 1988   Male
    ## 1751      78.74430      73.82918  4.91511994    Mississippi 1989 Female
    ## 1752      70.67081      65.10744  5.56337017    Mississippi 1989   Male
    ## 1753      78.90659      73.88493  5.02166211    Mississippi 1990 Female
    ## 1754      70.84812      64.91168  5.93644797    Mississippi 1990   Male
    ## 1755      78.91165      73.89382  5.01782379    Mississippi 1991 Female
    ## 1756      71.01991      64.87625  6.14366505    Mississippi 1991   Male
    ## 1757      79.03154      74.10207  4.92947515    Mississippi 1992 Female
    ## 1758      71.13471      64.96124  6.17346763    Mississippi 1992   Male
    ## 1759      78.94468      73.98893  4.95574465    Mississippi 1993 Female
    ## 1760      71.16932      64.89488  6.27443868    Mississippi 1993   Male
    ## 1761      78.84400      73.84440  4.99960036    Mississippi 1994 Female
    ## 1762      71.34075      65.02615  6.31460654    Mississippi 1994   Male
    ## 1763      78.86682      74.05679  4.81003021    Mississippi 1995 Female
    ## 1764      71.38878      65.22825  6.16053883    Mississippi 1995   Male
    ## 1765      78.85740      74.14372  4.71367688    Mississippi 1996 Female
    ## 1766      71.59256      65.48280  6.10976266    Mississippi 1996   Male
    ## 1767      78.75968      74.11502  4.64465064    Mississippi 1997 Female
    ## 1768      71.72058      65.70504  6.01553814    Mississippi 1997   Male
    ## 1769      78.75344      74.08789  4.66554657    Mississippi 1998 Female
    ## 1770      71.77711      66.03180  5.74531172    Mississippi 1998   Male
    ## 1771      78.64382      74.09512  4.54870301    Mississippi 1999 Female
    ## 1772      71.87260      66.38849  5.48410708    Mississippi 1999   Male
    ## 1773      78.47242      73.98563  4.48679196    Mississippi 2000 Female
    ## 1774      71.97711      66.68433  5.29278209    Mississippi 2000   Male
    ## 1775      78.42045      74.01042  4.41002452    Mississippi 2001 Female
    ## 1776      72.15961      66.83459  5.32501718    Mississippi 2001   Male
    ## 1777      78.36798      74.09194  4.27603418    Mississippi 2002 Female
    ## 1778      72.23008      66.93981  5.29026618    Mississippi 2002   Male
    ## 1779      78.43030      74.36437  4.06592653    Mississippi 2003 Female
    ## 1780      72.32295      67.09866  5.22429084    Mississippi 2003   Male
    ## 1781      78.61030      74.62328  3.98701758    Mississippi 2004 Female
    ## 1782      72.36008      67.29667  5.06341308    Mississippi 2004   Male
    ## 1783      78.49436      74.63981  3.85454178    Mississippi 2005 Female
    ## 1784      72.40963      67.28700  5.12262130    Mississippi 2005   Male
    ## 1785      78.68674      74.89540  3.79133612    Mississippi 2006 Female
    ## 1786      72.61307      67.51351  5.09955781    Mississippi 2006   Male
    ## 1787      78.77120      75.21565  3.55554647    Mississippi 2007 Female
    ## 1788      72.79973      67.91919  4.88053375    Mississippi 2007   Male
    ## 1789      78.66787      75.46688  3.20099011    Mississippi 2008 Female
    ## 1790      72.93315      68.29778  4.63536858    Mississippi 2008   Male
    ## 1791      78.78449      75.78071  3.00378292    Mississippi 2009 Female
    ## 1792      73.13477      68.63249  4.50228213    Mississippi 2009   Male
    ## 1793      78.62905      76.02174  2.60731597    Mississippi 2010 Female
    ## 1794      73.28523      68.94312  4.34211201    Mississippi 2010   Male
    ## 1795      78.63466      76.10624  2.52842354    Mississippi 2011 Female
    ## 1796      73.28844      69.23861  4.04983156    Mississippi 2011   Male
    ## 1797      78.61204      76.21842  2.39362345    Mississippi 2012 Female
    ## 1798      73.38563      69.32585  4.05978093    Mississippi 2012   Male
    ## 1799      78.54324      76.20253  2.34070491    Mississippi 2013 Female
    ## 1800      73.25964      69.33574  3.92389915    Mississippi 2013   Male
    ## 1801      75.50206      68.10073  7.40133677       Missouri 1969 Female
    ## 1802      67.64075      58.77064  8.87011750       Missouri 1969   Male
    ## 1803      75.78717      68.51868  7.26848479       Missouri 1970 Female
    ## 1804      67.90804      59.15211  8.75593071       Missouri 1970   Male
    ## 1805      75.96808      69.11687  6.85121566       Missouri 1971 Female
    ## 1806      68.19607      59.68773  8.50834254       Missouri 1971   Male
    ## 1807      76.14241      69.41219  6.73021653       Missouri 1972 Female
    ## 1808      68.26914      60.01542  8.25371741       Missouri 1972   Male
    ## 1809      76.47006      69.97165  6.49840648       Missouri 1973 Female
    ## 1810      68.47580      60.22716  8.24864077       Missouri 1973   Male
    ## 1811      76.77445      70.42845  6.34600069       Missouri 1974 Female
    ## 1812      68.89246      60.60620  8.28626397       Missouri 1974   Male
    ## 1813      77.34841      71.01153  6.33688033       Missouri 1975 Female
    ## 1814      69.29266      61.04655  8.24610428       Missouri 1975   Male
    ## 1815      77.56578      71.46282  6.10296063       Missouri 1976 Female
    ## 1816      69.57631      61.58649  7.98982304       Missouri 1976   Male
    ## 1817      77.82776      71.72852  6.09923765       Missouri 1977 Female
    ## 1818      69.88901      61.88270  8.00631580       Missouri 1977   Male
    ## 1819      78.03491      71.86976  6.16515182       Missouri 1978 Female
    ## 1820      70.08005      62.07856  8.00148995       Missouri 1978   Male
    ## 1821      78.29827      72.32024  5.97802305       Missouri 1979 Female
    ## 1822      70.44043      62.44596  7.99447470       Missouri 1979   Male
    ## 1823      78.32236      72.46398  5.85837656       Missouri 1980 Female
    ## 1824      70.62753      62.86124  7.76629056       Missouri 1980   Male
    ## 1825      78.55046      72.91249  5.63796685       Missouri 1981 Female
    ## 1826      70.90968      63.24443  7.66524816       Missouri 1981   Male
    ## 1827      78.77163      73.22009  5.55153829       Missouri 1982 Female
    ## 1828      71.27300      63.61004  7.66296573       Missouri 1982   Male
    ## 1829      78.78316      73.20652  5.57663590       Missouri 1983 Female
    ## 1830      71.41719      63.90977  7.50742734       Missouri 1983   Male
    ## 1831      78.93435      73.27857  5.65578294       Missouri 1984 Female
    ## 1832      71.59806      64.17755  7.42051478       Missouri 1984   Male
    ## 1833      78.85425      73.38734  5.46690284       Missouri 1985 Female
    ## 1834      71.67745      64.17758  7.49986977       Missouri 1985   Male
    ## 1835      78.97018      73.59128  5.37889025       Missouri 1986 Female
    ## 1836      71.82882      64.14046  7.68835614       Missouri 1986   Male
    ## 1837      79.03505      73.65586  5.37919614       Missouri 1987 Female
    ## 1838      71.93789      64.25550  7.68239369       Missouri 1987   Male
    ## 1839      79.17822      73.61600  5.56221984       Missouri 1988 Female
    ## 1840      72.04708      64.25715  7.78993075       Missouri 1988   Male
    ## 1841      79.39527      73.54932  5.84595191       Missouri 1989 Female
    ## 1842      72.31785      64.12874  8.18910606       Missouri 1989   Male
    ## 1843      79.55375      73.59671  5.95703970       Missouri 1990 Female
    ## 1844      72.47211      63.90693  8.56517975       Missouri 1990   Male
    ## 1845      79.70072      73.62830  6.07242193       Missouri 1991 Female
    ## 1846      72.55730      63.72329  8.83401438       Missouri 1991   Male
    ## 1847      79.66997      73.88781  5.78216633       Missouri 1992 Female
    ## 1848      72.74331      63.63163  9.11167446       Missouri 1992   Male
    ## 1849      79.39460      73.88314  5.51145403       Missouri 1993 Female
    ## 1850      72.65416      63.62371  9.03044958       Missouri 1993   Male
    ## 1851      79.34659      74.06989  5.27669729       Missouri 1994 Female
    ## 1852      72.82056      63.92292  8.89763868       Missouri 1994   Male
    ## 1853      79.32227      74.12195  5.20031239       Missouri 1995 Female
    ## 1854      72.96987      64.62221  8.34765975       Missouri 1995   Male
    ## 1855      79.34334      74.08464  5.25869837       Missouri 1996 Female
    ## 1856      73.27998      65.19364  8.08634181       Missouri 1996   Male
    ## 1857      79.35936      74.07563  5.28372787       Missouri 1997 Female
    ## 1858      73.44590      65.60313  7.84277059       Missouri 1997   Male
    ## 1859      79.29353      74.12648  5.16704574       Missouri 1998 Female
    ## 1860      73.61811      65.85915  7.75895952       Missouri 1998   Male
    ## 1861      79.22759      74.25020  4.97738761       Missouri 1999 Female
    ## 1862      73.76550      66.10342  7.66207971       Missouri 1999   Male
    ## 1863      79.28409      74.59261  4.69148312       Missouri 2000 Female
    ## 1864      74.01825      66.52969  7.48855647       Missouri 2000   Male
    ## 1865      79.35215      74.76448  4.58767148       Missouri 2001 Female
    ## 1866      74.12972      66.89888  7.23084733       Missouri 2001   Male
    ## 1867      79.34800      74.81915  4.52885287       Missouri 2002 Female
    ## 1868      74.10273      67.18177  6.92095423       Missouri 2002   Male
    ## 1869      79.44986      74.95350  4.49635940       Missouri 2003 Female
    ## 1870      74.33244      67.54361  6.78882606       Missouri 2003   Male
    ## 1871      79.73286      75.28616  4.44669760       Missouri 2004 Female
    ## 1872      74.59958      67.84408  6.75549803       Missouri 2004   Male
    ## 1873      79.81688      75.57352  4.24336000       Missouri 2005 Female
    ## 1874      74.70672      68.05890  6.64782591       Missouri 2005   Male
    ## 1875      79.94059      75.82134  4.11925202       Missouri 2006 Female
    ## 1876      74.92611      68.35313  6.57297685       Missouri 2006   Male
    ## 1877      80.10579      76.10543  4.00036000       Missouri 2007 Female
    ## 1878      75.07136      68.80700  6.26435504       Missouri 2007   Male
    ## 1879      79.93341      76.61573  3.31768263       Missouri 2008 Female
    ## 1880      75.00437      69.25698  5.74739177       Missouri 2008   Male
    ## 1881      80.28028      77.00520  3.27508103       Missouri 2009 Female
    ## 1882      75.29611      69.77446  5.52165342       Missouri 2009   Male
    ## 1883      80.31990      77.21260  3.10729503       Missouri 2010 Female
    ## 1884      75.44097      70.01981  5.42115342       Missouri 2010   Male
    ## 1885      80.35633      77.50098  2.85535042       Missouri 2011 Female
    ## 1886      75.51147      70.19247  5.31899937       Missouri 2011   Male
    ## 1887      80.51719      77.53567  2.98151178       Missouri 2012 Female
    ## 1888      75.61041      70.24458  5.36582656       Missouri 2012   Male
    ## 1889      80.44139      77.51734  2.92405296       Missouri 2013 Female
    ## 1890      75.62032      70.31347  5.30684869       Missouri 2013   Male
    ## 1891      77.24814      68.42541  8.82272986       Nebraska 1969 Female
    ## 1892      69.50782      62.81032  6.69750208       Nebraska 1969   Male
    ## 1893      77.33853      68.70230  8.63623786       Nebraska 1970 Female
    ## 1894      69.48326      63.07895  6.40431117       Nebraska 1970   Male
    ## 1895      77.50686      68.97752  8.52934099       Nebraska 1971 Female
    ## 1896      69.51083      63.33317  6.17765997       Nebraska 1971   Male
    ## 1897      77.58174      69.28761  8.29412604       Nebraska 1972 Female
    ## 1898      69.68754      63.50272  6.18481275       Nebraska 1972   Male
    ## 1899      77.93076      69.82340  8.10735854       Nebraska 1973 Female
    ## 1900      70.08984      63.76175  6.32809018       Nebraska 1973   Male
    ## 1901      78.18205      70.10349  8.07855672       Nebraska 1974 Female
    ## 1902      70.39791      63.95732  6.44059378       Nebraska 1974   Male
    ## 1903      78.75788      70.50450  8.25338021       Nebraska 1975 Female
    ## 1904      70.69358      64.27993  6.41364350       Nebraska 1975   Male
    ## 1905      78.84172      70.77904  8.06268201       Nebraska 1976 Female
    ## 1906      71.08490      64.78033  6.30456965       Nebraska 1976   Male
    ## 1907      79.23793      71.04352  8.19441402       Nebraska 1977 Female
    ## 1908      71.38676      65.09695  6.28980590       Nebraska 1977   Male
    ## 1909      79.45537      71.18347  8.27189774       Nebraska 1978 Female
    ## 1910      71.58436      65.37324  6.21111593       Nebraska 1978   Male
    ## 1911      79.68466      71.18021  8.50444847       Nebraska 1979 Female
    ## 1912      71.84188      65.64041  6.20147550       Nebraska 1979   Male
    ## 1913      79.77790      71.54485  8.23304812       Nebraska 1980 Female
    ## 1914      72.09011      65.80967  6.28044483       Nebraska 1980   Male
    ## 1915      79.85013      72.05491  7.79522404       Nebraska 1981 Female
    ## 1916      72.23983      65.96862  6.27120276       Nebraska 1981   Male
    ## 1917      79.95950      72.43209  7.52741139       Nebraska 1982 Female
    ## 1918      72.46581      66.09645  6.36936221       Nebraska 1982   Male
    ## 1919      80.03931      72.73797  7.30133979       Nebraska 1983 Female
    ## 1920      72.63179      66.26451  6.36727844       Nebraska 1983   Male
    ## 1921      80.10674      72.82886  7.27788415       Nebraska 1984 Female
    ## 1922      72.83546      66.34498  6.49047649       Nebraska 1984   Male
    ## 1923      80.18353      72.92035  7.26318432       Nebraska 1985 Female
    ## 1924      72.95953      66.37954  6.57998739       Nebraska 1985   Male
    ## 1925      80.32946      72.93675  7.39270945       Nebraska 1986 Female
    ## 1926      73.13940      66.45254  6.68685313       Nebraska 1986   Male
    ## 1927      80.33653      73.03184  7.30469335       Nebraska 1987 Female
    ## 1928      73.30098      66.56987  6.73111167       Nebraska 1987   Male
    ## 1929      80.39120      73.00233  7.38886877       Nebraska 1988 Female
    ## 1930      73.51704      66.76961  6.74743694       Nebraska 1988   Male
    ## 1931      80.47157      73.18413  7.28743919       Nebraska 1989 Female
    ## 1932      73.71505      66.92375  6.79130145       Nebraska 1989   Male
    ## 1933      80.64681      73.35799  7.28882611       Nebraska 1990 Female
    ## 1934      73.93430      66.94599  6.98831633       Nebraska 1990   Male
    ## 1935      80.68635      73.49679  7.18956028       Nebraska 1991 Female
    ## 1936      74.20633      66.91234  7.29399226       Nebraska 1991   Male
    ## 1937      80.76121      73.56501  7.19620815       Nebraska 1992 Female
    ## 1938      74.37141      66.98470  7.38671538       Nebraska 1992   Male
    ## 1939      80.82959      73.64050  7.18909684       Nebraska 1993 Female
    ## 1940      74.40322      67.07146  7.33175827       Nebraska 1993   Male
    ## 1941      80.83844      73.84271  6.99572704       Nebraska 1994 Female
    ## 1942      74.53546      67.40699  7.12846867       Nebraska 1994   Male
    ## 1943      80.75326      73.91961  6.83364814       Nebraska 1995 Female
    ## 1944      74.72713      67.62048  7.10664619       Nebraska 1995   Male
    ## 1945      80.73466      74.05935  6.67531015       Nebraska 1996 Female
    ## 1946      74.91074      67.85864  7.05210144       Nebraska 1996   Male
    ## 1947      80.91470      74.21805  6.69664934       Nebraska 1997 Female
    ## 1948      75.03022      68.11894  6.91127944       Nebraska 1997   Male
    ## 1949      80.90088      74.37270  6.52817755       Nebraska 1998 Female
    ## 1950      75.29998      68.42615  6.87383231       Nebraska 1998   Male
    ## 1951      80.88963      74.59684  6.29278509       Nebraska 1999 Female
    ## 1952      75.52205      68.80149  6.72056353       Nebraska 1999   Male
    ## 1953      81.05786      74.83037  6.22748430       Nebraska 2000 Female
    ## 1954      75.76345      69.11830  6.64515446       Nebraska 2000   Male
    ## 1955      81.01808      75.07834  5.93973321       Nebraska 2001 Female
    ## 1956      75.94376      69.40558  6.53817783       Nebraska 2001   Male
    ## 1957      80.99239      75.22023  5.77215323       Nebraska 2002 Female
    ## 1958      75.99735      69.76053  6.23681383       Nebraska 2002   Male
    ## 1959      81.15758      75.40199  5.75559700       Nebraska 2003 Female
    ## 1960      76.23050      70.12537  6.10513234       Nebraska 2003   Male
    ## 1961      81.56388      75.68022  5.88365988       Nebraska 2004 Female
    ## 1962      76.51777      70.45003  6.06773605       Nebraska 2004   Male
    ## 1963      81.62988      75.89302  5.73686603       Nebraska 2005 Female
    ## 1964      76.70273      70.66732  6.03541110       Nebraska 2005   Male
    ## 1965      81.70077      76.03292  5.66785182       Nebraska 2006 Female
    ## 1966      76.95119      70.85056  6.10063204       Nebraska 2006   Male
    ## 1967      81.65122      76.15356  5.49766273       Nebraska 2007 Female
    ## 1968      77.08632      70.94412  6.14219335       Nebraska 2007   Male
    ## 1969      81.69996      76.40868  5.29127584       Nebraska 2008 Female
    ## 1970      77.19344      71.13958  6.05386600       Nebraska 2008   Male
    ## 1971      81.99856      76.52357  5.47499458       Nebraska 2009 Female
    ## 1972      77.44873      71.23304  6.21568964       Nebraska 2009   Male
    ## 1973      82.09129      76.63733  5.45395815       Nebraska 2010 Female
    ## 1974      77.46908      71.32145  6.14762927       Nebraska 2010   Male
    ## 1975      82.01211      76.73388  5.27822306       Nebraska 2011 Female
    ## 1976      77.53370      71.42828  6.10542141       Nebraska 2011   Male
    ## 1977      82.08294      76.64954  5.43340296       Nebraska 2012 Female
    ## 1978      77.56306      71.47696  6.08609710       Nebraska 2012   Male
    ## 1979      82.02073      76.60734  5.41338752       Nebraska 2013 Female
    ## 1980      77.60440      71.47661  6.12779027       Nebraska 2013   Male
    ## 1981      74.86569      70.28738  4.57831206         Nevada 1969 Female
    ## 1982      66.80943      62.70328  4.10615150         Nevada 1969   Male
    ## 1983      74.92923      70.32045  4.60877647         Nevada 1970 Female
    ## 1984      66.95732      62.77975  4.17756552         Nevada 1970   Male
    ## 1985      75.11845      70.63759  4.48085687         Nevada 1971 Female
    ## 1986      67.30483      62.91042  4.39441619         Nevada 1971   Male
    ## 1987      75.40793      70.99658  4.41135447         Nevada 1972 Female
    ## 1988      67.64088      63.21196  4.42891893         Nevada 1972   Male
    ## 1989      75.72199      71.28343  4.43855938         Nevada 1973 Female
    ## 1990      67.85419      63.53379  4.32039695         Nevada 1973   Male
    ## 1991      76.11821      71.50242  4.61579453         Nevada 1974 Female
    ## 1992      68.17153      63.81264  4.35889241         Nevada 1974   Male
    ## 1993      76.42454      71.87947  4.54506683         Nevada 1975 Female
    ## 1994      68.48320      64.21654  4.26665769         Nevada 1975   Male
    ## 1995      76.68011      72.18457  4.49554471         Nevada 1976 Female
    ## 1996      68.74910      64.57699  4.17211574         Nevada 1976   Male
    ## 1997      76.89942      72.43185  4.46756350         Nevada 1977 Female
    ## 1998      69.03973      64.88089  4.15883264         Nevada 1977   Male
    ## 1999      77.03334      72.61999  4.41334636         Nevada 1978 Female
    ## 2000      69.38770      65.11270  4.27500044         Nevada 1978   Male
    ## 2001      77.05665      72.72553  4.33111941         Nevada 1979 Female
    ## 2002      69.60022      65.36098  4.23923873         Nevada 1979   Male
    ## 2003      77.20754      72.92805  4.27948478         Nevada 1980 Female
    ## 2004      69.80707      65.59159  4.21548222         Nevada 1980   Male
    ## 2005      77.42397      73.09654  4.32742057         Nevada 1981 Female
    ## 2006      70.04613      65.89967  4.14646579         Nevada 1981   Male
    ## 2007      77.40260      73.29305  4.10955572         Nevada 1982 Female
    ## 2008      70.22646      66.14691  4.07954645         Nevada 1982   Male
    ## 2009      77.43579      73.50235  3.93344348         Nevada 1983 Female
    ## 2010      70.47053      66.35510  4.11543181         Nevada 1983   Male
    ## 2011      77.48218      73.73464  3.74754399         Nevada 1984 Female
    ## 2012      70.56855      66.48911  4.07944482         Nevada 1984   Male
    ## 2013      77.54315      73.89023  3.65292165         Nevada 1985 Female
    ## 2014      70.67850      66.57127  4.10722358         Nevada 1985   Male
    ## 2015      77.63965      73.92051  3.71913803         Nevada 1986 Female
    ## 2016      70.92994      66.66544  4.26450418         Nevada 1986   Male
    ## 2017      77.78579      73.96424  3.82155226         Nevada 1987 Female
    ## 2018      71.06399      66.74026  4.32373882         Nevada 1987   Male
    ## 2019      77.97820      74.05505  3.92314387         Nevada 1988 Female
    ## 2020      71.15115      66.74897  4.40217629         Nevada 1988   Male
    ## 2021      78.18016      74.18870  3.99146653         Nevada 1989 Female
    ## 2022      71.36490      66.81462  4.55027729         Nevada 1989   Male
    ## 2023      78.27448      74.47936  3.79511947         Nevada 1990 Female
    ## 2024      71.48323      66.98276  4.50046695         Nevada 1990   Male
    ## 2025      78.41550      74.65414  3.76135774         Nevada 1991 Female
    ## 2026      71.60466      67.17752  4.42713646         Nevada 1991   Male
    ## 2027      78.60051      74.94792  3.65258312         Nevada 1992 Female
    ## 2028      71.81892      67.44010  4.37882007         Nevada 1992   Male
    ## 2029      78.47260      75.22233  3.25027430         Nevada 1993 Female
    ## 2030      71.94030      67.74306  4.19724047         Nevada 1993   Male
    ## 2031      78.60729      75.49966  3.10762568         Nevada 1994 Female
    ## 2032      72.08102      67.99214  4.08888055         Nevada 1994   Male
    ## 2033      78.76186      75.77805  2.98380562         Nevada 1995 Female
    ## 2034      72.24448      68.25367  3.99081043         Nevada 1995   Male
    ## 2035      78.79859      75.88907  2.90951686         Nevada 1996 Female
    ## 2036      72.54187      68.55917  3.98269827         Nevada 1996   Male
    ## 2037      78.84529      75.97961  2.86567101         Nevada 1997 Female
    ## 2038      72.90885      69.02673  3.88212040         Nevada 1997   Male
    ## 2039      78.75629      76.12411  2.63217598         Nevada 1998 Female
    ## 2040      73.12232      69.34502  3.77730704         Nevada 1998   Male
    ## 2041      78.78741      76.22399  2.56341655         Nevada 1999 Female
    ## 2042      73.24376      69.89216  3.35160046         Nevada 1999   Male
    ## 2043      78.84301      76.40965  2.43336525         Nevada 2000 Female
    ## 2044      73.45582      70.30988  3.14594431         Nevada 2000   Male
    ## 2045      78.79574      76.39204  2.40369361         Nevada 2001 Female
    ## 2046      73.60275      70.54229  3.06045264         Nevada 2001   Male
    ## 2047      78.72065      76.54248  2.17817942         Nevada 2002 Female
    ## 2048      73.75212      70.83031  2.92180913         Nevada 2002   Male
    ## 2049      78.77579      76.70730  2.06849594         Nevada 2003 Female
    ## 2050      73.77477      71.10333  2.67144052         Nevada 2003   Male
    ## 2051      78.96975      76.98938  1.98037206         Nevada 2004 Female
    ## 2052      73.92039      71.38124  2.53915336         Nevada 2004   Male
    ## 2053      79.06059      77.23266  1.82792293         Nevada 2005 Female
    ## 2054      74.01445      71.70245  2.31200080         Nevada 2005   Male
    ## 2055      79.32216      77.51784  1.80431231         Nevada 2006 Female
    ## 2056      74.27963      72.10351  2.17612699         Nevada 2006   Male
    ## 2057      79.70365      77.81328  1.89036763         Nevada 2007 Female
    ## 2058      74.61539      72.59335  2.02204174         Nevada 2007   Male
    ## 2059      79.78900      78.12802  1.66097543         Nevada 2008 Female
    ## 2060      74.84726      73.00650  1.84076774         Nevada 2008   Male
    ## 2061      80.02654      78.28952  1.73702195         Nevada 2009 Female
    ## 2062      75.11705      73.33594  1.78111033         Nevada 2009   Male
    ## 2063      80.06430      78.38771  1.67658938         Nevada 2010 Female
    ## 2064      75.33407      73.63418  1.69989354         Nevada 2010   Male
    ## 2065      80.08088      78.43701  1.64386253         Nevada 2011 Female
    ## 2066      75.48884      73.75643  1.73240971         Nevada 2011   Male
    ## 2067      80.20010      78.33543  1.86466048         Nevada 2012 Female
    ## 2068      75.62068      73.88215  1.73852502         Nevada 2012   Male
    ## 2069      80.23881      78.38831  1.85049604         Nevada 2013 Female
    ## 2070      75.71154      73.96840  1.74314402         Nevada 2013   Male
    ## 2071      75.17543      68.98153  6.19389303     New Jersey 1969 Female
    ## 2072      68.59000      59.93443  8.65557732     New Jersey 1969   Male
    ## 2073      75.41016      69.17415  6.23600739     New Jersey 1970 Female
    ## 2074      68.71106      60.19522  8.51583887     New Jersey 1970   Male
    ## 2075      75.66475      69.47844  6.18631185     New Jersey 1971 Female
    ## 2076      68.93482      60.72545  8.20936889     New Jersey 1971   Male
    ## 2077      75.92215      69.81095  6.11119647     New Jersey 1972 Female
    ## 2078      69.10725      61.14374  7.96351082     New Jersey 1972   Male
    ## 2079      76.26825      70.30010  5.96814722     New Jersey 1973 Female
    ## 2080      69.34500      61.82174  7.52326555     New Jersey 1973   Male
    ## 2081      76.70114      71.00979  5.69135427     New Jersey 1974 Female
    ## 2082      69.75644      62.37767  7.37877161     New Jersey 1974   Male
    ## 2083      77.16545      71.67051  5.49493360     New Jersey 1975 Female
    ## 2084      70.26603      63.06506  7.20097602     New Jersey 1975   Male
    ## 2085      77.38064      72.02789  5.35274893     New Jersey 1976 Female
    ## 2086      70.59917      63.42702  7.17215400     New Jersey 1976   Male
    ## 2087      77.66312      72.40604  5.25707651     New Jersey 1977 Female
    ## 2088      70.73979      63.79740  6.94238691     New Jersey 1977   Male
    ## 2089      77.88906      72.91773  4.97132670     New Jersey 1978 Female
    ## 2090      70.97833      64.11687  6.86146010     New Jersey 1978   Male
    ## 2091      78.10204      72.88783  5.21420645     New Jersey 1979 Female
    ## 2092      71.23229      64.28239  6.94989984     New Jersey 1979   Male
    ## 2093      77.94113      72.92356  5.01756827     New Jersey 1980 Female
    ## 2094      71.23106      64.41781  6.81325069     New Jersey 1980   Male
    ## 2095      78.25346      73.25031  5.00315220     New Jersey 1981 Female
    ## 2096      71.60433      64.76946  6.83486961     New Jersey 1981   Male
    ## 2097      78.38573      73.37513  5.01060107     New Jersey 1982 Female
    ## 2098      71.78529      64.85612  6.92917508     New Jersey 1982   Male
    ## 2099      78.38785      73.32443  5.06341394     New Jersey 1983 Female
    ## 2100      71.87911      64.89070  6.98840525     New Jersey 1983   Male
    ## 2101      78.50365      73.33971  5.16393212     New Jersey 1984 Female
    ## 2102      72.05627      64.69124  7.36503305     New Jersey 1984   Male
    ## 2103      78.64621      73.21178  5.43443188     New Jersey 1985 Female
    ## 2104      72.05608      64.34218  7.71390663     New Jersey 1985   Male
    ## 2105      78.62373      73.29208  5.33165366     New Jersey 1986 Female
    ## 2106      72.28569      64.00725  8.27844459     New Jersey 1986   Male
    ## 2107      78.80675      73.06192  5.74482412     New Jersey 1987 Female
    ## 2108      72.38005      63.55889  8.82115189     New Jersey 1987   Male
    ## 2109      78.76740      73.06930  5.69809636     New Jersey 1988 Female
    ## 2110      72.46738      63.51893  8.94844149     New Jersey 1988   Male
    ## 2111      79.12507      73.15528  5.96978732     New Jersey 1989 Female
    ## 2112      73.03094      63.57166  9.45928032     New Jersey 1989   Male
    ## 2113      79.45218      73.13401  6.31816591     New Jersey 1990 Female
    ## 2114      73.37114      64.05854  9.31260209     New Jersey 1990   Male
    ## 2115      79.73437      73.22375  6.51061591     New Jersey 1991 Female
    ## 2116      73.59037      64.08252  9.50784618     New Jersey 1991   Male
    ## 2117      79.87169      73.51608  6.35561076     New Jersey 1992 Female
    ## 2118      73.69077      64.41466  9.27611255     New Jersey 1992   Male
    ## 2119      79.85939      73.40367  6.45572514     New Jersey 1993 Female
    ## 2120      73.83648      64.22518  9.61130546     New Jersey 1993   Male
    ## 2121      80.06442      73.48360  6.58081286     New Jersey 1994 Female
    ## 2122      74.01853      64.64376  9.37476326     New Jersey 1994   Male
    ## 2123      80.00311      73.55841  6.44469616     New Jersey 1995 Female
    ## 2124      74.24897      65.21242  9.03654969     New Jersey 1995   Male
    ## 2125      80.17527      74.19488  5.98038369     New Jersey 1996 Female
    ## 2126      74.69527      66.12694  8.56833974     New Jersey 1996   Male
    ## 2127      80.34450      74.90243  5.44207657     New Jersey 1997 Female
    ## 2128      75.10769      67.66325  7.44444630     New Jersey 1997   Male
    ## 2129      80.51068      75.28729  5.22339448     New Jersey 1998 Female
    ## 2130      75.39919      68.40919  6.99000450     New Jersey 1998   Male
    ## 2131      80.47964      75.35735  5.12228808     New Jersey 1999 Female
    ## 2132      75.46412      68.48410  6.98002163     New Jersey 1999   Male
    ## 2133      80.52803      75.43079  5.09724624     New Jersey 2000 Female
    ## 2134      75.52913      68.66162  6.86750305     New Jersey 2000   Male
    ## 2135      80.68180      75.53879  5.14300965     New Jersey 2001 Female
    ## 2136      75.72264      68.99790  6.72474039     New Jersey 2001   Male
    ## 2137      80.80675      75.75693  5.04981964     New Jersey 2002 Female
    ## 2138      76.05173      69.55498  6.49675444     New Jersey 2002   Male
    ## 2139      81.03284      76.19360  4.83924015     New Jersey 2003 Female
    ## 2140      76.34887      69.77159  6.57727179     New Jersey 2003   Male
    ## 2141      81.33921      76.63807  4.70114139     New Jersey 2004 Female
    ## 2142      76.73047      70.35986  6.37061593     New Jersey 2004   Male
    ## 2143      81.51505      76.86382  4.65123986     New Jersey 2005 Female
    ## 2144      76.85539      70.73005  6.12533229     New Jersey 2005   Male
    ## 2145      81.89221      77.42586  4.46635057     New Jersey 2006 Female
    ## 2146      77.08125      71.24080  5.84044358     New Jersey 2006   Male
    ## 2147      82.08901      77.95220  4.13680482     New Jersey 2007 Female
    ## 2148      77.37341      71.71764  5.65577508     New Jersey 2007   Male
    ## 2149      82.23683      78.39961  3.83721466     New Jersey 2008 Female
    ## 2150      77.63730      72.05526  5.58204212     New Jersey 2008   Male
    ## 2151      82.56462      78.97497  3.58964886     New Jersey 2009 Female
    ## 2152      77.94665      72.62315  5.32349827     New Jersey 2009   Male
    ## 2153      82.66044      79.14567  3.51476596     New Jersey 2010 Female
    ## 2154      77.96115      72.93368  5.02746830     New Jersey 2010   Male
    ## 2155      82.64653      79.31533  3.33120181     New Jersey 2011 Female
    ## 2156      77.94513      73.29333  4.65180551     New Jersey 2011   Male
    ## 2157      82.73026      79.63083  3.09943119     New Jersey 2012 Female
    ## 2158      77.98975      73.72752  4.26223312     New Jersey 2012   Male
    ## 2159      82.76130      79.80197  2.95932760     New Jersey 2013 Female
    ## 2160      77.98886      73.80464  4.18422085     New Jersey 2013   Male
    ## 2161      75.65293      72.04185  3.61107568     New Mexico 1969 Female
    ## 2162      67.44933      64.08828  3.36104947     New Mexico 1969   Male
    ## 2163      75.91453      72.33693  3.57760488     New Mexico 1970 Female
    ## 2164      67.69568      64.14950  3.54617815     New Mexico 1970   Male
    ## 2165      76.16973      72.67729  3.49243727     New Mexico 1971 Female
    ## 2166      68.02418      64.59153  3.43265120     New Mexico 1971   Male
    ## 2167      76.42500      72.94481  3.48018822     New Mexico 1972 Female
    ## 2168      68.18579      64.90194  3.28384900     New Mexico 1972   Male
    ## 2169      76.77811      73.24354  3.53457181     New Mexico 1973 Female
    ## 2170      68.32073      65.12574  3.19499376     New Mexico 1973   Male
    ## 2171      77.14319      73.53817  3.60501720     New Mexico 1974 Female
    ## 2172      68.81312      65.50579  3.30732520     New Mexico 1974   Male
    ## 2173      77.57113      73.84624  3.72488580     New Mexico 1975 Female
    ## 2174      69.25822      65.82254  3.43568486     New Mexico 1975   Male
    ## 2175      77.89542      74.18168  3.71374390     New Mexico 1976 Female
    ## 2176      69.58714      66.03093  3.55621852     New Mexico 1976   Male
    ## 2177      78.38676      74.50785  3.87891072     New Mexico 1977 Female
    ## 2178      69.93073      66.14069  3.79004022     New Mexico 1977   Male
    ## 2179      78.61401      74.85513  3.75887812     New Mexico 1978 Female
    ## 2180      70.17215      66.45279  3.71935728     New Mexico 1978   Male
    ## 2181      78.76276      75.18009  3.58266633     New Mexico 1979 Female
    ## 2182      70.33613      67.03733  3.29880392     New Mexico 1979   Male
    ## 2183      78.83742      75.52349  3.31393881     New Mexico 1980 Female
    ## 2184      70.61287      67.53211  3.08075824     New Mexico 1980   Male
    ## 2185      79.11090      75.81346  3.29744596     New Mexico 1981 Female
    ## 2186      71.13653      67.97573  3.16080368     New Mexico 1981   Male
    ## 2187      79.11118      76.07708  3.03410058     New Mexico 1982 Female
    ## 2188      71.35781      68.37854  2.97926821     New Mexico 1982   Male
    ## 2189      79.20630      76.34564  2.86065039     New Mexico 1983 Female
    ## 2190      71.66804      68.72590  2.94213732     New Mexico 1983   Male
    ## 2191      79.22106      76.54355  2.67750920     New Mexico 1984 Female
    ## 2192      71.85517      69.05069  2.80448194     New Mexico 1984   Male
    ## 2193      79.37703      76.71048  2.66654403     New Mexico 1985 Female
    ## 2194      71.95840      69.38598  2.57241649     New Mexico 1985   Male
    ## 2195      79.42168      76.82730  2.59438038     New Mexico 1986 Female
    ## 2196      72.15089      69.70682  2.44407527     New Mexico 1986   Male
    ## 2197      79.43232      76.87931  2.55300766     New Mexico 1987 Female
    ## 2198      72.40753      69.95547  2.45205963     New Mexico 1987   Male
    ## 2199      79.59536      77.11042  2.48494265     New Mexico 1988 Female
    ## 2200      72.55739      70.14965  2.40773994     New Mexico 1988   Male
    ## 2201      79.65903      77.31220  2.34683205     New Mexico 1989 Female
    ## 2202      72.77040      70.32670  2.44370740     New Mexico 1989   Male
    ## 2203      79.78081      77.47655  2.30426360     New Mexico 1990 Female
    ## 2204      72.91290      70.42166  2.49123498     New Mexico 1990   Male
    ## 2205      79.92616      77.55508  2.37107608     New Mexico 1991 Female
    ## 2206      73.01737      70.46027  2.55710463     New Mexico 1991   Male
    ## 2207      80.12612      77.55023  2.57588873     New Mexico 1992 Female
    ## 2208      73.23355      70.74754  2.48601392     New Mexico 1992   Male
    ## 2209      80.05185      77.44964  2.60221340     New Mexico 1993 Female
    ## 2210      73.38817      71.20339  2.18477819     New Mexico 1993   Male
    ## 2211      80.10385      77.57957  2.52428641     New Mexico 1994 Female
    ## 2212      73.42743      71.60631  1.82111365     New Mexico 1994   Male
    ## 2213      80.16626      77.72820  2.43805890     New Mexico 1995 Female
    ## 2214      73.68253      71.97279  1.70973885     New Mexico 1995   Male
    ## 2215      80.40111      77.89771  2.50339848     New Mexico 1996 Female
    ## 2216      73.90569      72.31151  1.59418064     New Mexico 1996   Male
    ## 2217      80.50971      77.88527  2.62444533     New Mexico 1997 Female
    ## 2218      74.18765      72.66165  1.52599629     New Mexico 1997   Male
    ## 2219      80.44303      78.00498  2.43804517     New Mexico 1998 Female
    ## 2220      74.35830      73.00412  1.35418837     New Mexico 1998   Male
    ## 2221      80.36999      77.95128  2.41871205     New Mexico 1999 Female
    ## 2222      74.39921      73.28631  1.11290382     New Mexico 1999   Male
    ## 2223      80.55411      78.29950  2.25460578     New Mexico 2000 Female
    ## 2224      74.53677      73.63091  0.90586450     New Mexico 2000   Male
    ## 2225      80.42936      78.52611  1.90324747     New Mexico 2001 Female
    ## 2226      74.49840      73.93453  0.56386990     New Mexico 2001   Male
    ## 2227      80.57280      78.74244  1.83035161     New Mexico 2002 Female
    ## 2228      74.54826      74.25413  0.29412377     New Mexico 2002   Male
    ## 2229      80.47263      78.91920  1.55342701     New Mexico 2003 Female
    ## 2230      74.67275      74.54766  0.12508422     New Mexico 2003   Male
    ## 2231      80.69553      79.01229  1.68324451     New Mexico 2004 Female
    ## 2232      74.89897      74.79766  0.10130620     New Mexico 2004   Male
    ## 2233      80.73183      79.07197  1.65986017     New Mexico 2005 Female
    ## 2234      74.94744      74.99450 -0.04706211     New Mexico 2005   Male
    ## 2235      80.74617      79.23196  1.51420609     New Mexico 2006 Female
    ## 2236      75.07934      75.19011 -0.11077096     New Mexico 2006   Male
    ## 2237      80.97618      79.46051  1.51566723     New Mexico 2007 Female
    ## 2238      75.23459      75.37159 -0.13700106     New Mexico 2007   Male
    ## 2239      80.95047      79.68174  1.26872870     New Mexico 2008 Female
    ## 2240      75.39709      75.48420 -0.08711820     New Mexico 2008   Male
    ## 2241      81.24180      79.86868  1.37312753     New Mexico 2009 Female
    ## 2242      75.64905      75.55658  0.09247598     New Mexico 2009   Male
    ## 2243      81.21156      80.03603  1.17553040     New Mexico 2010 Female
    ## 2244      75.83999      75.64880  0.19119446     New Mexico 2010   Male
    ## 2245      81.28020      80.35811  0.92208386     New Mexico 2011 Female
    ## 2246      75.84450      75.67071  0.17378816     New Mexico 2011   Male
    ## 2247      81.38956      80.43808  0.95147387     New Mexico 2012 Female
    ## 2248      75.84026      75.67315  0.16711362     New Mexico 2012   Male
    ## 2249      81.50231      80.28480  1.21751076     New Mexico 2013 Female
    ## 2250      75.92597      75.62292  0.30305662     New Mexico 2013   Male
    ## 2251      74.77177      68.80853  5.96324217       New York 1969 Female
    ## 2252      67.89412      59.12958  8.76454113       New York 1969   Male
    ## 2253      75.03691      68.99503  6.04187966       New York 1970 Female
    ## 2254      68.10940      59.40992  8.69947658       New York 1970   Male
    ## 2255      75.41253      69.77666  5.63587500       New York 1971 Female
    ## 2256      68.42295      60.04676  8.37618572       New York 1971   Male
    ## 2257      75.64690      70.30149  5.34541721       New York 1972 Female
    ## 2258      68.61069      60.25841  8.35227382       New York 1972   Male
    ## 2259      75.99232      70.89921  5.09310406       New York 1973 Female
    ## 2260      68.90945      61.16708  7.74236565       New York 1973   Male
    ## 2261      76.41695      71.44916  4.96779282       New York 1974 Female
    ## 2262      69.35525      61.91816  7.43708769       New York 1974   Male
    ## 2263      77.15281      71.91122  5.24159082       New York 1975 Female
    ## 2264      69.86838      62.48181  7.38657001       New York 1975   Male
    ## 2265      76.98559      72.24115  4.74444692       New York 1976 Female
    ## 2266      70.08209      62.77411  7.30797835       New York 1976   Male
    ## 2267      77.42091      73.00716  4.41374198       New York 1977 Female
    ## 2268      70.36656      63.66603  6.70052990       New York 1977   Male
    ## 2269      77.69242      73.36440  4.32802328       New York 1978 Female
    ## 2270      70.60160      64.13274  6.46886395       New York 1978   Male
    ## 2271      77.94030      73.71219  4.22810840       New York 1979 Female
    ## 2272      70.91983      64.29126  6.62857159       New York 1979   Male
    ## 2273      77.72366      73.52266  4.20099338       New York 1980 Female
    ## 2274      70.81040      64.24756  6.56283127       New York 1980   Male
    ## 2275      78.06969      73.76846  4.30123067       New York 1981 Female
    ## 2276      71.10817      64.62675  6.48142190       New York 1981   Male
    ## 2277      78.18618      74.11867  4.06751131       New York 1982 Female
    ## 2278      71.28834      65.02494  6.26339414       New York 1982   Male
    ## 2279      78.15256      74.21053  3.94202674       New York 1983 Female
    ## 2280      71.38492      65.11332  6.27159601       New York 1983   Male
    ## 2281      78.12911      74.35214  3.77697582       New York 1984 Female
    ## 2282      71.46398      65.01082  6.45315948       New York 1984   Male
    ## 2283      78.26375      74.48376  3.77999650       New York 1985 Female
    ## 2284      71.40672      64.76632  6.64039513       New York 1985   Male
    ## 2285      78.36706      74.39936  3.96770125       New York 1986 Female
    ## 2286      71.35677      64.24373  7.11304351       New York 1986   Male
    ## 2287      78.46660      74.35783  4.10877358       New York 1987 Female
    ## 2288      71.33692      63.61066  7.72626471       New York 1987   Male
    ## 2289      78.44330      74.21668  4.22662345       New York 1988 Female
    ## 2290      71.45952      63.09761  8.36190648       New York 1988   Male
    ## 2291      78.80700      74.37942  4.42758628       New York 1989 Female
    ## 2292      71.72643      63.53504  8.19139134       New York 1989   Male
    ## 2293      79.11268      74.74737  4.36530765       New York 1990 Female
    ## 2294      72.02668      64.10431  7.92237307       New York 1990   Male
    ## 2295      79.31746      74.95787  4.35958986       New York 1991 Female
    ## 2296      72.28730      64.47879  7.80851041       New York 1991   Male
    ## 2297      79.49822      75.14663  4.35159242       New York 1992 Female
    ## 2298      72.48341      65.21384  7.26956934       New York 1992   Male
    ## 2299      79.35502      75.19301  4.16200197       New York 1993 Female
    ## 2300      72.54832      65.26497  7.28335091       New York 1993   Male
    ## 2301      79.57131      75.53208  4.03922814       New York 1994 Female
    ## 2302      72.86398      65.73880  7.12518643       New York 1994   Male
    ## 2303      79.61687      76.00189  3.61497729       New York 1995 Female
    ## 2304      73.24936      66.57029  6.67906920       New York 1995   Male
    ## 2305      79.84934      76.63131  3.21803705       New York 1996 Female
    ## 2306      73.99712      68.09106  5.90606330       New York 1996   Male
    ## 2307      80.23152      77.41333  2.81819249       New York 1997 Female
    ## 2308      74.73901      69.85494  4.88407211       New York 1997   Male
    ## 2309      80.36891      77.91515  2.45375910       New York 1998 Female
    ## 2310      75.25697      70.85449  4.40247673       New York 1998   Male
    ## 2311      80.45732      78.07086  2.38646267       New York 1999 Female
    ## 2312      75.33927      71.20604  4.13322684       New York 1999   Male
    ## 2313      80.71386      78.38202  2.33183536       New York 2000 Female
    ## 2314      75.56023      71.58596  3.97426862       New York 2000   Male
    ## 2315      80.82899      78.65097  2.17801833       New York 2001 Female
    ## 2316      75.63212      72.11719  3.51492931       New York 2001   Male
    ## 2317      80.94196      78.88431  2.05764393       New York 2002 Female
    ## 2318      75.95523      72.44581  3.50941426       New York 2002   Male
    ## 2319      81.19084      79.22370  1.96714178       New York 2003 Female
    ## 2320      76.38839      72.81796  3.57042516       New York 2003   Male
    ## 2321      81.51619      79.35223  2.16396186       New York 2004 Female
    ## 2322      76.78559      73.29557  3.49002028       New York 2004   Male
    ## 2323      81.65700      79.87517  1.78182834       New York 2005 Female
    ## 2324      76.97666      73.85112  3.12554202       New York 2005   Male
    ## 2325      82.01899      80.53477  1.48422213       New York 2006 Female
    ## 2326      77.23729      74.38315  2.85413720       New York 2006   Male
    ## 2327      82.29651      80.90390  1.39260614       New York 2007 Female
    ## 2328      77.54252      74.78135  2.76117342       New York 2007   Male
    ## 2329      82.35716      81.18952  1.16764242       New York 2008 Female
    ## 2330      77.67182      75.28263  2.38918596       New York 2008   Male
    ## 2331      82.68295      81.79951  0.88343801       New York 2009 Female
    ## 2332      77.91235      75.76133  2.15102573       New York 2009   Male
    ## 2333      82.76376      82.21586  0.54789914       New York 2010 Female
    ## 2334      78.16249      76.01691  2.14558329       New York 2010   Male
    ## 2335      82.75244      82.35031  0.40212777       New York 2011 Female
    ## 2336      78.12459      76.55076  1.57383154       New York 2011   Male
    ## 2337      82.93768      82.49453  0.44315030       New York 2012 Female
    ## 2338      78.22494      76.84051  1.38442568       New York 2012   Male
    ## 2339      82.94504      82.56889  0.37614476       New York 2013 Female
    ## 2340      78.24787      77.17407  1.07379967       New York 2013   Male
    ## 2341      75.67339      67.82466  7.84873682 North Carolina 1969 Female
    ## 2342      66.71705      58.38432  8.33273251 North Carolina 1969   Male
    ## 2343      75.98559      68.29737  7.68822129 North Carolina 1970 Female
    ## 2344      66.95425      58.63436  8.31989246 North Carolina 1970   Male
    ## 2345      76.26093      69.00569  7.25524169 North Carolina 1971 Female
    ## 2346      67.19364      59.27033  7.92330320 North Carolina 1971   Male
    ## 2347      76.23683      69.17144  7.06539340 North Carolina 1972 Female
    ## 2348      67.24319      59.31229  7.93090054 North Carolina 1972   Male
    ## 2349      76.42911      69.59626  6.83284973 North Carolina 1973 Female
    ## 2350      67.47228      59.93014  7.54214066 North Carolina 1973   Male
    ## 2351      77.05011      70.57200  6.47810795 North Carolina 1974 Female
    ## 2352      68.00883      60.62264  7.38619152 North Carolina 1974   Male
    ## 2353      77.80006      71.33180  6.46826177 North Carolina 1975 Female
    ## 2354      68.41906      61.33239  7.08667860 North Carolina 1975   Male
    ## 2355      77.89045      72.01387  5.87658526 North Carolina 1976 Female
    ## 2356      68.86287      62.00490  6.85797053 North Carolina 1976   Male
    ## 2357      78.25952      72.52879  5.73073438 North Carolina 1977 Female
    ## 2358      69.22165      62.22475  6.99690348 North Carolina 1977   Male
    ## 2359      78.48286      72.95253  5.53032565 North Carolina 1978 Female
    ## 2360      69.55555      62.53919  7.01636084 North Carolina 1978   Male
    ## 2361      78.75269      73.53229  5.22040170 North Carolina 1979 Female
    ## 2362      69.92510      63.03209  6.89301427 North Carolina 1979   Male
    ## 2363      78.89655      73.76869  5.12785331 North Carolina 1980 Female
    ## 2364      70.18349      63.43595  6.74754172 North Carolina 1980   Male
    ## 2365      78.95333      73.89408  5.05925306 North Carolina 1981 Female
    ## 2366      70.46265      63.84342  6.61922715 North Carolina 1981   Male
    ## 2367      79.17341      74.18017  4.99323907 North Carolina 1982 Female
    ## 2368      70.84681      64.29669  6.55012428 North Carolina 1982   Male
    ## 2369      79.22163      74.15694  5.06468347 North Carolina 1983 Female
    ## 2370      70.96080      64.49925  6.46154790 North Carolina 1983   Male
    ## 2371      79.25784      74.19615  5.06168773 North Carolina 1984 Female
    ## 2372      71.20107      64.58347  6.61760497 North Carolina 1984   Male
    ## 2373      79.15840      74.10916  5.04923366 North Carolina 1985 Female
    ## 2374      71.36183      64.52412  6.83770668 North Carolina 1985   Male
    ## 2375      79.11857      74.04874  5.06982901 North Carolina 1986 Female
    ## 2376      71.46189      64.49476  6.96713479 North Carolina 1986   Male
    ## 2377      79.16020      73.98854  5.17165121 North Carolina 1987 Female
    ## 2378      71.67199      64.43871  7.23328237 North Carolina 1987   Male
    ## 2379      79.17630      73.96587  5.21043303 North Carolina 1988 Female
    ## 2380      71.74438      64.29921  7.44516896 North Carolina 1988   Male
    ## 2381      79.43874      74.24924  5.18949751 North Carolina 1989 Female
    ## 2382      72.05249      64.39580  7.65668977 North Carolina 1989   Male
    ## 2383      79.70139      74.67162  5.02976369 North Carolina 1990 Female
    ## 2384      72.36601      64.58571  7.78030647 North Carolina 1990   Male
    ## 2385      79.76172      74.63720  5.12452139 North Carolina 1991 Female
    ## 2386      72.60720      64.68585  7.92134684 North Carolina 1991   Male
    ## 2387      79.92532      74.66982  5.25549741 North Carolina 1992 Female
    ## 2388      72.80171      64.82374  7.97797131 North Carolina 1992   Male
    ## 2389      79.84620      74.81588  5.03032467 North Carolina 1993 Female
    ## 2390      72.82276      64.83917  7.98359092 North Carolina 1993   Male
    ## 2391      79.92453      74.75117  5.17335698 North Carolina 1994 Female
    ## 2392      73.01731      65.03990  7.97740744 North Carolina 1994   Male
    ## 2393      79.92526      74.85382  5.07143951 North Carolina 1995 Female
    ## 2394      73.18726      65.37252  7.81474038 North Carolina 1995   Male
    ## 2395      79.93740      74.87370  5.06369926 North Carolina 1996 Female
    ## 2396      73.42770      65.88366  7.54403902 North Carolina 1996   Male
    ## 2397      79.98379      75.12270  4.86108205 North Carolina 1997 Female
    ## 2398      73.75931      66.58673  7.17258077 North Carolina 1997   Male
    ## 2399      79.95890      74.99579  4.96311186 North Carolina 1998 Female
    ## 2400      73.89064      66.89244  6.99819555 North Carolina 1998   Male
    ## 2401      79.72299      75.09644  4.62655243 North Carolina 1999 Female
    ## 2402      74.05939      67.27256  6.78682983 North Carolina 1999   Male
    ## 2403      79.57514      75.08700  4.48813403 North Carolina 2000 Female
    ## 2404      74.10171      67.52509  6.57662416 North Carolina 2000   Male
    ## 2405      79.82191      75.37070  4.45121112 North Carolina 2001 Female
    ## 2406      74.34739      67.97898  6.36841429 North Carolina 2001   Male
    ## 2407      79.81942      75.63323  4.18619850 North Carolina 2002 Female
    ## 2408      74.46431      68.43181  6.03249950 North Carolina 2002   Male
    ## 2409      79.84076      75.76991  4.07085166 North Carolina 2003 Female
    ## 2410      74.55506      68.82303  5.73202621 North Carolina 2003   Male
    ## 2411      80.15536      76.05790  4.09745903 North Carolina 2004 Female
    ## 2412      74.82903      69.10673  5.72229884 North Carolina 2004   Male
    ## 2413      80.12267      76.23312  3.88955494 North Carolina 2005 Female
    ## 2414      74.96323      69.46590  5.49733469 North Carolina 2005   Male
    ## 2415      80.43913      76.72602  3.71311531 North Carolina 2006 Female
    ## 2416      75.26691      69.77896  5.48794975 North Carolina 2006   Male
    ## 2417      80.56406      77.10857  3.45549719 North Carolina 2007 Female
    ## 2418      75.43201      70.18597  5.24603906 North Carolina 2007   Male
    ## 2419      80.58395      77.58862  2.99533148 North Carolina 2008 Female
    ## 2420      75.63075      70.74586  4.88489141 North Carolina 2008   Male
    ## 2421      80.88047      77.90454  2.97592729 North Carolina 2009 Female
    ## 2422      75.85884      71.31874  4.54010069 North Carolina 2009   Male
    ## 2423      80.91195      78.31986  2.59208821 North Carolina 2010 Female
    ## 2424      76.00563      71.74786  4.25777317 North Carolina 2010   Male
    ## 2425      80.91854      78.48836  2.43018025 North Carolina 2011 Female
    ## 2426      76.18593      72.09128  4.09465078 North Carolina 2011   Male
    ## 2427      80.90368      78.62720  2.27647540 North Carolina 2012 Female
    ## 2428      76.33916      72.22035  4.11881283 North Carolina 2012   Male
    ## 2429      81.04566      78.71510  2.33056164 North Carolina 2013 Female
    ## 2430      76.41847      72.30171  4.11676521 North Carolina 2013   Male
    ## 2431      74.96276      69.40115  5.56160901           Ohio 1969 Female
    ## 2432      67.69790      61.16654  6.53135338           Ohio 1969   Male
    ## 2433      75.23187      69.48350  5.74837212           Ohio 1970 Female
    ## 2434      67.94428      61.06199  6.88228832           Ohio 1970   Male
    ## 2435      75.50464      69.64442  5.86021333           Ohio 1971 Female
    ## 2436      68.22901      61.19352  7.03549062           Ohio 1971   Male
    ## 2437      75.56205      69.73236  5.82968335           Ohio 1972 Female
    ## 2438      68.27687      61.33894  6.93792571           Ohio 1972   Male
    ## 2439      75.79867      70.18131  5.61735705           Ohio 1973 Female
    ## 2440      68.46825      61.87264  6.59560369           Ohio 1973   Male
    ## 2441      76.23244      70.62341  5.60902836           Ohio 1974 Female
    ## 2442      68.85126      62.48908  6.36217479           Ohio 1974   Male
    ## 2443      76.76744      71.24963  5.51781272           Ohio 1975 Female
    ## 2444      69.27320      62.94236  6.33083640           Ohio 1975   Male
    ## 2445      76.95076      71.74345  5.20731396           Ohio 1976 Female
    ## 2446      69.55877      63.23533  6.32344092           Ohio 1976   Male
    ## 2447      77.15060      72.19711  4.95348490           Ohio 1977 Female
    ## 2448      69.72281      63.57020  6.15261194           Ohio 1977   Male
    ## 2449      77.38452      72.48950  4.89502370           Ohio 1978 Female
    ## 2450      69.99360      63.91245  6.08115138           Ohio 1978   Male
    ## 2451      77.68609      72.74968  4.93641347           Ohio 1979 Female
    ## 2452      70.28155      64.16942  6.11213482           Ohio 1979   Male
    ## 2453      77.64536      72.88977  4.75559331           Ohio 1980 Female
    ## 2454      70.42025      64.37445  6.04580504           Ohio 1980   Male
    ## 2455      77.94572      73.15888  4.78683390           Ohio 1981 Female
    ## 2456      70.80961      64.77637  6.03324390           Ohio 1981   Male
    ## 2457      78.28443      73.35927  4.92516572           Ohio 1982 Female
    ## 2458      71.22502      65.21374  6.01127689           Ohio 1982   Male
    ## 2459      78.21542      73.48159  4.73383324           Ohio 1983 Female
    ## 2460      71.32383      65.58944  5.73439103           Ohio 1983   Male
    ## 2461      78.35497      73.69468  4.66028729           Ohio 1984 Female
    ## 2462      71.52723      65.83590  5.69132494           Ohio 1984   Male
    ## 2463      78.31355      73.62955  4.68400430           Ohio 1985 Female
    ## 2464      71.63197      65.94331  5.68865407           Ohio 1985   Male
    ## 2465      78.40254      73.62083  4.78170831           Ohio 1986 Female
    ## 2466      71.75671      65.94575  5.81095903           Ohio 1986   Male
    ## 2467      78.51945      73.87029  4.64915378           Ohio 1987 Female
    ## 2468      72.05553      66.09386  5.96167466           Ohio 1987   Male
    ## 2469      78.61557      73.99339  4.62217623           Ohio 1988 Female
    ## 2470      72.25535      65.97062  6.28472817           Ohio 1988   Male
    ## 2471      78.88888      74.14263  4.74625534           Ohio 1989 Female
    ## 2472      72.57431      65.97342  6.60089435           Ohio 1989   Male
    ## 2473      79.06025      74.27002  4.79022746           Ohio 1990 Female
    ## 2474      72.75179      66.07001  6.68177327           Ohio 1990   Male
    ## 2475      79.16450      74.59620  4.56829711           Ohio 1991 Female
    ## 2476      72.87826      66.21043  6.66782834           Ohio 1991   Male
    ## 2477      79.36991      74.69517  4.67474017           Ohio 1992 Female
    ## 2478      73.14084      66.43244  6.70840345           Ohio 1992   Male
    ## 2479      79.24407      74.67544  4.56862737           Ohio 1993 Female
    ## 2480      73.16876      66.47096  6.69779250           Ohio 1993   Male
    ## 2481      79.25276      74.82551  4.42725074           Ohio 1994 Female
    ## 2482      73.30677      66.66607  6.64070686           Ohio 1994   Male
    ## 2483      79.16369      74.85055  4.31313079           Ohio 1995 Female
    ## 2484      73.41651      66.82777  6.58873902           Ohio 1995   Male
    ## 2485      79.31490      74.96989  4.34500793           Ohio 1996 Female
    ## 2486      73.71896      67.32626  6.39270774           Ohio 1996   Male
    ## 2487      79.36009      75.06076  4.29933066           Ohio 1997 Female
    ## 2488      73.87285      67.84383  6.02901286           Ohio 1997   Male
    ## 2489      79.32565      75.12099  4.20466227           Ohio 1998 Female
    ## 2490      74.10567      68.17947  5.92620010           Ohio 1998   Male
    ## 2491      79.22783      75.06734  4.16048992           Ohio 1999 Female
    ## 2492      74.18581      68.28327  5.90254707           Ohio 1999   Male
    ## 2493      79.32403      75.00964  4.31438662           Ohio 2000 Female
    ## 2494      74.36559      68.45759  5.90800583           Ohio 2000   Male
    ## 2495      79.40139      75.19796  4.20343022           Ohio 2001 Female
    ## 2496      74.46003      68.61798  5.84204929           Ohio 2001   Male
    ## 2497      79.38310      75.33234  4.05075672           Ohio 2002 Female
    ## 2498      74.53296      68.67842  5.85453571           Ohio 2002   Male
    ## 2499      79.50689      75.41907  4.08782472           Ohio 2003 Female
    ## 2500      74.76288      68.95587  5.80700666           Ohio 2003   Male
    ## 2501      79.87314      75.59310  4.28003686           Ohio 2004 Female
    ## 2502      74.98378      69.00051  5.98326595           Ohio 2004   Male
    ## 2503      79.85336      75.85732  3.99604445           Ohio 2005 Female
    ## 2504      74.94065      69.16750  5.77315109           Ohio 2005   Male
    ## 2505      80.12046      76.21911  3.90135354           Ohio 2006 Female
    ## 2506      75.23049      69.39549  5.83500144           Ohio 2006   Male
    ## 2507      80.26057      76.56644  3.69413152           Ohio 2007 Female
    ## 2508      75.41550      69.73274  5.68275266           Ohio 2007   Male
    ## 2509      80.17626      76.81474  3.36152024           Ohio 2008 Female
    ## 2510      75.43460      70.05548  5.37912403           Ohio 2008   Male
    ## 2511      80.48130      77.08867  3.39262749           Ohio 2009 Female
    ## 2512      75.72366      70.57030  5.15336541           Ohio 2009   Male
    ## 2513      80.39009      77.30825  3.08184361           Ohio 2010 Female
    ## 2514      75.74796      70.84724  4.90072786           Ohio 2010   Male
    ## 2515      80.22522      77.39537  2.82985629           Ohio 2011 Female
    ## 2516      75.71813      71.03208  4.68605118           Ohio 2011   Male
    ## 2517      80.23427      77.49814  2.73613450           Ohio 2012 Female
    ## 2518      75.69698      71.28687  4.41011342           Ohio 2012   Male
    ## 2519      80.29656      77.47544  2.82111889           Ohio 2013 Female
    ## 2520      75.74172      71.27300  4.46872169           Ohio 2013   Male
    ## 2521      76.22547      71.68400  4.54147461       Oklahoma 1969 Female
    ## 2522      67.84580      62.42981  5.41598419       Oklahoma 1969   Male
    ## 2523      76.38453      71.76082  4.62371142       Oklahoma 1970 Female
    ## 2524      67.86563      62.59805  5.26757629       Oklahoma 1970   Male
    ## 2525      76.65056      71.90701  4.74355024       Oklahoma 1971 Female
    ## 2526      68.22926      62.93714  5.29212593       Oklahoma 1971   Male
    ## 2527      76.67816      72.05670  4.62145551       Oklahoma 1972 Female
    ## 2528      68.25415      63.23970  5.01444086       Oklahoma 1972   Male
    ## 2529      76.85431      72.24310  4.61120446       Oklahoma 1973 Female
    ## 2530      68.34794      63.50475  4.84319131       Oklahoma 1973   Male
    ## 2531      77.02542      72.44060  4.58481775       Oklahoma 1974 Female
    ## 2532      68.58936      63.58188  5.00748270       Oklahoma 1974   Male
    ## 2533      77.40984      72.72846  4.68138246       Oklahoma 1975 Female
    ## 2534      68.79255      63.77184  5.02070350       Oklahoma 1975   Male
    ## 2535      77.61434      72.88339  4.73095278       Oklahoma 1976 Female
    ## 2536      69.11127      64.15829  4.95297885       Oklahoma 1976   Male
    ## 2537      77.86440      73.09433  4.77006185       Oklahoma 1977 Female
    ## 2538      69.45950      64.55103  4.90847096       Oklahoma 1977   Male
    ## 2539      77.91787      73.13091  4.78696820       Oklahoma 1978 Female
    ## 2540      69.58109      64.72672  4.85436974       Oklahoma 1978   Male
    ## 2541      78.07708      73.21979  4.85729539       Oklahoma 1979 Female
    ## 2542      69.73075      64.86536  4.86539062       Oklahoma 1979   Male
    ## 2543      78.21941      73.36539  4.85402399       Oklahoma 1980 Female
    ## 2544      69.88794      65.12680  4.76114231       Oklahoma 1980   Male
    ## 2545      78.31459      73.60270  4.71188912       Oklahoma 1981 Female
    ## 2546      70.04281      65.44695  4.59586244       Oklahoma 1981   Male
    ## 2547      78.35684      73.73770  4.61914757       Oklahoma 1982 Female
    ## 2548      70.20178      65.77548  4.42629980       Oklahoma 1982   Male
    ## 2549      78.41988      73.81595  4.60393142       Oklahoma 1983 Female
    ## 2550      70.57365      66.11178  4.46186021       Oklahoma 1983   Male
    ## 2551      78.50075      73.89255  4.60820133       Oklahoma 1984 Female
    ## 2552      70.83287      66.33645  4.49641980       Oklahoma 1984   Male
    ## 2553      78.51151      73.96461  4.54690529       Oklahoma 1985 Female
    ## 2554      70.97181      66.52915  4.44265637       Oklahoma 1985   Male
    ## 2555      78.57572      74.11398  4.46173533       Oklahoma 1986 Female
    ## 2556      71.18319      66.71330  4.46988407       Oklahoma 1986   Male
    ## 2557      78.69693      74.21252  4.48441191       Oklahoma 1987 Female
    ## 2558      71.45943      66.92087  4.53856758       Oklahoma 1987   Male
    ## 2559      78.59018      74.27822  4.31195209       Oklahoma 1988 Female
    ## 2560      71.52796      67.03141  4.49655425       Oklahoma 1988   Male
    ## 2561      78.64198      74.24688  4.39509746       Oklahoma 1989 Female
    ## 2562      71.64982      67.07964  4.57018282       Oklahoma 1989   Male
    ## 2563      78.59394      74.34371  4.25022847       Oklahoma 1990 Female
    ## 2564      71.67710      67.14140  4.53569624       Oklahoma 1990   Male
    ## 2565      78.73001      74.32586  4.40414499       Oklahoma 1991 Female
    ## 2566      71.79887      67.19195  4.60691669       Oklahoma 1991   Male
    ## 2567      78.75923      74.33741  4.42182673       Oklahoma 1992 Female
    ## 2568      71.84358      67.23353  4.61004706       Oklahoma 1992   Male
    ## 2569      78.54914      74.33909  4.21004560       Oklahoma 1993 Female
    ## 2570      71.73562      67.24158  4.49403159       Oklahoma 1993   Male
    ## 2571      78.57559      74.39673  4.17885816       Oklahoma 1994 Female
    ## 2572      71.75379      67.38341  4.37038645       Oklahoma 1994   Male
    ## 2573      78.48250      74.37231  4.11018694       Oklahoma 1995 Female
    ## 2574      71.83303      67.55405  4.27897248       Oklahoma 1995   Male
    ## 2575      78.39124      74.28598  4.10525516       Oklahoma 1996 Female
    ## 2576      72.02480      67.72161  4.30318815       Oklahoma 1996   Male
    ## 2577      78.33564      74.22963  4.10601460       Oklahoma 1997 Female
    ## 2578      72.18155      67.92111  4.26043803       Oklahoma 1997   Male
    ## 2579      78.27505      74.21928  4.05576611       Oklahoma 1998 Female
    ## 2580      72.33990      68.11744  4.22245934       Oklahoma 1998   Male
    ## 2581      78.12508      74.14770  3.97738182       Oklahoma 1999 Female
    ## 2582      72.48029      68.21036  4.26992853       Oklahoma 1999   Male
    ## 2583      78.01745      74.17989  3.83756449       Oklahoma 2000 Female
    ## 2584      72.57104      68.39106  4.17997278       Oklahoma 2000   Male
    ## 2585      78.08762      74.10742  3.98019562       Oklahoma 2001 Female
    ## 2586      72.68109      68.60604  4.07505382       Oklahoma 2001   Male
    ## 2587      77.99523      74.12658  3.86865124       Oklahoma 2002 Female
    ## 2588      72.72431      68.64948  4.07482440       Oklahoma 2002   Male
    ## 2589      77.98708      74.16633  3.82075438       Oklahoma 2003 Female
    ## 2590      72.79376      68.69150  4.10225773       Oklahoma 2003   Male
    ## 2591      78.21307      74.25912  3.95395098       Oklahoma 2004 Female
    ## 2592      73.00119      68.74121  4.25998559       Oklahoma 2004   Male
    ## 2593      78.08582      74.38081  3.70501542       Oklahoma 2005 Female
    ## 2594      73.03084      68.87096  4.15988485       Oklahoma 2005   Male
    ## 2595      78.25780      74.56994  3.68785895       Oklahoma 2006 Female
    ## 2596      73.19013      68.99449  4.19564800       Oklahoma 2006   Male
    ## 2597      78.23813      74.78007  3.45806267       Oklahoma 2007 Female
    ## 2598      73.29526      69.12728  4.16798810       Oklahoma 2007   Male
    ## 2599      78.23319      75.00159  3.23160251       Oklahoma 2008 Female
    ## 2600      73.37052      69.31130  4.05922069       Oklahoma 2008   Male
    ## 2601      78.57186      75.15815  3.41371552       Oklahoma 2009 Female
    ## 2602      73.58805      69.49876  4.08928359       Oklahoma 2009   Male
    ## 2603      78.54937      75.27140  3.27796803       Oklahoma 2010 Female
    ## 2604      73.67333      69.69734  3.97598819       Oklahoma 2010   Male
    ## 2605      78.54119      75.42879  3.11240448       Oklahoma 2011 Female
    ## 2606      73.70959      69.85108  3.85851185       Oklahoma 2011   Male
    ## 2607      78.61890      75.58297  3.03593332       Oklahoma 2012 Female
    ## 2608      73.83770      69.93608  3.90161874       Oklahoma 2012   Male
    ## 2609      78.53470      75.64976  2.88493804       Oklahoma 2013 Female
    ## 2610      73.77330      69.84791  3.92539323       Oklahoma 2013   Male
    ## 2611      76.55848      73.12495  3.43353001         Oregon 1969 Female
    ## 2612      68.64283      62.13690  6.50593281         Oregon 1969   Male
    ## 2613      76.83822      73.27793  3.56028749         Oregon 1970 Female
    ## 2614      68.86845      62.33557  6.53287695         Oregon 1970   Male
    ## 2615      76.90524      73.38227  3.52297443         Oregon 1971 Female
    ## 2616      68.97930      62.43945  6.53984163         Oregon 1971   Male
    ## 2617      77.04991      73.41332  3.63658480         Oregon 1972 Female
    ## 2618      69.11733      62.72272  6.39461030         Oregon 1972   Male
    ## 2619      77.16144      73.58607  3.57536940         Oregon 1973 Female
    ## 2620      69.34508      63.03878  6.30629910         Oregon 1973   Male
    ## 2621      77.62058      73.69308  3.92750008         Oregon 1974 Female
    ## 2622      69.70051      63.41010  6.29041167         Oregon 1974   Male
    ## 2623      77.92699      73.80208  4.12490435         Oregon 1975 Female
    ## 2624      70.12100      63.78381  6.33718993         Oregon 1975   Male
    ## 2625      78.17493      73.86532  4.30961916         Oregon 1976 Female
    ## 2626      70.44112      64.08088  6.36023971         Oregon 1976   Male
    ## 2627      78.52608      74.04157  4.48450678         Oregon 1977 Female
    ## 2628      70.79645      64.32411  6.47233945         Oregon 1977   Male
    ## 2629      78.70490      74.20479  4.50010567         Oregon 1978 Female
    ## 2630      71.06317      64.56751  6.49566224         Oregon 1978   Male
    ## 2631      79.00710      74.36600  4.64110245         Oregon 1979 Female
    ## 2632      71.27548      64.78264  6.49283803         Oregon 1979   Male
    ## 2633      79.04881      74.44237  4.60643426         Oregon 1980 Female
    ## 2634      71.46871      65.01498  6.45373635         Oregon 1980   Male
    ## 2635      79.19654      74.52888  4.66766147         Oregon 1981 Female
    ## 2636      71.78808      65.21309  6.57499208         Oregon 1981   Male
    ## 2637      79.34453      74.54592  4.79861530         Oregon 1982 Female
    ## 2638      72.13645      65.44838  6.68807222         Oregon 1982   Male
    ## 2639      79.20843      74.59078  4.61765872         Oregon 1983 Female
    ## 2640      72.24789      65.75966  6.48822629         Oregon 1983   Male
    ## 2641      79.21944      74.55589  4.66355508         Oregon 1984 Female
    ## 2642      72.25365      65.99130  6.26235436         Oregon 1984   Male
    ## 2643      79.18246      74.51912  4.66334077         Oregon 1985 Female
    ## 2644      72.23911      66.17677  6.06234317         Oregon 1985   Male
    ## 2645      79.40838      74.65883  4.74955607         Oregon 1986 Female
    ## 2646      72.48711      66.36642  6.12068860         Oregon 1986   Male
    ## 2647      79.29606      74.75972  4.53633722         Oregon 1987 Female
    ## 2648      72.61335      66.46024  6.15311402         Oregon 1987   Male
    ## 2649      79.31896      74.91190  4.40706455         Oregon 1988 Female
    ## 2650      72.85860      66.60128  6.25732455         Oregon 1988   Male
    ## 2651      79.49986      75.05971  4.44014654         Oregon 1989 Female
    ## 2652      73.08921      66.68878  6.40043131         Oregon 1989   Male
    ## 2653      79.68612      75.24536  4.44076275         Oregon 1990 Female
    ## 2654      73.32786      66.96347  6.36438669         Oregon 1990   Male
    ## 2655      79.92810      75.40091  4.52718648         Oregon 1991 Female
    ## 2656      73.66278      67.21806  6.44472089         Oregon 1991   Male
    ## 2657      79.89290      75.57453  4.31837029         Oregon 1992 Female
    ## 2658      73.83716      67.49625  6.34091008         Oregon 1992   Male
    ## 2659      79.74289      75.69494  4.04794840         Oregon 1993 Female
    ## 2660      73.76856      67.85614  5.91242289         Oregon 1993   Male
    ## 2661      79.80753      75.88090  3.92663344         Oregon 1994 Female
    ## 2662      73.98147      68.36464  5.61683781         Oregon 1994   Male
    ## 2663      79.85216      76.06321  3.78894536         Oregon 1995 Female
    ## 2664      74.13587      68.75392  5.38195108         Oregon 1995   Male
    ## 2665      79.84712      76.25365  3.59346474         Oregon 1996 Female
    ## 2666      74.34467      69.12252  5.22214853         Oregon 1996   Male
    ## 2667      79.90530      76.43141  3.47388636         Oregon 1997 Female
    ## 2668      74.71235      69.50446  5.20788545         Oregon 1997   Male
    ## 2669      79.98439      76.64291  3.34147933         Oregon 1998 Female
    ## 2670      74.91279      69.84841  5.06437877         Oregon 1998   Male
    ## 2671      79.96609      76.82667  3.13942023         Oregon 1999 Female
    ## 2672      75.25645      70.21085  5.04560292         Oregon 1999   Male
    ## 2673      80.06700      76.99204  3.07495460         Oregon 2000 Female
    ## 2674      75.42636      70.64704  4.77932083         Oregon 2000   Male
    ## 2675      80.05715      77.15156  2.90559470         Oregon 2001 Female
    ## 2676      75.54069      71.15652  4.38417338         Oregon 2001   Male
    ## 2677      80.09018      77.37222  2.71796137         Oregon 2002 Female
    ## 2678      75.54217      71.64146  3.90070915         Oregon 2002   Male
    ## 2679      80.29416      77.61326  2.68090403         Oregon 2003 Female
    ## 2680      75.80535      72.01807  3.78727783         Oregon 2003   Male
    ## 2681      80.60977      77.87622  2.73355114         Oregon 2004 Female
    ## 2682      76.08299      72.53725  3.54574151         Oregon 2004   Male
    ## 2683      80.61039      78.15117  2.45922503         Oregon 2005 Female
    ## 2684      76.22764      73.00141  3.22623782         Oregon 2005   Male
    ## 2685      80.83462      78.40150  2.43312087         Oregon 2006 Female
    ## 2686      76.39387      73.41787  2.97599827         Oregon 2006   Male
    ## 2687      81.10656      78.50778  2.59877211         Oregon 2007 Female
    ## 2688      76.57630      73.67010  2.90619828         Oregon 2007   Male
    ## 2689      81.27753      78.52261  2.75492379         Oregon 2008 Female
    ## 2690      76.69142      73.98887  2.70255295         Oregon 2008   Male
    ## 2691      81.51264      78.63792  2.87471779         Oregon 2009 Female
    ## 2692      76.96212      74.17859  2.78352463         Oregon 2009   Male
    ## 2693      81.58898      78.63050  2.95847869         Oregon 2010 Female
    ## 2694      77.15739      74.27282  2.88457058         Oregon 2010   Male
    ## 2695      81.59710      78.72846  2.86864546         Oregon 2011 Female
    ## 2696      77.20956      74.29789  2.91166867         Oregon 2011   Male
    ## 2697      81.71447      78.77395  2.94051462         Oregon 2012 Female
    ## 2698      77.36338      74.25699  3.10639113         Oregon 2012   Male
    ## 2699      81.64670      78.75571  2.89098855         Oregon 2013 Female
    ## 2700      77.29609      74.19202  3.10407297         Oregon 2013   Male
    ## 2701      74.68229      67.81487  6.86742137   Pennsylvania 1969 Female
    ## 2702      67.57304      58.92030  8.65274251   Pennsylvania 1969   Male
    ## 2703      74.85040      67.94882  6.90158011   Pennsylvania 1970 Female
    ## 2704      67.80017      58.73002  9.07014296   Pennsylvania 1970   Male
    ## 2705      75.16824      68.39451  6.77373506   Pennsylvania 1971 Female
    ## 2706      68.05006      58.98925  9.06081552   Pennsylvania 1971   Male
    ## 2707      75.44055      68.67722  6.76333750   Pennsylvania 1972 Female
    ## 2708      68.17118      59.19834  8.97284081   Pennsylvania 1972   Male
    ## 2709      75.82182      69.18033  6.64149428   Pennsylvania 1973 Female
    ## 2710      68.33526      59.62244  8.71281859   Pennsylvania 1973   Male
    ## 2711      76.25016      69.81586  6.43430373   Pennsylvania 1974 Female
    ## 2712      68.83473      59.80041  9.03431962   Pennsylvania 1974   Male
    ## 2713      76.75582      70.25393  6.50189415   Pennsylvania 1975 Female
    ## 2714      69.23277      60.57562  8.65715466   Pennsylvania 1975   Male
    ## 2715      76.89345      70.60534  6.28811694   Pennsylvania 1976 Female
    ## 2716      69.48136      61.20109  8.28027828   Pennsylvania 1976   Male
    ## 2717      77.28784      71.09920  6.18864249   Pennsylvania 1977 Female
    ## 2718      69.86380      61.62196  8.24183760   Pennsylvania 1977   Male
    ## 2719      77.48338      71.73459  5.74879738   Pennsylvania 1978 Female
    ## 2720      70.05173      62.28304  7.76868797   Pennsylvania 1978   Male
    ## 2721      77.74621      72.23478  5.51143718   Pennsylvania 1979 Female
    ## 2722      70.39520      62.70570  7.68949652   Pennsylvania 1979   Male
    ## 2723      77.62138      72.27466  5.34671662   Pennsylvania 1980 Female
    ## 2724      70.40592      62.88733  7.51858936   Pennsylvania 1980   Male
    ## 2725      77.98007      72.53757  5.44249342   Pennsylvania 1981 Female
    ## 2726      70.87861      63.41370  7.46490344   Pennsylvania 1981   Male
    ## 2727      78.26052      72.71841  5.54211172   Pennsylvania 1982 Female
    ## 2728      71.21245      63.77940  7.43305048   Pennsylvania 1982   Male
    ## 2729      78.26979      72.68383  5.58595588   Pennsylvania 1983 Female
    ## 2730      71.36312      64.01498  7.34814044   Pennsylvania 1983   Male
    ## 2731      78.42588      72.53201  5.89387959   Pennsylvania 1984 Female
    ## 2732      71.53510      64.03341  7.50169355   Pennsylvania 1984   Male
    ## 2733      78.42431      72.58860  5.83571208   Pennsylvania 1985 Female
    ## 2734      71.65316      63.78613  7.86703573   Pennsylvania 1985   Male
    ## 2735      78.55436      72.63500  5.91935394   Pennsylvania 1986 Female
    ## 2736      71.80540      63.60134  8.20406262   Pennsylvania 1986   Male
    ## 2737      78.64305      72.47408  6.16896584   Pennsylvania 1987 Female
    ## 2738      72.00868      63.29018  8.71850469   Pennsylvania 1987   Male
    ## 2739      78.76495      72.48131  6.28364024   Pennsylvania 1988 Female
    ## 2740      72.18054      63.29782  8.88272236   Pennsylvania 1988   Male
    ## 2741      79.14153      72.71773  6.42380653   Pennsylvania 1989 Female
    ## 2742      72.53272      63.11616  9.41656048   Pennsylvania 1989   Male
    ## 2743      79.41793      73.15034  6.26759379   Pennsylvania 1990 Female
    ## 2744      72.85033      63.45282  9.39750751   Pennsylvania 1990   Male
    ## 2745      79.55060      73.48331  6.06728862   Pennsylvania 1991 Female
    ## 2746      73.06451      63.74873  9.31578162   Pennsylvania 1991   Male
    ## 2747      79.67601      73.57038  6.10563447   Pennsylvania 1992 Female
    ## 2748      73.24197      63.76729  9.47467731   Pennsylvania 1992   Male
    ## 2749      79.66018      73.67424  5.98593781   Pennsylvania 1993 Female
    ## 2750      73.32919      63.58265  9.74654094   Pennsylvania 1993   Male
    ## 2751      79.60337      73.90976  5.69360589   Pennsylvania 1994 Female
    ## 2752      73.46213      63.74905  9.71308485   Pennsylvania 1994   Male
    ## 2753      79.78023      74.08780  5.69243324   Pennsylvania 1995 Female
    ## 2754      73.60590      64.17969  9.42621140   Pennsylvania 1995   Male
    ## 2755      79.77682      74.25043  5.52638928   Pennsylvania 1996 Female
    ## 2756      73.78983      64.76426  9.02557325   Pennsylvania 1996   Male
    ## 2757      79.91225      74.43698  5.47527105   Pennsylvania 1997 Female
    ## 2758      74.16304      65.58670  8.57633519   Pennsylvania 1997   Male
    ## 2759      80.08345      74.69052  5.39293243   Pennsylvania 1998 Female
    ## 2760      74.42924      66.25074  8.17850062   Pennsylvania 1998   Male
    ## 2761      79.95568      74.52317  5.43251517   Pennsylvania 1999 Female
    ## 2762      74.55240      66.54737  8.00503536   Pennsylvania 1999   Male
    ## 2763      79.97275      74.67054  5.30221527   Pennsylvania 2000 Female
    ## 2764      74.67231      66.81919  7.85312002   Pennsylvania 2000   Male
    ## 2765      80.08902      74.91478  5.17423235   Pennsylvania 2001 Female
    ## 2766      74.81120      67.22626  7.58494438   Pennsylvania 2001   Male
    ## 2767      80.14503      75.03879  5.10624313   Pennsylvania 2002 Female
    ## 2768      74.87933      67.56390  7.31543649   Pennsylvania 2002   Male
    ## 2769      80.29543      75.38519  4.91023273   Pennsylvania 2003 Female
    ## 2770      75.03729      67.73444  7.30285023   Pennsylvania 2003   Male
    ## 2771      80.45387      75.90805  4.54582178   Pennsylvania 2004 Female
    ## 2772      75.25453      68.19067  7.06386005   Pennsylvania 2004   Male
    ## 2773      80.49003      76.14035  4.34968538   Pennsylvania 2005 Female
    ## 2774      75.34272      68.43290  6.90982564   Pennsylvania 2005   Male
    ## 2775      80.87800      76.52093  4.35706212   Pennsylvania 2006 Female
    ## 2776      75.67935      68.76257  6.91677759   Pennsylvania 2006   Male
    ## 2777      81.07995      76.75700  4.32295398   Pennsylvania 2007 Female
    ## 2778      75.86925      69.34592  6.52333710   Pennsylvania 2007   Male
    ## 2779      81.05363      76.97390  4.07973348   Pennsylvania 2008 Female
    ## 2780      75.93290      69.92537  6.00752982   Pennsylvania 2008   Male
    ## 2781      81.35315      77.21990  4.13325641   Pennsylvania 2009 Female
    ## 2782      76.23921      70.29571  5.94349523   Pennsylvania 2009   Male
    ## 2783      81.48478      77.44555  4.03922927   Pennsylvania 2010 Female
    ## 2784      76.35710      70.63881  5.71829086   Pennsylvania 2010   Male
    ## 2785      81.34134      77.66962  3.67171808   Pennsylvania 2011 Female
    ## 2786      76.29699      70.99529  5.30170071   Pennsylvania 2011   Male
    ## 2787      81.49414      77.92737  3.56676667   Pennsylvania 2012 Female
    ## 2788      76.47301      71.18560  5.28741368   Pennsylvania 2012   Male
    ## 2789      81.43716      78.05445  3.38270741   Pennsylvania 2013 Female
    ## 2790      76.46892      71.40953  5.05938689   Pennsylvania 2013   Male
    ## 2791      75.98043      70.15212  5.82831793   Rhode Island 1969 Female
    ## 2792      68.76578      61.73724  7.02853994   Rhode Island 1969   Male
    ## 2793      76.11711      70.74351  5.37360477   Rhode Island 1970 Female
    ## 2794      68.79718      62.08024  6.71694164   Rhode Island 1970   Male
    ## 2795      76.35766      71.20486  5.15280723   Rhode Island 1971 Female
    ## 2796      69.04654      62.56160  6.48494283   Rhode Island 1971   Male
    ## 2797      76.62309      71.63275  4.99033637   Rhode Island 1972 Female
    ## 2798      69.14806      63.08301  6.06504918   Rhode Island 1972   Male
    ## 2799      76.94419      72.04981  4.89438579   Rhode Island 1973 Female
    ## 2800      69.41117      63.46501  5.94616184   Rhode Island 1973   Male
    ## 2801      77.31412      72.57757  4.73654901   Rhode Island 1974 Female
    ## 2802      69.87950      63.82979  6.04970776   Rhode Island 1974   Male
    ## 2803      77.60787      72.96902  4.63884861   Rhode Island 1975 Female
    ## 2804      70.26113      64.52152  5.73961041   Rhode Island 1975   Male
    ## 2805      77.92016      73.22658  4.69358404   Rhode Island 1976 Female
    ## 2806      70.39380      64.95337  5.44043622   Rhode Island 1976   Male
    ## 2807      78.29745      73.35414  4.94330986   Rhode Island 1977 Female
    ## 2808      70.62626      65.27990  5.34635916   Rhode Island 1977   Male
    ## 2809      78.46864      73.34415  5.12449154   Rhode Island 1978 Female
    ## 2810      70.95721      65.53635  5.42085865   Rhode Island 1978   Male
    ## 2811      78.58851      73.33797  5.25054125   Rhode Island 1979 Female
    ## 2812      71.06807      65.91125  5.15682356   Rhode Island 1979   Male
    ## 2813      78.70172      73.75471  4.94701127   Rhode Island 1980 Female
    ## 2814      71.22841      66.39561  4.83279469   Rhode Island 1980   Male
    ## 2815      78.98106      73.98640  4.99466209   Rhode Island 1981 Female
    ## 2816      71.48336      66.79846  4.68489591   Rhode Island 1981   Male
    ## 2817      79.21988      74.32041  4.89947755   Rhode Island 1982 Female
    ## 2818      71.82672      67.03490  4.79181515   Rhode Island 1982   Male
    ## 2819      79.15567      74.52579  4.62987725   Rhode Island 1983 Female
    ## 2820      71.93780      67.24285  4.69494430   Rhode Island 1983   Male
    ## 2821      79.24498      74.63284  4.61214322   Rhode Island 1984 Female
    ## 2822      72.06413      67.35794  4.70618461   Rhode Island 1984   Male
    ## 2823      79.27362      74.76448  4.50914343   Rhode Island 1985 Female
    ## 2824      72.19945      67.36908  4.83037398   Rhode Island 1985   Male
    ## 2825      79.29916      74.90292  4.39623828   Rhode Island 1986 Female
    ## 2826      72.35817      67.31198  5.04618456   Rhode Island 1986   Male
    ## 2827      79.50190      75.08279  4.41910829   Rhode Island 1987 Female
    ## 2828      72.59154      67.29903  5.29251630   Rhode Island 1987   Male
    ## 2829      79.62448      75.22606  4.39841920   Rhode Island 1988 Female
    ## 2830      72.86227      67.34242  5.51984639   Rhode Island 1988   Male
    ## 2831      79.83432      75.40256  4.43175542   Rhode Island 1989 Female
    ## 2832      73.12915      67.48573  5.64342152   Rhode Island 1989   Male
    ## 2833      80.06726      75.68355  4.38371468   Rhode Island 1990 Female
    ## 2834      73.40120      67.65837  5.74283689   Rhode Island 1990   Male
    ## 2835      80.26710      75.87952  4.38757729   Rhode Island 1991 Female
    ## 2836      73.72119      67.81872  5.90246734   Rhode Island 1991   Male
    ## 2837      80.40033      76.18603  4.21429765   Rhode Island 1992 Female
    ## 2838      73.93720      68.17863  5.75857284   Rhode Island 1992   Male
    ## 2839      80.36641      76.55534  3.81107420   Rhode Island 1993 Female
    ## 2840      74.04026      68.53284  5.50741559   Rhode Island 1993   Male
    ## 2841      80.57173      76.73237  3.83935649   Rhode Island 1994 Female
    ## 2842      74.37955      68.90611  5.47343692   Rhode Island 1994   Male
    ## 2843      80.60686      77.03376  3.57309802   Rhode Island 1995 Female
    ## 2844      74.53398      69.56123  4.97275840   Rhode Island 1995   Male
    ## 2845      80.63654      77.19516  3.44138192   Rhode Island 1996 Female
    ## 2846      74.79007      70.20871  4.58136073   Rhode Island 1996   Male
    ## 2847      80.63819      77.21601  3.42217977   Rhode Island 1997 Female
    ## 2848      74.93030      70.76301  4.16728921   Rhode Island 1997   Male
    ## 2849      80.81109      77.62221  3.18888437   Rhode Island 1998 Female
    ## 2850      75.16205      71.28640  3.87564986   Rhode Island 1998   Male
    ## 2851      80.78826      78.00106  2.78719972   Rhode Island 1999 Female
    ## 2852      75.39411      71.63747  3.75663124   Rhode Island 1999   Male
    ## 2853      80.67247      78.45281  2.21966203   Rhode Island 2000 Female
    ## 2854      75.47967      72.07255  3.40711295   Rhode Island 2000   Male
    ## 2855      80.67768      78.78505  1.89262978   Rhode Island 2001 Female
    ## 2856      75.57158      72.52327  3.04830224   Rhode Island 2001   Male
    ## 2857      80.73429      79.08222  1.65207528   Rhode Island 2002 Female
    ## 2858      75.68008      72.99595  2.68412281   Rhode Island 2002   Male
    ## 2859      80.93692      79.38415  1.55277039   Rhode Island 2003 Female
    ## 2860      75.88289      73.49307  2.38981511   Rhode Island 2003   Male
    ## 2861      81.20554      79.75284  1.45269429   Rhode Island 2004 Female
    ## 2862      76.07654      73.96332  2.11322351   Rhode Island 2004   Male
    ## 2863      81.16685      80.38543  0.78141065   Rhode Island 2005 Female
    ## 2864      76.21279      74.39477  1.81801979   Rhode Island 2005   Male
    ## 2865      81.45452      80.99326  0.46126630   Rhode Island 2006 Female
    ## 2866      76.31325      74.88652  1.42672839   Rhode Island 2006   Male
    ## 2867      81.47590      81.60268 -0.12678505   Rhode Island 2007 Female
    ## 2868      76.43648      75.36796  1.06852489   Rhode Island 2007   Male
    ## 2869      81.67429      82.08871 -0.41441481   Rhode Island 2008 Female
    ## 2870      76.51626      75.86546  0.65080531   Rhode Island 2008   Male
    ## 2871      81.94116      82.71787 -0.77671412   Rhode Island 2009 Female
    ## 2872      76.74108      76.41243  0.32864954   Rhode Island 2009   Male
    ## 2873      82.02776      83.04855 -1.02079021   Rhode Island 2010 Female
    ## 2874      76.75658      76.87281 -0.11623392   Rhode Island 2010   Male
    ## 2875      81.98986      83.60224 -1.61238049   Rhode Island 2011 Female
    ## 2876      76.78669      77.28733 -0.50064335   Rhode Island 2011   Male
    ## 2877      82.04218      84.47348 -2.43129507   Rhode Island 2012 Female
    ## 2878      76.79141      77.53421 -0.74279594   Rhode Island 2012   Male
    ## 2879      82.06529      84.80365 -2.73836140   Rhode Island 2013 Female
    ## 2880      76.64974      77.60831 -0.95857136   Rhode Island 2013   Male
    ## 2881      75.07120      67.60731  7.46388773 South Carolina 1969 Female
    ## 2882      66.08381      58.26884  7.81496720 South Carolina 1969   Male
    ## 2883      75.27794      68.28106  6.99688234 South Carolina 1970 Female
    ## 2884      66.32340      58.58044  7.74296168 South Carolina 1970   Male
    ## 2885      75.49851      68.57955  6.91895727 South Carolina 1971 Female
    ## 2886      66.57567      58.95584  7.61983570 South Carolina 1971   Male
    ## 2887      75.64532      68.70634  6.93898004 South Carolina 1972 Female
    ## 2888      66.59253      59.14879  7.44374559 South Carolina 1972   Male
    ## 2889      75.86835      69.14253  6.72581770 South Carolina 1973 Female
    ## 2890      66.69386      59.47163  7.22222271 South Carolina 1973   Male
    ## 2891      76.41849      70.33552  6.08296874 South Carolina 1974 Female
    ## 2892      67.08848      60.08553  7.00294319 South Carolina 1974   Male
    ## 2893      76.99742      71.14007  5.85734948 South Carolina 1975 Female
    ## 2894      67.66412      61.01283  6.65129377 South Carolina 1975   Male
    ## 2895      77.09345      71.42500  5.66844954 South Carolina 1976 Female
    ## 2896      68.21088      61.51365  6.69722876 South Carolina 1976   Male
    ## 2897      77.44343      71.78949  5.65394616 South Carolina 1977 Female
    ## 2898      68.53623      61.99250  6.54372944 South Carolina 1977   Male
    ## 2899      77.67446      72.35777  5.31669149 South Carolina 1978 Female
    ## 2900      69.00335      62.27891  6.72444105 South Carolina 1978   Male
    ## 2901      77.95297      72.88463  5.06833554 South Carolina 1979 Female
    ## 2902      69.36372      62.57892  6.78479517 South Carolina 1979   Male
    ## 2903      78.12918      73.02261  5.10656727 South Carolina 1980 Female
    ## 2904      69.56429      62.99201  6.57228477 South Carolina 1980   Male
    ## 2905      78.13871      73.19566  4.94305296 South Carolina 1981 Female
    ## 2906      69.89022      63.40175  6.48847303 South Carolina 1981   Male
    ## 2907      78.43877      73.33817  5.10059406 South Carolina 1982 Female
    ## 2908      70.22844      63.70552  6.52292119 South Carolina 1982   Male
    ## 2909      78.43941      73.31214  5.12726989 South Carolina 1983 Female
    ## 2910      70.36802      64.00072  6.36729653 South Carolina 1983   Male
    ## 2911      78.52224      73.41481  5.10742418 South Carolina 1984 Female
    ## 2912      70.63487      64.09500  6.53987440 South Carolina 1984   Male
    ## 2913      78.59258      73.29061  5.30196781 South Carolina 1985 Female
    ## 2914      70.76365      64.06382  6.69982907 South Carolina 1985   Male
    ## 2915      78.55795      73.14888  5.40906557 South Carolina 1986 Female
    ## 2916      70.83484      64.12240  6.71243862 South Carolina 1986   Male
    ## 2917      78.59788      73.30353  5.29435177 South Carolina 1987 Female
    ## 2918      71.04736      64.12109  6.92626962 South Carolina 1987   Male
    ## 2919      78.64418      73.25129  5.39289653 South Carolina 1988 Female
    ## 2920      71.21992      64.12214  7.09778041 South Carolina 1988   Male
    ## 2921      78.95398      73.56438  5.38959288 South Carolina 1989 Female
    ## 2922      71.50983      64.13536  7.37446722 South Carolina 1989   Male
    ## 2923      79.19680      73.89052  5.30627689 South Carolina 1990 Female
    ## 2924      71.77474      64.29443  7.48031824 South Carolina 1990   Male
    ## 2925      79.37760      74.12155  5.25604598 South Carolina 1991 Female
    ## 2926      71.99019      64.60934  7.38085325 South Carolina 1991   Male
    ## 2927      79.43172      74.34681  5.08491363 South Carolina 1992 Female
    ## 2928      72.23586      64.74302  7.49284188 South Carolina 1992   Male
    ## 2929      79.30611      74.44560  4.86051269 South Carolina 1993 Female
    ## 2930      72.35829      64.90248  7.45580898 South Carolina 1993   Male
    ## 2931      79.36353      74.58876  4.77477629 South Carolina 1994 Female
    ## 2932      72.50392      65.22108  7.28283983 South Carolina 1994   Male
    ## 2933      79.34817      74.49885  4.84931882 South Carolina 1995 Female
    ## 2934      72.53663      65.45147  7.08516112 South Carolina 1995   Male
    ## 2935      79.37244      74.57704  4.79539668 South Carolina 1996 Female
    ## 2936      72.89853      65.60802  7.29050473 South Carolina 1996   Male
    ## 2937      79.56307      74.76235  4.80072317 South Carolina 1997 Female
    ## 2938      73.17354      66.07052  7.10302680 South Carolina 1997   Male
    ## 2939      79.38492      74.81148  4.57343893 South Carolina 1998 Female
    ## 2940      73.29597      66.46250  6.83346879 South Carolina 1998   Male
    ## 2941      79.29677      74.89521  4.40155963 South Carolina 1999 Female
    ## 2942      73.37165      66.68462  6.68702844 South Carolina 1999   Male
    ## 2943      79.39759      74.93936  4.45822689 South Carolina 2000 Female
    ## 2944      73.39104      67.03985  6.35118707 South Carolina 2000   Male
    ## 2945      79.53827      75.20545  4.33281493 South Carolina 2001 Female
    ## 2946      73.61101      67.18121  6.42980211 South Carolina 2001   Male
    ## 2947      79.48389      75.18695  4.29694242 South Carolina 2002 Female
    ## 2948      73.64533      67.46523  6.18009824 South Carolina 2002   Male
    ## 2949      79.47138      75.53379  3.93759005 South Carolina 2003 Female
    ## 2950      73.87944      67.72297  6.15647569 South Carolina 2003   Male
    ## 2951      79.82147      75.76564  4.05582606 South Carolina 2004 Female
    ## 2952      74.09485      68.09421  6.00064226 South Carolina 2004   Male
    ## 2953      79.79938      76.13789  3.66149129 South Carolina 2005 Female
    ## 2954      74.19213      68.39975  5.79238289 South Carolina 2005   Male
    ## 2955      80.09518      76.41552  3.67966177 South Carolina 2006 Female
    ## 2956      74.52911      68.70786  5.82125666 South Carolina 2006   Male
    ## 2957      80.20977      76.56658  3.64319630 South Carolina 2007 Female
    ## 2958      74.76714      69.14416  5.62298701 South Carolina 2007   Male
    ## 2959      80.18404      76.88912  3.29492479 South Carolina 2008 Female
    ## 2960      74.95253      69.71638  5.23614564 South Carolina 2008   Male
    ## 2961      80.43170      77.12413  3.30757329 South Carolina 2009 Female
    ## 2962      75.02899      70.12542  4.90357158 South Carolina 2009   Male
    ## 2963      80.34673      77.45069  2.89603959 South Carolina 2010 Female
    ## 2964      75.12829      70.47423  4.65406068 South Carolina 2010   Male
    ## 2965      80.24629      77.66503  2.58126215 South Carolina 2011 Female
    ## 2966      75.29855      70.75637  4.54218413 South Carolina 2011   Male
    ## 2967      80.23084      77.78112  2.44972256 South Carolina 2012 Female
    ## 2968      75.41891      70.82750  4.59140525 South Carolina 2012   Male
    ## 2969      80.23198      77.78456  2.44742035 South Carolina 2013 Female
    ## 2970      75.39811      70.87800  4.52010969 South Carolina 2013   Male
    ## 2971      75.67450      68.06105  7.61344486      Tennessee 1969 Female
    ## 2972      67.08191      60.72970  6.35221185      Tennessee 1969   Male
    ## 2973      75.89353      68.53726  7.35627072      Tennessee 1970 Female
    ## 2974      67.17564      61.06359  6.11204639      Tennessee 1970   Male
    ## 2975      76.03828      69.21672  6.82155753      Tennessee 1971 Female
    ## 2976      67.46573      61.27196  6.19377341      Tennessee 1971   Male
    ## 2977      76.15722      69.66181  6.49540504      Tennessee 1972 Female
    ## 2978      67.45496      61.18298  6.27198493      Tennessee 1972   Male
    ## 2979      76.34902      69.80035  6.54867540      Tennessee 1973 Female
    ## 2980      67.66124      61.61915  6.04208851      Tennessee 1973   Male
    ## 2981      76.76864      70.28144  6.48719960      Tennessee 1974 Female
    ## 2982      68.11783      62.19454  5.92329530      Tennessee 1974   Male
    ## 2983      77.28741      70.94113  6.34628034      Tennessee 1975 Female
    ## 2984      68.60208      62.67660  5.92547686      Tennessee 1975   Male
    ## 2985      77.55901      71.46344  6.09556918      Tennessee 1976 Female
    ## 2986      68.83342      63.12147  5.71194735      Tennessee 1976   Male
    ## 2987      77.91188      71.90663  6.00524367      Tennessee 1977 Female
    ## 2988      69.16444      63.42100  5.74344378      Tennessee 1977   Male
    ## 2989      78.20736      72.47127  5.73609009      Tennessee 1978 Female
    ## 2990      69.59329      63.82717  5.76611947      Tennessee 1978   Male
    ## 2991      78.54342      72.82067  5.72274464      Tennessee 1979 Female
    ## 2992      69.91199      63.92499  5.98699862      Tennessee 1979   Male
    ## 2993      78.47014      72.70702  5.76312639      Tennessee 1980 Female
    ## 2994      70.05218      64.14752  5.90466642      Tennessee 1980   Male
    ## 2995      78.67156      72.81471  5.85685065      Tennessee 1981 Female
    ## 2996      70.28807      64.36744  5.92062898      Tennessee 1981   Male
    ## 2997      78.80744      72.93579  5.87164984      Tennessee 1982 Female
    ## 2998      70.59441      64.50681  6.08759915      Tennessee 1982   Male
    ## 2999      78.78421      72.84132  5.94289509      Tennessee 1983 Female
    ## 3000      70.67328      64.57956  6.09372433      Tennessee 1983   Male
    ## 3001      78.88873      72.82941  6.05931618      Tennessee 1984 Female
    ## 3002      70.72726      64.57391  6.15335008      Tennessee 1984   Male
    ## 3003      78.85776      72.84773  6.01003064      Tennessee 1985 Female
    ## 3004      70.84457      64.45691  6.38766057      Tennessee 1985   Male
    ## 3005      78.76070      72.94215  5.81854476      Tennessee 1986 Female
    ## 3006      70.93018      64.39248  6.53770382      Tennessee 1986   Male
    ## 3007      78.79197      72.99198  5.79999213      Tennessee 1987 Female
    ## 3008      70.98179      64.39930  6.58249024      Tennessee 1987   Male
    ## 3009      78.77707      72.99244  5.78463024      Tennessee 1988 Female
    ## 3010      71.06552      64.50541  6.56010824      Tennessee 1988   Male
    ## 3011      79.04416      73.05819  5.98597133      Tennessee 1989 Female
    ## 3012      71.28635      64.55183  6.73452444      Tennessee 1989   Male
    ## 3013      79.15064      73.17847  5.97216789      Tennessee 1990 Female
    ## 3014      71.39643      64.60018  6.79624671      Tennessee 1990   Male
    ## 3015      79.28286      73.33645  5.94641166      Tennessee 1991 Female
    ## 3016      71.64764      64.66487  6.98277324      Tennessee 1991   Male
    ## 3017      79.31008      73.51900  5.79107258      Tennessee 1992 Female
    ## 3018      71.84716      64.64859  7.19857457      Tennessee 1992   Male
    ## 3019      79.04530      73.48520  5.56010484      Tennessee 1993 Female
    ## 3020      71.83123      64.63563  7.19559442      Tennessee 1993   Male
    ## 3021      78.89767      73.48556  5.41211224      Tennessee 1994 Female
    ## 3022      71.89507      64.68577  7.20929439      Tennessee 1994   Male
    ## 3023      78.94853      73.52190  5.42662699      Tennessee 1995 Female
    ## 3024      72.02066      64.61608  7.40457612      Tennessee 1995   Male
    ## 3025      78.96767      73.56690  5.40076809      Tennessee 1996 Female
    ## 3026      72.23109      64.99371  7.23738218      Tennessee 1996   Male
    ## 3027      78.91733      73.53883  5.37850558      Tennessee 1997 Female
    ## 3028      72.35098      65.43523  6.91574962      Tennessee 1997   Male
    ## 3029      78.84946      73.65914  5.19031622      Tennessee 1998 Female
    ## 3030      72.45720      65.90397  6.55322473      Tennessee 1998   Male
    ## 3031      78.76906      73.68267  5.08639241      Tennessee 1999 Female
    ## 3032      72.65467      66.25478  6.39989073      Tennessee 1999   Male
    ## 3033      78.64511      73.69920  4.94590338      Tennessee 2000 Female
    ## 3034      72.70499      66.38147  6.32352614      Tennessee 2000   Male
    ## 3035      78.57277      73.92791  4.64485634      Tennessee 2001 Female
    ## 3036      72.86160      66.67410  6.18750687      Tennessee 2001   Male
    ## 3037      78.47931      74.02570  4.45361232      Tennessee 2002 Female
    ## 3038      72.83120      66.80308  6.02812591      Tennessee 2002   Male
    ## 3039      78.50946      74.22511  4.28434956      Tennessee 2003 Female
    ## 3040      72.88670      67.09522  5.79147462      Tennessee 2003   Male
    ## 3041      78.72481      74.57499  4.14982552      Tennessee 2004 Female
    ## 3042      73.12995      67.52071  5.60924581      Tennessee 2004   Male
    ## 3043      78.79004      74.86118  3.92885970      Tennessee 2005 Female
    ## 3044      73.24332      67.74618  5.49713749      Tennessee 2005   Male
    ## 3045      79.11117      75.12454  3.98663168      Tennessee 2006 Female
    ## 3046      73.46520      68.09092  5.37427676      Tennessee 2006   Male
    ## 3047      79.19084      75.39154  3.79929201      Tennessee 2007 Female
    ## 3048      73.69821      68.54102  5.15719103      Tennessee 2007   Male
    ## 3049      79.08518      75.68728  3.39789937      Tennessee 2008 Female
    ## 3050      73.84478      68.98002  4.86476032      Tennessee 2008   Male
    ## 3051      79.33770      76.21228  3.12542154      Tennessee 2009 Female
    ## 3052      74.00055      69.35554  4.64501084      Tennessee 2009   Male
    ## 3053      79.29905      76.55629  2.74275284      Tennessee 2010 Female
    ## 3054      74.05840      69.81792  4.24047688      Tennessee 2010   Male
    ## 3055      79.26710      76.84749  2.41961701      Tennessee 2011 Female
    ## 3056      74.09207      70.15154  3.94053142      Tennessee 2011   Male
    ## 3057      79.21641      77.09603  2.12037938      Tennessee 2012 Female
    ## 3058      74.14754      70.32796  3.81958716      Tennessee 2012   Male
    ## 3059      79.18916      77.02065  2.16851670      Tennessee 2013 Female
    ## 3060      74.14706      70.46248  3.68457616      Tennessee 2013   Male
    ## 3061      75.84819      69.75565  6.09254365          Texas 1969 Female
    ## 3062      67.63561      61.09411  6.54150315          Texas 1969   Male
    ## 3063      76.07859      70.26508  5.81350376          Texas 1970 Female
    ## 3064      67.88148      61.44008  6.44140067          Texas 1970   Male
    ## 3065      76.33603      70.60007  5.73596660          Texas 1971 Female
    ## 3066      68.20197      61.92687  6.27509506          Texas 1971   Male
    ## 3067      76.40173      70.78018  5.62154336          Texas 1972 Female
    ## 3068      68.06263      62.01706  6.04557020          Texas 1972   Male
    ## 3069      76.54778      70.94146  5.60632058          Texas 1973 Female
    ## 3070      68.20022      62.28258  5.91764040          Texas 1973   Male
    ## 3071      77.05426      71.42854  5.62572045          Texas 1974 Female
    ## 3072      68.74482      62.88922  5.85559459          Texas 1974   Male
    ## 3073      77.66541      72.09210  5.57331839          Texas 1975 Female
    ## 3074      69.26740      63.29142  5.97597802          Texas 1975   Male
    ## 3075      77.71335      72.55112  5.16223361          Texas 1976 Female
    ## 3076      69.57782      63.67208  5.90573111          Texas 1976   Male
    ## 3077      78.16105      73.17287  4.98818788          Texas 1977 Female
    ## 3078      69.90646      64.03985  5.86661079          Texas 1977   Male
    ## 3079      78.25068      73.33137  4.91931017          Texas 1978 Female
    ## 3080      70.06773      63.97790  6.08983085          Texas 1978   Male
    ## 3081      78.38174      73.75288  4.62885800          Texas 1979 Female
    ## 3082      70.29308      64.21648  6.07659814          Texas 1979   Male
    ## 3083      78.50480      73.90994  4.59486113          Texas 1980 Female
    ## 3084      70.40873      64.56771  5.84101229          Texas 1980   Male
    ## 3085      78.58120      74.31136  4.26984523          Texas 1981 Female
    ## 3086      70.53000      64.92524  5.60475752          Texas 1981   Male
    ## 3087      78.82827      74.44100  4.38727051          Texas 1982 Female
    ## 3088      70.89014      65.42223  5.46791249          Texas 1982   Male
    ## 3089      78.85774      74.44402  4.41372692          Texas 1983 Female
    ## 3090      71.05000      65.79130  5.25869372          Texas 1983   Male
    ## 3091      78.85553      74.45526  4.40027169          Texas 1984 Female
    ## 3092      71.24113      65.96448  5.27665338          Texas 1984   Male
    ## 3093      79.08689      74.41087  4.67602091          Texas 1985 Female
    ## 3094      71.38077      66.03515  5.34561122          Texas 1985   Male
    ## 3095      79.31786      74.44043  4.87743356          Texas 1986 Female
    ## 3096      71.69580      66.03468  5.66111282          Texas 1986   Male
    ## 3097      79.33601      74.48805  4.84796118          Texas 1987 Female
    ## 3098      71.84391      66.21491  5.62899634          Texas 1987   Male
    ## 3099      79.30549      74.44651  4.85897797          Texas 1988 Female
    ## 3100      71.83246      66.07526  5.75719854          Texas 1988   Male
    ## 3101      79.41263      74.36599  5.04663927          Texas 1989 Female
    ## 3102      72.04042      65.65901  6.38141456          Texas 1989   Male
    ## 3103      79.64576      74.61612  5.02964723          Texas 1990 Female
    ## 3104      72.17487      65.46083  6.71403776          Texas 1990   Male
    ## 3105      79.84871      74.76982  5.07889030          Texas 1991 Female
    ## 3106      72.45508      65.50401  6.95106378          Texas 1991   Male
    ## 3107      79.89230      74.84719  5.04510684          Texas 1992 Female
    ## 3108      72.64621      65.61772  7.02848831          Texas 1992   Male
    ## 3109      79.78865      74.81627  4.97237872          Texas 1993 Female
    ## 3110      72.68466      65.87975  6.80491143          Texas 1993   Male
    ## 3111      79.86491      75.00091  4.86399884          Texas 1994 Female
    ## 3112      72.85290      66.27269  6.58021625          Texas 1994   Male
    ## 3113      79.88447      75.01259  4.87187745          Texas 1995 Female
    ## 3114      73.19623      66.85132  6.34490802          Texas 1995   Male
    ## 3115      79.86147      75.01739  4.84408395          Texas 1996 Female
    ## 3116      73.51235      67.39843  6.11391981          Texas 1996   Male
    ## 3117      79.82059      75.14326  4.67732994          Texas 1997 Female
    ## 3118      73.78222      67.91069  5.87152493          Texas 1997   Male
    ## 3119      79.94936      75.12895  4.82041148          Texas 1998 Female
    ## 3120      74.19687      68.26875  5.92811841          Texas 1998   Male
    ## 3121      79.78115      75.01648  4.76467160          Texas 1999 Female
    ## 3122      74.38671      68.64315  5.74355756          Texas 1999   Male
    ## 3123      79.73297      75.02842  4.70455284          Texas 2000 Female
    ## 3124      74.48096      68.88477  5.59619566          Texas 2000   Male
    ## 3125      79.71041      74.98360  4.72680753          Texas 2001 Female
    ## 3126      74.54516      68.99704  5.54811300          Texas 2001   Male
    ## 3127      79.71305      75.06101  4.65203457          Texas 2002 Female
    ## 3128      74.58551      69.09035  5.49515866          Texas 2002   Male
    ## 3129      79.98345      75.27537  4.70808122          Texas 2003 Female
    ## 3130      74.83633      69.33905  5.49727371          Texas 2003   Male
    ## 3131      80.29383      75.63578  4.65805359          Texas 2004 Female
    ## 3132      75.18572      69.69870  5.48702277          Texas 2004   Male
    ## 3133      80.37487      75.96033  4.41453440          Texas 2005 Female
    ## 3134      75.34384      70.04739  5.29644676          Texas 2005   Male
    ## 3135      80.53461      76.52655  4.00806062          Texas 2006 Female
    ## 3136      75.66040      70.54895  5.11144926          Texas 2006   Male
    ## 3137      80.62105      76.78105  3.84000564          Texas 2007 Female
    ## 3138      75.69703      71.07051  4.62651442          Texas 2007   Male
    ## 3139      80.62465      77.07667  3.54798776          Texas 2008 Female
    ## 3140      75.71818      71.66631  4.05186887          Texas 2008   Male
    ## 3141      81.00866      77.46971  3.53894594          Texas 2009 Female
    ## 3142      76.13858      71.89127  4.24730490          Texas 2009   Male
    ## 3143      81.10044      77.72651  3.37393115          Texas 2010 Female
    ## 3144      76.32547      72.27641  4.04906890          Texas 2010   Male
    ## 3145      81.27556      77.88838  3.38717779          Texas 2011 Female
    ## 3146      76.56729      72.57529  3.99200259          Texas 2011   Male
    ## 3147      81.29035      78.14245  3.14790822          Texas 2012 Female
    ## 3148      76.55242      72.69468  3.85773710          Texas 2012   Male
    ## 3149      81.31042      78.29531  3.01511042          Texas 2013 Female
    ## 3150      76.57018      72.73980  3.83038218          Texas 2013   Male
    ## 3151      75.86036      68.22246  7.63790138       Virginia 1969 Female
    ## 3152      67.82267      59.86305  7.95961900       Virginia 1969   Male
    ## 3153      76.05782      68.64410  7.41372099       Virginia 1970 Female
    ## 3154      67.94277      60.21897  7.72379730       Virginia 1970   Male
    ## 3155      76.27285      69.29100  6.98185188       Virginia 1971 Female
    ## 3156      68.01738      60.84522  7.17215545       Virginia 1971   Male
    ## 3157      76.46694      69.69822  6.76872646       Virginia 1972 Female
    ## 3158      68.13813      61.20215  6.93598650       Virginia 1972   Male
    ## 3159      76.80726      70.24234  6.56491433       Virginia 1973 Female
    ## 3160      68.31657      61.63085  6.68571912       Virginia 1973   Male
    ## 3161      77.25096      71.00366  6.24729327       Virginia 1974 Female
    ## 3162      68.74937      62.14491  6.60445593       Virginia 1974   Male
    ## 3163      77.71000      71.76291  5.94709900       Virginia 1975 Female
    ## 3164      69.17777      62.70781  6.46995810       Virginia 1975   Male
    ## 3165      77.89905      72.10545  5.79360401       Virginia 1976 Female
    ## 3166      69.54225      63.15328  6.38897180       Virginia 1976   Male
    ## 3167      78.23063      72.42179  5.80883702       Virginia 1977 Female
    ## 3168      69.93518      63.68385  6.25132558       Virginia 1977   Male
    ## 3169      78.30946      72.87514  5.43432674       Virginia 1978 Female
    ## 3170      70.21612      64.17161  6.04450231       Virginia 1978   Male
    ## 3171      78.47865      73.06783  5.41081693       Virginia 1979 Female
    ## 3172      70.46752      64.58086  5.88666252       Virginia 1979   Male
    ## 3173      78.49599      73.20159  5.29440025       Virginia 1980 Female
    ## 3174      70.65460      64.88218  5.77241699       Virginia 1980   Male
    ## 3175      78.67142      73.62895  5.04246210       Virginia 1981 Female
    ## 3176      70.99976      65.29671  5.70305110       Virginia 1981   Male
    ## 3177      78.82679      73.94669  4.88010207       Virginia 1982 Female
    ## 3178      71.37847      65.51110  5.86737415       Virginia 1982   Male
    ## 3179      78.79879      73.92032  4.87846632       Virginia 1983 Female
    ## 3180      71.51952      65.56163  5.95789490       Virginia 1983   Male
    ## 3181      78.88463      73.95573  4.92889754       Virginia 1984 Female
    ## 3182      71.73671      65.61473  6.12197928       Virginia 1984   Male
    ## 3183      78.95560      73.91596  5.03964088       Virginia 1985 Female
    ## 3184      71.92772      65.66517  6.26255208       Virginia 1985   Male
    ## 3185      78.98785      73.92537  5.06248633       Virginia 1986 Female
    ## 3186      72.15321      65.57317  6.58004499       Virginia 1986   Male
    ## 3187      79.18529      74.02874  5.15655138       Virginia 1987 Female
    ## 3188      72.42991      65.57969  6.85022087       Virginia 1987   Male
    ## 3189      79.35090      74.10019  5.25070588       Virginia 1988 Female
    ## 3190      72.59773      65.57073  7.02699675       Virginia 1988   Male
    ## 3191      79.54778      74.25481  5.29297539       Virginia 1989 Female
    ## 3192      72.94165      65.83053  7.11111572       Virginia 1989   Male
    ## 3193      79.62479      74.52852  5.09626532       Virginia 1990 Female
    ## 3194      73.10860      65.89094  7.21765910       Virginia 1990   Male
    ## 3195      79.76498      74.61621  5.14877015       Virginia 1991 Female
    ## 3196      73.31013      65.93209  7.37803535       Virginia 1991   Male
    ## 3197      79.87435      74.76513  5.10921720       Virginia 1992 Female
    ## 3198      73.53359      66.15345  7.38014190       Virginia 1992   Male
    ## 3199      79.83141      74.85040  4.98100585       Virginia 1993 Female
    ## 3200      73.63175      66.28369  7.34806222       Virginia 1993   Male
    ## 3201      79.87364      74.97888  4.89475640       Virginia 1994 Female
    ## 3202      73.80000      66.51821  7.28179356       Virginia 1994   Male
    ## 3203      79.94321      75.02929  4.91392945       Virginia 1995 Female
    ## 3204      74.07205      66.80937  7.26267800       Virginia 1995   Male
    ## 3205      80.00063      75.13915  4.86147390       Virginia 1996 Female
    ## 3206      74.35944      67.31094  7.04849372       Virginia 1996   Male
    ## 3207      80.05917      75.37469  4.68448382       Virginia 1997 Female
    ## 3208      74.61709      67.89499  6.72210188       Virginia 1997   Male
    ## 3209      80.09512      75.55136  4.54375720       Virginia 1998 Female
    ## 3210      74.83643      68.40405  6.43238626       Virginia 1998   Male
    ## 3211      80.16763      75.68595  4.48168441       Virginia 1999 Female
    ## 3212      75.07928      68.72111  6.35816768       Virginia 1999   Male
    ## 3213      80.12889      75.85455  4.27434657       Virginia 2000 Female
    ## 3214      75.29537      69.08702  6.20835087       Virginia 2000   Male
    ## 3215      80.24115      75.94348  4.29766674       Virginia 2001 Female
    ## 3216      75.52353      69.36810  6.15543130       Virginia 2001   Male
    ## 3217      80.35926      76.08270  4.27656380       Virginia 2002 Female
    ## 3218      75.58895      69.62907  5.95987259       Virginia 2002   Male
    ## 3219      80.46523      76.27086  4.19436894       Virginia 2003 Female
    ## 3220      75.77365      69.79291  5.98074030       Virginia 2003   Male
    ## 3221      80.77632      76.54417  4.23215389       Virginia 2004 Female
    ## 3222      76.10529      70.22801  5.87727954       Virginia 2004   Male
    ## 3223      80.83702      76.83711  3.99990407       Virginia 2005 Female
    ## 3224      76.31157      70.55844  5.75313716       Virginia 2005   Male
    ## 3225      81.07778      77.17153  3.90625765       Virginia 2006 Female
    ## 3226      76.52836      71.00617  5.52219477       Virginia 2006   Male
    ## 3227      81.25518      77.44740  3.80778532       Virginia 2007 Female
    ## 3228      76.75782      71.28167  5.47615721       Virginia 2007   Male
    ## 3229      81.33765      77.64933  3.68832423       Virginia 2008 Female
    ## 3230      76.96064      71.78240  5.17823872       Virginia 2008   Male
    ## 3231      81.63207      78.16696  3.46510859       Virginia 2009 Female
    ## 3232      77.20474      72.13661  5.06812538       Virginia 2009   Male
    ## 3233      81.71203      78.48716  3.22487314       Virginia 2010 Female
    ## 3234      77.41169      72.49877  4.91292064       Virginia 2010   Male
    ## 3235      81.66540      78.73384  2.93155443       Virginia 2011 Female
    ## 3236      77.48774      72.91533  4.57241605       Virginia 2011   Male
    ## 3237      81.75320      78.84567  2.90752272       Virginia 2012 Female
    ## 3238      77.61379      73.13235  4.48143854       Virginia 2012   Male
    ## 3239      81.79112      78.93765  2.85346415       Virginia 2013 Female
    ## 3240      77.66552      73.21596  4.44956004       Virginia 2013   Male
    ## 3241      76.09647      71.71520  4.38127744     Washington 1969 Female
    ## 3242      68.27288      63.65136  4.62151863     Washington 1969   Male
    ## 3243      76.46197      72.09745  4.36451349     Washington 1970 Female
    ## 3244      68.59503      63.90332  4.69171240     Washington 1970   Male
    ## 3245      76.58526      72.55386  4.03139887     Washington 1971 Female
    ## 3246      68.92234      64.38981  4.53253180     Washington 1971   Male
    ## 3247      76.86952      72.95729  3.91223282     Washington 1972 Female
    ## 3248      69.29328      64.86995  4.42332861     Washington 1972   Male
    ## 3249      76.96772      73.26118  3.70653429     Washington 1973 Female
    ## 3250      69.50482      65.16530  4.33952458     Washington 1973   Male
    ## 3251      77.44190      73.52681  3.91508510     Washington 1974 Female
    ## 3252      69.94185      65.53811  4.40373139     Washington 1974   Male
    ## 3253      77.78253      73.74382  4.03871317     Washington 1975 Female
    ## 3254      70.22326      65.85104  4.37222244     Washington 1975   Male
    ## 3255      77.95407      74.04367  3.91039593     Washington 1976 Female
    ## 3256      70.52511      66.19175  4.33336094     Washington 1976   Male
    ## 3257      78.49366      74.11673  4.37692881     Washington 1977 Female
    ## 3258      70.98325      66.47473  4.50852258     Washington 1977   Male
    ## 3259      78.66345      74.22515  4.43829897     Washington 1978 Female
    ## 3260      71.27722      66.67815  4.59907077     Washington 1978   Male
    ## 3261      78.89424      74.41322  4.48101757     Washington 1979 Female
    ## 3262      71.67419      66.91580  4.75839229     Washington 1979   Male
    ## 3263      78.85349      74.48778  4.36571107     Washington 1980 Female
    ## 3264      71.91561      67.10573  4.80987428     Washington 1980   Male
    ## 3265      79.10280      74.62718  4.47561981     Washington 1981 Female
    ## 3266      72.27706      67.25197  5.02508887     Washington 1981   Male
    ## 3267      79.18933      74.83903  4.35029762     Washington 1982 Female
    ## 3268      72.49528      67.49413  5.00115110     Washington 1982   Male
    ## 3269      79.28915      74.91665  4.37249653     Washington 1983 Female
    ## 3270      72.68626      67.56968  5.11657905     Washington 1983   Male
    ## 3271      79.27479      74.90869  4.36609755     Washington 1984 Female
    ## 3272      72.72652      67.62487  5.10165351     Washington 1984   Male
    ## 3273      79.37363      75.14447  4.22916472     Washington 1985 Female
    ## 3274      72.84678      67.93362  4.91316712     Washington 1985   Male
    ## 3275      79.52359      75.40319  4.12039519     Washington 1986 Female
    ## 3276      73.15668      68.07983  5.07684629     Washington 1986   Male
    ## 3277      79.52688      75.54686  3.98002074     Washington 1987 Female
    ## 3278      73.36736      68.21143  5.15592449     Washington 1987   Male
    ## 3279      79.53228      75.48096  4.05132455     Washington 1988 Female
    ## 3280      73.46348      68.27608  5.18739977     Washington 1988   Male
    ## 3281      79.73149      75.53066  4.20082652     Washington 1989 Female
    ## 3282      73.79749      68.33170  5.46578924     Washington 1989   Male
    ## 3283      79.90570      75.72920  4.17650644     Washington 1990 Female
    ## 3284      73.98336      68.36699  5.61636671     Washington 1990   Male
    ## 3285      80.16015      75.89543  4.26471684     Washington 1991 Female
    ## 3286      74.20070      68.60812  5.59258028     Washington 1991   Male
    ## 3287      80.31569      75.87871  4.43697908     Washington 1992 Female
    ## 3288      74.28788      68.80017  5.48771115     Washington 1992   Male
    ## 3289      80.13407      75.95181  4.18226244     Washington 1993 Female
    ## 3290      74.23326      68.92331  5.30994849     Washington 1993   Male
    ## 3291      80.42727      76.23383  4.19343991     Washington 1994 Female
    ## 3292      74.53417      69.07009  5.46407928     Washington 1994   Male
    ## 3293      80.42055      76.56237  3.85818440     Washington 1995 Female
    ## 3294      74.83100      69.56381  5.26719358     Washington 1995   Male
    ## 3295      80.41333      76.70495  3.70837522     Washington 1996 Female
    ## 3296      75.02311      70.01828  5.00483554     Washington 1996   Male
    ## 3297      80.63348      76.93655  3.69693705     Washington 1997 Female
    ## 3298      75.42447      70.54885  4.87561733     Washington 1997   Male
    ## 3299      80.59488      77.14823  3.44664876     Washington 1998 Female
    ## 3300      75.60828      71.00816  4.60012166     Washington 1998   Male
    ## 3301      80.51811      77.15407  3.36403676     Washington 1999 Female
    ## 3302      75.75905      71.39784  4.36120367     Washington 1999   Male
    ## 3303      80.60904      77.30590  3.30313669     Washington 2000 Female
    ## 3304      75.92463      71.87912  4.04550513     Washington 2000   Male
    ## 3305      80.62504      77.63446  2.99058351     Washington 2001 Female
    ## 3306      76.07102      72.26444  3.80658433     Washington 2001   Male
    ## 3307      80.74071      77.93501  2.80569784     Washington 2002 Female
    ## 3308      76.16309      72.54954  3.61354356     Washington 2002   Male
    ## 3309      80.81215      78.22653  2.58562217     Washington 2003 Female
    ## 3310      76.42021      72.85133  3.56887732     Washington 2003   Male
    ## 3311      81.18918      78.53823  2.65094703     Washington 2004 Female
    ## 3312      76.71990      73.32978  3.39011356     Washington 2004   Male
    ## 3313      81.20118      78.85161  2.34956837     Washington 2005 Female
    ## 3314      76.90591      73.59985  3.30605965     Washington 2005   Male
    ## 3315      81.42639      79.08440  2.34198520     Washington 2006 Female
    ## 3316      77.24765      73.90634  3.34130485     Washington 2006   Male
    ## 3317      81.48884      79.28277  2.20606550     Washington 2007 Female
    ## 3318      77.30207      74.23661  3.06546159     Washington 2007   Male
    ## 3319      81.53799      79.51893  2.01905815     Washington 2008 Female
    ## 3320      77.37938      74.51538  2.86400691     Washington 2008   Male
    ## 3321      81.89720      79.81663  2.08057585     Washington 2009 Female
    ## 3322      77.66069      74.91153  2.74915667     Washington 2009   Male
    ## 3323      82.13488      80.04270  2.09218083     Washington 2010 Female
    ## 3324      77.88591      75.27787  2.60804476     Washington 2010   Male
    ## 3325      82.14044      80.31288  1.82755911     Washington 2011 Female
    ## 3326      77.91838      75.42079  2.49758873     Washington 2011   Male
    ## 3327      82.27104      80.56855  1.70249012     Washington 2012 Female
    ## 3328      77.97356      75.53445  2.43910549     Washington 2012   Male
    ## 3329      82.25360      80.64364  1.60995985     Washington 2013 Female
    ## 3330      78.07217      75.51431  2.55785687     Washington 2013   Male
    ## 3331      75.08030      68.34662  6.73367491  Washington DC 1969 Female
    ## 3332      66.60755      58.57737  8.03018718  Washington DC 1969   Male
    ## 3333      75.24712      68.50403  6.74308957  Washington DC 1970 Female
    ## 3334      66.90003      58.72951  8.17051339  Washington DC 1970   Male
    ## 3335      75.78366      68.77969  7.00397140  Washington DC 1971 Female
    ## 3336      67.56602      59.05175  8.51426849  Washington DC 1971   Male
    ## 3337      76.05452      69.23698  6.81753726  Washington DC 1972 Female
    ## 3338      68.09558      59.39887  8.69670429  Washington DC 1972   Male
    ## 3339      76.26907      69.73504  6.53403118  Washington DC 1973 Female
    ## 3340      68.66648      59.87703  8.78945816  Washington DC 1973   Male
    ## 3341      76.80433      70.12743  6.67690637  Washington DC 1974 Female
    ## 3342      69.35163      60.07597  9.27566665  Washington DC 1974   Male
    ## 3343      77.31539      70.50817  6.80721648  Washington DC 1975 Female
    ## 3344      69.90199      60.41207  9.48992644  Washington DC 1975   Male
    ## 3345      77.32823      70.80157  6.52666097  Washington DC 1976 Female
    ## 3346      70.31731      60.73943  9.57787724  Washington DC 1976   Male
    ## 3347      77.72772      71.02474  6.70298268  Washington DC 1977 Female
    ## 3348      70.55565      61.10510  9.45054313  Washington DC 1977   Male
    ## 3349      78.01335      71.32274  6.69061188  Washington DC 1978 Female
    ## 3350      70.78463      61.43063  9.35400514  Washington DC 1978   Male
    ## 3351      78.05703      71.62823  6.42880115  Washington DC 1979 Female
    ## 3352      71.13509      61.51095  9.62413787  Washington DC 1979   Male
    ## 3353      78.01715      71.68509  6.33206618  Washington DC 1980 Female
    ## 3354      71.33868      61.53424  9.80444497  Washington DC 1980   Male
    ## 3355      78.68459      71.81957  6.86501679  Washington DC 1981 Female
    ## 3356      71.60931      61.65605  9.95326510  Washington DC 1981   Male
    ## 3357      79.03617      72.11609  6.92008638  Washington DC 1982 Female
    ## 3358      72.02979      61.87266 10.15712473  Washington DC 1982   Male
    ## 3359      79.12256      72.27045  6.85211019  Washington DC 1983 Female
    ## 3360      72.38853      61.88152 10.50701009  Washington DC 1983   Male
    ## 3361      79.35485      72.37691  6.97793328  Washington DC 1984 Female
    ## 3362      72.70776      61.49410 11.21365885  Washington DC 1984   Male
    ## 3363      79.65796      72.23399  7.42397242  Washington DC 1985 Female
    ## 3364      72.91171      61.13511 11.77659727  Washington DC 1985   Male
    ## 3365      79.86069      72.09092  7.76976775  Washington DC 1986 Female
    ## 3366      72.90250      60.59705 12.30545288  Washington DC 1986   Male
    ## 3367      79.91855      71.91119  8.00735660  Washington DC 1987 Female
    ## 3368      72.62278      59.92425 12.69852842  Washington DC 1987   Male
    ## 3369      80.20681      71.71055  8.49625893  Washington DC 1988 Female
    ## 3370      72.31811      58.94902 13.36908896  Washington DC 1988   Male
    ## 3371      80.58343      71.72282  8.86061210  Washington DC 1989 Female
    ## 3372      72.23657      58.16987 14.06670105  Washington DC 1989   Male
    ## 3373      80.91207      71.78361  9.12845372  Washington DC 1990 Female
    ## 3374      72.28648      57.79267 14.49381471  Washington DC 1990   Male
    ## 3375      81.37431      71.92495  9.44936450  Washington DC 1991 Female
    ## 3376      72.55278      57.61717 14.93561552  Washington DC 1991   Male
    ## 3377      81.62698      72.00285  9.62412877  Washington DC 1992 Female
    ## 3378      72.74572      57.43268 15.31304830  Washington DC 1992   Male
    ## 3379      81.51943      72.07649  9.44293985  Washington DC 1993 Female
    ## 3380      72.85688      56.98562 15.87126137  Washington DC 1993   Male
    ## 3381      81.90694      72.00741  9.89952583  Washington DC 1994 Female
    ## 3382      72.84949      57.08281 15.76668130  Washington DC 1994   Male
    ## 3383      81.91084      72.12314  9.78770347  Washington DC 1995 Female
    ## 3384      74.13105      57.66119 16.46986341  Washington DC 1995   Male
    ## 3385      82.11715      72.34139  9.77575705  Washington DC 1996 Female
    ## 3386      75.34786      58.69235 16.65551637  Washington DC 1996   Male
    ## 3387      82.26778      72.63135  9.63643696  Washington DC 1997 Female
    ## 3388      76.45846      60.57767 15.88078542  Washington DC 1997   Male
    ## 3389      82.43039      72.83039  9.60000586  Washington DC 1998 Female
    ## 3390      77.05215      61.67403 15.37812415  Washington DC 1998   Male
    ## 3391      82.60913      73.07794  9.53119342  Washington DC 1999 Female
    ## 3392      77.52620      62.05167 15.47452490  Washington DC 1999   Male
    ## 3393      82.79480      73.33881  9.45599197  Washington DC 2000 Female
    ## 3394      77.87338      62.47524 15.39813328  Washington DC 2000   Male
    ## 3395      83.18313      73.59036  9.59277023  Washington DC 2001 Female
    ## 3396      78.30624      62.63775 15.66848889  Washington DC 2001   Male
    ## 3397      83.62128      73.76962  9.85166627  Washington DC 2002 Female
    ## 3398      78.79576      62.98452 15.81123451  Washington DC 2002   Male
    ## 3399      84.04645      73.86234 10.18411079  Washington DC 2003 Female
    ## 3400      79.11135      63.53757 15.57377931  Washington DC 2003   Male
    ## 3401      84.13233      74.03026 10.10206291  Washington DC 2004 Female
    ## 3402      79.42357      64.14491 15.27866571  Washington DC 2004   Male
    ## 3403      84.50104      74.10796 10.39308601  Washington DC 2005 Female
    ## 3404      79.73258      64.56721 15.16536213  Washington DC 2005   Male
    ## 3405      84.55198      74.37979 10.17218903  Washington DC 2006 Female
    ## 3406      79.82622      65.17442 14.65179796  Washington DC 2006   Male
    ## 3407      84.68830      74.73693  9.95137111  Washington DC 2007 Female
    ## 3408      80.13554      65.74955 14.38598900  Washington DC 2007   Male
    ## 3409      84.93658      75.14313  9.79345035  Washington DC 2008 Female
    ## 3410      80.60157      66.31881 14.28276507  Washington DC 2008   Male
    ## 3411      85.31600      75.63835  9.67764662  Washington DC 2009 Female
    ## 3412      81.05227      66.98398 14.06829094  Washington DC 2009   Male
    ## 3413      85.36829      75.96691  9.40137992  Washington DC 2010 Female
    ## 3414      81.50232      67.99036 13.51195966  Washington DC 2010   Male
    ## 3415      85.72831      76.15640  9.57191235  Washington DC 2011 Female
    ## 3416      81.53388      68.57190 12.96197948  Washington DC 2011   Male
    ## 3417      85.83524      76.22988  9.60535567  Washington DC 2012 Female
    ## 3418      81.73702      68.89712 12.83990045  Washington DC 2012   Male
    ## 3419      85.99473      76.26234  9.73238872  Washington DC 2013 Female
    ## 3420      81.65717      68.98653 12.67063358  Washington DC 2013   Male
    ## 3421      74.13824      68.02021  6.11803320  West Virginia 1969 Female
    ## 3422      65.97002      59.54337  6.42665504  West Virginia 1969   Male
    ## 3423      74.27841      68.23788  6.04052665  West Virginia 1970 Female
    ## 3424      65.97879      59.72873  6.25005608  West Virginia 1970   Male
    ## 3425      74.57647      68.55952  6.01694560  West Virginia 1971 Female
    ## 3426      66.23830      59.83134  6.40696031  West Virginia 1971   Male
    ## 3427      74.68165      68.92405  5.75760555  West Virginia 1972 Female
    ## 3428      66.24882      60.00224  6.24657551  West Virginia 1972   Male
    ## 3429      75.18129      69.35841  5.82288622  West Virginia 1973 Female
    ## 3430      66.60857      60.27173  6.33683600  West Virginia 1973   Male
    ## 3431      75.46540      69.72478  5.74061327  West Virginia 1974 Female
    ## 3432      66.99501      60.61592  6.37909050  West Virginia 1974   Male
    ## 3433      75.84967      70.07165  5.77802409  West Virginia 1975 Female
    ## 3434      67.33772      61.04984  6.28787344  West Virginia 1975   Male
    ## 3435      76.01613      70.54433  5.47179929  West Virginia 1976 Female
    ## 3436      67.63068      61.59217  6.03850472  West Virginia 1976   Male
    ## 3437      76.42989      70.70602  5.72386294  West Virginia 1977 Female
    ## 3438      67.99160      61.89569  6.09591188  West Virginia 1977   Male
    ## 3439      76.58387      71.09124  5.49262817  West Virginia 1978 Female
    ## 3440      68.32093      62.29494  6.02599448  West Virginia 1978   Male
    ## 3441      76.99310      71.30190  5.69119869  West Virginia 1979 Female
    ## 3442      68.65729      62.78818  5.86910923  West Virginia 1979   Male
    ## 3443      77.17911      71.76970  5.40941574  West Virginia 1980 Female
    ## 3444      69.00134      63.14570  5.85564110  West Virginia 1980   Male
    ## 3445      77.39822      72.18760  5.21062711  West Virginia 1981 Female
    ## 3446      69.28409      63.46740  5.81669092  West Virginia 1981   Male
    ## 3447      77.61976      72.42853  5.19123464  West Virginia 1982 Female
    ## 3448      69.58940      63.73048  5.85891694  West Virginia 1982   Male
    ## 3449      77.67883      72.57983  5.09899929  West Virginia 1983 Female
    ## 3450      69.82272      63.90744  5.91528045  West Virginia 1983   Male
    ## 3451      77.68488      72.76649  4.91838901  West Virginia 1984 Female
    ## 3452      70.00562      64.24263  5.76298082  West Virginia 1984   Male
    ## 3453      77.71808      72.79509  4.92298673  West Virginia 1985 Female
    ## 3454      70.13688      64.46586  5.67102048  West Virginia 1985   Male
    ## 3455      77.69991      72.89192  4.80798541  West Virginia 1986 Female
    ## 3456      70.23642      64.64418  5.59223126  West Virginia 1986   Male
    ## 3457      77.73587      73.14664  4.58922744  West Virginia 1987 Female
    ## 3458      70.30924      64.76789  5.54134445  West Virginia 1987   Male
    ## 3459      77.80276      73.36016  4.44260530  West Virginia 1988 Female
    ## 3460      70.48784      64.90143  5.58641338  West Virginia 1988   Male
    ## 3461      77.99323      73.67044  4.32279247  West Virginia 1989 Female
    ## 3462      70.59947      65.01672  5.58274427  West Virginia 1989   Male
    ## 3463      78.09091      73.88705  4.20386716  West Virginia 1990 Female
    ## 3464      70.75951      65.11309  5.64642441  West Virginia 1990   Male
    ## 3465      78.05873      74.01024  4.04849202  West Virginia 1991 Female
    ## 3466      70.93317      65.32360  5.60957686  West Virginia 1991   Male
    ## 3467      78.13246      74.14325  3.98920362  West Virginia 1992 Female
    ## 3468      71.17387      65.49696  5.67691098  West Virginia 1992   Male
    ## 3469      78.05525      74.09547  3.95977833  West Virginia 1993 Female
    ## 3470      71.30576      65.60933  5.69643159  West Virginia 1993   Male
    ## 3471      78.08834      74.28245  3.80588483  West Virginia 1994 Female
    ## 3472      71.55208      65.80978  5.74229350  West Virginia 1994   Male
    ## 3473      78.13826      74.46584  3.67242640  West Virginia 1995 Female
    ## 3474      71.65748      66.01221  5.64527556  West Virginia 1995   Male
    ## 3475      78.08603      74.39107  3.69495885  West Virginia 1996 Female
    ## 3476      71.77228      66.27505  5.49723502  West Virginia 1996   Male
    ## 3477      77.93441      74.46437  3.47004092  West Virginia 1997 Female
    ## 3478      71.84117      66.59202  5.24915108  West Virginia 1997   Male
    ## 3479      77.98134      74.59830  3.38304053  West Virginia 1998 Female
    ## 3480      71.96214      66.86628  5.09585985  West Virginia 1998   Male
    ## 3481      77.85463      74.66561  3.18902270  West Virginia 1999 Female
    ## 3482      72.08221      67.23488  4.84732572  West Virginia 1999   Male
    ## 3483      77.81011      74.91562  2.89448417  West Virginia 2000 Female
    ## 3484      72.18472      67.57455  4.61016998  West Virginia 2000   Male
    ## 3485      77.82078      75.01603  2.80475557  West Virginia 2001 Female
    ## 3486      72.25620      67.83743  4.41876486  West Virginia 2001   Male
    ## 3487      77.81232      75.21990  2.59241692  West Virginia 2002 Female
    ## 3488      72.26939      68.03850  4.23089345  West Virginia 2002   Male
    ## 3489      77.80156      75.17370  2.62786416  West Virginia 2003 Female
    ## 3490      72.35412      68.31373  4.04038582  West Virginia 2003   Male
    ## 3491      77.94400      75.20592  2.73807115  West Virginia 2004 Female
    ## 3492      72.47863      68.57615  3.90247478  West Virginia 2004   Male
    ## 3493      78.01324      75.31125  2.70198897  West Virginia 2005 Female
    ## 3494      72.55916      68.76023  3.79893502  West Virginia 2005   Male
    ## 3495      78.12970      75.48039  2.64930983  West Virginia 2006 Female
    ## 3496      72.59601      68.91441  3.68159969  West Virginia 2006   Male
    ## 3497      78.12289      75.57403  2.54886276  West Virginia 2007 Female
    ## 3498      72.62749      69.06073  3.56675826  West Virginia 2007   Male
    ## 3499      77.97229      75.79291  2.17937932  West Virginia 2008 Female
    ## 3500      72.71066      69.21756  3.49310686  West Virginia 2008   Male
    ## 3501      78.10892      75.90151  2.20741447  West Virginia 2009 Female
    ## 3502      72.79428      69.36687  3.42740620  West Virginia 2009   Male
    ## 3503      78.16409      76.10271  2.06137980  West Virginia 2010 Female
    ## 3504      72.83726      69.48806  3.34919680  West Virginia 2010   Male
    ## 3505      78.06136      76.17244  1.88892201  West Virginia 2011 Female
    ## 3506      72.81152      69.50374  3.30778358  West Virginia 2011   Male
    ## 3507      78.07733      76.21912  1.85820924  West Virginia 2012 Female
    ## 3508      72.86606      69.47049  3.39557759  West Virginia 2012   Male
    ## 3509      78.15661      76.16591  1.99070878  West Virginia 2013 Female
    ## 3510      72.90225      69.52594  3.37631005  West Virginia 2013   Male
    ## 3511      76.34827      72.18321  4.16505867      Wisconsin 1969 Female
    ## 3512      69.26419      64.98089  4.28330384      Wisconsin 1969   Male
    ## 3513      76.63180      72.36087  4.27093180      Wisconsin 1970 Female
    ## 3514      69.40920      65.15182  4.25738838      Wisconsin 1970   Male
    ## 3515      76.84370      72.53224  4.31145977      Wisconsin 1971 Female
    ## 3516      69.75463      65.42027  4.33435465      Wisconsin 1971   Male
    ## 3517      76.97308      72.76996  4.20312518      Wisconsin 1972 Female
    ## 3518      69.70695      65.59026  4.11668975      Wisconsin 1972   Male
    ## 3519      77.24310      73.05764  4.18546492      Wisconsin 1973 Female
    ## 3520      69.99267      65.81085  4.18181919      Wisconsin 1973   Male
    ## 3521      77.69604      73.34654  4.34949691      Wisconsin 1974 Female
    ## 3522      70.22178      66.02837  4.19340941      Wisconsin 1974   Male
    ## 3523      78.09083      73.48214  4.60869151      Wisconsin 1975 Female
    ## 3524      70.67372      66.28163  4.39209209      Wisconsin 1975   Male
    ## 3525      78.26370      73.58715  4.67655012      Wisconsin 1976 Female
    ## 3526      71.02746      66.51381  4.51365376      Wisconsin 1976   Male
    ## 3527      78.65493      73.78449  4.87043664      Wisconsin 1977 Female
    ## 3528      71.40055      66.73173  4.66881476      Wisconsin 1977   Male
    ## 3529      78.82282      73.94310  4.87972415      Wisconsin 1978 Female
    ## 3530      71.55524      66.91371  4.64153866      Wisconsin 1978   Male
    ## 3531      79.20164      73.98369  5.21795700      Wisconsin 1979 Female
    ## 3532      71.87815      67.02885  4.84929750      Wisconsin 1979   Male
    ## 3533      79.20624      74.06609  5.14015451      Wisconsin 1980 Female
    ## 3534      72.01964      67.12387  4.89576685      Wisconsin 1980   Male
    ## 3535      79.45253      74.20152  5.25100935      Wisconsin 1981 Female
    ## 3536      72.33309      67.26693  5.06615562      Wisconsin 1981   Male
    ## 3537      79.63424      74.28160  5.35263634      Wisconsin 1982 Female
    ## 3538      72.59523      67.33554  5.25969752      Wisconsin 1982   Male
    ## 3539      79.73016      74.41529  5.31486719      Wisconsin 1983 Female
    ## 3540      72.70316      67.42050  5.28265942      Wisconsin 1983   Male
    ## 3541      79.90045      74.54726  5.35319626      Wisconsin 1984 Female
    ## 3542      72.87643      67.38956  5.48687206      Wisconsin 1984   Male
    ## 3543      79.86945      74.64546  5.22398962      Wisconsin 1985 Female
    ## 3544      73.08419      67.34037  5.74381362      Wisconsin 1985   Male
    ## 3545      79.91204      74.74157  5.17046731      Wisconsin 1986 Female
    ## 3546      73.24555      67.25196  5.99359184      Wisconsin 1986   Male
    ## 3547      80.06021      74.79503  5.26517496      Wisconsin 1987 Female
    ## 3548      73.43971      67.16263  6.27708135      Wisconsin 1987   Male
    ## 3549      80.09001      74.91176  5.17825345      Wisconsin 1988 Female
    ## 3550      73.54834      67.11196  6.43638550      Wisconsin 1988   Male
    ## 3551      80.22910      75.02316  5.20594019      Wisconsin 1989 Female
    ## 3552      73.88464      67.03371  6.85092402      Wisconsin 1989   Male
    ## 3553      80.39173      75.20872  5.18300417      Wisconsin 1990 Female
    ## 3554      74.07723      66.92372  7.15350792      Wisconsin 1990   Male
    ## 3555      80.58325      75.34825  5.23500038      Wisconsin 1991 Female
    ## 3556      74.22912      66.95776  7.27135912      Wisconsin 1991   Male
    ## 3557      80.78378      75.40494  5.37883330      Wisconsin 1992 Female
    ## 3558      74.54736      67.01827  7.52909035      Wisconsin 1992   Male
    ## 3559      80.65376      75.33433  5.31942559      Wisconsin 1993 Female
    ## 3560      74.56317      66.98369  7.57948099      Wisconsin 1993   Male
    ## 3561      80.72328      75.23598  5.48730122      Wisconsin 1994 Female
    ## 3562      74.74116      66.95050  7.79065675      Wisconsin 1994   Male
    ## 3563      80.79521      75.28122  5.51399231      Wisconsin 1995 Female
    ## 3564      74.88961      67.01586  7.87374618      Wisconsin 1995   Male
    ## 3565      80.90403      75.35508  5.54894851      Wisconsin 1996 Female
    ## 3566      75.05701      67.28074  7.77627676      Wisconsin 1996   Male
    ## 3567      80.96957      75.47695  5.49261790      Wisconsin 1997 Female
    ## 3568      75.34839      67.60083  7.74755718      Wisconsin 1997   Male
    ## 3569      80.92698      75.51307  5.41391157      Wisconsin 1998 Female
    ## 3570      75.47443      67.82771  7.64671751      Wisconsin 1998   Male
    ## 3571      80.88712      75.50669  5.38043807      Wisconsin 1999 Female
    ## 3572      75.54434      68.14088  7.40346242      Wisconsin 1999   Male
    ## 3573      80.94993      75.48019  5.46973927      Wisconsin 2000 Female
    ## 3574      75.79925      68.37718  7.42207424      Wisconsin 2000   Male
    ## 3575      81.05765      75.58893  5.46871117      Wisconsin 2001 Female
    ## 3576      75.92860      68.65637  7.27222787      Wisconsin 2001   Male
    ## 3577      81.19950      75.65749  5.54200869      Wisconsin 2002 Female
    ## 3578      76.08706      68.88468  7.20237825      Wisconsin 2002   Male
    ## 3579      81.46824      75.67063  5.79760300      Wisconsin 2003 Female
    ## 3580      76.39208      69.18159  7.21049125      Wisconsin 2003   Male
    ## 3581      81.71006      75.71951  5.99054926      Wisconsin 2004 Female
    ## 3582      76.67501      69.46263  7.21238589      Wisconsin 2004   Male
    ## 3583      81.68170      75.77630  5.90540719      Wisconsin 2005 Female
    ## 3584      76.86912      69.60820  7.26092146      Wisconsin 2005   Male
    ## 3585      81.85627      75.85209  6.00418803      Wisconsin 2006 Female
    ## 3586      77.13428      69.88914  7.24514446      Wisconsin 2006   Male
    ## 3587      82.04466      76.02080  6.02385650      Wisconsin 2007 Female
    ## 3588      77.32448      70.21011  7.11437093      Wisconsin 2007   Male
    ## 3589      82.16887      76.22281  5.94605941      Wisconsin 2008 Female
    ## 3590      77.44623      70.52313  6.92310184      Wisconsin 2008   Male
    ## 3591      82.45759      76.35614  6.10145138      Wisconsin 2009 Female
    ## 3592      77.69554      70.67366  7.02188054      Wisconsin 2009   Male
    ## 3593      82.32234      76.32467  5.99767159      Wisconsin 2010 Female
    ## 3594      77.73048      70.80655  6.92393214      Wisconsin 2010   Male
    ## 3595      82.22799      76.35424  5.87375458      Wisconsin 2011 Female
    ## 3596      77.76516      70.91821  6.84694957      Wisconsin 2011   Male
    ## 3597      82.33711      76.31667  6.02044451      Wisconsin 2012 Female
    ## 3598      77.87107      70.91615  6.95492556      Wisconsin 2012   Male
    ## 3599      82.24197      76.28350  5.95847174      Wisconsin 2013 Female
    ## 3600      77.79645      70.88431  6.91213667      Wisconsin 2013   Male

dplyr rename() to rename a variable
-----------------------------------

-   Let's rename the `sex` variable as `gender`

<!-- -->

    BlackWhite_results <- BlackWhite_results %>% 
      rename(gender = sex)

    names(BlackWhite_results)

    ## [1] "LE_white_mean" "LE_black_mean" "state"         "year"         
    ## [5] "gender"        "stabbrs"       "diff"

dplyr arrange() to sort the dataset based on one or several variables
---------------------------------------------------------------------

-   Try `arrange()`ing the dataset by the `diff` variable, and by
    `-diff`
-   Have a look at the results to compare

<!-- -->

    Results_sort1 <- BlackWhite_results %>% 
      arrange(diff)

    Results_sort2 <- BlackWhite_results %>% 
      arrange(-diff)

dplyr filter() to subset the data's rows based on a condition
-------------------------------------------------------------

-   Let's use `filter()` to create a new dataset `ny.women` that
    contains only women from New York.

<!-- -->

    ny.women <- BlackWhite_results %>% 
      filter(state == "New York", gender == "Female")

    dim(ny.women)

    ## [1] 45  7

dplyr summarise() to perform an aggregated calculation
------------------------------------------------------

-   Summarise can be used to calculate summary statistics
-   What variable does this code summarize over?

<!-- -->

    ny.women %>% 
      summarise(average.le.white = round(mean(LE_white_mean), 1),
                average.le.black = round(mean(LE_black_mean), 1))

    ##   average.le.white average.le.black
    ## 1             79.3             75.9

Stacking dplyr() functions using %&gt;%
---------------------------------------

-   What does this code do?

<!-- -->

     BlackWhite_results %>% 
      filter(state == "New York", gender == "Female", year > 2010) %>%
      summarise(average.le.white = round(mean(LE_white_mean), 1),
                average.le.black = round(mean(LE_black_mean), 1))

    ##   average.le.white average.le.black
    ## 1             82.9             82.5

dplyr group\_by() %&gt;% summarise()
------------------------------------

-   Pair together `group_by()` and `summarise()` to calculate summary
    statistics within groups

<!-- -->

    yearly.means <- BlackWhite_results %>% 
      group_by(year, gender) %>%
      summarise(ave.yr.gender = mean(diff))

dplyr cheat sheet
-----------------

-   <https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf>

Connect
-------

-   Mail: <corinne.riddell@mail.mcgill.ca>
-   Web: corinneriddell.com
-   GitHub: corinne-riddell
-   Twitter: @datavisitor
