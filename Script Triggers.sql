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
-- FIN DEL SCRIPT
