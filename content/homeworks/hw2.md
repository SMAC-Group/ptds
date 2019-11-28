+++
title = "homework #2"
date =  2018-08-17T16:40:55+02:00
weight = 20
+++

{{% notice warning %}}
**Deadline: 2019-10-21 at 4pm**  
To submit your work, add `samorso` and `irudnyts` as collaborators to your private GitHub repo.  
We will grade only the latest files prior to the deadline. Any ulterior modifications are pointless. 
{{% /notice %}}

The objectives of this homework assignment are the followings:

- Learn how program effectively using if/else and iterations statements; 
- Become familiar with using data frame objects and mapping packages;  
- Constructing a portfolio;  
- Become familiar with GitHub and using it as a collaborative tool.

To begin with, create a (preferably private) GitHub repository for your group, and name it `ptds2019hw2`. Once again, make sure to add `samorso` and `irudnyts` as collaborators. This project **must** be done using GitHub and respect the following requirements:

- All members of the group must commit at least once.  
- All commit messages must be reasonably clear and meaningful.  
- Your GitHub repository must include at least one issue containing some form of TO DO list. 

You can create one or several RMarkdown files to answer the following problems:

#### Problem 1: Fuzz Bizz
Write a program that prints the numbers from 1 to 1000, but with the following specific requirement:

- for multiples of three, print "Fuzz" instead of the number; 
- for the multiples of five print "Bizz" instead of the number; 
- for numbers which are multiples of both three and five print "FuzzBizz" instead of the number.

An example of the output would be: 

```{toml}
1, 2, Fuzz, 4, Bizz, Fuzz, 7, 8, Fuzz, Bizz, 11, Fuzz, 13, 14, FuzzBizz, 16, 17, Fuzz, 19, Bizz, Fuzz, 22, 23, Fuzz, Bizz, 26, Fuzz, 28, 29, FuzzBizz, 31, 32, Fuzz, 34, Bizz, Fuzz, ...
```
#### Problem 2: Map
Using the same tools we used in class, create a simple map to represent the volume of the real estate market in Switzerland. More specifically, the goal of this problem is to reproduce as closely as possible the map below:

<img src="/homeworks/map_hw2.png" alt="map" width="400px"/> 

Note that the code below was used to scrap the data needed for this graph:

```{toml}
library("rworldmap")
library("rworldxtra")
library("ggmap")
library("tidyverse")
library("magrittr")
library("ptdspkg")

cities <- tibble(
  name = c("zurich", "bern", "lausanne", "geneva", "basel"),
  language = c("german", "german", "french", "french", "german"),
  latitude = c(47.369019, 46.948002, 46.519630, 46.204391, 47.559608),
  longitude = c(8.538030, 7.448130, 6.632130, 6.143158, 7.580610)
)

# Scrap prices from comparis.ch using ptdspkg::get_volume()
#-------------------------------------------------------------------------------

cities <- cities %>%
  mutate(volume = sapply(name, get_volume))

# Draw the map
#-------------------------------------------------------------------------------

world_map <- getMap(resolution = "high")

which(sapply(1:243, function(x) world_map@polygons[[x]]@ID) == "Switzerland")

switzerland <- world_map@polygons[[40]]@Polygons[[1]]@coords %>% as_tibble()

# your code goes here
```

#### Problem 3: 3D-random walk

In this problem you will program a three-dimensional random walk. For this purpose we will consider a three-dimensional space where we let $\mathbf{X}_0 = [0 \;\; 0\;\; 0]^T$ denote the starting point of our process. Suppose that there exists a sequence of (univariate) random variables $U_1, \cdots, U_B$ such $U_t \stackrel{iid}{\sim} \mathcal{U}(0,1)$. Then, we let the position at time $t$ (where $1 \leq t \leq B$) be given by $$\mathbf{X}_t = \mathbf{X}_s + \mathbf{f}(U_t),$$ where $s=t-1$. The function $\mathbf{f}$ gives the new direction. For simplicity, we assume that at each time $t$ the process moves one-step forward or backward in (only) one of the three dimensions. Let us introduces five "threeshold values" $0\leq a_1<a_2<a_3<a_4<a_5\leq1$. So to be concrete, the function $\mathbf{f}$ returns the following vectors:

