
# This is a human-written portion of the code where I connect to the PAN db

# Libraries
library(tidyverse)
library(DBI)

# Connect to db
con <- dbConnect(
  RPostgres::Postgres(),
  host = Sys.getenv("host"),
  user = Sys.getenv("user"),
  password = Sys.getenv("password"),
  dbname = Sys.getenv("dbname"),
)

# Pull a couple data tables
p2_redcap_demographics <- dbReadTable(con, "p2_redcap_demographics")
scores_flk <- dbReadTable(con, "scores_flk")

# Claude-written portion: Pasted the above code and asked the following in claude.ai:
# This code pulls two tables: demographics and flanker scores. 
# Join the two tables and filter the data to get the most recent score for each id

# Keep only the most recent flanker score per id
latest_flk <- scores_flk %>%
  group_by(hml_id) %>%
  slice_max(order_by = FLK_game_result, n = 1, with_ties = FALSE) %>%
  ungroup()

# Join to demographics
flk_demo <- p2_redcap_demographics %>%
  inner_join(latest_flk, by = "hml_id")


