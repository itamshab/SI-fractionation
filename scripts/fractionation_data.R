# import and clean fractionation data

# Author: Itamar Shabtai
# Version: 2020-01-26

# Libraries
library(tidyverse)
library(here)

# Parameters
  #input_file
file_raw <- here("data-raw/fractionation_experiment.csv")

file_elemental_raw <- here("data-raw/fractionation_isotope_elements.csv")

  #output_file
file_out <- here("data/fractionation_experiment.rds")
file_elemental_out <- here("data/fractionation_elemental.rds")


# ============================================================================

file_raw <-
  read_csv("data-raw/fractionation_experiment.csv") %>%
  select(c(1, 2, 8, 11, 14)) %>%
  rename(jar_ID = sample_num) %>%
  mutate(total_POM = fPOM_dry_mg_g + oPOM_dry_mg_g)

file_elemental_raw <- read_csv(file_elemental_raw) %>%
  filter(fraction != "MBC")

write_rds(file_raw, file_out)
write_rds(file_elemental_raw, file_elemental_out)
