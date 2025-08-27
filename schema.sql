-- Crear base de datos
CREATE DATABASE IF NOT EXISTS fideburguesas;
USE fideburguesas;

-- Tabla de productos
CREATE TABLE IF NOT EXISTS producto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL,
    disponible BOOLEAN DEFAULT TRUE,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de órdenes
CREATE TABLE IF NOT EXISTS orden (
    id INT AUTO_INCREMENT PRIMARY KEY,
    total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(50) DEFAULT 'PENDIENTE',
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de items de orden
CREATE TABLE IF NOT EXISTS orden_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    orden_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (orden_id) REFERENCES orden(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES producto(id) ON DELETE CASCADE
);

-- Insertar productos iniciales
INSERT INTO producto (nombre, descripcion, precio, disponible) VALUES
('Hamburguesa', 'Hamburguesa artesanal con carne y queso', 5.50, TRUE),
('Papas Fritas', 'Papas fritas crujientes', 2.50, TRUE),
('Refresco', 'Refresco de 500ml', 1.50, TRUE);
