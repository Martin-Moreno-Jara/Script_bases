Use investigacion;
-- ####################################################################################################
-- SCRIPT DE CREACIÓN DE TRIGGERS
-- ####################################################################################################

-- *****************************************************************************************************
-- ***************** EJECUTARSE DESPUES DE INSERTAR DATOS
-- *****************************************************************************************************
-- SUMAR O RESTAR 1 CUANDO SE UNE O SALE UN ESTUDIANTE DEL GRUPO
DELIMITER ??
CREATE TRIGGER num_integrantes_grupo 
AFTER UPDATE ON estudiante
FOR EACH ROW
BEGIN
	IF (NEW.est_gru_id IS NOT NULL)  AND (OLD.est_gru_id IS NULL)  THEN
		UPDATE grupo_investigacion SET gru_numIntegrantes = gru_numIntegrantes+1
		WHERE gru_id= NEW.est_gru_id;
    END IF;
    
   	IF (NEW.est_gru_id IS NULL)  AND (OLD.est_gru_id IS NOT NULL)  THEN
		UPDATE grupo_investigacion SET gru_numIntegrantes = gru_numIntegrantes-1
		WHERE gru_id= OLD.est_gru_id;
    END IF;
END ??
DELIMITER ;

-- ***********************************************************************************************
-- *****************************************************************************************************
-- TRIGGER PARA AUMENTAR NUMERO DE PAPERS EN GRUPO CUANDO SE INSERTA EN PAPERS
DELIMITER ??
CREATE TRIGGER inc_num_papers AFTER INSERT ON paper
FOR EACH ROW
BEGIN
	UPDATE vw_proyecto_grupo SET gru_numPapers=gru_numPapers+1 WHERE NEW.pap_pry_id=pry_id;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- TRIGGER PARA AUMENTAR NUMERO DE INTEGRANTES EN GRUPO CUANDO SE INSERTA EN ESTUDIANTES
DELIMITER ??
CREATE TRIGGER inc_num_integrantes AFTER INSERT ON estudiante
FOR EACH ROW
BEGIN 
	UPDATE vw_grupo_estudiante SET gru_numIntegrantes=gru_numIntegrantes+1 WHERE NEW.est_gru_id=gru_id;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- TRIGGER PARA AUMENTAR NUMERO DE PROYECTOS EN GRUPO CUANDO SE INSERTA EN PROYECTOS
DELIMITER ??
CREATE TRIGGER inc_num_proyectos AFTER INSERT ON proyecto
FOR EACH ROW
BEGIN 
	UPDATE vw_proyecto_grupo SET gru_numProyectos=gru_numProyectos+1 WHERE NEW.pry_gru_id=gru_id;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- TRIGGERS PARA UPDATES DE ESTUDIANTES
 DELIMITER ??
 CREATE TRIGGER actualizacion_estudiante 
 BEFORE UPDATE ON estudiante
 FOR EACH ROW 
 BEGIN
	IF (NEW.est_telefono='' OR NEW.est_telefono=NULL) AND (NEW.est_direccion='' OR NEW.est_direccion = NULL ) THEN
		SET NEW.est_telefono = OLD.est_telefono, NEW.est_direccion = OLD.est_direccion;
	ELSEIF NEW.est_telefono='' OR NEW.est_telefono=NULL THEN 
		SET NEW.est_telefono = OLD.est_telefono;
	ELSEIF NEW.est_direccion = '' OR NEW.est_direccion = NULL THEN
		SET NEW.est_direccion = OLD.est_direccion;
	END IF;

 END ??
-- *****************************************************************************************************
-- TRIGGERS PARA UPDATES DE PROFESOR
 CREATE TRIGGER actualizacion_profesor 
 BEFORE UPDATE ON profesor
 FOR EACH ROW 
 BEGIN
	IF (NEW.pro_telefono='' OR NEW.pro_telefono=NULL) AND (NEW.pro_direccion='' OR NEW.pro_direccion = NULL ) THEN
		SET NEW.pro_telefono = OLD.pro_telefono, NEW.pro_direccion = OLD.pro_direccion;
	ELSEIF NEW.pro_telefono='' OR NEW.pro_telefono=NULL THEN 
		SET NEW.pro_telefono = OLD.pro_telefono;
	ELSEIF NEW.pro_direccion = '' OR NEW.pro_direccion = NULL THEN
		SET NEW.pro_direccion = OLD.pro_direccion;
	END IF;
 END ??
