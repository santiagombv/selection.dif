selection.dif
=============

**Una aplicación shiny para mostrar diferenciales de selección.**

Elija el tipo de selección y luego elija el porcentaje de la población que permanece luego de la acción de la selección.  
El panel superior muestra la distribución de la población antes y después de la selección.  
El panel intermedio muestra la diferencia de medias antes y después de la selección, correspondiente al diferencial de selección lineal $s_{i}$.  
El panel inferior el valor de 2 veces el devío estandar antes (bara roja) y después (barra azul) de la selección. La diferencia entre ambas barras corresponde al diferencial de selección cuadrático $c_{i}$.  
La simulación se realiza con base en 200 individuos muestreados de una distribución normal con media pre-selección de 0 y desvío estándar pre-selección de 1. Por el tamaño muestral, es posible observar efectos estocásticos.

**Para correr la aplicación ingrese en R**

```
library(shiny)
runGitHub("selection.dif", "santiagombv")
```