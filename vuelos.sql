CREATE DATABASE vuelos;

USE vuelos;

CREATE TABLE ubicacion{
	pais VARCHAR(45) NOT NULL,
	estado VARCHAR(45) NOT NULL,
	ciudad VARCHAR(45) NOT NULL,
	huso INT SIGNED NOT NULL CONSTRAINT huso_invalido CHECK(BETWEEN -12 AND 12),
	
	CONSTRAINT pk_ubicacion PRIMARY KEY (pais, estado, ciudad)
} ENGINE=InnoDB;

CREATE TABLE aeropuerto {
	codigo VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	pais VARCHAR(45) NOT NULL,
	estado VARCHAR(45) NOT NULL,
	ciudad VARCHAR(45) NOT NULL,
	
	CONSTRAINT pk_aeropuerto PRIMARY KEY (codigo),
	
	CONSTRAINT fk_aeropuerto FOREIGN KEY (pais) REFERENCES ubicacion(pais),
	
	CONSTRAINT fk_aeropuerto FOREIGN KEY (estado) REFERENCES ubicacion(estado),
	
	CONSTRAINT fk_aeropuerto FOREIGN KEY (ciudad) REFERENCES ubicacion(ciudad)
	
} ENGINE=InnoDB;

CREATE table vuelos_programados{
	numero VARCHAR(45) NOT NULL,
	aeropuerto_salida VARCHAR(45) NOT NULL,
	aeropuerto_llegada VARCHAR(45) NOT NULL,
	
	CONSTRAINT pk_vuelos_programados PRIMARY KEY (numero),
	
	CONSTRAINT fk_vuelos_programados FOREIGN KEY (aeropuerto_salida) REFERENCES aeropuerto (codigo),
	
	CONSTRAINT fk_vuelos_programados FOREIGN KEY (aeropuerto_llegada) REFERENCES aeropuerto (codigo)	
} ENGINE=InnoDB;

CREATE TABLE modelo_avion{
	modelo VARCHAR(45) NOT NULL,
	fabricante VARCHAR(45) NOT NULL,
	cabinas UNSIGNED INT NOT NULL,
	cant_asientos UNSIGNED INT NOT NULL,
	
	CONSTRAINT pk_modelo_avion PRIMARY KEY modelo
} ENGINE=InnoDB;

CREATE TABLE salidas{
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia CHECK(dia in {"Do","Lu","Ma","Mi","Ju","Vi","Sa"}),
	hora_sale TIME NOT NULL,
	hora_llega TIME NOT NULL,
	modelo_avion VARCHAR(45) NOT NULL,
	
	CONSTRAINT pk_salidas PRIMARY KEY(vuelo, dia)
	
	CONSTRAINT fk_salidas FOREIGN KEY(vuelo) REFERENCES vuelos_programados(numero)
	
	CONSTRAINT fk_salidas FOREIGN KEY(modelo_avion) REFERENCES modelo_avion(modelo)
} ENGINE=InnoDB;

CREATE TABLE instancia_vuelo{
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia CHECK(dia in {"Do","Lu","Ma","Mi","Ju","Vi","Sa"}),
	estado VARCHAR(45) NOT NULL,
	
	CONSTANT pk_instancia_vuelo PRIMARY KEY (vuelo, dia),
	
	CONSTRAINT fk_instancia_vuelo FOREIGN KEY(vuelo) REFERENCES salidas(vuelo),
	
	CONSTRAINT fk_instancia_vuelo FOREIGN KEY(dia) REFERENCES salidas(dia),
} ENGINE=InnoDB;

CREATE TABLE clases{
	nombre VARCHAR(45) NOT NULL,
	porcentaje FLOAT NOT NULL CONSTRAINT no_es_porcentaje CHECK(porcentaje>=0 AND porcentaje<=0.99),
	
	CONSTRAINT pk_clases PRIMARY KEY(nombre),
} ENGINE=InnoDB;

CREATE TABLE comodidades{
	codigo INT UNSIGNED NOT NULL,
	descrpcion VARCHAR(45) NOT NULL,
	
	CONSTRAINT pk_comodidades PRIMARY KEY(codigo),
} ENGINE=InnoDB;

