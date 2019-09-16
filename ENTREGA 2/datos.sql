/*ubicacion*/
INSERT INTO ubicacion (pais, estado, ciudad, huso) VALUES ('United States', 'Alabama', 'Birmingham', -12);
INSERT INTO ubicacion (pais, estado, ciudad, huso) VALUES ('United States', 'New York', 'New York City', 0);
INSERT INTO ubicacion (pais, estado, ciudad, huso) VALUES ('United States', 'Georgia', 'Atlanta', -9);
INSERT INTO ubicacion (pais, estado, ciudad, huso) VALUES ('United States', 'Ohio', 'Cleveland', 10);
INSERT INTO ubicacion (pais, estado, ciudad, huso) VALUES ('United States', 'Oklahoma', 'Tulsa', -1);

/*aeroupuertos*/
INSERT INTO aeropuertos (codigo, nombre, telefono, direccion, pais, estado, ciudad) VALUES ('59898-123', 'NuVasive, Inc.', '256-501-9047', '98525 Hooker Place', 'United States', 'Alabama', 'Birmingham');
INSERT INTO aeropuertos (codigo, nombre, telefono, direccion, pais, estado, ciudad) VALUES ('50268-110', 'Old Dominion Freight Line, Inc.', '347-238-5683', '90729 Namekagon Lane', 'United States', 'New York', 'New York City');
INSERT INTO aeropuertos (codigo, nombre, telefono, direccion, pais, estado, ciudad) VALUES ('0093-7242', 'ServiceMaster Global Holdings, Inc.', '205-303-8900', '230 Shopko Trail', 'United States', 'Georgia', 'Atlanta');
INSERT INTO aeropuertos (codigo, nombre, telefono, direccion, pais, estado, ciudad) VALUES ('36987-2698', 'Arthur J. Gallagher & Co.', '917-373-2417', '72232 Prentice Alley', 'United States', 'Ohio', 'Cleveland');
INSERT INTO aeropuertos (codigo, nombre, telefono, direccion, pais, estado, ciudad) VALUES ('36987-2607', 'MannKind Corporation', '251-411-7468', '298 Homewood Street', 'United States', 'Oklahoma', 'Tulsa');

/*vuelos_programados*/
INSERT INTO vuelos_programados (numero, aeropuerto_salida, aeropuerto_llegada) VALUES (1, '0093-7242', '59898-123');
INSERT INTO vuelos_programados (numero, aeropuerto_salida, aeropuerto_llegada) VALUES (2, '50268-110', '0093-7242');
INSERT INTO vuelos_programados (numero, aeropuerto_salida, aeropuerto_llegada) VALUES (3, '59898-123', '50268-110');
INSERT INTO vuelos_programados (numero, aeropuerto_salida, aeropuerto_llegada) VALUES (4, '36987-2698', '0093-7242');
INSERT INTO vuelos_programados (numero, aeropuerto_salida, aeropuerto_llegada) VALUES (5, '50268-110', '36987-2607');


/*modelos_avion*/
INSERT INTO modelos_avion (modelo, fabricante, cabinas, cant_asientos) VALUES ('Leaf', 'Nissan', 4, 247);
INSERT INTO modelos_avion (modelo, fabricante, cabinas, cant_asientos) VALUES ('DBS', 'Aston Martin', 6, 187);
INSERT INTO modelos_avion (modelo, fabricante, cabinas, cant_asientos) VALUES ('960', 'Volvo', 3, 193);
INSERT INTO modelos_avion (modelo, fabricante, cabinas, cant_asientos) VALUES ('Yukon XL 1500', 'GMC', 4, 136);
INSERT INTO modelos_avion (modelo, fabricante, cabinas, cant_asientos) VALUES ('Spectra', 'Kia', 8, 103);

/*salidas*/
INSERT INTO salidas (vuelo, dia, hora_sale, hora_llega, modelo_avion) VALUES (1, 'Lu', '2018-10-23 16:36:53', '2018-10-24 9:52:36', 'Leaf');
INSERT INTO salidas (vuelo, dia, hora_sale, hora_llega, modelo_avion) VALUES (2, 'Ma', '2018-11-22 18:53:37', '2018-11-23 5:04:32', 'DBS');
INSERT INTO salidas (vuelo, dia, hora_sale, hora_llega, modelo_avion) VALUES (3, 'Mi', '2019-04-13 10:57:50', '2019-04-14 8:59:06', '960');
INSERT INTO salidas (vuelo, dia, hora_sale, hora_llega, modelo_avion) VALUES (4, 'Ju', '2019-06-16 0:25:51', '2019-06-16 8:01:07', 'Leaf');
INSERT INTO salidas (vuelo, dia, hora_sale, hora_llega, modelo_avion) VALUES (5, 'Vi', '2019-07-19 11:31:05', '2019-07-20 9:55:41', 'Spectra');

/*instacias_vuelo*/
insert into instancias_vuelo (vuelo, fecha, dia, estado) values (1, '2018-10-23 10:45:38', 'Lu', 'a tiempo');
insert into instancias_vuelo (vuelo, fecha, dia, estado) values (2, '2018-11-22 06:36:02', 'Ma', 'demorado');
insert into instancias_vuelo (vuelo, fecha, dia, estado) values (3, '2019-04-13 19:02:08', 'Mi', 'cancelado');
insert into instancias_vuelo (vuelo, fecha, dia, estado) values (4, '2019-06-15 00:17:10', 'Ju', 'a tiempo');
insert into instancias_vuelo (vuelo, fecha, dia, estado) values (5, '2018-11-30 21:50:38', 'Vi', 'demorado');

