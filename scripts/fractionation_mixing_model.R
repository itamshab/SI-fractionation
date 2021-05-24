# This script loads isotope and elemental fraction data and calculates fraction
# of and amount litter in fractions

# Author: Itamar Shabtai
# Version: 2020-01-26

# Libraries
library(tidyverse)
library(here)
library(broom)

mytheme <- theme_bw() + theme(panel.grid = element_blank()) +
  theme(axis.text.x = element_text(size = 15)) +
  theme(axis.text.y = element_text(size = 15)) +
  theme(axis.title.x = element_text(size = 15)) +
  theme(axis.title.y = element_text(size = 15)) +
  theme(legend.text = element_text(size = 15)) +
  theme(legend.title = element_text(size = 15)) +
  theme(strip.text.x = element_text(size = 15))

# Parameters
  data_file <- here("data/fractionation_elemental.rds")

  # ============================================================================

# load data and convert to factors

  df <- read_rds(data_file) %>%
    select(!(c(weight_mg, n2_amp, at_per_N, co2_amp, at_per_C))) %>%
    filter(Moisture != "pre-incubation")

  df$fraction <- as.factor(df$fraction)
  df$treatment <- as.factor(df$Treatment)
  df$water_content <- as.factor(df$Moisture)
  df$sampling_point <- as.factor(df$Time)
  df$litter <- as.factor(df$Litter)

  reps <- c(1, 2, 3)

# turn data to wide and connect n and y litter to one wide tibble

  df_wide <- df %>%
    pivot_wider(names_from = Litter, values_from = c(C, N, delta13C, delta15N),
                id_cols = c(sample_ID, jars, fraction, Moisture, Treatment, Time))

    df_wide_Y <- df_wide %>%
    select(!(c(1, 2, 7,9,11,13))) %>%
    drop_na(C_Y)
  df_wide_Y <- cbind(df_wide_Y, reps)


  df_wide_N <- df_wide %>%
    select(!(c(1, 2, 8,10,12,14))) %>%
    drop_na(C_N)
  df_wide_N <- cbind(df_wide_N, reps)


# join n and y litter and mutate new variables

  df_wide_all <- full_join(df_wide_N, df_wide_Y) %>%
    mutate(frac_label_c = (delta13C_Y - delta13C_N)/(718 - delta13C_N),
           frac_label_n = (delta15N_Y - delta15N_N)/(23306 - delta15N_N),
           frac_13_c = frac_label_c * C_Y *10,
           frac_15_n = frac_label_n * N_Y * 10,
           frac_c_to_n = (frac_13_c) / (frac_15_n),
           C_N_N = (C_N) / (N_N),
           C_N_Y = (C_N) / (N_Y))


# recode and reorder variable levels

  df_wide_all$Moisture <- factor(df_wide_all$Moisture, levels = c("Low", "High"))
  df_wide_all$Treatment <- factor(df_wide_all$Treatment, levels = c("DW", "Ca"))


  write_csv(x = df_wide_all, file = here("data/fractions_df_wide.csv"))


# subset MAOM fraction and plot----

  df_wide_maom <- df_wide_all %>%
    filter(fraction == "MAOM")

# plot %C from label on MAOM

  ggplot(df_wide_maom, aes(Moisture, frac_label_c*100, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, frac_label_c*100, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C from label (%)")

  ggsave(filename = here("plots/frac_label_c_maom.svg"), plot = last_plot(), width = 6, height = 4)


# stats for %C from label on MAOM

  m_maom_per_c <- aov(frac_label_c*100 ~ Moisture*Treatment*Time, data = filter(df_wide_maom))
  m_maom_per_c_beg <- aov(frac_label_c*100 ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "Beginning"))
  m_maom_per_c_end <- aov(frac_label_c*100 ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "End"))

  tidy(m_maom_per_c)
  tidy(m_maom_per_c_beg)
  tidy(m_maom_per_c_end)

  TukeyHSD(m_maom_per_c)
  TukeyHSD(m_maom_per_c_beg)
  TukeyHSD(m_maom_per_c_end)


