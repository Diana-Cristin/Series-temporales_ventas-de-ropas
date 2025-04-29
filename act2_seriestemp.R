# IMPORTACIÓN DE LIBRERÍAS
library(readr)
library(tseries)
library(lubridate)
library(tidyverse)
library(car)
library(astsa)
library(foreign)
library(timsac)
library(vars)
library(lmtest)
library(mFilter)
library(dynlm)
library(nlme)
library(lmtest)
library(broom)
library(kableExtra)
library(knitr)
library(MASS)
library(parallel)
library(car)
library(mlogit)
library(dplyr)
library(tidyr)
library(forecast)
library(fpp2)
library(stats)
library(quantmod)

install.packages('fpp2',dependencies = TRUE)
install.packages("tseries")

library(fpp2)
library(tseries)

# IMPORTACIÓN DEL DATASET
ventas <- read_csv("A_R_ESTADISTICA_ARCHIVOS/hola.csv",  col_types = cols_only(Ventas = col_double()))
View(ventas)

# Añadimos el tiempo por periodos de meses a cada venta
ventas_mensual.ts <- ts(ventas, start = c(2010, 1), freq = 12)
start(ventas_mensual.ts);end(ventas_mensual.ts)     #observamos que queda conforme el inicio y fin de la data
ventas_mensual.ts
plot(ventas_mensual.ts, ylab='Ventas')
class(ventas_mensual.ts)  #la data ya está en una serie de tiempo

# Descomposición de la serie temporal en gráficas
descomposicion <- decompose(ventas_mensual.ts)      #descomponemos la serie en sus columnas
plot(descomposicion)
tendencia <- descomposicion$trend
estacionalidad <- descomposicion$seasonal
alea <- descomposicion$random

# Test de Dicker-Fuller, determinación del modelo si es estacionario o no.
adf.test(ventas_mensual.ts)

# Veamos la autocorrelación de la serie 
acf(ventas_mensual.ts) 
pacf(ventas_mensual.ts) 

# Diferenciaciones
ventasdiff = diff(ventas_mensual.ts) 
plot(ventasdiff)

# Test de Dicker-Fuller luego de realizar 1 diferenciación
adf.test(ventasdiff, alternative = 'stationary')

# Volvemos a ver las gráficas de autoccorrelación y autocorrelación parcial
acf(ts(ventasdiff, frequency =1)) #usamos frequency para que el rezago coincida con la frecuencia
pacf(ts(ventasdiff, frequency =1)) 

# MEJOR MODELO SARIMA
modelo_sarima <- auto.arima(log(ventas_mensual.ts),seasonal = TRUE, allowmean = TRUE, allowdrift = TRUE, stepwise = FALSE, approximation = FALSE) 
summary(modelo_sarima)

# Graficamos ACF y PACF de los residuos con un intevalo de confianza definido

acf(resid(modelo_sarima), main = "ACF de los Residuos con IC 95%", ci = 0.95)
pacf(resid(modelo_sarima), main = "PACF de los Residuos con IC 95%", ci = 0.95)

# PRONÓSTICO

ts.plot(cbind(window(ventas_mensual.ts, start = 2010), exp(predict(modelo_sarima, 12)$pred)), lty = 1:2)

# Predicción y visualización de los intervalos de confianza
pred <- predict(modelo_sarima, n.ahead = 12)
pred

# Gráfico del pronóstico con intervalos de confianza
ts.plot(ventas_mensual.ts, exp(pred$pred), col = c("black", "red"), lty = 1:2, main = "Pronóstico con intervalos de confianza")
lines(exp(pred$pred + 1.96 * pred$se), col = "blue", lty = 2)
lines(exp(pred$pred - 1.96 * pred$se), col = "blue", lty = 2) 



