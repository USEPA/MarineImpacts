# lets make a damage function for each region using both scenarios
canada <- left_join(welfare_can, ph)

temp <- temperature %>% 
  select(year, scenario, temp) %>% 
  filter(year<2101) %>% 
  filter(year>2019)

can <- left_join(canada,temp)

double.fit <- lm(formula = welfare ~ temp + pH, data = can)

summary(double.fit)

extract_eq(double.fit, use_coefs = TRUE, fix_signs = FALSE)
ggplot(can, aes(temp, welfare, color = scenario))+
  geom_point()+
  geom_smooth(method = "lm")+
  ggtitle("Canada")
# By using the confint() function we can obtain the confidence intervals of the parameters of our model.
# Confidence intervals for model parameters:
confint(double.fit, level=0.95)

#Plot of fitted vs residuals. No clear pattern should show in the residual plot if the model is a good fit
plot(fitted(double.fit),residuals(double.fit))

# plot up a cool figure 
scatter3D(x = can$pH, y= can$welfare, z = can$temp,
          bty = "g",
          xlab="ph",
          ylab="welfare",
          zlab="temp",
          ticktype = "detailed")

usa <- left_join(welfare_us, ph)
usa <- left_join(usa, temp)


double.fit <- lm(formula = welfare ~ temp + pH, data = usa)

summary(double.fit)

extract_eq(double.fit, use_coefs = TRUE, fix_signs = FALSE)
ggplot(usa, aes(pH, welfare, color = scenario))+
  geom_point()+
  geom_smooth(method = "lm")+
  ggtitle("USA")
# By using the confint() function we can obtain the confidence intervals of the parameters of our model.
# Confidence intervals for model parameters:
confint(double.fit, level=0.95)

#Plot of fitted vs residuals. No clear pattern should show in the residual plot if the model is a good fit
plot(fitted(double.fit),residuals(double.fit))

# plot up a cool figure 
scatter3D(x = usa$pH, y= usa$welfare, z = usa$temp,
          bty = "g",
          xlab="ph",
          ylab="welfare",
          zlab="temp",
          ticktype = "detailed")
