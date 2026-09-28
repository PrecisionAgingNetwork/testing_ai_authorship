
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

