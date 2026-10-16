# inspeccion.R — Tipos, columna derivada e indicadores (R)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   Rscript scripts/inspeccion.R

# TODO 1: Cargar data/ventas.csv
ventas <- read.csv("data/ventas.csv")

# TODO 2: Imprimir la estructura y tipos de datos
cat("\n--- ESTRUCTURA Y TIPOS DE DATOS ---\n")
str(ventas)

cat("\n--- TIPO DE DATO DE REGION ---\n")
print(class(ventas$region))

# TODO 3: Crear la columna ticket = ventas / clientes
ventas$ticket <- ventas$ventas / ventas$clientes

cat("\n--- PRIMERAS FILAS CON TICKET ---\n")
print(head(ventas))

# TODO 4: Calcular e imprimir resultados

# Venta promedio por sucursal
cat("\n--- VENTA PROMEDIO POR SUCURSAL ---\n")
venta_promedio <- aggregate(ventas ~ sucursal, data = ventas, FUN = mean)
print(venta_promedio)

# Ticket promedio (ventas totales / clientes totales)
cat("\n--- TICKET PROMEDIO GENERAL ---\n")
ticket_promedio <- sum(ventas$ventas) / sum(ventas$clientes)
print(ticket_promedio)

# Ventas totales por sucursal
ventas_sucursal <- aggregate(ventas ~ sucursal, data = ventas, FUN = sum)

# Sucursal con mayor venta total
cat("\n--- SUCURSAL CON MAYOR VENTA TOTAL ---\n")
mayor <- which.max(ventas_sucursal$ventas)
print(ventas_sucursal[mayor, ])

# Sucursal con menor venta total
cat("\n--- SUCURSAL CON MENOR VENTA TOTAL ---\n")
menor <- which.min(ventas_sucursal$ventas)
print(ventas_sucursal[menor, ])

# Región con mayor venta total
ventas_region <- aggregate(ventas ~ region, data = ventas, FUN = sum)

cat("\n--- REGION CON MAYOR VENTA TOTAL ---\n")
mayor_region <- which.max(ventas_region$ventas)
print(ventas_region[mayor_region, ])