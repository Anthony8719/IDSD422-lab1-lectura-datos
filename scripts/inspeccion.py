# inspeccion.py — Tipos, columna derivada e indicadores (Python)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   python scripts/inspeccion.py

import pandas as pd

# TODO 1: Cargar data/ventas.csv
ventas = pd.read_csv("lab/data/ventas.csv")

# TODO 2: Imprimir los tipos de cada columna
print("\nTipos de Datos")
print(ventas.dtypes)

# TODO 3: Crear la columna ticket = ventas / clientes
ventas["ticket"] = ventas["ventas"] / ventas["clientes"]

print("\nPrimeras filas de Ticket")
print(ventas.head())

# TODO 4: Calcular e imprimir resultados

# Venta promedio por sucursal
print("\nVenta promedio por sucursal")
print(ventas.groupby("sucursal")["ventas"].mean())

# Ticket promedio (ventas totales / clientes totales)
print("\nTicket promedio")
print(ventas["ventas"].sum() / ventas["clientes"].sum())

# Sucursal con mayor y menor venta total
ventas_sucursal = ventas.groupby("sucursal")["ventas"].sum()

print("\nSucursal con mayor venta")
print(ventas_sucursal.idxmax())
print("Venta total:", ventas_sucursal.max())

print("\nSucursal con menor venta")
print(ventas_sucursal.idxmin())
print("Venta total:", ventas_sucursal.min())

# Región con mayor venta total
ventas_region = ventas.groupby("region")["ventas"].sum()

print("\nRegion con mayor venta")
print(ventas_region.idxmax())
print("Venta total:", ventas_region.max())