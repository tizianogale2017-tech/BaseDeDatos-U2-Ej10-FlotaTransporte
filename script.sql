-- Base de Datos I - Unidad 4 - Ej10: FlotaTransporte
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS CARGA_COMBUSTIBLE;
DROP TABLE IF EXISTS MANTENIMIENTO;
DROP TABLE IF EXISTS viaje_chofer;
DROP TABLE IF EXISTS VIAJE;
DROP TABLE IF EXISTS ESTACION_SERVICIO;
DROP TABLE IF EXISTS TALLER;
DROP TABLE IF EXISTS VEHICULO;
DROP TABLE IF EXISTS CHOFER;

CREATE TABLE CHOFER (
    id_chofer INT PRIMARY KEY,
    legajo_chofer VARCHAR(50),
    dni_chofer INT,
    nombre_chofer VARCHAR(50),
    fecha_nacimiento DATE,
    categoria_licencia VARCHAR(50),
    vencimiento_licencia VARCHAR(100)
);

CREATE TABLE VEHICULO (
    id_vehiculo INT PRIMARY KEY,
    patente VARCHAR(50) UNIQUE,
    numero_chasis VARCHAR(100) UNIQUE,
    anio_fabricacion INT,
    marca VARCHAR(50),
    modelo VARCHAR(50),
    kilometraje_actual INT
);

CREATE TABLE TALLER (
    id_taller INT PRIMARY KEY,
    cuit_taller VARCHAR(50),
    nombre_taller VARCHAR(50),
    direccion_taller VARCHAR(50),
    telefono_taller VARCHAR(100),
    especialidad VARCHAR(50)
);

CREATE TABLE ESTACION_SERVICIO (
    id_estacion INT PRIMARY KEY,
    cuit_estacion VARCHAR(50),
    nombre_estacion VARCHAR(50),
    direccion_estacion VARCHAR(50),
    localidad VARCHAR(50),
    bandera VARCHAR(100),
    telefono_estacion VARCHAR(100)
);

CREATE TABLE VIAJE (
    id_viaje INT PRIMARY KEY,
    id_vehiculo INT,
    fecha_hora_salida DATETIME,
    fecha_hora_llegada DATE,
    origen_viaje VARCHAR(50),
    destino_viaje VARCHAR(50),
    carga_kg VARCHAR(100),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo)
);

CREATE TABLE viaje_chofer (
    id_viaje_chofer INT PRIMARY KEY,
    id_viaje INT,
    id_chofer INT,
    rol_chofer VARCHAR(50),
    horas_conduccion INT,
    FOREIGN KEY (id_viaje) REFERENCES VIAJE(id_viaje),
    FOREIGN KEY (id_chofer) REFERENCES CHOFER(id_chofer)
);

CREATE TABLE MANTENIMIENTO (
    id_mantenimiento INT PRIMARY KEY,
    id_vehiculo INT,
    id_taller INT,
    tipo_mantenimiento VARCHAR(50),
    fecha_ingreso DATE,
    descripcion_trabajos VARCHAR(100),
    repuestos_utilizados VARCHAR(100),
    costo_total DECIMAL(12,2),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo),
    FOREIGN KEY (id_taller) REFERENCES TALLER(id_taller)
);

CREATE TABLE CARGA_COMBUSTIBLE (
    id_carga INT PRIMARY KEY,
    id_vehiculo INT,
    id_estacion INT,
    fecha_carga DATE,
    litros_cargados DECIMAL(12,2),
    costo_por_litro DECIMAL(12,2),
    odometro_carga VARCHAR(100),
    tipo_combustible VARCHAR(100),
    FOREIGN KEY (id_vehiculo) REFERENCES VEHICULO(id_vehiculo),
    FOREIGN KEY (id_estacion) REFERENCES ESTACION_SERVICIO(id_estacion)
);

-- Datos de CHOFER
INSERT INTO CHOFER (id_chofer, legajo_chofer, nombre_chofer, categoria_licencia, dni_chofer) VALUES (1, 'CH-01', 'Raúl Medina', 'D1', 24111222);
INSERT INTO CHOFER (id_chofer, legajo_chofer, nombre_chofer, categoria_licencia, dni_chofer) VALUES (2, 'CH-02', 'Sergio Pino', 'E1', 23222333);
INSERT INTO CHOFER (id_chofer, legajo_chofer, nombre_chofer, categoria_licencia, dni_chofer) VALUES (3, 'CH-03', 'Omar Lagos', 'D1', 25333444);
INSERT INTO CHOFER (id_chofer, legajo_chofer, nombre_chofer, categoria_licencia, dni_chofer) VALUES (4, 'CH-04', 'Hernán Duarte', 'E2', 26444555);

-- Datos de VEHICULO
INSERT INTO VEHICULO (id_vehiculo, patente, marca, modelo, anio_fabricacion) VALUES (1, 'AB123CD', 'Mercedes-Benz', 'Sprinter', 2021);
INSERT INTO VEHICULO (id_vehiculo, patente, marca, modelo, anio_fabricacion) VALUES (2, 'AC456EF', 'Scania', 'R450', 2019);
INSERT INTO VEHICULO (id_vehiculo, patente, marca, modelo, anio_fabricacion) VALUES (3, 'AE012IJ', 'Volvo', 'FH 460', 2020);
INSERT INTO VEHICULO (id_vehiculo, patente, marca, modelo, anio_fabricacion) VALUES (4, 'AF345KL', 'Ford', 'Transit', 2023);

