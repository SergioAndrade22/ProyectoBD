DROP DATABASE vuelos;
drop user cliente;
drop user admin@localhost;
drop user empleado;

CREATE DATABASE vuelos;

USE vuelos;

CREATE TABLE ubicaciones(
	pais VARCHAR(45) NOT NULL,
	estado VARCHAR(45) NOT NULL,
	ciudad VARCHAR(45) NOT NULL,
	huso INT SIGNED NOT NULL CONSTRAINT huso_invalido CHECK(huso BETWEEN -12 and 12),

	CONSTRAINT pk_ubicaciones
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

	CONSTRAINT fk_aeropuerto_ubicacion FOREIGN KEY (pais, estado, ciudad) REFERENCES ubicaciones(pais, estado, ciudad) ON DELETE RESTRICT ON UPDATE CASCADE
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
	dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa') NOT NULL,
	hora_sale TIME NOT NULL,
	hora_llega TIME NOT NULL,
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
	fecha DATE NOT NULL,
	dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa') NOT NULL,
	estado VARCHAR(45),

	CONSTRAINT pk_instancia_vuelo
		PRIMARY KEY (vuelo, fecha),

	CONSTRAINT fk_instancia_vuelo_vuelo
		FOREIGN KEY(vuelo, dia) REFERENCES salidas(vuelo, dia) ON DELETE RESTRICT ON UPDATE CASCADE,

	KEY(fecha)
) ENGINE=InnoDB;

CREATE TABLE clases(
	nombre VARCHAR(45) NOT NULL,
	porcentaje DECIMAL(2,2) UNSIGNED NOT NULL CONSTRAINT no_es_porcentaje CHECK(porcentaje BETWEEN 0.00 AND 0.99),

	CONSTRAINT pk_clases
		PRIMARY KEY(nombre)
) ENGINE=InnoDB;

