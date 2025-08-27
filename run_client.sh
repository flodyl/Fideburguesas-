#!/bin/bash

echo "🖥️  Iniciando Cliente FideBurguesas..."

# Verificar si el servidor está corriendo
if ! lsof -i :5050 > /dev/null 2>&1; then
    echo "⚠️  El servidor no está corriendo en el puerto 5050"
    echo "💡 Ejecuta primero: ./run_server.sh"
    exit 1
fi

# Ejecutar cliente
echo "✅ Cliente iniciado"
echo "📝 Conecta al servidor desde la interfaz gráfica"
echo ""

java -cp "src:mysql-connector-j-8.2.0.jar" cs.client.ClientMain
