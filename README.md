FIDEBURGUESAS POS

Aplicación de punto de venta con arquitectura cliente–servidor en Java. El cliente ofrece una interfaz en Swing para gestionar productos y órdenes. El servidor expone un protocolo de texto sobre TCP y persiste los datos en SQLite.

DESCRIPCIÓN GENERAL

• Cliente (Swing): muestra productos en tabla, permite crear órdenes con tipo de hamburguesa, cantidades de hamburguesa, papas y bebida, opción de combo (+₡1500 por hamburguesa que añade papas y bebida automáticamente) y observaciones del cliente. Permite ver las órdenes y actualizar su estado.
• Servidor (Swing): ventana con botones Iniciar, Detener y Salir, además de un registro de eventos.
• Persistencia: SQLite con creación automática de tablas. Si existe la columna “notas” en la tabla de órdenes, se almacenan ahí las observaciones.

TECNOLOGÍAS

Java (Swing, Sockets TCP)
SQLite con controlador sqlite-jdbc
Ant/NetBeans para compilación y ejecución

REQUISITOS

• JDK 17 o superior
• Archivo sqlite-jdbc en la carpeta lib y referenciado en el proyecto

CÓMO EJECUTAR

Servidor

1. Abrir el proyecto en NetBeans.
2. Ejecutar la clase cs.server.ServerMain.
3. En la ventana del servidor, confirmar el puerto (por defecto 5050) y pulsar Iniciar.

Cliente

1. Ejecutar la clase cs.client.ClienteSwing.
2. Conectar al servidor en 127.0.0.1:5050.
3. Usar Ver Productos, Crear Orden, Ver Órdenes y Actualizar Estado.

FUNCIONALIDADES PRINCIPALES

Productos
– Visualización en tabla con ID, nombre, descripción, precio y disponibilidad.

Órdenes
– Creación de órdenes con selección del tipo de hamburguesa.
– Cantidades independientes para hamburguesa, papas y bebida.
– Opción de combo que suma ₡1500 por cada hamburguesa y añade papas y bebida automáticamente.
– Observaciones del cliente (por ejemplo: “sin queso”).
– Listado de órdenes mostrando ID, total, estado, lo que hay que preparar y notas.
– Actualización de estado: PENDIENTE, EN\_PREPARACION, LISTO, ENTREGADO.

PROTOCOLO (RESUMEN)

El cliente envía comandos por TCP y el servidor responde en texto plano.

LIST\_PRODUCTS
Respuesta: OK|PRODUCTS|id|nombre|descripcion|precio|disponible|...

CREATE\_ORDER|id\:qty|OBS=texto opcional|COMBO=n opcional
Respuesta: OK|ORDER\_CREATED|ordenId|total

LIST\_ORDERS
Respuesta: OK|ORDERS|id|total|estado|preparar|notas|...

UPDATE\_ORDER\_STATUS|ordenId|nuevoEstado
Respuesta: OK|STATUS\_UPDATED

ESTRUCTURA DEL PROYECTO

src/cs/server/  ServerMain, ServerSwing, ClientHandler, Protocol
src/cs/client/  ClienteSwing
src/cs/dao/     OrdenDao, (ProductoDao)
src/cs/util/    DB
lib/            sqlite-jdbc-\<versión>.jar

NOTAS

• El archivo de base de datos fideburguesas.db se crea automáticamente.
• Si la tabla orden incluye la columna notas, las observaciones del cliente se guardan allí.
• El puerto por defecto es 5050 y puede cambiarse desde la ventana del servidor.
