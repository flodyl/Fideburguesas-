#!/bin/bash

echo "🔧 Configurando variables de entorno para MySQL..."
echo ""

# Solicitar credenciales
read -p "Usuario MySQL (default: root): " mysql_user
mysql_user=${mysql_user:-root}

read -s -p "Contraseña MySQL: " mysql_pass
echo ""

# Probar conexión
echo "Probando conexión..."
if mysql -u "$mysql_user" -p"$mysql_pass" -e "SELECT 1;" > /dev/null 2>&1; then
    echo "✅ Conexión exitosa!"
    
    # Exportar variables de entorno
    export MYSQL_USER="$mysql_user"
    export MYSQL_PASS="$mysql_pass"
    
    echo "✅ Variables de entorno configuradas:"
    echo "  MYSQL_USER=$mysql_user"
    echo "  MYSQL_PASS=***"
    echo ""
    echo "📝 Para ejecutar el servidor con estas credenciales:"
    echo "  source set_env.sh && ./run_server.sh"
    echo ""
    echo "📝 O ejecutar directamente:"
    echo "  MYSQL_USER=$mysql_user MYSQL_PASS=$mysql_pass ./run_server.sh"
    
else
    echo "❌ Error de conexión. Verifica las credenciales."
    exit 1
fi
