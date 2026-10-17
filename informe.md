# Informe técnico — Consolidación de reportes de ventas

**Para:** Gerencia de RetailAndina S.A.  
**De:** Equipo de Business Intelligence  
**Fecha:** 16/10/2026  
**Asunto:** Primer análisis de los reportes de ventas (semana 39)

---

## Resumen ejecutivo

Se procede con la lectura e inspección de los reportes de ventas semanales de RetailAndina S.A. que resultan del sistema ERP de sucursales, la plataforma de fidelización y el dpto. de Finanzas de la compañía, todos en formatos CSV, JSON y Excel, respectivamente. Se extraen a partir de Python y R la característica dimensional, la estructura y el tipo de los datos de cada uno, de forma de verificar la consistente de lo que está disponible. Se calculan indicadores comerciales asociados con las ventas, los clientes y el desempeño a nivel de sucursales y regiones. En función de ello, se trabaja con resultados de los reportes que generen información consistente para los análisis comerciales y decisiones gerenciales.

## 1. ¿Los tres formatos contienen la misma información?

Con el objetivo de validar la consistencia que tienen los reportes que se recibieron inicialmente, se realizó la lectura correspondiente a los archivos ventas.csv, ventas.json y ventas.xlsx, recurriendo para ello a las bibliotecas pertinentes tanto en Python como en R y se procedió a inspeccionar sus dimensiones, sus columnas y estructura.

| Formato | Origen | Filas | Columnas | Lectura en código |
|---|---|---|---|---|
| CSV | ERP de sucursales | 5 | 4 | Python: `pd.read_csv()` / R: `read.csv()` |
| JSON | API de fidelización | 5 | 4 | Python: `json.load()` y `pd.json_normalize()` / R: `fromJSON()` |
| Excel | Consolidado de finanzas | 5 | 4 | Python: `pd.read_excel()` / R: `read_excel()` |


**¿La estructura interna del archivo cambia el contenido?**

Pese a que los archivos tienen tipos y formatos de almacenamiento diferentes, eso no implica que puedan guardar información diferente. El formato CSV organiza la información como texto delimitado, el formato JSON permite expresar estructuras jerárquicas y el formato Excel almacena la información en hojas de cálculo dentro de un archivo estructurado.

Por esta razón, la comparación ha de hacerse sobre los datos obtenidos después de la lectura y ha de realizarse la comprobación de que las columnas y los registros son equivalentes. La coincidencia en el número de filas y de columnas constituye la primera evidencia, pero no garantiza que el contenido sea idéntico.

## 2. Tipos de datos y calidad

Se inspeccionaron los tipos de datos inferidos automáticamente por Python y R para determinar si las variables poseen una representación adecuada para su posterior procesamiento.

| Variable | Tipo inferido (Python) | Tipo inferido (R) | Interpretación |
|---|---|---|---|
| `ventas` | `int64` | `integer` / `numeric` | Valores numéricos de las ventas |
| `clientes` | `int64` | `integer` / `numeric` | Cantidad de clientes registrados |
| `sucursal` | `object` | `character` | Nombre de cada sucursal |
| `region` | `object` | `character` | Región geográfica de la sucursal |

En Python, las columnas que forman parte de la estructura de datos `df` con nombres `ventas` y `clientes` se identificaron como números enteros de acuerdo con el tipo `int64` (de 64 bits); por su lado, las columnas `sucursal` y `region` se dedujeron como de tipo `object` (por defecto, un vector de objetos en Python).

En R, las variables de texto se definieron como de tipo `character`, las columnas de tipo numérico se identificaron como `integer` al leer CSV y JSON, y se identificaron como de tipo `numeric` o `double` (doble precisión) al leer Excel a través de `readxl`. Es probable que los tipos de datos deducidos sean correctos para realizar cálculos o agrupaciones, dado que en este caso, las variables ventas y clientes tienen que ver con valores numéricos, mientras que las sucursales y región tienen que ver con categorías.

**¿Qué habría indicado un dato sucio si `ventas` llegara como texto?**

Una advertencia. Si el campo `ventas` se hubiese identificado como texto, sería una señal de que la calidad de los datos es muy mala; por ejemplo: existen caracteres especiales, símbolos monetarios, espacios extra o bien hay valores que no son numéricos. 
Pero no sólo eso, esto sería un inconveniente para realizar operaciones como sumas o promedios y se debería realizar la limpieza y conversión de tipos con anterioridad a calcular los indicadores del negocio.

## 3. Particularidades técnicas encontradas

**CSV:** En Python se usó `pd.read_csv()` y para R se usó `read.csv()`, ambos lenguajes de programación pudieron cargar sin problemas la totalidad de los datos a partir de una tabla, identificando de forma correcta las columnas y los tipos de estas. Este formato fue el de más fácil procesamiento, ya que se trataba de un archivo de texto plano.


