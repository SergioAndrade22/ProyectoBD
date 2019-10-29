DELIMITER !

CREATE TRIGGER TR_create_instancias
AFTER INSERT ON salidas
FOR EACH ROW 
BEGIN
	DECLARE fecha, corte DATE;
	SET fecha = CURDATE();
	SET corte = DATE_ADD(CURDATE(), INTERVAL 1 YEAR);
	WHILE (fecha - corte) < 0 DO
		INSERT INTO instancias_vuelo(vuelo, fecha, dia, estado) VALUES(NEW.vuelo, fecha, dia(fecha), 'A tiempo');
		SET fecha = ADDDATE(fecha, 7);
	END WHILE;
END; !

CREATE FUNCTION dia(fecha DATE) RETURNS CHAR(2)
 DETERMINISTIC
 BEGIN
   DECLARE i INT;   
   SELECT DAYOFWEEK(fecha) INTO i;
   CASE i
		WHEN 1 THEN RETURN 'Do';
		WHEN 2 THEN RETURN 'Lu';
		WHEN 3 THEN RETURN 'Ma';
		WHEN 4 THEN RETURN 'Mi';
		WHEN 5 THEN RETURN 'Ju';
		WHEN 6 THEN RETURN 'Vi';
		WHEN 7 THEN RETURN 'Sa';
	END CASE; 	
 END; !

DELIMITER ;