CREATE TABLE pasajeros{
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro LONG UNSIGNED NOT NULL,
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	nacionalidad VARCHAR(45) NOT NULL,
	
	CONSTRAINT pk_pasajeros PRIMARY KEY(doc_tipo, doc_nro)
} ENGINE=InnoDB;

CREATE TABLE empleados{
	legajo LONG UNSIGNED NOT NULL,
	password CHAR(32) NOT NULL,
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro LONG UNSIGNED NOT NULL,
	apellido VARCHAR(45) NOT NULL,
	nombre VARCHAR(45) NOT NULL,
	direccion VARCHAR(45) NOT NULL,
	telefono VARCHAR(45) NOT NULL,
	
	CONSTRAINT pk_empleados PRIMARY KEY(legajo)
} ENGINE=InnoDB;

CREATE TABLE reservas{
	numero INT UNSIGNED NOT NULL,
	fecha DATE NOT NULL,
	vencimiento DATE NOT NULL,
	estado VARCHAR(45) NOT NULL,
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro LONG UNSIGNED NOT NULL,
	legajo LONG UNSIGNED NOT NULL,
	
	CONSTRAINT pk_reservas PRIMARY KEY(numero),
	
	CONSTRAINT fk_reservas FOREIGN KEY(doc_tipo) REFERENCES pasajeros(doc_tipo),
	
	CONSTRAINT fk_reservas FOREIGN KEY(doc_nro) REFERENCES pasajeros(doc_nro),
	
	CONSTRAINT fk_reservas FOREIGN KEY(legajo) REFERENCES empleados(legajo)
} ENGINE=InnoDB;

CREATE TABLE brinda{
	vuelo VARCHAR(45) NOT NULL,
	dia VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia CHECK(dia in {"Do","Lu","Ma","Mi","Ju","Vi","Sa"}),
	clase VARCHAR(45) NOT NULL,
	cant_asientos INT UNSIGNED NOT NULL,
	precio FLOAT UNSIGNED DECIMAL(5,2),
	
	CONSTRAINT pk_brinda PRIMARY KEY(vuelo, dia, clase),
	
	CONSTRAINT fk_vuelo FOREIGN KEY(vuelo) REFERENCES salidas(vuelo),
	
	CONSTRAINT fk_vuelo FOREIGN KEY(dia) REFERENCES salidas(dia),
	
	CONSTRAINT fk_vuelo FOREIGN KEY(clase) REFERENCES clases(nombre)
} ENGINE=InnoDB;

CREATE TABLE posee{
	clase VARCHAR(45) NOT NULL,
	codigo INT UNSIGNED NOT NULL,
	
	CONSTRAINT pk_posee PRIMARY KEY(clase, comodidad),
	
	CONSTRAINT fk_posee FOREIGN KEY(clase) REFERENCES clases(nombre),
	
	CONSTRAINT fk_posee FOREIGN KEY(codigo) REFERENCES comodidad(codigo)
} ENGINE=InnoDB;

CREATE TABLE reserva_vuelo_clase{
	numero INT UNSIGNED NOT NULL,
	vuelo VARCHAR(45) NOT NULL,
	fecha_vuelo VARCHAR(2) NOT NULL CONSTRAINT ingresar_dia CHECK(dia in {"Do","Lu","Ma","Mi","Ju","Vi","Sa"}),
	clase VARCHAR(45) NOT NULL,
	
	CONSTRAINT pk_reserva_vuelo_clase PRIMARY KEY(numero, vuelo, fecha_vuelo),

	CONSTRAINT fk_reserva_vuelo_clase FOREIGN KEY(numero) REFERENCES reserva(numero),
	
	CONSTRAINT fk_reserva_vuelo_clase FOREIGN KEY(vuelo) REFERENCES instancia_vuelo(vuelo),
	
	CONSTRAINT fk_reserva_vuelo_clase FOREIGN KEY(fecha_vuelo) REFERENCES instancia_vuelo(dia)
} ENGINE=InnoDB;