
# Script to generate a damage function for the social cost of ocean acidification
# Corinne Hartin CCD/CSIB
# May 2022

# what do i need? timeseries of the following:

# welfare estimates in USD for all scenarios
# ocean pH global mean
# global mean surface temperature

# Fit a function to both pH or [CO2] and GMT - stay tuned

library(readxl)
library(dplyr)
library(ggplot2)
library(tidyr)
library(equatiomatic)
library(plot3D)

# read in welfare estimates
welfare_us <- read_excel("US total annual economic impacts.xlsx") %>% 
  select(year, "RCP2.6 vs Present", "RCP8.5 vs Present") %>% 
  rename(rcp26 = "RCP2.6 vs Present") %>% 
  rename(rcp85 = "RCP8.5 vs Present") %>% 
  pivot_longer(cols = c("rcp26", "rcp85"),
               names_to = "scenario",
               values_to = "welfare"
                 ) %>% 
  mutate(welfare = welfare / 10^6) %>%  #convert to millions of dollars 
  mutate(region = "USA")

welfare_can <- read_excel("Canada total annual economic impacts.xlsx") %>% 
  select(Year, "RCP2.6 vs Present", "RCP8.5 vs Present") %>% 
  rename(rcp26 = "RCP2.6 vs Present") %>% 
  rename(rcp85 = "RCP8.5 vs Present") %>%
  rename(year = "Year") %>% 
  pivot_longer(cols = c("rcp26", "rcp85"),
               names_to = "scenario",
               values_to = "welfare"
  ) %>% 
  mutate(welfare = welfare / 10^6) %>%  #convert to millions of dollars 
  mutate(region = "Canada")

welfare <- full_join(welfare_us, welfare_can)

# double check data looks good
ggplot(welfare, 
       aes(year, welfare, color = region)) +
  facet_wrap(~ scenario, scales = "free") +
  geom_point()
  

# read in pH and temperature data
# Travis recommends taking the mean of the 3 models - pH values are both surface and bottom.  Do I just want surface? yes, b/c that's all the SCM can produce
# Or do i want to try with [CO2] - maybe try both
# global hydrogen ion - need to convert to pH

ph <- read.csv("GlobalYearlyAveragepH.csv") %>% 
  select(Year, GFDL.ESM2G.26hsurf, IPSL.CM5AMR.26hsurf, GFDL.ESM2G.85hsurf,
         IPSL.CM5AMR.85hsurf, MPI.ESMMR.26hsurf, MPI.ESMMR.85hsurf) %>% 
  pivot_longer(cols = c("GFDL.ESM2G.26hsurf", "IPSL.CM5AMR.26hsurf", "GFDL.ESM2G.85hsurf"
                        ,"IPSL.CM5AMR.85hsurf", "MPI.ESMMR.26hsurf", "MPI.ESMMR.85hsurf"),
               names_to = "model",
               values_to = "value") %>% 
  rename(year = Year) %>% 
  separate(model, c("model","B", "scenario") ) %>% 
  select(-B) %>% 
  pivot_wider(names_from = scenario, 
              values_from = value) %>% 
  group_by(year) %>% 
  summarise(rcp26 = mean(`26hsurf`), rcp85 = mean(`85hsurf`) ) %>% 
  mutate(rcp26 = -log10(rcp26*10^-6)) %>% 
  mutate(rcp85 = -log10(rcp85*10^-6)) %>% 
  select(year, rcp26, rcp85) %>% 
  pivot_longer(cols = c("rcp26","rcp85"),
               names_to = "scenario",
               values_to = "pH")

avg_ph <- ph %>% 
  filter(year %in% c(2011:2020)) %>% 
  summarise(avg = mean(pH))

ph <- ph %>% 
  mutate("pH" = pH - avg_ph$avg) %>% 
  filter(year >2019)

ggplot(ph, aes(year, pH, color = scenario))+
  geom_point()


###########################
# temperature files from Hector comparison data
###########################


RCP26 <- read.csv("summary_rcp26.csv") %>% 
  filter(vtag == "tgav") %>% 
  select(year, meanvalue, scenario)

avg_26 <- RCP26 %>% 
  filter(year %in% c(2011:2020)) %>% 
  summarise(avg = mean(meanvalue))

RCP26 <- RCP26 %>% 
  mutate("temp" = meanvalue - avg_26$avg)