CREATE TABLE comodidades(
	codigo INT UNSIGNED NOT NULL,
	descripcion TEXT NOT NULL,

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
	numero INT UNSIGNED NOT NULL AUTO_INCREMENT,
	fecha DATE NOT NULL,
	vencimiento DATE NOT NULL,
	estado VARCHAR(45) NOT NULL,
	doc_tipo VARCHAR(45) NOT NULL,
	doc_nro BIGINT UNSIGNED NOT NULL,
	legajo BIGINT UNSIGNED NOT NULL,

	CONSTRAINT pk_reservas
		PRIMARY KEY(numero),

	CONSTRAINT fk_reservas_doc
		FOREIGN KEY(doc_tipo, doc_nro) REFERENCES pasajeros(doc_tipo, doc_nro) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reservas_legajo
		FOREIGN KEY(legajo) REFERENCES empleados(legajo) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE brinda(
	vuelo VARCHAR(45) NOT NULL,
	dia ENUM('Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sa') NOT NULL,
	clase VARCHAR(45) NOT NULL,
	cant_asientos INT UNSIGNED NOT NULL,
	precio DECIMAL(7,2) UNSIGNED NOT NULL,

	CONSTRAINT pk_brinda
		PRIMARY KEY(vuelo, dia, clase),

	CONSTRAINT fk_vuelo_salida
		FOREIGN KEY(vuelo, dia) REFERENCES salidas(vuelo, dia) ON DELETE RESTRICT ON UPDATE CASCADE,

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
	fecha_vuelo DATE NOT NULL,
	clase VARCHAR(45) NOT NULL,

	CONSTRAINT pk_reserva_vuelo_clase
		PRIMARY KEY(numero, vuelo, fecha_vuelo),

	CONSTRAINT fk_reserva_vuelo_clase_numero
		FOREIGN KEY(numero) REFERENCES reservas(numero) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reserva_vuelo_clase_vuelo
		FOREIGN KEY(vuelo, fecha_vuelo) REFERENCES instancias_vuelo(vuelo, fecha) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_reserva_vuelo_clase_clase
		FOREIGN KEY(clase) REFERENCES clases(nombre) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

CREATE TABLE asientos_reservados(
	vuelo VARCHAR(45) NOT NULL,
	fecha DATE NOT NULL,
	clase VARCHAR(45) NOT NULL,
	cantidad INT UNSIGNED AUTO_INCREMENT,

	CONSTRAINT pk_asientos_reservados
		PRIMARY KEY(vuelo, fecha, clase),

	CONSTRAINT fk_asientos_reservados_instancias_vuelo
		FOREIGN KEY(vuelo, fecha) REFERENCES instancias_vuelo(vuelo, fecha) ON DELETE RESTRICT ON UPDATE CASCADE,

	CONSTRAINT fk_asientos_reservados_clase
		FOREIGN KEY (clase) REFERENCES clases(nombre) ON DELETE RESTRICT ON UPDATE CASCADE,

	KEY(cantidad)
) ENGINE=InnoDB;

CREATE VIEW vuelos_disponibles AS

SELECT DISTINCT s.vuelo, s.modelo_avion, iv.fecha, s.dia,

	vp.aeropuerto_salida, a_sale.nombre AS nombre_salida, a_sale.ciudad AS ciudad_salida, a_sale.estado AS estado_salida, a_sale.pais AS pais_salida,

	vp.aeropuerto_llegada, a_llega.nombre AS nombre_llegada, a_llega.ciudad AS ciudad_llegada, a_llega.estado AS estado_llegada, a_llega.pais AS pais_llegada,

	s.hora_sale, s.hora_llega, CASE WHEN TIME(s.hora_llega) < TIME(s.hora_sale) THEN TIMEDIFF(ADDTIME(s.hora_llega, "24:00:00"), s.hora_sale) ELSE TIMEDIFF(s.hora_llega, s.hora_sale) END AS tiempo_estimado,

	b.precio, b.clase, TRUNCATE((b.cant_asientos * (1 + c.porcentaje) - ( SELECT COUNT(*) FROM reserva_vuelo_clase WHERE (reserva_vuelo_clase.vuelo = b.vuelo) AND (reserva_vuelo_clase.clase = b.clase))), 0) as cant_asientos

FROM salidas AS s, vuelos_programados AS vp, aeropuertos AS a_sale, aeropuertos AS a_llega,
instancias_vuelo AS iv, brinda AS b, clases AS c

WHERE (s.vuelo = vp.numero) AND (vp.aeropuerto_salida = a_sale.codigo) AND (vp.aeropuerto_llegada = a_llega.codigo)
	AND (s.vuelo = iv.vuelo) AND (s.vuelo = b.vuelo) AND (c.nombre = b.clase) AND (s.dia=iv.dia)
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

DELIMITER !

CREATE PROCEDURE realizarReservaIda(IN vuelo VARCHAR(45), IN fvu DATE, IN c VARCHAR(45), IN f DATE,IN dt VARCHAR(45), IN dn BIGINT, IN l BIGINT, OUT nres BOOLEAN)
BEGIN
	DECLARE e VARCHAR(45);
	DECLARE cond BOOLEAN;
	START TRANSACTION;
	SET cond = asientosLibres(vuelo, c, fvu);
	IF cond THEN
		SET e = 'Confirmada';
	ELSE
		SET e = 'En espera';
	END IF;
	#Asumimos que la fecha de vencimiento de una reserva es la misma que el dia del vuelo.
  INSERT INTO reservas(fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) VALUES(f, fvu, e, dt, dn, l);
	SELECT LAST_INSERT_ID() INTO nres FOR UPDATE;
  INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) VALUES(nres, vuelo, fvu, c);
	COMMIT;
END; !

CREATE PROCEDURE realizarReservaIdaVuelta(IN vi VARCHAR(45), IN vv VARCHAR(45), IN fvui DATE, IN fvuv DATE, IN ci VARCHAR(45), IN cv VARCHAR(45), IN f DATE, IN dt VARCHAR(45), IN dn BIGINT, IN l BIGINT)
BEGIN
	DECLARE e VARCHAR(45);
	DECLARE cond BOOLEAN;
	DECLARE nres INT;
	START TRANSACTION;
	CALL realizarReservaIda(vi, fvui, ci, f, dt, dn, l, nres);
	SET cond = asientosLibres(vv, cv, fvuv);
	IF cond THEN
		SET e = 'Confirmada';
	ELSE
		SET e = 'En espera';
	END IF;
	#Asumimos que la fecha de vencimiento de una reserva es la misma que el dia del vuelo.
  INSERT INTO reservas(numero, fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) VALUES(nres, f, fvuv, e, dt, dn, l);
	SELECT LAST_INSERT_ID() INTO nres FOR UPDATE;
  INSERT INTO reserva_vuelo_clase(numero, vuelo, fecha_vuelo, clase) VALUES(nres, vv, fvuv, cv);
	COMMIT;
END; !

CREATE FUNCTION asientosLibres(vu VARCHAR(45), cl VARCHAR(45), fecha DATE) RETURNS BOOLEAN
DETERMINISTIC
BEGIN
	DECLARE soli, fis INT;
	DECLARE res BOOLEAN;
	SELECT COUNT(*) INTO soli FROM reserva_vuelo_clase WHERE reserva_vuelo_clase.vuelo = vu AND reserva_vuelo_clase.clase = cl AND reserva_vuelo_clase.fecha_vuelo = fecha FOR UPDATE;
	SELECT cant_asientos INTO fis FROM brinda, instancias_vuelo WHERE brinda.vuelo = vu AND brinda.vuelo = instancias_vuelo.vuelo AND brinda.clase = cl AND instancias_vuelo.fecha = fecha AND brinda.dia = instancias_vuelo.dia FOR UPDATE;
	SET res = fis > soli;
	RETURN res;
END; !

 DELIMITER ;
