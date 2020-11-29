# import and clean fractionation data

# Author: Itamar Shabtai
# Version: 2020-01-26

# Libraries
library(tidyverse)
library(here)

# Parameters
  #input_file
file_raw <- here("data-raw/fractionation_experiment.csv")
  #output_file
file_out <- here("data/fractionation_experiment.rds")

# ============================================================================

file_raw <-
  read_csv("data-raw/fractionation_experiment.csv") %>%
  select(c(1, 2, 8, 11, 14)) %>%
  rename(jar_ID = sample_num) %>%
  mutate(total_POM = fPOM_dry_mg_g + oPOM_dry_mg_g)

write_rds(file_raw, file_out)

