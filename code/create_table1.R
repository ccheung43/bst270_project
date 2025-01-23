# Function to create Table 1: Descriptive Statistics 
create_table1 <- function(foul_balls_data) {
  # Summarize the number of foul balls by game date and matchup, and extract the team name from the matchup string
  most_foul_heavy_day_tbl <- foul_balls_data %>%
    group_by(game_date, matchup) %>%
    summarize(foul_balls = n()) %>%  # Count the number of foul balls
    mutate(team = sub(" [Vv][Ss] .*", "", matchup))  # Extract the team name from the matchup
  
  # Initialize an empty data frame to store the average foul ball count for each stadium
  stadium_foul_avgs_tbl <- data.frame(stadium = character(), avg_foul_balls = numeric(), stringsAsFactors = FALSE)
  
  # List all CSV files in the directory containing per-stadium data
  csv_files <- list.files("data/full_data_by_stadium", pattern = "\\.csv$", full.names = TRUE)
  
  # Loop through each CSV file to calculate the average foul balls per game for each stadium
  for (file in csv_files) {
    data <- read.csv(file)  # Read the data from the current CSV file
    stadium_name <- gsub("_", " ", tools::file_path_sans_ext(basename(file)))  # Extract and clean stadium name
    avg_foul_balls <- data %>%
      group_by(game_date) %>%  # Group data by game date
      summarise(total_foul_balls = n()) %>%  # Count total foul balls for each game date
      summarise(avg_foul_balls = round(mean(total_foul_balls))) %>%  # Calculate the average foul balls per game
      pull(avg_foul_balls)  # Extract the calculated average
    # Append the stadium name and average foul balls to the summary table
    stadium_foul_avgs_tbl <- rbind(stadium_foul_avgs_tbl, data.frame(stadium = stadium_name, avg_foul_balls = avg_foul_balls))
  }
  
  # Read the mapping between stadiums and their corresponding teams
  stadium_team_key <- read.csv("data/stadium_team_key.csv")
  
  # Merge the foul-heavy day data with the stadium-team key to include stadium information
  most_foul_heavy_day_tbl <- merge(stadium_team_key, most_foul_heavy_day_tbl, by = "team")
  
  # Merge the stadium average foul ball data with the foul-heavy day data
  tbl1 <- merge(stadium_foul_avgs_tbl, most_foul_heavy_day_tbl, by = "stadium") %>%
    select(-c(team)) %>%  # Remove the team column as it's no longer needed
    arrange(desc(foul_balls))  # Arrange the table by descending number of foul balls
  
  # Rename columns for better readability in the final table
  colnames(tbl1) <- c("STADIUM", "AVERAGE NO. OF FOULS PER GAME", "DATE", "MATCHUP", "NO. OF FOULS")
  
  # Create a styled table using the 'gt' package
  tbl1 <- tbl1 %>%
    gt() %>%
    # Apply a color scale to the "NO. OF FOULS" column
    data_color(
      columns = c("NO. OF FOULS"),
      fn = scales::col_numeric(
        palette = c("aquamarine3", "aquamarine4"),  # Define color palette
        domain = c(min(tbl1$`NO. OF FOULS`), max(tbl1$`NO. OF FOULS`))  # Set color range based on data
      )
    ) %>%
    # Group related columns under a spanner labeled "MOST FOUL-HEAVY DAY"
    tab_spanner(label = "MOST FOUL-HEAVY DAY", columns = c("DATE", "MATCHUP", "NO. OF FOULS"))
  
  return(tbl1)
}
