STAN for TAT
========================================================

Below is the model that I specified along with data, inits, etc. It was really very tricky to get it to fit at all - I had to give initialization values or it wouldn't fit at all. Now I am getting CRAZY numbers for the fit, as you see below, however. I think I have the model in the desired form for the exercise, so am perplexed about why it basically blows up.

I am attaching a text file with the model specification as well, since I know it doesn't come out great here. Any thoughts?


```r
library(rstan)
```

```
## Loading required package: Rcpp
## Loading required package: inline
## 
## Attaching package: 'inline'
## 
## The following object is masked from 'package:Rcpp':
## 
##     registerPlugin
## 
## rstan (Version 2.0.1, packaged: 2013-10-25 13:14:25 UTC, GitRev: 1a89615fac00)
```

```r


tat.data <- list(SubjIdx = 40, CondIdx = 2, N = rep(10, 40), Cond = c(rep(1, 
    20), rep(2, 20)), z = c(8, 4, 6, 3, 1, 4, 4, 6, 4, 2, 2, 1, 1, 4, 3, 3, 
    2, 6, 3, 4, 2, 1, 1, 3, 2, 7, 2, 1, 3, 1, 0, 2, 4, 2, 3, 3, 0, 1, 2, 2))

test.model <- "\n  data{\n    int <lower = 0> SubjIdx;\n    int <lower = 0> CondIdx;\n    int <lower = 0> Cond[SubjIdx];\n    int <lower = 0> N[SubjIdx];\n    int <lower = 0> z[SubjIdx];\n  }\n\n  parameters{\n    real <lower = 0, upper = 1> theta[SubjIdx];\n    real <lower = 0, upper = 1> mu[CondIdx];\n    real <lower = 0, upper = 1000> kappa[CondIdx];\n  }\n  \n  transformed parameters {\n    real <lower = 0, upper = 100> a[CondIdx];\n    real <lower = 0, upper = 100> b[CondIdx];\n    for (i in 1 : CondIdx){\n      a[CondIdx] <- mu[CondIdx] * kappa[CondIdx];\n      b[CondIdx] <- (1 - mu[CondIdx]) * kappa[CondIdx];\n    }\n  }\n  model{\n    for (i in 1 : SubjIdx){\n      z[i] ~ binomial(N, theta[i]);\n      theta[i] ~ beta(a[Cond[i]], b[Cond[i]]);\n    }\n    for (i in 1 : CondIdx){\n      mu[CondIdx] ~ beta(3.6, 6.5);\n      kappa[CondIdx] ~ gamma(10, 0.1);\n    }\n  }\n"
inits <- function() {
    list(theta = c(runif(40, 0, 1)), mu = c(runif(2, 0, 1)), kappa = c(runif(2, 
        0, 1000)))
}

test <- stan(model_code = test.model, data = tat.data, iter = 10000, chains = 3, 
    init = inits)
```

```
## 
## TRANSLATING MODEL 'test.model' FROM Stan CODE TO C++ CODE NOW.
## COMPILING THE C++ CODE FOR MODEL 'test.model' NOW.
## cygwin warning:
##   MS-DOS style path detected: C:/PROGRA~1/R/R-30~1.2/etc/x64/Makeconf
##   Preferred POSIX equivalent is: /cygdrive/c/PROGRA~1/R/R-30~1.2/etc/x64/Makeconf
##   CYGWIN environment variable option "nodosfilewarning" turns off this warning.
##   Consult the user's guide for more details about POSIX paths:
##     http://cygwin.com/cygwin-ug-net/using.html#using-pathnames
## C:/Users/nutting/Documents/R/win-library/3.0/rstan/include//stansrc/stan/agrad/rev/var_stack.hpp:49:17: warning: 'void stan::agrad::free_memory()' defined but not used [-Wunused-function]
## SAMPLING FOR MODEL 'test.model' NOW (CHAIN 1).
```

```
## error occurred during calling the sampler; sampling not done
```

```r

print(test)
```

```
## Stan model 'test.model' does not contain samples.
```

```r

```


