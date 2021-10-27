#########################
## Assignment 4        ##
##      CLASS 4        ##
##  Deadline:          ##
##  2021/11/2 17:40   ##
#########################

##
# Create your own theme for ggplot!
#   In principle you should use this ggplot theme in the remainder of the course for assignments ect.
#   Of course you can change along, but I would like to encourage all of you to use a personalized theme!
#
#  !! Please RENAME this file and call it accordingly in the runfile !! 
#
#   To get 7 points you will need to modify at least 7 parameters of the theme_classic or theme_bw!

theme_colorized <- function( base_size = 11, base_family = "") {
  # Inherit the basic properties of theme_bw
  theme_classic() %+replace% 
    # Replace the following items:
    theme(
      # place legend to the top right and add some formatting
      legend.position = c(.95, .95),
      legend.justification = c("right", "top"),
      legend.box.just = "right",
      legend.margin = margin(6, 6, 6, 6),
      legend.key = element_rect(colour = NULL, fill = "white"),
      # colorize major x grid
      panel.grid.major.x = element_line(colour = "white"),
      # fill the background
      panel.background = element_rect(fill = "grey87"),
      # fill the plot background
      plot.background = element_rect(fill = "cyan"),
      axis.line = element_line(color = "black"),
      axis.ticks = element_line(color = "black"),
      axis.text = element_text(color = "black"),
      plot.caption =
    )
}