-- *****************************************************************************************************
-- TRIGGERS PARA UPDATES DE EMPLEADO 
 CREATE TRIGGER actualizacion_empleado 
 BEFORE UPDATE ON empleado
 FOR EACH ROW 
 BEGIN
	IF (NEW.emp_telefono='' OR NEW.emp_telefono=NULL) AND (NEW.emp_direccion='' OR NEW.emp_direccion = NULL ) THEN
		SET NEW.emp_telefono = OLD.emp_telefono, NEW.emp_direccion = OLD.emp_direccion;
	ELSEIF NEW.emp_telefono='' OR NEW.emp_telefono=NULL THEN 
		SET NEW.emp_telefono = OLD.emp_telefono;
	ELSEIF NEW.emp_direccion = '' OR NEW.emp_direccion = NULL THEN
		SET NEW.emp_direccion = OLD.emp_direccion;
	END IF;
 END ??
-- *****************************************************************************************************
-- NO REPETICIÓN DE CORREOS PARA ESTUDIANTES 
DELIMITER ??
	CREATE TRIGGER estudiante_correo BEFORE INSERT ON estudiante
    FOR EACH ROW
    BEGIN
		DECLARE numCor INT;
        DECLARE mgs VARCHAR(250);
        SELECT count(*) INTO numCor FROM estudiante WHERE est_correo=NEW.est_correo;
        IF numCor>0 THEN 
			SET mgs = concat('No se admiten correos duplicados ',NEW.est_correo);
            SIGNAL sqlstate '45000' SET message_text=mgs;
        END IF;
        IF NEW.est_correo NOT LIKE '%@unal.edu.co' THEN
			SET mgs = concat('Formato erróneo de correo ',NEW.est_correo);
            SIGNAL sqlstate '45000' SET message_text=mgs;
        END IF;
    END ??
DELIMITER ;
-- *****************************************************************************************************
-- NO REPETICIÓN DE CORREOS PARA PROFESORES 
DELIMITER ??
	CREATE TRIGGER profesor_correo BEFORE INSERT ON profesor
    FOR EACH ROW
    BEGIN
		DECLARE numCor INT;
        DECLARE mgs VARCHAR(250);
        SELECT count(*) INTO numCor FROM profesor WHERE pro_correo=NEW.pro_correo;
        IF numCor>0 THEN 
			SET mgs = concat('No se admiten correos duplicados ',NEW.pro_correo);
            SIGNAL sqlstate '45000' SET message_text=mgs;
        END IF;
        IF NEW.pro_correo NOT LIKE '%@unal.edu.co' THEN
			SET mgs = concat('Formato erróneo de correo ',NEW.pro_correo);
            SIGNAL sqlstate '45000' SET message_text=mgs;
        END IF;
    END ??
DELIMITER ;
-- *****************************************************************************************************
-- NO NOMBRES DUPLICADOS PARA GRUPOS DE INVESTIGACION
DELIMITER ??
CREATE TRIGGER grupo_nom_id BEFORE INSERT ON grupo_investigacion
FOR EACH ROW
BEGIN
	DECLARE numNom INT;
	DECLARE mgs VARCHAR(250);
    SELECT count(*) INTO numNom FROM grupo_investigacion WHERE gru_nombre LIKE new.gru_nombre;
    IF numNom>0 THEN 
		SET mgs = concat('No se admiten nombres duplicados ',NEW.gru_nombre);
            SIGNAL sqlstate '45000' SET message_text=mgs;
	END IF;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- UN PROFESOR SOLO PUEDE SER LIDER DE UN GRUPO
