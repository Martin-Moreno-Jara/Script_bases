Use investigacion;
-- SCRIPT DE CREACIÓN DE TRIGGERS
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
-- SCRIPS PARA UPDATES DE ESTUDIANTES, GRUPO INVESTIGACION, EMPLEADO Y PROFESOR
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
 
 CREATE TRIGGER actualizacion_grupo_investigacion 
 BEFORE UPDATE ON grupo_investigacion
 FOR EACH ROW 
 BEGIN
	IF NEW.gru_nombre='' OR NEW.gru_nombre=NULL THEN
		SET NEW.gru_nombre = OLD.gru_nombre;
	END IF;
 END ??
 DELIMITER ;
 
-- FIN DEL SCRIPT
