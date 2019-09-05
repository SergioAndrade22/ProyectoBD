CREATE DATABASE vuelos;

USE vuelos;

CREATE TABLE ubicacion(
	pais VARCHAR(45) NOT NULL,
	estado VARCHAR(45) NOT NULL,
	ciudad VARCHAR(45) NOT NULL,
	huso INT SIGNED NOT NULL CONSTRAINT huso_invalido CHECK(huso BETWEEN -12 and 12),

	CONSTRAINT pk_ubicacion PRIMARY KEY (pais, estado, ciudad),

	KEY(estado),

	KEY(ciudad)
) ENGINE=InnoDB;

CREATE TABLE aeropuerto (
	codigo VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	pais VARCHAR(45) NOT NULL,
	estado VARCHAR(45) NOT NULL,
	ciudad VARCHAR(45) NOT NULL,

	CONSTRAINT pk_aeropuerto PRIMARY KEY (codigo),

	CONSTRAINT fk_aeropuerto_pais FOREIGN KEY (pais) REFERENCES ubicacion(pais),

	CONSTRAINT fk_aeropuerto_estado FOREIGN KEY (estado) REFERENCES ubicacion(estado),

	CONSTRAINT fk_aeropuerto_ciudad FOREIGN KEY (ciudad) REFERENCES ubicacion(ciudad)

) ENGINE=InnoDB;

CREATE table vuelos_programados(
	numero VARCHAR(45) NOT NULL,
	aeropuerto_salida VARCHAR(45) NOT NULL,
	aeropuerto_llegada VARCHAR(45) NOT NULL,

	CONSTRAINT pk_vuelos_programados PRIMARY KEY (numero),

	CONSTRAINT fk_vuelos_programados_salida FOREIGN KEY (aeropuerto_salida) REFERENCES aeropuerto (codigo),

	CONSTRAINT fk_vuelos_programados_llegada FOREIGN KEY (aeropuerto_llegada) REFERENCES aeropuerto (codigo)
) ENGINE=InnoDB;

CREATE TABLE modelo_avion(
	modelo VARCHAR(45) NOT NULL,
	fabricante VARCHAR(45) NOT NULL,
	cabinas INT UNSIGNED NOT NULL,
	cant_asientos INT UNSIGNED NOT NULL,

	CONSTRAINT pk_modelo_avion PRIMARY KEY (modelo)
) ENGINE=InnoDB;

CREATE TABLE salidas(
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia_salida CHECK(dia IN ('Do','Lu','Ma','Mi','Ju','Vi','Sa')),
	hora_sale TIME NOT NULL,
	hora_llega TIME NOT NULL,
	modelo_avion VARCHAR(45) NOT NULL,

	CONSTRAINT pk_salidas PRIMARY KEY(vuelo, dia),

	CONSTRAINT fk_salidas_vuelo FOREIGN KEY(vuelo) REFERENCES vuelos_programados(numero),

	CONSTRAINT fk_salidas_avion FOREIGN KEY(modelo_avion) REFERENCES modelo_avion(modelo),

	key(dia)
) ENGINE=InnoDB;

CREATE TABLE instancia_vuelo(
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia_instancia_vuelo CHECK(dia IN ('Do','Lu','Ma','Mi','Ju','Vi','Sa')),
	estado VARCHAR(45) NOT NULL,

	CONSTRAINT pk_instancia_vuelo PRIMARY KEY (vuelo, dia),

	CONSTRAINT fk_instancia_vuelo_vuelo FOREIGN KEY(vuelo) REFERENCES salidas(vuelo),

	CONSTRAINT fk_instancia_vuelo_fecha FOREIGN KEY(dia) REFERENCES salidas(dia)
) ENGINE=InnoDB;

CREATE TABLE clases(
	nombre VARCHAR(45) NOT NULL,
	porcentaje FLOAT NOT NULL CONSTRAINT no_es_porcentaje CHECK(porcentaje BETWEEN 0.00 AND 0.99),

	CONSTRAINT pk_clases PRIMARY KEY(nombre)
) ENGINE=InnoDB;

