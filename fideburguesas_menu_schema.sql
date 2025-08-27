PRAGMA foreign_keys = ON;

CREATE TABLE IF NOT EXISTS producto (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,
    categoria TEXT NOT NULL CHECK (categoria IN ('HAMBURGUESA','ACOMPAÑAMIENTO','BEBIDA')),
    precio INTEGER NOT NULL CHECK (precio >= 0),        -- en colones (CRC), sin decimales
    disponible INTEGER NOT NULL DEFAULT 1,              -- 1=true, 0=false
    fecha_creacion TEXT NOT NULL DEFAULT (datetime('now'))
);

CREATE TABLE IF NOT EXISTS regla_combo (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre TEXT NOT NULL UNIQUE,                        -- p.ej. "Combo papas + bebida"
    aplica_categoria TEXT NOT NULL CHECK (aplica_categoria IN ('HAMBURGUESA','ACOMPAÑAMIENTO','BEBIDA')),
    recargo INTEGER NOT NULL CHECK (recargo >= 0),      -- recargo total del combo en colones
    incluye_papas INTEGER NOT NULL DEFAULT 1,
    incluye_bebida INTEGER NOT NULL DEFAULT 1,
    activo INTEGER NOT NULL DEFAULT 1
);


CREATE TABLE IF NOT EXISTS orden (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    total INTEGER NOT NULL DEFAULT 0 CHECK (total >= 0), 
    estado TEXT NOT NULL DEFAULT 'PENDIENTE',            
    fecha_creacion TEXT NOT NULL DEFAULT (datetime('now'))
);


CREATE TABLE IF NOT EXISTS orden_item (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    orden_id INTEGER NOT NULL,
    producto_id INTEGER NOT NULL,
    cantidad INTEGER NOT NULL CHECK (cantidad > 0),
    precio_unitario INTEGER NOT NULL CHECK (precio_unitario >= 0),
    FOREIGN KEY (orden_id) REFERENCES orden(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES producto(id) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_producto_categoria ON producto (categoria);
CREATE INDEX IF NOT EXISTS idx_orden_item_orden_id ON orden_item (orden_id);
CREATE INDEX IF NOT EXISTS idx_orden_item_producto_id ON orden_item (producto_id);

CREATE TRIGGER IF NOT EXISTS trg_orden_item_ai
AFTER INSERT ON orden_item
BEGIN
    UPDATE orden
    SET total = (
        SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
        FROM orden_item
        WHERE orden_id = NEW.orden_id
    )
    WHERE id = NEW.orden_id;
END;

CREATE TRIGGER IF NOT EXISTS trg_orden_item_au
AFTER UPDATE ON orden_item
BEGIN
    UPDATE orden
    SET total = (
        SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
        FROM orden_item
        WHERE orden_id = NEW.orden_id
    )
    WHERE id = NEW.orden_id;
END;

CREATE TRIGGER IF NOT EXISTS trg_orden_item_ad
AFTER DELETE ON orden_item
BEGIN
    UPDATE orden
    SET total = (
        SELECT IFNULL(SUM(cantidad * precio_unitario), 0)
        FROM orden_item
        WHERE orden_id = OLD.orden_id
    )
    WHERE id = OLD.orden_id;
END;

INSERT OR IGNORE INTO producto (nombre, categoria, precio, disponible) VALUES
('Hamburguesa Doble',      'HAMBURGUESA', 3500, 1),
('Hamburguesa Sencilla',   'HAMBURGUESA', 1500, 1),
('Hamburguesa con Tocino', 'HAMBURGUESA', 2500, 1),
('Papas Fritas',           'ACOMPAÑAMIENTO', 1000, 1),
('Bebida',                 'BEBIDA', 1000, 1);

INSERT OR IGNORE INTO regla_combo (nombre, aplica_categoria, recargo, incluye_papas, incluye_bebida, activo) VALUES
('Combo papas + bebida (+1500)', 'HAMBURGUESA', 1500, 1, 1, 1);

CREATE VIEW IF NOT EXISTS vw_menu_combos AS
SELECT
    p.id                    AS id_hamburguesa,
    p.nombre                AS hamburguesa,
    p.precio                AS precio_base,
    r.nombre                AS nombre_combo,
    r.recargo               AS recargo_combo,
    (p.precio + r.recargo)  AS precio_combo,
    CASE r.incluye_papas WHEN 1 THEN 'Papas Fritas' ELSE NULL END AS incluye_papas,
    CASE r.incluye_bebida WHEN 1 THEN 'Bebida' ELSE NULL END AS incluye_bebida
FROM producto p
JOIN regla_combo r
  ON p.categoria = r.aplica_categoria
WHERE r.activo = 1
  AND p.categoria = 'HAMBURGUESA';

INSERT OR IGNORE INTO producto (nombre, categoria, precio, disponible) VALUES
('Recargo Combo (+1500)', 'ACOMPAÑAMIENTO', 1500, 1);

INSERT INTO orden (estado) VALUES ('PENDIENTE'); -- id = 1

INSERT INTO orden_item (orden_id, producto_id, cantidad, precio_unitario)
SELECT 1, id, 1, precio FROM producto WHERE nombre = 'Hamburguesa Doble';
INSERT INTO orden_item (orden_id, producto_id, cantidad, precio_unitario)
SELECT 1, id, 1, 0 FROM producto WHERE nombre = 'Papas Fritas';
INSERT INTO orden_item (orden_id, producto_id, cantidad, precio_unitario)
SELECT 1, id, 1, 0 FROM producto WHERE nombre = 'Bebida';
INSERT INTO orden_item (orden_id, producto_id, cantidad, precio_unitario)
SELECT 1, id, 1, precio FROM producto WHERE nombre = 'Recargo Combo (+1500)';

