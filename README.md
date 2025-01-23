# BST 270: Individual Project

**Author**: Caitlin Cheung  
**Date**: January 21, 2025  

---

## Overview

This project reproduces elements of the FiveThirtyEight article ["We Watched 906 Foul Balls To Find Out Where The Most Dangerous Ones Land"](https://fivethirtyeight.com/features/we-watched-906-foul-balls-to-find-out-where-the-most-dangerous-ones-land/). The article explores foul ball data from MLB stadiums, identifying areas with the highest risks for fans and advocating for enhanced safety measures.  

Key goals of this project:
- Reproduce **Table 1**: Descriptive statistics for foul balls.
- Recreate **Figure 1**: Foul ball distribution by stadium zones, categorized by exit velocity.

---

## Environment

This project uses R for data analysis and visualization. Below are the required packages:

- [`dplyr`](https://dplyr.tidyverse.org/): For data manipulation.
- [`gt`](https://gt.rstudio.com/): For creating publication-quality tables.
- [`ggplot2`](https://ggplot2.tidyverse.org/): For data visualization.

Install these packages in R using:

```r
install.packages(c("dplyr", "gt", "ggplot2"))

```

├── README.md # Project documentation ├── data/ # Input datasets │ ├── foul_balls.csv # Foul ball dataset from FiveThirtyEight │ ├── stadium_team_key.csv # Dataset linking stadium to team │ ├── table1_original.png # Original table from FiveThirtyEight │ ├── figure1_original.png # Original figure from FiveThirtyEight │ └── full_data_by_stadium/ # Stadium full datasets from Baseball Savant │ ├── Camden_Yards.csv
│ ├── Citizens_Bank_Park.csv │ ├── Dodger_Stadium.csv
│ ├── Globe_Life_Park.csv
│ ├── Miller_Park.csv
│ ├── Oakland_Coliseum.csv
│ ├── PNC_Park.csv
│ ├── SunTrust_Park.csv
│ ├── T-Mobile_Park.csv
│ └── Yankee_Stadium.csv
├── code/ # R scripts for analysis │ ├── create_table1.R # Script to reproduce Table 1 │ └── create_figure1.R # Script to recreate Figure 1 ├── foul_balls_reproduction.Rmd # RMarkdown file for complete reproduction └── foul_balls_reproduction.html # HTML (knit) file for complete reproduction

Copy
Edit
## Getting Started 

1. Clone the GitHub repository. 
2. Open the foul_balls_reproduction.Rmd file in RStudio (after installing dplyr, gt, and ggplot2 packages).
3. Click "Run" to execute the notebook. 

## Data

The data set used for the reproduction analysis is available at "data/foul_balls.csv". It is available on [GitHub](https://github.com/fivethirtyeight/data/tree/master/foul-balls).

Column | Description
-------|-------------
`matchup` | The two teams that played
`game_date`| Date of the most foul-heavy day at each stadium
`type_of_hit` | Fly, grounder, line drive, pop up or batter hits self
`exit_velocity` | Recorded exit velocity of each hit -- blank if not provided
`predicted_zone` | The zone we predicted the foul ball would land in by gauging angles
`camera_zone` | The zone that the foul ball landed in, confirmed by footage
`used_zone` | The zone used for analysis 
 
Original Data Source: [Baseball Savant](https://baseballsavant.mlb.com/statcast_search?hfPT=&hfAB=&hfBBT=&hfPR=foul%7C&hfZ=&stadium=&hfBBL=&hfNewZones=&hfGT=R%7C&hfC=&hfSea=2019%7C&hfSit=&player_type=pitcher&hfOuts=&opponent=&pitcher_throws=&batter_stands=&hfSA=&game_date_gt=&game_date_lt=2019-06-05&hfInfield=&team=&position=&hfOutfield=&hfRO=&home_road=&hfFlag=&hfPull=&metric_1=&hfInn=&min_pitches=0&min_results=0&group_by=venue&sort_col=pitches&player_event_sort=h_launch_speed&sort_order=desc&min_pas=0#results)