-- Datos de TALLER
INSERT INTO TALLER (id_taller, cuit_taller, nombre_taller, especialidad, direccion_taller) VALUES (1, '30-60111111-1', 'Taller Cuyo', 'Motores', 'Ruta 7 km 12');
INSERT INTO TALLER (id_taller, cuit_taller, nombre_taller, especialidad, direccion_taller) VALUES (2, '30-60222222-2', 'Mecánica Sur', 'Frenos', 'Av. Sur 340');
INSERT INTO TALLER (id_taller, cuit_taller, nombre_taller, especialidad, direccion_taller) VALUES (3, '30-60444444-4', 'AutoService', 'Electricidad', 'Calle Norte 77');
INSERT INTO TALLER (id_taller, cuit_taller, nombre_taller, especialidad, direccion_taller) VALUES (4, '30-60555555-5', 'Frenos Express', 'Frenos', 'Av. Libertador 1500');

-- Datos de ESTACION_SERVICIO
INSERT INTO ESTACION_SERVICIO (id_estacion, cuit_estacion, nombre_estacion, localidad, direccion_estacion) VALUES (1, '30-70111111-1', 'YPF Ruta 7', 'Luján', 'Ruta 7 km 20');
INSERT INTO ESTACION_SERVICIO (id_estacion, cuit_estacion, nombre_estacion, localidad, direccion_estacion) VALUES (2, '30-70222222-2', 'Shell Centro', 'Mendoza', 'Av. San Martín 900');
INSERT INTO ESTACION_SERVICIO (id_estacion, cuit_estacion, nombre_estacion, localidad, direccion_estacion) VALUES (3, '30-70333333-3', 'Axion Norte', 'Córdoba', 'Av. Colón 1500');
INSERT INTO ESTACION_SERVICIO (id_estacion, cuit_estacion, nombre_estacion, localidad, direccion_estacion) VALUES (4, '30-70555555-5', 'YPF Ruta 40', 'Malargüe', 'Ruta 40 km 10');

-- Datos de VIAJE
INSERT INTO VIAJE (id_viaje, id_vehiculo, origen_viaje, destino_viaje, fecha_hora_salida) VALUES (1, 1, 'Mendoza', 'San Juan', '2026-09-01 06:00');
INSERT INTO VIAJE (id_viaje, id_vehiculo, origen_viaje, destino_viaje, fecha_hora_salida) VALUES (2, 2, 'Córdoba', 'Mendoza', '2026-09-02 07:30');
INSERT INTO VIAJE (id_viaje, id_vehiculo, origen_viaje, destino_viaje, fecha_hora_salida) VALUES (3, 2, 'Rosario', 'Córdoba', '2026-09-03 05:00');
INSERT INTO VIAJE (id_viaje, id_vehiculo, origen_viaje, destino_viaje, fecha_hora_salida) VALUES (4, 4, 'Neuquén', 'Bariloche', '2026-09-05 06:30');

-- Datos de viaje_chofer
INSERT INTO viaje_chofer (id_viaje_chofer, id_viaje, id_chofer, rol_chofer, horas_conduccion) VALUES (1, 1, 1, 'Titular', 4);
INSERT INTO viaje_chofer (id_viaje_chofer, id_viaje, id_chofer, rol_chofer, horas_conduccion) VALUES (2, 2, 2, 'Titular', 9);
INSERT INTO viaje_chofer (id_viaje_chofer, id_viaje, id_chofer, rol_chofer, horas_conduccion) VALUES (3, 2, 3, 'Acompañante', 5);
INSERT INTO viaje_chofer (id_viaje_chofer, id_viaje, id_chofer, rol_chofer, horas_conduccion) VALUES (4, 3, 4, 'Titular', 6);

-- Datos de MANTENIMIENTO
INSERT INTO MANTENIMIENTO (id_mantenimiento, id_vehiculo, id_taller, tipo_mantenimiento, costo_total) VALUES (1, 1, 1, 'Preventivo', 80000);
INSERT INTO MANTENIMIENTO (id_mantenimiento, id_vehiculo, id_taller, tipo_mantenimiento, costo_total) VALUES (2, 2, 2, 'Correctivo', 250000);
INSERT INTO MANTENIMIENTO (id_mantenimiento, id_vehiculo, id_taller, tipo_mantenimiento, costo_total) VALUES (3, 3, 3, 'Correctivo', 180000);
INSERT INTO MANTENIMIENTO (id_mantenimiento, id_vehiculo, id_taller, tipo_mantenimiento, costo_total) VALUES (4, 4, 4, 'Preventivo', 60000);

-- Datos de CARGA_COMBUSTIBLE
INSERT INTO CARGA_COMBUSTIBLE (id_carga, id_vehiculo, id_estacion, litros_cargados, fecha_carga) VALUES (1, 1, 1, 60, '2026-09-01');
INSERT INTO CARGA_COMBUSTIBLE (id_carga, id_vehiculo, id_estacion, litros_cargados, fecha_carga) VALUES (2, 1, 2, 45, '2026-09-02');
INSERT INTO CARGA_COMBUSTIBLE (id_carga, id_vehiculo, id_estacion, litros_cargados, fecha_carga) VALUES (3, 2, 3, 300, '2026-09-02');
INSERT INTO CARGA_COMBUSTIBLE (id_carga, id_vehiculo, id_estacion, litros_cargados, fecha_carga) VALUES (4, 3, 4, 250, '2026-09-04');
