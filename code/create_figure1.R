# Function to create Figure 1: Foul Hits per Stadium Zone
create_figure1 <- function(foul_balls_data) {
  # Transform data and define categories for velocity and zones
  foul_balls_data %>%
    mutate(
      # Create a velocity category based on the exit velocity of foul balls
      velocity_cat = case_when(
        is.na(exit_velocity) ~ "Unknown exit velocity",  # Assign "Unknown" for missing data
        exit_velocity < 90 ~ "< 90 mph",  # Assign "< 90 mph" for low velocities
        exit_velocity >= 90 ~ "\u2265 90 mph"  # Assign "≥ 90 mph" for high velocities
      ) %>%
        factor(levels = c("Unknown exit velocity", "\u2265 90 mph", "< 90 mph")),  # Define order for velocity categories
      
      # Rename and categorize stadium zones, labeling "Zone 1" and maintaining specific order
      used_zone = factor(
        ifelse(used_zone == "1", "Zone 1", as.character(used_zone)),
        levels = c("7", "6", "5", "4", "3", "2", "Zone 1")
      )
    ) %>%
    # Create a ggplot object to visualize foul hits per stadium zone
    ggplot(aes(y = used_zone, fill = velocity_cat)) +
    geom_bar() +  # Use a bar plot to represent data
    
    # Apply a minimal theme for simplicity and adjust formatting
    theme_minimal() +
    theme(
      axis.title.x = element_blank(),  # Remove the x-axis title
      axis.title.y = element_blank(),  # Remove the y-axis title
      axis.text.x = element_text(color = "gray"),  # Style x-axis text
      axis.text.y = element_text(color = "black", face = "bold"),  # Style y-axis text
      legend.position = "none",  # Hide the legend
      panel.grid.major.x = element_line(color = "lightgray", size = 0.5),  # Add major grid lines to x-axis
      panel.grid.major = element_blank(),  # Remove other major grid lines
      panel.grid.minor = element_blank()  # Remove all minor grid lines
    ) +
    
    # Set x-axis scale and position
    scale_x_continuous(position = "top", breaks = seq(0, 250, 50)) +
    
    # Define custom colors for velocity categories
    scale_fill_manual(values = c(
      "< 90 mph" = "yellowgreen", 
      "\u2265 90 mph" = "cadetblue4", 
      "Unknown exit velocity" = "lightgray"
    )) +
    
    # Add text annotations to highlight categories in specific zones
    geom_text(aes(x = 75, y = "Zone 1", label = "< 90 mph"), color = "white", size = 5) +
    geom_text(aes(x = 210, y = "Zone 1", label = "Unknown exit velocity"), color = "white", size = 5) +
    geom_text(aes(x = 140, y = "3", label = "\u2265 90 mph"), color = "cadetblue4", size = 5)
}