DELIMITER ??
 CREATE TRIGGER solo_un_grupo_lider 
 BEFORE INSERT ON grupo_investigacion
 FOR EACH ROW
 BEGIN
	DECLARE mensaje VARCHAR(75);
    SET mensaje = CONCAT('El profesor ya aparece registrado como lider un grupo');
	IF EXISTS (SELECT gru_lider FROM grupo_investigacion WHERE gru_lider=NEW.gru_lider) THEN 
		SIGNAL SQLSTATE '13500'
        SET MESSAGE_TEXT = mensaje ;
    END IF;
 END??
DELIMITER ;
-- *****************************************************************************************************
-- UN PROFESOR SOLO PUEDE SER LIDER DE UN GRUPO
DELIMITER ??
 CREATE TRIGGER solo_un_grupo
 BEFORE INSERT ON grupo_investigacion
 FOR EACH ROW
 BEGIN
	DECLARE mensaje VARCHAR(75);
    SET mensaje = CONCAT('El profesor ya aparece registrado en un grupo');
	IF (SELECT pro_gru_id FROM profesor WHERE pro_cedula=NEW.gru_lider ) IS NOT NULL THEN 
		SIGNAL SQLSTATE '13500'
        SET MESSAGE_TEXT = mensaje ;
    END IF;
 END??
DELIMITER ;
-- *****************************************************************************************************
-- HACER LIDER A UN PROFESOR CUANDO CREA GRUPO
DELIMITER ??
CREATE TRIGGER lider_grupo_integrante AFTER INSERT ON grupo_investigacion 
FOR EACH ROW 
BEGIN
	
	UPDATE profesor SET pro_gru_id = NEW.gru_id WHERE NEW.gru_lider=pro_cedula;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- PAPER CON NOMBRE ÚNICO AL CREAR
DELIMITER ??
CREATE TRIGGER paper_unico
BEFORE INSERT ON paper
FOR EACH ROW
BEGIN
	DECLARE mensaje VARCHAR(150);
    SET mensaje = CONCAT('No puedes usar ',NEW.pap_titulo,', ya hay un paper con este titulo.');
	IF EXISTS (SELECT pap_titulo FROM paper WHERE pap_titulo=NEW.pap_titulo)	THEN
		SIGNAL SQLSTATE '13600'
        SET MESSAGE_TEXT = mensaje ;
	END IF;
END ??
-- *****************************************************************************************************
-- PAPER CON NOMBRE ÚNICO AL ACTUALIZAR
CREATE TRIGGER actualizar_paper_unico
BEFORE UPDATE ON paper
FOR EACH ROW
BEGIN
	DECLARE mensaje VARCHAR(150);
    SET mensaje = CONCAT('No puedes cambiar a ',NEW.pap_titulo,', ya hay un paper con este titulo.');
	IF EXISTS (SELECT pap_titulo FROM paper WHERE pap_titulo=NEW.pap_titulo)	THEN
		SIGNAL SQLSTATE '13700'
        SET MESSAGE_TEXT = mensaje ;
	END IF;	
END ??
DELIMITER ;
-- ***************************************************************************************************** 
-- RESTAR DE A UN PAPER CUANDO SE ELIMINA
DELIMITER ??
CREATE TRIGGER disminuirPapers
BEFORE DELETE ON paper
FOR EACH ROW 
BEGIN
    UPDATE vw_proyecto_grupo
    SET gru_numPapers = gru_numPapers - 1
    WHERE gru_id=(select pry_gru_id from proyecto where pry_id=(select pap_pry_id FROM paper WHERE pap_id=OLD.pap_id));
END ??
DELIMITER ;

-- *****************************************************************************************************
-- RESTAR DE A UN PROYECTO CUANDO SE ELIMINA, Y LOS PAPERS ASOCIADOS
DELIMITER ??
CREATE TRIGGER disminuirProyecto
BEFORE DELETE ON proyecto
FOR EACH ROW
BEGIN
    UPDATE grupo_investigacion
    SET gru_numProyectos = gru_numProyectos - 1
    WHERE gru_id = OLD.pry_gru_id;
    
    DELETE FROM paper
    WHERE pap_pry_id = OLD.pry_id;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- FIN DEL SCRIPT
