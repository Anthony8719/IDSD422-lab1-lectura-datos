# leer_json.py — Cargar el reporte JSON de la API (Python)
# Completa los pasos marcados con TODO. Ejecuta desde la raíz del repositorio:
#   python scripts/leer_json.py

# TODO 1: importa json y pandas
import json
import pandas as pd

# TODO 2: carga data/ventas.json con json.load
with open("lab/data/ventas.json", encoding = "utf-8") as f:
    datos = json.load(f)

# TODO 3: convierte la lista de diccionarios en un DataFrame
#    (recuerda del cap. 2: el JSON no llega como tabla directa)
    ventas = pd.json_normalize(datos)

# TODO 4: imprime las dimensiones y las primeras filas
    print("\nEncabezado")
print( ventas.head())
#imprimir dimensiones
print("\nDimensiones")
print( ventas.shape)
#imprimir tipos de columna
print("\nTipos de columna")
print(ventas.dtypes)