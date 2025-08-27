#!/bin/bash

echo "🔧 Configurando credenciales de base de datos..."
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
    
    # Actualizar archivo DB.java
    echo "Actualizando archivo DB.java..."
    sed -i.bak "s/private static final String USER = \".*\";/private static final String USER = \"$mysql_user\";/" src/cs/util/DB.java
    sed -i.bak "s/private static final String PASS = \".*\";/private static final String PASS = \"$mysql_pass\";/" src/cs/util/DB.java
    
    echo "✅ Credenciales actualizadas en src/cs/util/DB.java"
    echo ""
    echo "📝 Para aplicar cambios:"
    echo "  1. ./compile.sh"
    echo "  2. ./run_server.sh"
    
else
    echo "❌ Error de conexión. Verifica las credenciales."
    exit 1
fi
