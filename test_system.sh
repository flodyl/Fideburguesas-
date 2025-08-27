#!/bin/bash

echo "🧪 Probando Sistema FideBurguesas..."
echo ""

# Verificar que MySQL esté corriendo
echo "1. Verificando MySQL..."
if mysql -u root -p -e "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ MySQL está corriendo"
else
    echo "❌ MySQL no está corriendo"
    exit 1
fi

# Verificar base de datos
echo "2. Verificando base de datos..."
if mysql -u root -p -e "USE fideburguesas; SELECT COUNT(*) FROM producto;" > /dev/null 2>&1; then
    echo "✅ Base de datos fideburguesas existe"
else
    echo "❌ Base de datos no existe"
    exit 1
fi

# Verificar archivos compilados
echo "3. Verificando archivos compilados..."
if [ -f "src/cs/server/ServerMain.class" ] && [ -f "src/cs/client/ClientMain.class" ]; then
    echo "✅ Archivos compilados encontrados"
else
    echo "❌ Archivos no compilados"
    exit 1
fi

# Verificar MySQL Connector
echo "4. Verificando MySQL Connector..."
if [ -f "mysql-connector-j-8.2.0.jar" ]; then
    echo "✅ MySQL Connector encontrado"
else
    echo "❌ MySQL Connector no encontrado"
    exit 1
fi

# Verificar puerto del servidor
echo "5. Verificando servidor..."
if lsof -i :5050 > /dev/null 2>&1; then
    echo "✅ Servidor corriendo en puerto 5050"
else
    echo "⚠️  Servidor no está corriendo"
    echo "💡 Ejecuta: ./run_server.sh"
fi

echo ""
echo "🎉 Sistema listo para usar!"
echo ""
echo "📋 Comandos útiles:"
echo "  Compilar:     ./compile.sh"
echo "  Servidor:     ./run_server.sh"
echo "  Cliente:      ./run_client.sh"
echo "  Detener:      lsof -ti :5050 | xargs kill -9"
