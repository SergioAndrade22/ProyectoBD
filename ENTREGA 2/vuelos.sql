CREATE DATABASE vuelos;

USE vuelos;

CREATE TABLE ubicacion(
	pais VARCHAR(45) NOT NULL,
	estado VARCHAR(45) NOT NULL,
	ciudad VARCHAR(45) NOT NULL,
	huso INT SIGNED NOT NULL CONSTRAINT huso_invalido CHECK(huso BETWEEN -12 and 12),

	CONSTRAINT pk_ubicacion 
		PRIMARY KEY (pais, estado, ciudad),
		
	KEY(estado),

	KEY(ciudad)
) ENGINE=InnoDB;

CREATE TABLE aeropuertos (
	codigo VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	pais VARCHAR(45) NOT NULL,
	estado VARCHAR(45) NOT NULL,
	ciudad VARCHAR(45) NOT NULL,

	CONSTRAINT pk_aeropuerto 
		PRIMARY KEY (codigo),

	CONSTRAINT fk_aeropuerto_pais 
		FOREIGN KEY (pais) REFERENCES ubicacion(pais) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_aeropuerto_estado 
		FOREIGN KEY (estado) REFERENCES ubicacion(estado) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_aeropuerto_ciudad 
		FOREIGN KEY (ciudad) REFERENCES ubicacion(ciudad) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE table vuelos_programados(
	numero VARCHAR(45) NOT NULL,
	aeropuerto_salida VARCHAR(45) NOT NULL,
	aeropuerto_llegada VARCHAR(45) NOT NULL,

	CONSTRAINT pk_vuelos_programados 
		PRIMARY KEY (numero),

	CONSTRAINT fk_vuelos_programados_salida 
		FOREIGN KEY (aeropuerto_salida) REFERENCES aeropuertos (codigo) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_vuelos_programados_llegada 
		FOREIGN KEY (aeropuerto_llegada) REFERENCES aeropuertos (codigo) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE modelos_avion(
	modelo VARCHAR(45) NOT NULL,
	fabricante VARCHAR(45) NOT NULL,
	cabinas INT UNSIGNED NOT NULL,
	cant_asientos INT UNSIGNED NOT NULL,

	CONSTRAINT pk_modelo_avion 
		PRIMARY KEY (modelo)
) ENGINE=InnoDB;

CREATE TABLE salidas(
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia_salida CHECK(dia IN ('Do','Lu','Ma','Mi','Ju','Vi','Sa')),
	hora_sale DATETIME NOT NULL,
	hora_llega DATETIME NOT NULL,
	modelo_avion VARCHAR(45) NOT NULL,

	CONSTRAINT pk_salidas 
		PRIMARY KEY(vuelo, dia),

	CONSTRAINT fk_salidas_vuelo 
		FOREIGN KEY(vuelo) REFERENCES vuelos_programados(numero) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_salidas_avion 
		FOREIGN KEY(modelo_avion) REFERENCES modelos_avion(modelo) ON DELETE RESTRICT ON UPDATE CASCADE,

	KEY(dia)
) ENGINE=InnoDB;

CREATE TABLE instancias_vuelo(
	vuelo VARCHAR(45) NOT NULL,
	fecha DATETIME NOT NULL,
	dia VARCHAR(2) NOT NULL,
	estado VARCHAR(45) NOT NULL,

	CONSTRAINT pk_instancia_vuelo 
		PRIMARY KEY (vuelo, fecha),

	CONSTRAINT fk_instancia_vuelo_vuelo 
		FOREIGN KEY(vuelo) REFERENCES salidas(vuelo) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_instancia_vuelo_fecha 
		FOREIGN KEY(dia) REFERENCES salidas(dia) ON DELETE RESTRICT ON UPDATE CASCADE,

	KEY(fecha)
) ENGINE=InnoDB;

CREATE TABLE clases(
	nombre VARCHAR(45) NOT NULL,
	porcentaje FLOAT NOT NULL CONSTRAINT no_es_porcentaje CHECK(porcentaje BETWEEN 0.00 AND 0.99),

	CONSTRAINT pk_clases 
		PRIMARY KEY(nombre)
) ENGINE=InnoDB;

CREATE TABLE comodidades(
	codigo INT UNSIGNED NOT NULL,
	descripcion VARCHAR(45) NOT NULL,

	CONSTRAINT pk_comodidades 
		PRIMARY KEY(codigo)
) ENGINE=InnoDB;

CREATE TABLE pasajeros(
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro BIGINT UNSIGNED NOT NULL,
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	nacionalidad VARCHAR(45) NOT NULL,

	CONSTRAINT pk_pasajeros 
		PRIMARY KEY(doc_tipo, doc_nro),

	KEY(doc_nro),

	KEY(doc_tipo)
) ENGINE=InnoDB;

CREATE TABLE empleados(
	legajo BIGINT UNSIGNED NOT NULL,
	password VARCHAR(32) NOT NULL,
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro BIGINT UNSIGNED NOT NULL,
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,

	CONSTRAINT pk_empleados 
		PRIMARY KEY(legajo)
) ENGINE=InnoDB;

CREATE TABLE reservas(
	numero INT UNSIGNED NOT NULL,
	fecha DATETIME NOT NULL,
	vencimiento DATETIME NOT NULL,
	estado VARCHAR(45) NOT NULL,
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro BIGINT UNSIGNED NOT NULL,
	legajo BIGINT UNSIGNED NOT NULL,

	CONSTRAINT pk_reservas 
		PRIMARY KEY(numero),

	CONSTRAINT fk_reservas_doc_tipo 
		FOREIGN KEY(doc_tipo) REFERENCES pasajeros(doc_tipo) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reservas_doc_nro 
		FOREIGN KEY(doc_nro) REFERENCES pasajeros(doc_nro) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reservas_legajo 
		FOREIGN KEY(legajo) REFERENCES empleados(legajo) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE brinda(
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL,
	clase VARCHAR(45) NOT NULL,
	cant_asientos INT UNSIGNED NOT NULL,
	precio DECIMAL(7,2) NOT NULL,

	CONSTRAINT pk_brinda 
		PRIMARY KEY(vuelo, dia, clase),

	CONSTRAINT fk_vuelo_vuelo 
		FOREIGN KEY(vuelo) REFERENCES salidas(vuelo) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_vuelo_dia 
		FOREIGN KEY(dia) REFERENCES salidas(dia) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_vuelo_clase 
		FOREIGN KEY(clase) REFERENCES clases(nombre) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE posee(
	clase VARCHAR(45) NOT NULL,
	comodidad INT UNSIGNED NOT NULL,

	CONSTRAINT pk_posee 
		PRIMARY KEY(clase, comodidad),

	CONSTRAINT fk_posee_clase 
		FOREIGN KEY(clase) REFERENCES clases(nombre) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_posee_codigo 
		FOREIGN KEY(comodidad) REFERENCES comodidades(codigo) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE reserva_vuelo_clase(
	numero INT UNSIGNED NOT NULL,
	vuelo VARCHAR(45) NOT NULL,
	fecha_vuelo DATETIME NOT NULL,
	clase VARCHAR(45) NOT NULL,

	CONSTRAINT pk_reserva_vuelo_clase 
		PRIMARY KEY(numero, vuelo, fecha_vuelo),

	CONSTRAINT fk_reserva_vuelo_clase_numero 
		FOREIGN KEY(numero) REFERENCES reservas(numero) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reserva_vuelo_clase_vuelo 
		FOREIGN KEY(vuelo) REFERENCES instancias_vuelo(vuelo) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reserva_vuelo_clase_fecha_vuelo 
		FOREIGN KEY(fecha_vuelo) REFERENCES instancias_vuelo(fecha) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reserva_vuelo_clase_clase 
		FOREIGN KEY(clase) REFERENCES clases(nombre) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE VIEW vuelos_disponibles AS

SELECT s.vuelo, s.modelo_avion, iv.fecha, s.dia,

	vp.aeropuerto_salida, a_sale.nombre AS nombre_salida, a_sale.ciudad AS ciudad_salida, a_sale.estado AS estado_salida, a_sale.pais AS pais_salida,

	vp.aeropuerto_llegada, a_llega.nombre AS nombre_llegada, a_llega.ciudad AS ciudad_llegada, a_llega.estado AS estado_llegada, a_llega.pais AS pais_llegada,

	s.hora_sale, s.hora_llega, TIMEDIFF(DATE_ADD(s.hora_llega, INTERVAL ubi_lleg.huso HOUR), DATE_ADD(s.hora_sale, INTERVAL ubi_sal.huso HOUR)) AS tiempo_estimado,

	b.precio, TRUNCATE((b.cant_asientos * (1 + c.porcentaje) - ( SELECT COUNT(*) FROM reserva_vuelo_clase WHERE (reserva_vuelo_clase.vuelo = b.vuelo) AND (reserva_vuelo_clase.clase = b.clase))), 0)

FROM salidas AS s, vuelos_programados AS vp, aeropuertos AS a_sale, aeropuertos AS a_llega,
instancias_vuelo AS iv, brinda AS b, clases AS c, ubicacion AS ubi_lleg, ubicacion AS ubi_sal

WHERE (s.vuelo = vp.numero) AND (vp.aeropuerto_salida = a_sale.codigo) AND (vp.aeropuerto_llegada = a_llega.codigo) 
	AND (s.vuelo = iv.vuelo) AND (s.vuelo = b.vuelo) AND (c.nombre = b.clase)
	AND (a_llega.pais = ubi_lleg.pais) AND (a_llega.estado = ubi_lleg.estado) AND (a_llega.ciudad = ubi_lleg.ciudad)
	AND (a_sale.pais = ubi_sal.pais) AND (a_sale.estado = ubi_sal.estado) AND (a_sale.ciudad = ubi_sal.ciudad)
;

CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';
GRANT ALL PRIVILEGES ON vuelos.* TO 'admin'@'localhost' WITH GRANT OPTION;

CREATE USER 'empleado'@'%' IDENTIFIED BY 'empleado';
GRANT SELECT ON vuelos.* TO 'empleado'@'%';
GRANT ALL PRIVILEGES ON vuelos.reservas TO 'empleado'@'%';
GRANT ALL PRIVILEGES ON vuelos.pasajeros TO 'empleado'@'%';
GRANT ALL PRIVILEGES ON vuelos.reserva_vuelo_clase TO 'empleado'@'%';

CREATE USER 'cliente'@'%' IDENTIFIED BY 'cliente';
GRANT SELECT ON vuelos.vuelos_disponibles TO 'cliente'@'%';
