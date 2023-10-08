---
title: "Representativeness"
subtitle: "Day 2"
author: 
 - Pieter van den Berg
 - Ryan van Lamoen
 - Taoying Farenhorst
date: 2023-10-09
date-format: long
format: eduquant-slides-revealjs
multiplex: false
---



## Day 2

::: columns
::: {.column width="15%"}
*13:00*

*13:30*

*14:30*

*15:30*

*16:30*

:::

::: {.column width="85%"}
Case study discussion & Recap

Economic & Market Conditions

Definition of Default

General estimation process

Case Study #2
:::
:::
::: footer 

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/unnamed-chunk-1_a8b74f1aad465d105c11f6a9566e084b'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/unnamed-chunk-1-1.png){width=384}
:::
:::

:::



# Case study discussion

::: {.cell hash='representativeness_day_2_cache/revealjs/setup_433d5d004fa37dae66fc9dd41073cbb7'}

:::



## Case study: scope of application { .smaller .r-fit-text auto-animate="true"}

:::: columns

::: {.column width="50%" #vcenter .r-fit-text }


#### Description

 * Two homogeneous segments A and B


::: 

::: {.column width="50%" #vcenter .r-fit-text }


::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/segment_plot_f907dfb5bb1ab1d987edb4c6647c720f'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/segment_plot-1.png){width=288}
:::
:::


:::


::::


## Case study: scope of application {.smaller .r-fit-text auto-animate="true"}

:::: columns

::: {.column width="50%" .r-fit-text }


#### Description

 * Two homogeneous segments A and B

 [...with a varying share $\frac{n_A}{n_A+n_B}(t)$]{style="color:darkcyan"}

::::: {.fragment .fade-in fragment-index=2}
 ...different (stationary) default levels 
:::::
::::: {.fragment .fade-in fragment-index=2}
 
:::::
::::: {.fragment .fade-in fragment-index=3} 
[**$\rightarrow$ What is the correct/allowed treatment**?]{style="color:slateblue"}
:::::



::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/segment_plot_f907dfb5bb1ab1d987edb4c6647c720f'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/segment_plot-1.png){width=288}
:::
:::

::: 

::: {.column width="50%" .r-fit-text }




::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/ratio_plot_7688f125cda0f538ecce3815f97bbf77'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/ratio_plot-1.png){width=288}
:::
:::


::::: {.fragment .fade-in fragment-index=2}

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/dr_plot_047efe7017190f94c0e1980b8c9e4053'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/dr_plot-1.png){width=288}
:::
:::

:::::
:::


::::

## Case study: scope of application {.smaller .r-fit-text auto-animate="true"}

:::: columns

::: {.column width="70%" .r-fit-text }


#### Description

 * Two homogeneous segments A and B

 [...with a varying share $\frac{n_A}{n_A+n_B}(t)$]{style="color:darkcyan"}

 ...different (stationary) default levels
 
 [**$\rightarrow$ Treatment depends on segmentation dimension**]{style="color:slateblue"}

|Segmentation|Level of risk|Treatment|
|--|--|--|


::: 

::: {.column width="30%" .r-fit-text }


::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/ratio_plot_7855f5afa8ecc86794d81d57642a5a49'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/ratio_plot-1.png){width=240}
:::
:::

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/dr_plot_7a64ceb8fb13f5bdf9c394ce917af93a'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/dr_plot-1.png){width=240}
:::
:::

:::


::::


## Case study: scope of application {.smaller .r-fit-text auto-animate="true"}

:::: columns

::: {.column width="75%" .r-fit-text }


#### Description

 [**$\rightarrow$ Treatment depends on segmentation dimension**]{style="color:slateblue"}

|Segmentation|Level of risk|Treatment|
|--|--|--|
|Behavioural|point-in-time|None/grade/pool|
|Econ. cond.|point-in-time|None/grade/pool|
|Econ. cond.|LRA/DT|Calibration segment|
|Fac./obligor type|cond. LRA/DT|Calibration segment|
|Processes|cond. LRA/DT|Type of exposures|
|*Other*|*cond. LRA/DT*|*Appropriate adjustment*|



:::::{.fragment fragment-index=1}
![](/media/rating_system_calib_segm_small.drawio.svg)
:::::


::: 

::: {.column width="25%" .r-fit-text }


::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/ratio_plot_7855f5afa8ecc86794d81d57642a5a49'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/ratio_plot-1.png){width=240}
:::
:::

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/dr_plot_7a64ceb8fb13f5bdf9c394ce917af93a'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/dr_plot-1.png){width=240}
:::
:::


:::


::::



## Case study: scope of application {.smaller .r-fit-text auto-animate="true"}

:::: columns

::: {.column width="75%" .r-fit-text }


#### Description

 $\rightarrow$ Treatment depends on segmentation dimension

|Segmentation|Level of risk|Treatment|
|--|--|--|
|*Other*|*cond. LRA/DT*|*Appropriate adjustment*|

 $\rightarrow$ Adjust calibraton target for [**effect of non-representativeness**]{style="color:slateblue"}

::::{.fragment}
![](/media/representativeness_simple.drawio.svg)
::::
::: 

::: {.column width="25%" .r-fit-text }


::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/ratio_plot_7855f5afa8ecc86794d81d57642a5a49'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/ratio_plot-1.png){width=240}
:::
:::

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/dr_plot_7a64ceb8fb13f5bdf9c394ce917af93a'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/dr_plot-1.png){width=240}
:::
:::

:::


::::





## Case study: scope of application {.smaller .r-fit-text auto-animate="true"}

:::: columns

::: {.column width="50%" .r-fit-text }


#### Description


 [$\rightarrow$ Adjust calibraton target for effect of non-representativeness]{style="color:slateblue"}
 
##### Representative of what?
 * Modelling problem
 * Typical approach: 
    - assume something reasonable
    - $r_0\sim\sum_t\frac{n_B}{n_A+n_B}(t)/T$
    - $r_0=\frac{n_B}{n_A+n_B}(t=\text{last Thursday})$
::: 

::: {.column width="50%" .r-fit-text }


:::::: {.r-stack}

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/ratio_plot_e5b3ce776294331ee0677f5fd98a525f'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/ratio_plot-1.png){width=384}
:::
:::


:::::{.fragment}

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/ratio_plot2_1d6fe6b7c02e59d8d6dc860a5af78e7b'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/ratio_plot2-1.png){width=384}
:::
:::

:::::
::::::
:::


::::



## Case study: scope of application {.smaller .r-fit-text auto-animate="true"}

:::: columns

::: {.column width="50%" .r-fit-text }


#### Description


[$\rightarrow$ Adjust calibraton target for effect of non-representativeness]{style="color:slateblue"}

$\r_0\sim\frac{1}{S}\sum_{u=1...S}\frac{n_B}{n_A+n_B}(t_{u_0}+u)$

$n^\prime_{B}(t)=\frac{r_0}{1-r_0}n_A(t)$

$D(t> t_{u_0})=\frac{D_A(t)n_A(t)+D_B(t)n_B(t)}{n_A(t)+n_B(t)}$

$D^\prime(t\le t_{u_0})=\frac{D_A(t)n_A(t)+D_B(t)n^\prime_B(t)}{n_A(t)+n^\prime_B(t)}$


$D^\prime(t\le t_{u_0})=\frac{D_A(t)+D_B(t)\frac{r_0}{1-r_0}}{n_A(t)+n^\prime_B(t)}n_A(t)$

::: 

::: {.column width="50%" .r-fit-text }
:::::{.fragment}

::: {.cell fig.asp='1' hash='representativeness_day_2_cache/revealjs/ratio_plot2_1d6fe6b7c02e59d8d6dc860a5af78e7b'}
::: {.cell-output-display}
![](representativeness_day_2_files/figure-revealjs/ratio_plot2-1.png){width=384}
:::
:::

:::::
:::


::::

