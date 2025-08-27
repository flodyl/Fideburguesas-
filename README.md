# Sistema FideBurguesas - Cliente/Servidor

Sistema completo de gestión de pedidos para una hamburguesería con interfaz gráfica, servidor concurrente y base de datos MySQL.

## Características

- ✅ **Servidor concurrente** - Maneja múltiples clientes simultáneamente
- ✅ **Base de datos MySQL** - Persistencia completa de productos y órdenes
- ✅ **Interfaz gráfica Swing** - Cliente fácil de usar
- ✅ **3 productos predefinidos** - Hamburguesas, Papas Fritas, Refrescos
- ✅ **Tracking de pedidos** - Estados: PENDIENTE → EN_PREPARACION → LISTO → ENTREGADO
- ✅ **JOptionPane** - Mensajes de confirmación y error

## Estructura del Proyecto

```
src/
├── cs/
│   ├── client/
│   │   ├── ClienteSwing.java    # Interfaz gráfica del cliente
│   │   └── ClientMain.java      # Clase principal del cliente
│   ├── server/
│   │   ├── ServerMain.java      # Servidor principal
│   │   ├── ClientHandler.java   # Maneja cada cliente en un hilo
│   │   └── Protocol.java        # Protocolo de comunicación
│   ├── model/
│   │   ├── Producto.java        # Modelo de producto
│   │   └── Orden.java           # Modelo de orden
│   ├── dao/
│   │   ├── ProductoDao.java     # Acceso a datos de productos
│   │   └── OrdenDao.java        # Acceso a datos de órdenes
│   └── util/
│       └── DB.java              # Conexión a base de datos
└── schema.sql                   # Script de base de datos
```

## Configuración

### 1. Base de Datos MySQL

1. Instala MySQL si no lo tienes
2. Ejecuta el script `schema.sql`:
   ```sql
   mysql -u root -p < schema.sql
   ```

### 2. Configurar Credenciales

Edita `src/cs/util/DB.java` con tus credenciales de MySQL:
```java
private static final String USER = "tu_usuario";
private static final String PASS = "tu_contraseña";
```

### 3. Agregar MySQL Connector

En NetBeans:
1. Click derecho en el proyecto → Properties
2. Libraries → Add JAR/Folder
3. Selecciona `mysql-connector-j-8.x.x.jar`

## Uso del Sistema

### 1. Ejecutar Servidor

```bash
./run_server.sh
```

O manualmente:
```bash
java -cp src cs.server.ServerMain
```

Deberías ver: "Servidor escuchando en puerto 5050"

### 2. Ejecutar Cliente

```bash
./run_client.sh
```

O manualmente:
```bash
java -cp src cs.client.ClientMain
```

Se abrirá la interfaz gráfica.

### 3. Usar la Aplicación

1. **Conectar**: Click en "Conectar al Servidor"
2. **Ver Productos**: Pestaña "Productos" → "Ver Productos"
3. **Crear Orden**: Pestaña "Crear Orden" → Seleccionar cantidades → "Crear Orden"
4. **Ver Órdenes**: Pestaña "Órdenes" → "Ver Órdenes"
5. **Actualizar Estado**: Ingresar ID de orden → Seleccionar estado → "Actualizar Estado"

## Productos Disponibles

- **ID 1**: Hamburguesa ($5.50)
- **ID 2**: Papas Fritas ($2.50)  
- **ID 3**: Refresco ($1.50)

## Protocolo de Comunicación

- `LIST_PRODUCTS` - Listar productos disponibles
- `CREATE_ORDER|1:2,2:1,3:1` - Crear orden (ID:cantidad,ID:cantidad...)
- `LIST_ORDERS` - Listar todas las órdenes
- `UPDATE_ORDER_STATUS|1|EN_PREPARACION` - Actualizar estado de orden

## Estados de Órdenes

- **PENDIENTE** - Orden recién creada
- **EN_PREPARACION** - En cocina
- **LISTO** - Lista para entregar
- **ENTREGADO** - Entregada al cliente

## Funcionalidades

### Cliente
- ✅ Conexión al servidor
- ✅ Visualización de productos
- ✅ Creación de órdenes
- ✅ Visualización de órdenes
- ✅ Actualización de estados
- ✅ Mensajes de confirmación/error

### Servidor
- ✅ Manejo concurrente de clientes
- ✅ Persistencia en MySQL
- ✅ Validación de datos
- ✅ Manejo de errores

## Solución de Problemas

### Error de Conexión
- Verifica que MySQL esté corriendo
- Revisa credenciales en `DB.java`
- Asegúrate de que el puerto 5050 esté libre
- Si el puerto está ocupado, ejecuta: `lsof -ti :5050 | xargs kill -9`

### Error de Compilación
- Asegúrate de tener MySQL Connector en el classpath
- Compila todos los archivos juntos
- Usa: `./compile.sh` para compilar fácilmente

### Cliente no Responde
- Verifica que el servidor esté corriendo
- Revisa el log en la parte inferior del cliente

## Tecnologías Utilizadas

- **Java** - Lenguaje principal
- **Swing** - Interfaz gráfica
- **Sockets** - Comunicación cliente/servidor
- **Threads** - Concurrencia
- **MySQL** - Base de datos
- **JDBC** - Acceso a datos

## Autores

- [Tu Nombre]

## Versión

1.0 - Sistema completo funcional 