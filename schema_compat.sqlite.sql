PRAGMA foreign_keys=ON;

DROP TABLE IF EXISTS orden_item;
DROP TABLE IF EXISTS orden;
DROP TABLE IF EXISTS producto;

CREATE TABLE producto (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  nombre TEXT NOT NULL,
  descripcion TEXT,
  precio REAL NOT NULL,
  disponible INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE orden (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  total REAL NOT NULL DEFAULT 0,
  estado TEXT NOT NULL DEFAULT 'PENDIENTE',
  fecha_creacion TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE orden_item (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  orden_id INTEGER NOT NULL,
  producto_id INTEGER NOT NULL,
  cantidad INTEGER NOT NULL,
  precio_unitario REAL NOT NULL,
  FOREIGN KEY (orden_id) REFERENCES orden(id) ON DELETE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES producto(id) ON DELETE CASCADE
);

-- semilla con tu menú (colones como REAL para que el DAO esté contento)
INSERT INTO producto(nombre, descripcion, precio, disponible) VALUES
('Hamburguesa Sencilla','Carne 100g, queso, lechuga, tomate',1500.0,1),
('Hamburguesa Doble','Doble carne, doble queso',3500.0,1),
('Hamburguesa con Tocino','Carne 100g, tocino, queso',2500.0,1),
('Papas Fritas','Porción mediana',1000.0,1),
('Bebida','Refresco 500ml',1000.0,1);
