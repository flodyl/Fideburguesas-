#!/bin/bash

echo "🔍 Probando conexión a base de datos..."

# Crear un archivo temporal de prueba
cat > TestDB.java << 'EOF'
import java.sql.*;

public class TestDB {
    public static void main(String[] args) {
        String url = "jdbc:mysql://localhost:3306/fideburguesas?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true";
        String user = "root";
        String pass = "root";
        
        try {
            System.out.println("Conectando a MySQL...");
            Connection conn = DriverManager.getConnection(url, user, pass);
            System.out.println("✅ Conexión exitosa!");
            
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT COUNT(*) as total FROM producto");
            
            if (rs.next()) {
                System.out.println("✅ Productos en BD: " + rs.getInt("total"));
            }
            
            rs = stmt.executeQuery("SELECT * FROM producto");
            System.out.println("📋 Productos disponibles:");
            while (rs.next()) {
                System.out.println("  - " + rs.getString("nombre") + ": $" + rs.getDouble("precio"));
            }
            
            conn.close();
            System.out.println("✅ Prueba completada exitosamente!");
            
        } catch (SQLException e) {
            System.err.println("❌ Error: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
EOF

# Compilar y ejecutar
echo "Compilando prueba..."
javac -cp "mysql-connector-j-8.2.0.jar" TestDB.java

if [ $? -eq 0 ]; then
    echo "Ejecutando prueba..."
    java -cp ".:mysql-connector-j-8.2.0.jar" TestDB
else
    echo "❌ Error compilando prueba"
fi

# Limpiar
rm -f TestDB.java TestDB.class