RCP85 <- read.csv("summary_rcp85.csv") %>% 
  filter(vtag == "tgav") %>% 
  select(year, meanvalue, scenario)

avg_85 <- RCP85 %>% 
  filter(year %in% c(2011:2020)) %>% 
  summarise(avg = mean(meanvalue))

RCP85 <- RCP85 %>% 
  mutate("temp" = meanvalue - avg_85$avg)

temperature <- rbind(RCP26, RCP85) 

ggplot(temperature, aes(year, temp, color = scenario)) +
  geom_point()

############################
# Let's test out a lm 
# function with pH and welfare
###########################

df <- rbind(ph, welfare) 
df <- left_join(df, temperature) %>% 
  filter(year %in% c(2020:2100)) 
# 
# # testing out some fits
# # simple linear fit with one independent variable
# # simple linear fit with two independent variables
# 
# simple.fit <- lm(formula = welfare ~ ph_diff, data = df) 
# summary(simple.fit)
# extract_eq(simple.fit, use_coefs = TRUE, fix_signs = FALSE)
# # welfare is the dependent variable the one we are trying to predict
# # if i want to fit 2 variables in a linear fashion 
# # welfare ~ diff + temp
# ggplot(df, aes(temp, welfare))+
#   geom_point()+
#   geom_smooth(method = "lm")

double.fit <- lm(formula = welfare ~ temp + pH, data = df)
summary(double.fit)
extract_eq(double.fit, use_coefs = TRUE, fix_signs = FALSE)
ggplot(df, aes(temp, welfare))+
  geom_point()+
  geom_smooth(method = "lm")
# By using the confint() function we can obtain the confidence intervals of the parameters of our model.
# Confidence intervals for model parameters:
confint(double.fit, level=0.95)

#Plot of fitted vs residuals. No clear pattern should show in the residual plot if the model is a good fit
plot(fitted(double.fit),residuals(double.fit))

# plot up a cool figure 
scatter3D(x = df$ph_diff, y= df$welfare, z = df$temp,
          bty = "g",
          xlab="ph",
          ylab="welfare",
          zlab="temp",
          ticktype = "detailed")


#### trying out polynomial regressions
# create regressions for quadratic and cubic functions
fit <- lm(formula = df$welfare ~ poly(df$temp, 3))
summary(fit)
# By using the confint() function we can obtain the confidence intervals of the parameters of our model.
# Confidence intervals for model parameters:
confint(fit, level=0.95)

#Plot of fitted vs residuals. No clear pattern should show in the residual plot if the model is a good fit
plot(fitted(fit),residuals(fit))


fit_1 = lm(welfare~ph_diff+temp, data = df)
fit_3 = lm(welfare~ph_diff+poly(temp,3), data = df)
fit_5 = lm(welfare~ph_diff+poly(temp,5), data = df)
fit_9 = lm(welfare~ph_diff+poly(temp,9), data = df)
print(anova(fit_1,fit_3, fit_5, fit_9))
#The most important value in the entire output is the p-value because this tells us whether there is a significant difference in the mean values between the three groups.


# is there actual structure in the high temps? Does this represent something physical?
ggplot(df) +
  geom_point(aes(temp, welfare, shape = factor(region), color = scenario), cex = 2) 


+
  stat_smooth(method = "lm", formula = y~poly(x,1), aes(temp, fit_1$fitted.values, col = "Order 1")) +
  stat_smooth(method = "lm", formula = y~poly(x,3), aes(temp, fit_3$fitted.values, col = "Order 3")) +
  stat_smooth(method = "lm", formula = y~poly(x,5), aes(temp, fit_5$fitted.values, col = "Order 5")) +
  stat_smooth(method = "lm", formula = y~poly(x,9), aes(temp, fit_9$fitted.values, col = "Order 9")) +
  scale_colour_manual("",
                      breaks = c("Original",  "Order 1",  "Order 3", "Order 5", "Order 9"),
                      values = c("red","cyan", "blue",  "orange"
                                 ,"green")) +
  theme_minimal() 
  
  

# testing out polynomial on different order of variables
# not significant
fitph_1 = lm(welfare~temp+ph_diff, data = df)
fitph_2 = lm(welfare~temp+poly(ph_diff,2), data = df)
fitph_3 = lm(welfare~temp+poly(ph_diff), data = df)
print(anova(fitph_1,fitph_2,fitph_3))
# none of these are significant

