#!/bin/bash

echo "🚀 Iniciando Servidor FideBurguesas..."

# Verificar si el puerto está en uso
if lsof -i :5050 > /dev/null 2>&1; then
    echo "⚠️  El puerto 5050 está en uso. Terminando procesos..."
    lsof -ti :5050 | xargs kill -9
    sleep 2
fi

# Ejecutar servidor
echo "✅ Servidor iniciado en puerto 5050"
echo "📝 Para detener: Ctrl+C"
echo ""

java -cp "src:mysql-connector-j-8.2.0.jar" cs.server.ServerMain
