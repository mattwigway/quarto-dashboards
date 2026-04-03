# get the census data on ages
library(tidycensus)
library(tidyverse)

data = map(c(2021, 2022, 2023, 2024), function(year) {
  get_acs(
    "state",
    variables = c(
      Male_0_4 = "B01001_003",
      Male_5_9 = "B01001_004",
      Male_10_14 = "B01001_005",
      Male_15_17 = "B01001_006",
      Male_18_19 = "B01001_007",
      Male_20_20 = "B01001_008",
      Male_21_21 = "B01001_009",
      Male_22_24 = "B01001_010",
      Male_25_29 = "B01001_011",
      Male_30_34 = "B01001_012",
      Male_35_39 = "B01001_013",
      Male_40_44 = "B01001_014",
      Male_45_49 = "B01001_015",
      Male_50_54 = "B01001_016",
      Male_55_59 = "B01001_017",
      Male_60_61 = "B01001_018",
      Male_62_64 = "B01001_019",
      Male_65_66 = "B01001_020",
      Male_67_69 = "B01001_021",
      Male_70_74 = "B01001_022",
      Male_75_79 = "B01001_023",
      Male_80_84 = "B01001_024",
      Male_85_Inf = "B01001_025",
      Female_0_4 = "B01001_027",
      Female_5_9 = "B01001_028",
      Female_10_14 = "B01001_029",
      Female_15_17 = "B01001_030",
      Female_18_19 = "B01001_031",
      Female_20_20 = "B01001_032",
      Female_21_21 = "B01001_033",
      Female_22_24 = "B01001_034",
      Female_25_29 = "B01001_035",
      Female_30_34 = "B01001_036",
      Female_35_39 = "B01001_037",
      Female_40_44 = "B01001_038",
      Female_45_49 = "B01001_039",
      Female_50_54 = "B01001_040",
      Female_55_59 = "B01001_041",
      Female_60_61 = "B01001_042",
      Female_62_64 = "B01001_043",
      Female_65_66 = "B01001_044",
      Female_67_69 = "B01001_045",
      Female_70_74 = "B01001_046",
      Female_75_79 = "B01001_047",
      Female_80_84 = "B01001_048",
      Female_85_Inf = "B01001_049"
    ),
    state = "NC",
    survey = "acs1"
  ) |>
    mutate(year = year)
}) |>
  list_rbind()

data = data |> separate_wider_delim(variable, "_", names=c("sex", "age_from", "age_to"))

data |>
  select(sex, age_from, age_to, count=estimate, year) |>
  write_csv("data/ages.csv")