# plot amount of C from label on MAOM

  ggplot(df_wide_maom, aes(Moisture, frac_13_c, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_13_c, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "Amount of label in fraction (mg C/g)")

# stats for amount of C from label on MAOM

  m_maom_conc_c <- aov(frac_13_c ~ Moisture*Treatment*Time, data = filter(df_wide_maom))
  m_maom_conc_c_beg <- aov(frac_13_c ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "Beginning"))
  m_maom_conc_c_end <- aov(frac_13_c ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "End"))

  tidy(m_maom_conc_c)
  tidy(m_maom_conc_c_beg)
  tidy(m_maom_conc_c_end)

  TukeyHSD(m_maom_conc_c)
  TukeyHSD(m_maom_conc_c_beg)
  TukeyHSD(m_maom_conc_c_end)

# plot %N from label on MAOM

  ggplot(df_wide_maom, aes(Moisture, frac_label_n*100, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_label_n*100, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "N from label (%)")

# stats for %N from label on MAOM

  m_maom_per_n <- aov(frac_label_n*100 ~ Moisture*Treatment*Time, data = filter(df_wide_maom))
  m_maom_per_n_beg <- aov(frac_label_n*100 ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "Beginning"))
  m_maom_per_n_end <- aov(frac_label_n*100 ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "End"))

  tidy(m_maom_per_n)
  tidy(m_maom_per_n_beg)
  tidy(m_maom_per_n_end)

  TukeyHSD(m_maom_per_n)
  TukeyHSD(m_maom_per_n_beg)
  TukeyHSD(m_maom_per_n_end)

# plot amount of N from label on MAOM

  ggplot(df_wide_maom, aes(Moisture, frac_15_n, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_15_n, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "Amount of label in fraction (mg N/g)")

# stats for amount of N from label on MAOM

  m_maom_conc_n <- aov(frac_15_n ~ Moisture*Treatment*Time, data = filter(df_wide_maom))
  m_maom_conc_n_beg <- aov(frac_15_n ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "Beginning"))
  m_maom_conc_n_end <- aov(frac_15_n ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "End"))

  tidy(m_maom_conc_n)
  tidy(m_maom_conc_n_beg)
  tidy(m_maom_conc_n_end)

  TukeyHSD(m_maom_conc_n)
  TukeyHSD(m_maom_conc_n_beg)
  TukeyHSD(m_maom_conc_n_end)

# plot for label C:N on MAOM

  ggplot(df_wide_maom, aes(Moisture, frac_c_to_n, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, frac_c_to_n, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C:N ratio from label")


  ggsave(filename = here("plots/cn_ratio_litter_maom.svg"), plot = last_plot(), width = 6, height = 4)

# stats of label C:N on maom

  m_maom_cn_label <- aov(frac_c_to_n ~ Moisture*Treatment*Time, data = filter(df_wide_maom))
  m_maom_cn_label_beg <- aov(frac_c_to_n ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "Beginning"))
  m_maom_cn_label_end <- aov(frac_c_to_n ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "End"))

  tidy(m_maom_cn_label)
  tidy(m_maom_cn_label_beg)
  tidy(m_maom_cn_label_end)

  TukeyHSD(m_maom_cn_label)
  TukeyHSD(m_maom_cn_label_beg)
  TukeyHSD(m_maom_cn_label_end)

# plot the C:N ratio of the MAOM

  ggplot(df_wide_maom, aes(Moisture, C_N_Y, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, C_N_N, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C:N ratio in MAOM fraction")

  ggsave(filename = here("plots/cn_ratio_maom.svg"), plot = last_plot(), width = 6, height = 4)

  m_maom_cn <- aov(C_N_Y ~ Moisture*Treatment*Time, data = filter(df_wide_maom))
  m_maom_cn_beg <- aov(C_N_Y ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "Beginning"))
  m_maom_cn_end <- aov(C_N_Y ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "End"))

  tidy(m_maom_cn)
  tidy(m_maom_cn_beg)
  tidy(m_maom_cn_end)

  TukeyHSD(m_maom_cn)
  TukeyHSD(m_maom_cn_beg)
  TukeyHSD(m_maom_cn_end)


  ggplot(df_wide_all) +
    geom_jitter(aes(fraction, C_N_N, shape = Time), color = "blue") +
    geom_jitter(aes(fraction, C_N_Y, shape = Time), color = "red")

