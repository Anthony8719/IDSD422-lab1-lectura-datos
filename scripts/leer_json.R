# leer_json.R — Cargar el reporte JSON de la API (R)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   Rscript scripts/leer_json.R

# TODO 1: carga data/ventas.json con jsonlite::fromJSON
install.packages("jsonlite")
library(jsonlite)

# TODO 2: convierte el resultado en data.frame si hace falta
ventas <- fromJSON("data/ventas.json")

# TODO 3: imprime las dimensiones (dim) y las primeras filas (head)
head(ventas)
dim(ventas)
str(ventas)