/*clases*/
insert into clases (nombre, porcentaje) values ('Premium', 0.73);
insert into clases (nombre, porcentaje) values ('Normal', 0.69);
insert into clases (nombre, porcentaje) values ('Fea', 0.93);

/*comodidades*/
insert into comodidades (codigo, descripcion) values (1, 'Comodidad Baja');
insert into comodidades (codigo, descripcion) values (2, 'Comodidad Media');
insert into comodidades (codigo, descripcion) values (3, 'Comodidad Alta');


/*pasajeros*/
insert into pasajeros (doc_tipo, doc_nro, apellido, nombre, direccion, telefono, nacionalidad) values ('TSS', 36359701, 'Girdlestone', 'Leif', '3 Bultman Point', '305-468-1877', 'Japan');
insert into pasajeros (doc_tipo, doc_nro, apellido, nombre, direccion, telefono, nacionalidad) values ('ID', 25690192, 'Geake', 'Orsola', '9298 Bunting Lane', '815-172-0958', 'Russia');
insert into pasajeros (doc_tipo, doc_nro, apellido, nombre, direccion, telefono, nacionalidad) values ('Pasaporte', 22175155, 'Oakinfold', 'Fawne', '859 Superior Drive', '710-159-0501', 'Belarus');
insert into pasajeros (doc_tipo, doc_nro, apellido, nombre, direccion, telefono, nacionalidad) values ('Identity Card', 33371405, 'Punyer', 'Bellina', '01781 Maple Wood Street', '722-700-9246', 'Czech Republic');
insert into pasajeros (doc_tipo, doc_nro, apellido, nombre, direccion, telefono, nacionalidad) values ('ID', 19529284, 'Kilminster', 'Wyatan', '987 Sycamore Park', '131-518-6132', 'Canada');

/*empleados*/
insert into empleados (legajo, password, doc_tipo, doc_nro, apellido, nombre, direccion, telefono) values (5297, md5('kubaFo5luah'), 'DNI', 12131991, 'McGuiney', 'Val', '9243 Lillian Alley', '303-199-1333');
insert into empleados (legajo, password, doc_tipo, doc_nro, apellido, nombre, direccion, telefono) values (6488, md5('KXIEvM5a'), 'DNI', 44138994, 'Towey', 'Dewitt', '67314 Haas Circle', '114-245-7172');
insert into empleados (legajo, password, doc_tipo, doc_nro, apellido, nombre, direccion, telefono) values (9932, md5('SS7yoDqSj'), 'DNI', 26818191, 'Plaide', 'Thurston', '0250 Chinook Lane', '658-515-8242');
insert into empleados (legajo, password, doc_tipo, doc_nro, apellido, nombre, direccion, telefono) values (5108, md5('61r6z66'), 'DNI', 4584153, 'Duffer', 'Brianne', '92 Tomscot Plaza', '506-910-7763');
insert into empleados (legajo, password, doc_tipo, doc_nro, apellido, nombre, direccion, telefono) values (1429, md5('Mk15vN'), 'DNI', 38062912, 'Lempel', 'Mariela', '7406 Mcbride Parkway', '257-203-0648');

/*reservas*/
insert into reservas (numero, fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) values (1243, '2018-11-01 22:08:46', '2019-11-20 19:58:52', 'confirmada', 'TSS', 36359701, 5297);
insert into reservas (numero, fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) values (1490, '2019-07-10 09:15:52', '2020-07-24 16:39:10', 'en espera', 'ID', 19529284, 5297);
insert into reservas (numero, fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) values (5562, '2019-01-25 13:33:05', '2020-08-28 07:34:20', 'en espera', 'Identity Card', 33371405, 9932);
insert into reservas (numero, fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) values (9341, '2019-06-30 18:08:19', '2019-12-27 11:27:32', 'pagada', 'ID', 25690192, 6488);
insert into reservas (numero, fecha, vencimiento, estado, doc_tipo, doc_nro, legajo) values (4207, '2019-07-03 10:43:32', '2020-05-18 03:17:40', 'pagada', 'Pasaporte', 22175155, 6488);

/*brinda*/
insert into brinda (vuelo, dia, clase, cant_asientos, precio) values (1, 'Lu', 'Premium', 15, 2000.00);
insert into brinda (vuelo, dia, clase, cant_asientos, precio) values (1, 'Lu', 'Normal', 20, 1600.25);
insert into brinda (vuelo, dia, clase, cant_asientos, precio) values (1, 'Lu', 'Fea', 25, 1000.75);
insert into brinda (vuelo, dia, clase, cant_asientos, precio) values (2, 'Lu', 'Premium', 35, 2000.00);
insert into brinda (vuelo, dia, clase, cant_asientos, precio) values (2, 'Lu', 'Normal', 25, 1600.25);

/*posee*/
insert into posee (clase, comodidad) values ('Premium', 3);
insert into posee (clase, comodidad) values ('Normal', 2);
insert into posee (clase, comodidad) values ('Fea', 1);

/*reserva_vuelo_clase*/
insert into reserva_vuelo_clase values (1243, 1, '2018-10-23 10:45:38', 'Premium');
insert into reserva_vuelo_clase values (1490, 1, '2018-10-23 10:45:38', 'Premium');
insert into reserva_vuelo_clase values (5562, 2, '2018-11-22 06:36:02', 'Normal');
insert into reserva_vuelo_clase values (9341, 2, '2018-11-22 06:36:02', 'Fea');
