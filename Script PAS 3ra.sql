Use investigacion;
-- SCRIPT DE CREACIÓN DE PROCEDIMIENTOS ALMACENADOS
-- *****************************************************************************************************
-- LOGIN PARA ESTUDIANTE
drop procedure login_estudiante;
DELIMITER ??
CREATE PROCEDURE login_estudiante(IN corr VARCHAR(50),IN contra VARCHAR(50) )
BEGIN
	DECLARE estudianteCor VARCHAR(50);
    DECLARE pass VARCHAR(50);
    SELECT est_correo INTO estudianteCor FROM estudiante WHERE est_correo like corr;
    SELECT convert(aes_decrypt(est_contrasena,'clave')using utf8mb4) AS pass INTO pass FROM estudiante WHERE est_correo like corr;
	IF estudianteCor LIKE corr AND pass LIKE contra
		THEN 
        select estudianteCor,pass;
        select est_cedula from estudiante WHERE est_correo like corr;
	ELSE
		SELECT -1;
    END IF ;
END ??
DELIMITER ;
SELECT convert(aes_decrypt(est_contrasena,'clave')using utf8mb3) AS pass FROM estudiante WHERE est_correo like 'josego@unal.edu.co';
call login_estudiante('josego@unal.edu.co','123');
call login_estudiante('josego@al.edu.co','123');
-- *****************************************************************************************************
-- CREAR UN USUARIO DE TIPO ESTUDIANTE E INSERTARLO EN LA TABLA 
-- drop procedure estudiante_register;
DELIMITER ??
CREATE PROCEDURE estudiante_register
(IN cedula INT,IN nombre VARCHAR(50),IN apellido VARCHAR(50),IN edad int,IN correo VARCHAR(50),
IN telefono VARCHAR(50),IN direccion VARCHAR(50),IN tipo VARCHAR(50),IN programa VARCHAR(50),pass VARCHAR(50))
BEGIN
	INSERT INTO estudiante(est_cedula,est_nombre,est_apellido,est_edad,est_correo,est_telefono,est_direccion,est_fechaVinculacion,est_tipoEstudiante,est_prg_id)
    VALUES (cedula,nombre,apellido,edad,correo,telefono,direccion,tipo,1);
    SET @createUserQuery = CONCAT('CREATE USER \'', correo, '\'@\'localhost\' IDENTIFIED BY \'', pass, '\';');
        PREPARE createUserStmt FROM @createUserQuery;
        EXECUTE createUserStmt;
        DEALLOCATE PREPARE createUserStmt;
	-- ALTER USER correo@'localhost'  default role role_estudiante;
    SET @grantRoleQuery = CONCAT('GRANT role_estudiante TO \'', correo, '\'@\'localhost\';');
        PREPARE grantRoleStmt FROM @grantRoleQuery;
        EXECUTE grantRoleStmt;
        DEALLOCATE PREPARE grantRoleStmt;
    SET @sql = CONCAT('ALTER USER ''', correo, '''@''localhost'' DEFAULT ROLE role_estudiante;');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
END??
DELIMITER ;
-- *****************************************************************************************************
-- MOSTRAR TODOS LOS PROGRAMAS ACADÉMICOS
-- drop procedure get_programas_academicos;
DELIMITER ??
CREATE PROCEDURE get_programas_academicos()
BEGIN 
	select prg_nombre from programa_academico;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MOSTRAR TODAS LAS FACULTADES
DELIMITER ??
CREATE PROCEDURE get_facultades()
BEGIN 
	SELECT fac_nombre FROM facultad;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MOSTRAR TODAS LAS ÁREAS DE LOS GRUPOS DE INVESTIGACIÓN
DELIMITER ??
CREATE PROCEDURE get_grupos_areas()
BEGIN 
	select distinct gru_area FROM grupo_investigacion;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LA TABLA DE LOS GRUPOS DE INVESTIGACIÓN.
-- drop procedure llenar_tabla_grupos;
DELIMITER ??
CREATE PROCEDURE llenar_tabla_grupos()
BEGIN 
SELECT gru_nombre,gru_area,gru_numIntegrantes,gru_numProyectos,gru_numPapers,concat(pro_nombre,' ',pro_apellido)
 FROM grupo_investigacion join profesor ON (grupo_investigacion.gru_lider=profesor.pro_cedula);
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LA TABLA DE PROYECTOS
DELIMITER ??
 CREATE PROCEDURE ver_all_proyectos()
 BEGIN
	SELECT * FROM ver_proyectos;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LA TABLA DE PUBLICACIONES O PAPERS
DELIMITER ??
CREATE PROCEDURE ver_all_publicaciones()
BEGIN
	SELECT * FROM ver_publicaciones;
END??
CREATE PROCEDURE buscar_publicacion
(IN bp_title VARCHAR(80), IN bp_tema VARCHAR(80), IN bp_grupo VARCHAR(80), IN bp_proyecto VARCHAR(80))
BEGIN
			SELECT * FROM ver_publicaciones 
            WHERE pap_titulo= bp_title 
            OR pap_tema=bp_tema OR gru_nombre= bp_grupo OR pry_nombre= bp_proyecto; 
END??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LA TABLA DE LABORATORIOS
-- drop procedure llenar_tabla_laboratorios;
DELIMITER ??
CREATE PROCEDURE llenar_tabla_laboratorios()
BEGIN
	SELECT lab_id,lab_nombre,lab_tipoLaboratorio,edf_nombre,concat(emp_nombre,' ',emp_apellido) 
	FROM laboratorio JOIN empleado ON (emp_cedula =lab_ayudante) JOIN edificio ON (lab_edf_id=edf_id);
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LOS DATOS DEL PERFIL DEL ESTUDIANTE
DELIMITER ??
CREATE PROCEDURE mostrar_perfiles ()
BEGIN
	SELECT * FROM perfil;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LOS DATOS DEL PERFIL DEL ESTUDIANTE EN ESPECÍFICO
DELIMITER ??
CREATE PROCEDURE mostrar_un_perfil(IN ced INT)
BEGIN
	SELECT * FROM perfil WHERE est_cedula = ced;
END??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LLENAR LA TABLA DE PUBLICACIONES
DELIMITER ??
CREATE PROCEDURE ver_all_publicaciones()
BEGIN
	SELECT * FROM ver_publicaciones;
END??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN FILTRADA DE LA TABLA DE PUBLICACIONES
DELIMITER ??
CREATE PROCEDURE buscar_publicacion
(IN bp_title VARCHAR(80), IN bp_tema VARCHAR(80), IN bp_grupo VARCHAR(80), IN bp_proyecto VARCHAR(80))
BEGIN
			SELECT * FROM ver_publicaciones 
            WHERE pap_titulo= bp_title 
            OR pap_tema=bp_tema OR gru_nombre= bp_grupo OR pry_nombre= bp_proyecto; 
END??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LA TABLA DE PROYECTOS
  DELIMITER ??
 CREATE PROCEDURE ver_all_proyectos()
 BEGIN
	SELECT * FROM ver_proyectos;
 END??
 DELIMITER ; 
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA UN PROYECTO EN ESPECIFICO
DELIMITER ??
 CREATE PROCEDURE consultar_proyecto(IN v_p_nombre VARCHAR (60),IN v_gru_nombre VARCHAR (60),IN v_p_estado VARCHAR (60))
 BEGIN
	SELECT * FROM ver_proyectos 
    WHERE pry_nombre= v_p_nombre 
    OR gru_nombre = v_gru_nombre OR pry_estado=v_p_estado;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LOS PROFESORES
 DELIMITER ??
CREATE PROCEDURE mostrar_perfiles_profesores ()
BEGIN
	SELECT * FROM perfil_profesor;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA UN PROFESOR EN ESPECÍFICO
DELIMITER ??
CREATE PROCEDURE mostrar_un_perfil_profesor(IN ced INT)
BEGIN
	SELECT * FROM perfil_profesor WHERE pro_cedula = ced;
END??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LISTAR LOS INTEGRANTES DE LOS GRUPO
DELIMITER ??
 CREATE PROCEDURE list_all_groups()
 BEGIN
	SELECT * FROM lista_integrantes_gi;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LISTAR LOS INTEGRANTES DE UN GRUPO EN ESPECÍFICO
  DELIMITER ??
 CREATE PROCEDURE list_one_group(IN n_grupo VARCHAR (30))
 BEGIN
	SELECT * FROM lista_integrantes_gi	WHERE gru_nombre=n_grupo;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LISTAR LOS PAPERS
 DELIMITER ??
 CREATE PROCEDURE all_papers_proy()
 BEGIN
	SELECT * FROM vw_papers_de_proyecto;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LISTAR LOS PAPERS DE UN GRUPO EN ESPECÍFICO
  DELIMITER ??
 CREATE PROCEDURE one_paper_proy(IN n_proy VARCHAR (30))
 BEGIN
	SELECT * FROM vw_papers_de_proyecto	WHERE  pry_nombre=n_proy;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LISTAR LOS PROYECTOS DE LOS GRUPO 
DELIMITER ??
 CREATE PROCEDURE all_proy_group()
 BEGIN
	SELECT * FROM vw_proyectos_de_grupos;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LISTAR UN PROYECTO EN ESPECIFICO
DELIMITER ??
 CREATE PROCEDURE one_proy_group(IN n_group VARCHAR (30))
 BEGIN
	SELECT * FROM vw_proyectos_de_grupos WHERE  gru_nombre = n_group;
 END??
 DELIMITER ;
-- FIN DEL SCRIPT