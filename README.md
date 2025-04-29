# Series-temporales_ventas-de-ropas
Pronóstico de ventas de ropas 
1. DATASET
El dataset usado proviene de la plataforma Chatgpt al generar reportes de ventas de una tienda de ropa en el cual se indica el total de ventas en dólares en cada mes y año desde enero del 2010 hasta diciembre del 2019.
Se tiene el dataset ventas_mensuales.csv el cual contiene dos columnas, Ventas y Time. De las dos columnas solo se extrae la columna Ventas y tomando en cuenta el tiempo de los datos colocamos las fechas de inicio y fin de la columna Time en la serie de tiempo ventas_mensual.ts.

2. OBJETIVOS
En este trabajo se busca realizar la predicción de las ventas de los próximos doce meses teniendo en cuenta la data desde el 2010. Con esto se podría tener una cantidad base de producción de prendas y también un pronóstico de las ventas futuras. Se usará el mejor modelo de serie temporal de acuerdo con las particularidades de la serie temporal.

3. CONCLUSIONES
Se concluye que un modelo óptimo para este caso de venta de ropas sería un SARIMA con parámetros (2,1,1)(0,0,1). Internamente se usó el logaritmo para estabilizar las varianzas y así obtener un modelo óptimo. La predicción contempla orden 1 de las medias móviles estacionales, es decir, el modelo ajustó los errores pasados en lugar de errores propios pasados. Las ventas de los próximos meses corresponden al rango de la variabilidad de varianza de los valores anteriores. 
Se realizó una función get.best.arima sin embargo no se presentó en este trabajo debido a que una de las dificultades de este fue el manejo de los valores negativos ya que la única manera de manejarlos era excluyéndolos del bucle. Esto ocasionó un sesgo en a predicción final de las ventas en el año 2020 por lo que se decidió trabajar con la función auto.arima la cual tiene en su interior otros bucles que al parecer si manejan los valores negativos. 
De igual forma el AIC anterior fue 562.39 y el del modelo usado en el trabajo fue de 603.46 lo cual indicaría que el primero es mejor; sin embargo, al momento de realizar la predicción se observó que con el primero modelo las ventas se desbordaban de los años anteriores (Gráfico 12, Anexos) por lo que no corresponderían a una predicción creíble.
Considero que este podría ser uno de los trabajos futuros, es decir, construir funciones más optimizadas que contemplen diversos valores de los datos ya que estos, debido a las transformaciones realizadas podrían dar valores no manejables. 
Además, se podría considerar funciones que internamente verifique que el gráfico de pronóstico sea el mejor al compararlo con otros gráficos y así nos de un par de mejor AIC con mejor predicción que se encuentre dentro de los intervalos de confianza.