# stats of MAOM C:N

  m_maom_cn <- aov(frac_c_to_n ~ Moisture*Treatment*Time, data = filter(df_wide_maom))
  m_maom_cn_beg <- aov(frac_c_to_n ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "Beginning"))
  m_maom_cn_end <- aov(frac_c_to_n ~ Moisture*Treatment, data = filter(df_wide_maom, Time == "End"))

  tidy(m_maom_cn)
  tidy(m_maom_cn_beg)
  tidy(m_maom_cn_end)

  TukeyHSD(m_maom_cn)
  TukeyHSD(m_maom_cn_beg)
  TukeyHSD(m_maom_cn_end)

# subset oPOM fraction and plot----

  df_wide_opom <- df_wide_all %>%
    filter(fraction == "oPOM")


# plot %C from label in oPOM

  ggplot(df_wide_opom, aes(Moisture, frac_label_c*100, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, frac_label_c*100, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C from label (%)")

  ggsave(filename = here("plots/frac_label_c_opom.svg"), plot = last_plot(), width = 6, height = 4)

# plot amount of label C in oPOM

  ggplot(df_wide_opom, aes(Moisture, frac_13_c, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_13_c, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "Amount of label in fraction (mg C/g)")


# plot %N from label in oPOM

  ggplot(df_wide_opom, aes(Moisture, frac_label_n*100, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_label_n*100, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "N from label (%)")

# plot amount of N from label in oPOM

  ggplot(df_wide_opom, aes(Moisture, frac_15_n, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_15_n, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "Amount of label in fraction (mg N/g)")

# plot C:N ratio of label in oPOM

  ggplot(df_wide_opom, aes(Moisture, frac_c_to_n, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, frac_c_to_n, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C:N ratio from label")


  ggsave(filename = here("plots/cn_ratio_litter_opom.svg"), plot = last_plot(), width = 6, height = 4)


# plot C:N ration in oPOM fraction

  ggplot(df_wide_opom, aes(Moisture, C_N_Y, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, C_N_Y, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C:N ratio in oPOM fraction")

  ggsave(filename = here("plots/cn_ratio_opom.svg"), plot = last_plot(), width = 6, height = 4)

# subset fPOM fraction and plot----

  df_wide_fpom <- df_wide_all %>%
    filter(fraction == "fPOM")

# plot %C from label in fPOM

  ggplot(df_wide_fpom, aes(Moisture, frac_label_c*100, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, frac_label_c*100, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C from label (%)")

  ggsave(filename = here("plots/frac_label_c_fpom.svg"), plot = last_plot(), width = 6, height = 4)

# plot amount of C from label in fPOM

  ggplot(df_wide_fpom, aes(Moisture, frac_13_c, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "fixed") +
    geom_point(aes(Moisture, frac_13_c, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "Amount of label in fraction (mg C/g)")

# plot %N from label in fPOM

  ggplot(df_wide_fpom, aes(Moisture, frac_label_n*100, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_label_n*100, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "N from label (%)")

# plot amount of N from label in fPOM

  ggplot(df_wide_fpom, aes(Moisture, frac_15_n, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time, scales = "free") +
    geom_point(aes(Moisture, frac_15_n, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "Amount of label in fraction (mg N/g)")

# plot C:N of label in fPOM

  ggplot(df_wide_fpom, aes(Moisture, frac_c_to_n, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, frac_c_to_n, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C:N ratio from label")

  ggsave(filename = here("plots/cn_ratio_litter_fpom.svg"), plot = last_plot(), width = 6, height = 4)

# plot C:N of fPOM

  ggplot(df_wide_fpom, aes(Moisture, C_N_Y, fill = Treatment)) +
    geom_boxplot() +
    facet_wrap(nrow = 1, . ~ Time) +
    geom_point(aes(Moisture, C_N_Y, fill = Treatment),
               position = position_jitterdodge(jitter.width = 0.01), shape = 21, size = 2) +
    mytheme + scale_fill_brewer(palette = "Set1") +
    labs(x = "Water content", y = "C:N ratio in fPom fraction")

  ggsave(filename = here("plots/cn_ratio_fpom.svg"), plot = last_plot(), width = 6, height = 4)