- $[+1\;\;0\;\;0]^T$ if $U_t\leq a_1$,   
- $[-1\;\;0\;\;0]^T$ if $U_t\in(a_1,a_2]$,   
- $[0\;\;+1\;\;0]^T$ if $U_t\in(a_2,a_3]$,   
- $[0\;\;-1\;\;0]^T$ if $U_t\in(a_3,a_4]$,   
- $[0\;\;0\;\;+1]^T$ if $U_t\in(a_4,a_5]$,   
- $[0\;\;0\;\;-1]^T$ if $U_t>a_5$.   

For example, let $B = 2$, $a_i = \frac{i}{6}$, $U_1 = 0.12$ and $U_2 = 0.81$ then we have, at the first step, $$ \mathbf{X}_1 = \mathbf{X}_0 + \mathbf{f}(U_1) = [0\;\;0\;\;0]^T + [1\;\;0\;\;0]^T = [1\;\;0\;\;0]^T, $$ and at the second step, $$ \mathbf{X}_2 = \mathbf{X}_1 + \mathbf{f}(U_2) = [1\;\;0\;\;0]^T + [0\;\;0\;\;1]^T = [1\;\;0\;\;1]^T. $$

- **(a)** Using the same idea, simulate a three-dimensional random walk with $B = 10^4$, $a_i = \frac{i}{6}$ and with $U_t$ being obtained as follows:

```{toml}
B <- 10^4
set.seed(1982)
Ut <- runif(B)
```

Notice that $U_t$ corresponds to the *t*-th element of `Ut`. With this configuration, show that a the last step you obtain $$ \mathbf{X}_B = [26\;\;-44\;\;26]^T, $$ and provide a graphical respresentation of your random walk. For example, you can produce a graph similar to the one below which is based on the function `segments3D` from the `plot3D` package. Note that the red and blue points indicate, respectively the starting and end points of the random walk.

<img src="/homeworks/rw3d_hw2.png" alt="map" width="600px"/> 

- **(b)** Repeat part **(a)** by modifying the parameters: $B = 10^5$, $a_i = 0.99 \frac{i}{6}$ and with $U_t$ being obtained as follows

```{toml}
B <- 10^5
set.seed(2000)
Ut <- runif(B)
```

Verify that you obtain $$ \mathbf{X}_B = [142\;\;-133\;\;-899]^T $$ and produce a graph similar to:

<img src="/homeworks/rw3d2_hw2.png" alt="map" width="600px"/> 

- **bonus** Use the package `animation` to create a video that shows how a random walk evolves over time.

#### Problem 4: portfolio construction
Suppose that you are working in an investment firm company as a quantitative analyst. Your boss gives you the task of creating a portfolio for one of your clients. The client wants to find the portfolio with the smallest variance that satisfies the following constraints:
  
- Invest exactly $1,000,000.  
- Invest in exactly two stocks of the S&P500 index.  

Therefore, your boss requires that you compute all possible portfolios that satify the client's constraints, represent them graphically as (for example) in the graph below and find the weight of the best (i.e. minimum variance) portfolio. 

<img src="/homeworks/port_hw2.png" alt="map" width="600px"/>

In order to complete this task, the boss tells you to use **3 years** of historical data. The boss also mentions that the function `get()` could be useful for this project and provides you with the example below (what a really nice boss!): 

```{toml}
library(quantmod)
library(rvest)
sp500 <- read_html("https://en.wikipedia.org/wiki/List_of_S%26P_500_companies")

sp500 %>% 
  html_nodes(".text") %>% # "td:nth-child(1) .text" should be used instead
  html_text() -> ticker_sp500

SP500_symbol <- ticker_sp500[(1:499)*2+1]

# Replace "." by "-"
SP500_symbol <- gsub(".","-",SP500_symbol,fixed=T)

# Specify timing
tot_length <- 3 * 365
today <- Sys.Date()
seq_three_years <- seq(today,by=-1,length.out=tot_length)
three_year_ago <- seq_three_years[tot_length]

# Retrieve data for a stock
i <- 1
getSymbols(SP500_symbol[i],from=three_year_ago,to=today)
stock_price <- ClCl(get(SP500_symbol[i]))
```