**JSON:** En Python hizo falta el uso de `json.load()` para cargar el fichero y `pd.json_normalize()` para llevarlo a un DataFrame específico, y en R se utilizó `fromJSON()` de la librería `jsonlite` para conseguir, en este caso, una tabla. Ello da muestra de que los datos organizados en JSON pueden hacer necesaria una transformación dependiendo de cómo estén dispuestos en dicho formato.

**Excel:** Tanto en Python (`pd.read_excel()`) como en R (`read_excel()` de la librería `readxl`), se especificó la lectura de la hoja `ventas`, que contiene la información que queremos trabajar. En contraste con el caso CSV, Excel tiene múltiples hojas, por tanto, también hemos de decir hacia cuál información queremos realizar el análisis.  

**Variables categóricas:** En Python, `sucursal` y `region` son del tipo `object`. En R, se trata de `character`, pero en caso de necesitar trabajar con categorías definidas (como en modelos estadísticos), se puede transformar como `factor`.  

En general, las diferencias encontradas se resumen en las funciones de lectura, las librerías utilizadas y el modo de representar los tipos de datos, respetando sin embargo los valores claros que observamos.

## 4. Indicadores para la reunión del lunes

Estos indicadores comerciales se calcularon a partir de los cinco registros de ventas.

| Indicador | Valor |
|---|---|
| Venta promedio por sucursal | 12.008 |
| Ticket promedio (ventas totales ÷ clientes totales) | 38,08 |
| Sucursal con mayor venta | Guayaquil Centro (15.200) |
| Sucursal con menor venta | Cuenca (8.540) |
| Región con mayor venta total | Sierra (30.860) |

### Análisis de los indicadores

**Venta promedio por sucursal:**

El promedio general de ventas de las cinco sucursales fue de 12.008. Los  valores individuales que se registraron fueron:

| Sucursal | Venta |
|---|---:|
| Quito Norte | 12.450 |
| Quito Sur | 9.870 |
| Guayaquil Centro | 15.200 |
| Guayaquil Norte | 13.980 |
| Cuenca | 8.540 |

Al tener un único resgistro para cada sucursal, es fácil comprobar que su venta promedio coincide con la venta registrada.

**Ticket promedio:**

El ticket promedio general obtenido de **38,07** fue calculado como el resultado de dividir las ventas totales de 190 a las que hemos llegado por el número de clientes a los que hemos atendido, también de 190.\
Esté ticket representa la venta promedio generada por cada uno de los clientes. Este ticket promedio, también nos permite evaluar el comportamiento comercial de cada una de las sucursales.


**Sucursal de mayor y menor venta:**

La sucursal Guayaquil Centro fue la que obtuvo el más alto valor en ventas con un total de 15.200, mientras que Cuenca fue la que presentó el menor valor de 8.540, ayuntando a interpretar y encontrar algunas oportunidades para abordar el análisis sobre qué sucursal tendría el menor rendimiento comercial.

**Región con mayor venta total:** 

La región Sierra acumuló un total de 30.860 en ventas y la región Costa obtuvo 29.180. Por lo tanto, podemos decir que la región Sierra fue la que tuvo la mayor venta total, en cambio, la sucursal que obtuvo la mayor venta fue Costa.

## 5. Conclusiones y recomendaciones

### Conclusiones

1. **Consistencia de la información:**  Dichos archivos CSV, JSON y Excel tienen los mismos registros y el mismo número de columnas, se pasaron por python y R, y obtuvieron resultados equivalentes, lo que permitió comprobar que la información es coherente con los diferentes formatos.

2. **Tipos de datos y procesamiento:** 
Los códigos confirmaron que Python y R utilizan diferentes funciones y estructuras para leer los correspondientes archivos. No obstante, ambos lenguajes lograron identificar los tipos de datos y estructurar la información en una tabla, lo que favorece su chequeo posterior.

3. **Análisis de indicadores:** Se logró el cálculo de los indicadores que identificaron a Guayaquil Centro como la sucursal con mayores ventas, Cuenca como la de menores ventas y Sierra como la región con mayor venta acumulada. Con ello, se logró una comparación del desempeño comercial entre las distintas sucursales y regiones la semana de interés.

### Recomendaciones

- **Validación la consistencia de los datos:** Se sugiere realizar una comparación de las dimensiones, de los nombres de las columnas y de los registros de los diferentes archivos antes de procesarlos, con el objeto de asegurarse de que los resultados se obtengan de la información coherente.

- **Control de calidad:** Es conveniente revisar el tipo de datos de las variables, además de mirar si hay valores faltantes, si hay registros duplicados o si hay errores que pudieran afectar al cálculo de los indicadores de los negocios.

- **Automatización del análisis:** Es conveniente revisar el tipo de datos de las variables, además de mirar si hay valores faltantes, si hay registros duplicados o si hay errores que pudieran afectar al cálculo de los indicadores de los negocios.

- **Comparaciones periódicas:** Se sugiere realizar un análisis de los resultados de diferentes semanas, que permitiría identificar cambios en el comportamiento de las sucursales y de las regiones, que permitiría complementar los indicadores iniciales e incluso aportar información más útil a la toma de decisiones de la gerencia.
