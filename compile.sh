#!/bin/bash

echo "Compilando Sistema FideBurguesas..."

# Limpiar archivos .class anteriores
find src -name "*.class" -delete

# Compilar todos los archivos juntos
echo "Compilando todos los archivos..."
javac -cp ".:mysql-connector-j-8.2.0.jar" src/cs/util/DB.java src/cs/model/Producto.java src/cs/model/Orden.java src/cs/dao/ProductoDao.java src/cs/dao/OrdenDao.java src/cs/server/Protocol.java src/cs/server/ClientHandler.java src/cs/server/ServerMain.java src/cs/client/ClienteSwing.java src/cs/client/ClientMain.java

if [ $? -eq 0 ]; then
    echo "✅ Compilación completada exitosamente!"
    echo ""
    echo "Para ejecutar:"
    echo "  Servidor: java -cp . cs.server.ServerMain"
    echo "  Cliente:  java -cp . cs.client.ClientMain"
else
    echo "❌ Error en la compilación"
    exit 1
fi
