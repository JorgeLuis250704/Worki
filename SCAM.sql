
-- ============================
-- CREAR Y USAR BASE DE DATOS
-- ============================

DROP DATABASE IF EXISTS SCAM;
CREATE DATABASE SCAM CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE SCAM;

-- ============================
-- TABLA DIRECCIONES (2FN)
-- ============================

CREATE TABLE direcciones (
    id_direccion INT PRIMARY KEY AUTO_INCREMENT,
    municipio VARCHAR(30),
    estado VARCHAR(30),
    colonia VARCHAR(30),
    calle VARCHAR(30),
    num_casa INT
);

-- ============================
-- TABLA EMPLEADOS
-- ============================

CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    ap_pat VARCHAR(30),
    ap_mat VARCHAR(30),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    id_direccion INT,
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ============================
-- TABLA PROVEEDORES
-- ============================

CREATE TABLE proveedores (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    ap_pat VARCHAR(30),
    ap_mat VARCHAR(30),
    telefono VARCHAR(20),
    correo VARCHAR(100)
);

-- ============================
-- TABLA CATEGORIAS (3FN OPCIONAL)
-- ============================

CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(50)
);

-- ============================
-- TABLA PRODUCTOS
-- ============================

CREATE TABLE productos (
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10,2),
    stock INT,
    id_categoria INT,
    id_proveedor INT,
    id_empleado INT,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
        ON DELETE SET NULL ON UPDATE CASCADE,
    FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ============================
-- TABLA CLIENTES
-- ============================

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100),
    ap_pat VARCHAR(30),
    ap_mat VARCHAR(30),
    telefono VARCHAR(20),
    correo VARCHAR(100),
    id_direccion INT,
    FOREIGN KEY (id_direccion) REFERENCES direcciones(id_direccion)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ============================
-- TABLA FACTURAS
-- ============================

CREATE TABLE facturas (
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    fecha_venta DATE,
    total DECIMAL(10,2),
    id_cliente INT,
    id_empleado INT,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado)
        ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ============================
-- INSERTS DE EJEMPLO
-- ============================

-- Direcciones para empleados
INSERT INTO direcciones (municipio, estado, colonia, calle, num_casa) VALUES
('Leon', 'Guanajuato', 'Centro', 'Tecnologico', 101),
('Irapuato', 'Guanajuato', 'Jardin', 'Reforma', 102),
('Celaya', 'Guanajuato', 'Industrial', 'Fresnos', 103),
('Salamanca', 'Guanajuato', 'Magisterial', 'Sauces', 104),
('San Miguel', 'Guanajuato', 'Mirador', 'Cedros', 105);

-- Empleados
INSERT INTO empleados (nombre, ap_pat, ap_mat, telefono, correo, id_direccion) VALUES
('Ramon', 'Perez', 'Lopez', '4771231111', 'ramon@browse.com', 1),
('Luisa', 'Gomez', 'Ruiz', '4629872222', 'luisa@browse.com', 2),
('Cesar', 'Lopez', 'Santos', '4612343333', 'cesar@browse.com', 3),
('Elena', 'Torres', 'Nunez', '4648764444', 'elena@browse.com', 4),
('Miguel', 'Martinez', 'Ortega', '4151235555', 'miguel@browse.com', 5);

-- Proveedores
INSERT INTO proveedores (nombre, ap_pat, ap_mat, telefono, correo) VALUES
('RefaccionesJIM', 'Hernandez', 'Luna', '5551111111', 'contacto@jim.com'),
('AutoPartsMX', 'Jimenez', 'Castro', '5552222222', 'ventas@autopartsmx.com'),
('DistribuidoraNAV', 'Navarro', 'Mendoza', '5553333333', 'soporte@nav.com'),
('MotorCenter', 'Ramos', 'Salazar', '5554444444', 'info@motorcenter.com'),
('LubricantesVP', 'Vargas', 'Pineda', '5555555555', 'ventas@lubvp.com');

-- Categorías
INSERT INTO categorias (nombre_categoria) VALUES
('Lubricantes'),
('Filtros'),
('Encendido'),
('Frenos'),
('Refrigerantes');

-- Productos
INSERT INTO productos (nombre, descripcion, precio, stock, id_categoria, id_proveedor, id_empleado) VALUES
('Aceite sintetico 5W30', 'Lubricante para motor de alto rendimiento', 420.00, 80, 1, 1, 1),
('Filtro de aceite', 'Filtro compatible con autos sedan', 150.00, 120, 2, 2, 2),
('Bujia NGK', 'Bujia para motor a gasolina', 85.00, 200, 3, 3, 3),
('Pastillas de freno', 'Juego delantero compacto', 320.00, 60, 4, 4, 4),
('Anticongelante verde', 'Proteccion para sistema de enfriamiento', 190.00, 50, 5, 5, 5);

-- Direcciones para clientes
INSERT INTO direcciones (municipio, estado, colonia, calle, num_casa) VALUES
('Queretaro', 'Queretaro', 'Centro', '5 de Febrero', 10),
('Corregidora', 'Queretaro', 'Tejeda', 'Constituyentes', 20),
('San Juan', 'Queretaro', 'Vista Real', 'Zaragoza', 30),
('El Marques', 'Queretaro', 'Zibata', 'Hidalgo', 40),
('Amealco', 'Queretaro', 'Centro', 'Juarez', 50);

-- Clientes
INSERT INTO clientes (nombre, ap_pat, ap_mat, telefono, correo, id_direccion) VALUES
('Carlos', 'Gonzalez', 'Muñoz', '4421230000', 'carlos@cliente.com', 6),
('Lucia', 'Sanchez', 'Cruz', '4422340000', 'lucia@cliente.com', 7),
('Jorge', 'Lopez', 'Reyes', '4423450000', 'jorge@cliente.com', 8),
('Claudia', 'Flores', 'Diaz', '4424560000', 'claudia@cliente.com', 9),
('Ricardo', 'Mendoza', 'Campos', '4425670000', 'ricardo@cliente.com', 10);

-- Facturas
INSERT INTO facturas (fecha_venta, total, id_cliente, id_empleado) VALUES
('2025-08-01', 420.00, 1, 1),
('2025-08-02', 300.00, 2, 2),
('2025-08-03', 255.00, 3, 3),
('2025-08-04', 490.00, 4, 4),
('2025-08-05', 320.00, 5, 5);

-- ============================
-- CONSULTAS SOLICITADAS
-- ============================
/*
-- 1. Consulta con WHERE empleado por id
SELECT  
FROM empleados 
WHERE id_direccion = 1,direccion=;

-- 2. Consulta con WHERE productos con precio mayor a 100
SELECT  
FROM productos 
WHERE precio  100;

-- 3. Consulta con JOIN nombre del producto y su categoría
SELECT productos.nombre, categorias.nombre_categoria
FROM productos
JOIN categorias ON productos.id_categoria = categorias.id_categoria;
*/
-- 4. Consulta con JOIN nombre del cliente y su municipio
SELECT clientes.nombre, direcciones.municipio
FROM clientes
JOIN direcciones ON clientes.id_direccion = direcciones.id_direccion;
/*
-- 5. Consulta con SUM total de todas las facturas
SELECT SUM(total) AS total_facturado
FROM facturas;

-- 6. Consulta con SUM total del stock de productos
SELECT SUM(stock) AS stock_total
FROM productos;

-- 7. Consulta con AVG precio promedio de productos
SELECT AVG(precio) AS precio_promedio
FROM productos;

-- 8. Consulta con AVG promedio del total de facturas
SELECT AVG(total) AS promedio_ventas
FROM facturas;
