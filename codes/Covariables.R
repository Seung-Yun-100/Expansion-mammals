
################### Covariables
## Landuse
landuse76 <- read.csv("./data/landuse/mesh5_district_LU76_per.csv") %>%
  mutate(AG = LU76_AG, FO = LU76_FO, HU = LU76_BU + LU76_TR + LU76_OT) %>%
  select(mesh_code, AG, FO, HU)

landuse06 <- read.csv("./data/landuse/mesh5_district_LU06_per.csv") %>%
  mutate(AG = LU06_AG, FO = LU06_FO, HU = LU06_BU + LU06_TR + LU06_OT + LU06_GO) %>%
  select(mesh_code, AG, FO, HU)

landuse14 <- read.csv("./data/landuse/mesh5_district_LU14_per.csv") %>%
  mutate(AG = LU14_AG, FO = LU14_FO, HU = LU14_BU + LU14_TR + LU14_OT + LU14_GO) %>%
  select(mesh_code, AG, FO, HU)


## ALAN
light03 <- read.csv("./data/ALAN/nightlight_2003.csv") %>% select(mesh_code, NL2003mean) %>% rename(NL2003 = NL2003mean)
light14 <- read.csv("./data/ALAN/nightlight_2014.csv") %>% select(mesh_code, NL2014mean) %>% rename(NL2014 = NL2014mean)
light17 <- read.csv("./data/ALAN/nightlight_2017.csv") %>% select(mesh_code, NL2017mean) %>% rename(NL2017 = NL2017mean)


## Topography
topo <- read.csv("./data/topography/topography.csv")


## Snow
snow02 <- read.csv("./data/snow/2002/SD_Max_2002_inland_mean.csv") %>% select(mesh_code, m_maxSD) %>% rename(snow = m_maxSD)
snow13 <- read.csv("./data/snow/2013/SD_Max_2013_inland_mean.csv") %>% select(mesh_code, m_maxSD) %>% rename(snow = m_maxSD)
snow16 <- read.csv("./data/snow/2016/SD_Max_2016_inland_mean.csv") %>% select(mesh_code, m_maxSD) %>% rename(snow = m_maxSD)


## Abandonment
abandon05 <- read.csv("./data/abandonment/agricensus2005_mesh5.csv") %>% select(mesh_code, abaTs) %>% rename(aband = abaTs)
abandon15 <- read.csv("./data/abandonment/agricensus2015_mesh5.csv") %>% select(mesh_code, abaTs) %>% rename(aband = abaTs)


#### Land Ratio
LandRatio <- read.csv("./data/grid/mesh5_nolake_noocean_54n_land_ratio.csv") 

#### District
district <- read.csv("./data/district/district_code.csv") 


###################################

enviro2003 <- left_join(landuse06, light03, by = join_by(mesh_code)) %>% 
  left_join(., topo, by = join_by(mesh_code)) %>% 
  left_join(., snow02, by = join_by(mesh_code)) %>% 
  left_join(., abandon05, by = join_by(mesh_code)) %>% 
  left_join(., LandRatio, by = join_by(mesh_code)) %>%
  left_join(., district, by = join_by(mesh_code))


enviro2014 <- left_join(landuse14, light14, by = join_by(mesh_code)) %>% 
  left_join(., topo, by = join_by(mesh_code)) %>% 
  left_join(., snow13, by = join_by(mesh_code)) %>% 
  left_join(., abandon15, by = join_by(mesh_code)) %>% 
  left_join(., LandRatio, by = join_by(mesh_code)) %>%
  left_join(., district, by = join_by(mesh_code))


enviro2017 <- left_join(landuse14, light17, by = join_by(mesh_code)) %>% 
  left_join(., topo, by = join_by(mesh_code)) %>% 
  left_join(., snow16, by = join_by(mesh_code)) %>% 
  left_join(., abandon15, by = join_by(mesh_code)) %>% 
  left_join(., LandRatio, by = join_by(mesh_code)) %>%
  left_join(., district, by = join_by(mesh_code))

###################################

rm(list = setdiff(ls(), c("enviro2003", "enviro2014", "enviro2017")))

###################################