CREATE TABLE comodidades(
	codigo INT UNSIGNED NOT NULL,
	descrpcion VARCHAR(45) NOT NULL,

	CONSTRAINT pk_comodidades PRIMARY KEY(codigo)
) ENGINE=InnoDB;

CREATE TABLE pasajeros(
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro BIGINT UNSIGNED NOT NULL,
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	nacionalidad VARCHAR(45) NOT NULL,

	CONSTRAINT pk_pasajeros PRIMARY KEY(doc_tipo, doc_nro),

	key(doc_nro),
	key(doc_tipo)
) ENGINE=InnoDB;

CREATE TABLE empleados(
	legajo BIGINT UNSIGNED NOT NULL,
	password CHAR(32) NOT NULL,
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro BIGINT UNSIGNED NOT NULL,
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,

	CONSTRAINT pk_empleados PRIMARY KEY(legajo)
) ENGINE=InnoDB;

CREATE TABLE reservas(
	numero INT UNSIGNED NOT NULL,
	fecha DATE NOT NULL,
	vencimiento DATE NOT NULL,
	estado VARCHAR(45) NOT NULL,
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro BIGINT UNSIGNED NOT NULL,
	legajo BIGINT UNSIGNED NOT NULL,

	CONSTRAINT pk_reservas PRIMARY KEY(numero),

	CONSTRAINT fk_reservas_doc_tipo FOREIGN KEY(doc_tipo) REFERENCES pasajeros(doc_tipo),

	CONSTRAINT fk_reservas_doc_nro FOREIGN KEY(doc_nro) REFERENCES pasajeros(doc_nro),

	CONSTRAINT fk_reservas_legajo FOREIGN KEY(legajo) REFERENCES empleados(legajo)
) ENGINE=InnoDB;

CREATE TABLE brinda(
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia_brinda CHECK(dia IN ('Do','Lu','Ma','Mi','Ju','Vi','Sa')),
	clase VARCHAR(45) NOT NULL,
	cant_asientos INT UNSIGNED NOT NULL,
	precio FLOAT(7, 2) UNSIGNED NOT NULL,

	CONSTRAINT pk_brinda PRIMARY KEY(vuelo, dia, clase),

	CONSTRAINT fk_vuelo_vuelo FOREIGN KEY(vuelo) REFERENCES salidas(vuelo),

	CONSTRAINT fk_vuelo_dia FOREIGN KEY(dia) REFERENCES salidas(dia),

	CONSTRAINT fk_vuelo_clase FOREIGN KEY(clase) REFERENCES clases(nombre)
) ENGINE=InnoDB;

CREATE TABLE posee(
	clase VARCHAR(45) NOT NULL,
	codigo INT UNSIGNED NOT NULL,

	CONSTRAINT pk_posee PRIMARY KEY(clase, codigo),

	CONSTRAINT fk_posee_clase FOREIGN KEY(clase) REFERENCES clases(nombre),

	CONSTRAINT fk_posee_codigo FOREIGN KEY(codigo) REFERENCES comodidades(codigo)
) ENGINE=InnoDB;

CREATE TABLE reserva_vuelo_clase(
	numero INT UNSIGNED NOT NULL,
	vuelo VARCHAR(45) NOT NULL,
	fecha_vuelo VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia_reserva_vuelo_clase CHECK(fecha_vuelo IN ('Do','Lu','Ma','Mi','Ju','Vi','Sa')),
	clase VARCHAR(45) NOT NULL,

	CONSTRAINT pk_reserva_vuelo_clase PRIMARY KEY(numero, vuelo, fecha_vuelo),

	CONSTRAINT fk_reserva_vuelo_clase_numero FOREIGN KEY(numero) REFERENCES reservas(numero),

	CONSTRAINT fk_reserva_vuelo_clase_vuelo FOREIGN KEY(vuelo) REFERENCES instancia_vuelo(vuelo),

	CONSTRAINT fk_reserva_vuelo_clase_dia FOREIGN KEY(fecha_vuelo) REFERENCES instancia_vuelo(dia)
) ENGINE=InnoDB;
