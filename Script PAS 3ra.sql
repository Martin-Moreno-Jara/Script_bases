Use investigacion;
-- SCRIPT DE CREACIÓN DE PROCEDIMIENTOS ALMACENADOS
-- *****************************************************************************************************
-- LOGIN PARA ESTUDIANTE
-- drop procedure login_estudiante;
DELIMITER ??
CREATE PROCEDURE login_estudiante(IN corr VARCHAR(50),IN contra VARCHAR(50) )
BEGIN
	DECLARE estudianteCor VARCHAR(50);
    DECLARE pass VARCHAR(50);
    SELECT est_correo INTO estudianteCor FROM estudiante WHERE est_correo like corr;
    SELECT convert(aes_decrypt(est_contrasena,'clave')using utf8mb4) AS pass INTO pass FROM estudiante WHERE est_correo like corr;
	IF estudianteCor LIKE corr AND pass LIKE contra
		THEN 
        select est_cedula from estudiante WHERE est_correo like corr;
	ELSE
		SELECT -1;
    END IF ;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- LOGIN PARA PROFESOR drop procedure login_profesor;
DELIMITER ??
CREATE PROCEDURE login_profesor(IN corr VARCHAR(50),IN contra VARCHAR(50) )
BEGIN
	DECLARE profeCor VARCHAR(50);
    DECLARE pass VARCHAR(50);
    SELECT pro_correo INTO profeCor FROM profesor WHERE pro_correo like corr;
    SELECT convert(aes_decrypt(pro_contrasena,'clave')using utf8mb4) AS pass INTO pass FROM profesor WHERE pro_correo like corr;
	IF profeCor LIKE corr AND pass LIKE contra
		THEN 
        select pro_cedula from profesor WHERE pro_correo like corr;
	ELSE
		SELECT -1;
    END IF ;
END ??
DELIMITER ;
-- call login_profesor('felipeg@unal.edu.co','123');
-- *****************************************************************************************************
-- LOGIN PARA EMPLEADO  drop procedure login_empleado;
DELIMITER ??
CREATE PROCEDURE login_empleado(IN corr VARCHAR(50),IN contra VARCHAR(50) )
BEGIN
	DECLARE empCor VARCHAR(50);
    DECLARE pass VARCHAR(50);
    SELECT emp_correo INTO empCor FROM empleado WHERE emp_correo like corr;
    SELECT convert(aes_decrypt(emp_contrasena,'clave')using utf8mb4) AS pass INTO pass FROM empleado WHERE emp_correo like corr;
	IF empCor LIKE corr AND pass LIKE contra
		THEN 
        select emp_cedula from empleado WHERE emp_correo like corr;
	ELSE
		SELECT -1;
    END IF ;
END ??
DELIMITER ;

-- call login_empleado('felipeg@unal.edu.co','123');

-- LOGIN PARA GRUPOS  drop procedure login_empleado;
-- DROP procedure login_grupo;
DELIMITER ??
CREATE PROCEDURE login_grupo(IN nombre VARCHAR(50),IN contra VARCHAR(50) )
BEGIN
	DECLARE nom VARCHAR(50);
    DECLARE pass VARCHAR(50);
    SELECT gru_nombre INTO nom FROM grupo_investigacion WHERE gru_nombre=nombre;
    SELECT convert(aes_decrypt(gru_contrasena,'clave')using utf8mb4) AS pass INTO pass FROM grupo_investigacion WHERE gru_nombre=nombre;
	IF nom=nombre AND pass LIKE contra
		THEN 
        select gru_id from grupo_investigacion WHERE gru_nombre=nombre;
	ELSE
		SELECT -1;
    END IF ;
END ??
DELIMITER ;

-- call login_empleado('felipeg@unal.edu.co','123');

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
SELECT * from vw_group_table;
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
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LA TABLA DE LABORATORIOS
-- drop procedure llenar_tabla_laboratorios;
DELIMITER ??
CREATE PROCEDURE llenar_tabla_laboratorios()
BEGIN
	SELECT * FROM vw_laboratorios;
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
 -- *****************************************************************************************************
-- Filtra los grupos de la tabla de grupos de investigación
-- drop procedure filtrar_grupos;
DELIMITER ??
 CREATE PROCEDURE filtrar_grupos(IN nombre VARCHAR (30),IN area VARCHAR(50))
 BEGIN
	IF nombre LIKE '' AND area LIKE '-'
		THEN SELECT * FROM vw_group_table;
	ELSEIF nombre LIKE '' 
		THEN SELECT * FROM vw_group_table WHERE gru_area LIKE area;
	ELSEIF area LIKE '-' 
		THEN 
			SET @query = CONCAT('SELECT * FROM vw_group_table WHERE gru_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
	ELSE 
			SET @query = CONCAT('SELECT * FROM vw_group_table WHERE gru_area LIKE \'', area, '\' AND gru_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    END IF;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- Obtener todos los grupos para el combobox
DELIMITER ??
CREATE PROCEDURE get_grupos()
BEGIN
	SELECT gru_nombre FROM grupo_investigacion;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- Filtrar los proyectos para la tabla
-- DROP procedure filtrar_proyectos;
DELIMITER ??
 CREATE PROCEDURE filtrar_proyectos(IN nombre VARCHAR (30),IN grupo VARCHAR(50),IN estado VARCHAR (30))
 BEGIN
	IF nombre LIKE '' AND grupo LIKE '-' AND estado LIKE '-'
		THEN SELECT * FROM ver_proyectos;
	ELSEIF nombre LIKE '' AND grupo LIKE '-' -- nombre y grupo es indiferente
		THEN SELECT * FROM ver_proyectos WHERE pry_estado LIKE estado;
    ELSEIF nombre LIKE '' AND estado LIKE '-' -- nombre y estado es indiferente
		THEN SELECT * FROM ver_proyectos WHERE gru_nombre LIKE grupo;
    ELSEIF grupo LIKE '-' AND estado LIKE '-' -- grupo y estado es indiferente
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_proyectos WHERE pry_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
	ELSEIF nombre LIKE '' -- nombre es indiferente
		THEN SELECT * FROM ver_proyectos WHERE gru_nombre LIKE grupo AND pry_estado LIKE estado;
	ELSEIF grupo LIKE '-'-- grupo es indiferente
		THEN
			SET @query = CONCAT('SELECT * FROM ver_proyectos WHERE pry_estado LIKE \'', estado, '\' AND pry_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF estado LIKE '-'-- estado es indiferente
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_proyectos WHERE gru_nombre LIKE \'', grupo, '\' AND pry_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
	ELSE 
			SET @query = CONCAT('SELECT * FROM ver_proyectos WHERE gru_nombre LIKE \'', grupo, '\' AND pry_estado LIKE \'',estado,'\' AND pry_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    END IF;
 END??
 DELIMITER ;
 -- *****************************************************************************************************
-- Obtener todos los temas para el combobox
DELIMITER ??
CREATE PROCEDURE get_temas()
BEGIN
	SELECT DISTINCT pap_tema FROM paper;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- Obtener todos los proyectos para el combobox
DELIMITER ??
CREATE PROCEDURE get_proyectos()
BEGIN
	SELECT DISTINCT pry_nombre FROM proyecto;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- Filtrar las publicaciones para la tabla 
-- drop procedure filtrar_publicaciones;
DELIMITER ??
 CREATE PROCEDURE filtrar_publicaciones(IN titulo VARCHAR (30),IN tema VARCHAR(50),IN grupo VARCHAR (30),IN proyecto VARCHAR (30))
 BEGIN
	IF titulo LIKE '' AND tema LIKE '-' AND grupo LIKE '-' AND proyecto LIKE '-'
		THEN SELECT * FROM ver_publicaciones;
	ELSEIF tema LIKE '-' AND grupo LIKE '-' AND proyecto LIKE '-' -- Solo buscar por titulo
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF titulo LIKE '' AND grupo LIKE '-' AND proyecto LIKE '-' -- Solo buscar por tema
		 THEN SELECT * FROM ver_publicaciones WHERE pap_tema LIKE tema;
    ELSEIF titulo LIKE '' AND tema LIKE '-' AND proyecto LIKE '-' -- Solo buscar por grupo
		THEN SELECT * FROM ver_publicaciones WHERE gru_nombre LIKE grupo;
    ELSEIF titulo LIKE '' AND tema LIKE '-' AND grupo LIKE '-' -- Solo buscar por proyecto
		THEN SELECT * FROM ver_publicaciones WHERE pry_nombre LIKE proyecto;
	ELSEIF grupo LIKE '-' AND proyecto LIKE '-' -- por titulo y tema
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE pap_tema LIKE \'', tema, '\' AND pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF tema LIKE '-'  AND proyecto LIKE '-' -- por titulo y grupo
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE gru_nombre LIKE \'',grupo,'\' AND pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF  tema LIKE '-' AND grupo LIKE '-' -- por titulo y proyecto
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE pry_nombre LIKE \'',proyecto,'\' AND pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF titulo LIKE ''  AND proyecto LIKE '-' -- por tema y grupo
		THEN SELECT * FROM ver_publicaciones WHERE gru_nombre LIKE grupo AND pap_tema LIKE tema;
    ELSEIF titulo LIKE '' AND grupo LIKE '-'  -- por tema y proyecto
		THEN SELECT * FROM ver_publicaciones WHERE pry_nombre LIKE proyecto AND pap_tema LIKE tema;
    ELSEIF titulo LIKE '' AND tema LIKE '-'  -- por grupo y proyecto
		THEN SELECT * FROM ver_publicaciones WHERE gru_nombre LIKE grupo AND pry_nombre LIKE proyecto;
	ELSEIF proyecto LIKE '-' -- por titulo y tema y grupo
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE pap_tema LIKE \'', tema, '\' AND gru_nombre LIKE \'',grupo,'\' AND pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF grupo LIKE '-' -- por titulo y tema y proyecto
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE pap_tema LIKE \'', tema, '\' AND pry_nombre LIKE \'',proyecto,'\' AND pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF titulo LIKE ''  -- por tema y grupo y proyecto
		THEN SELECT * FROM ver_publicaciones WHERE 
		 gru_nombre LIKE grupo AND pry_nombre LIKE proyecto AND pap_tema LIKE tema;
    ELSEIF tema LIKE '-'  -- por titulo y grupo y proyecto
		THEN 
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE pry_nombre LIKE \'', proyecto, '\' AND gru_nombre LIKE \'',grupo,'\' AND pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSE -- todas
			SET @query = CONCAT('SELECT * FROM ver_publicaciones WHERE pry_nombre LIKE \'', proyecto, '\' AND pap_tema LIKE \'', tema, '\' AND gru_nombre LIKE \'',grupo,'\' AND pap_titulo LIKE "%', titulo, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
    END IF;
 END??
 DELIMITER ;
 call filtrar_publicaciones('sa','-','-','-');
 -- *****************************************************************************************************
-- Obtener todos los edificios para el combobox
DELIMITER ??
CREATE PROCEDURE get_edificios()
BEGIN
	SELECT DISTINCT edf_nombre FROM edificio;
END ??
DELIMITER ;
 -- *****************************************************************************************************
-- Obtener todos los tipos de laboratorio para el combobox
DELIMITER ??
CREATE PROCEDURE get_labTipo()
BEGIN
	SELECT DISTINCT lab_tipoLaboratorio FROM laboratorio;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- Filtrar los laboratorios para la tabla
-- drop procedure filtrar_laboratorios;
DELIMITER ??
 CREATE PROCEDURE filtrar_laboratorios(IN nombre VARCHAR (30),IN tipo VARCHAR(50),IN edificio VARCHAR (30))
 BEGIN
	IF nombre LIKE '' AND tipo LIKE '-' AND edificio LIKE '-'
		THEN SELECT * FROM vw_laboratorios;
	ELSEIF nombre LIKE '' AND tipo LIKE '-' -- nombre y grupo es indiferente
		THEN SELECT * FROM vw_laboratorios WHERE edf_nombre LIKE edificio;
    ELSEIF nombre LIKE '' AND edificio LIKE '-' -- nombre y estado es indiferente
		THEN SELECT * FROM vw_laboratorios WHERE lab_tipoLaboratorio LIKE tipo;
    ELSEIF tipo LIKE '-' AND edificio LIKE '-' -- grupo y estado es indiferente
		THEN 
			SET @query = CONCAT('SELECT * FROM vw_laboratorios WHERE lab_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
	ELSEIF nombre LIKE '' -- nombre es indiferente
		THEN SELECT * FROM vw_laboratorios WHERE lab_tipoLaboratorio LIKE tipo AND edf_nombre LIKE edificio;
	ELSEIF tipo LIKE '-'-- grupo es indiferente
		THEN 
			SET @query = CONCAT('SELECT * FROM vw_laboratorios WHERE edf_nombre LIKE \'', edificio, '\' AND lab_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    ELSEIF edificio LIKE '-'-- estado es indiferente
		THEN 
			SET @query = CONCAT('SELECT * FROM vw_laboratorios WHERE lab_tipoLaboratorio LIKE \'', tipo, '\' AND lab_nombre LIKE "%', nombre, '%"');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
	ELSE 
		 SET @query = CONCAT('SELECT * FROM vw_laboratorios WHERE lab_tipoLaboratorio LIKE \'', tipo, '\' AND lab_nombre LIKE "%', nombre, '%" AND edf_nombre LIKE \'', edificio, '\'');
			PREPARE stmt FROM @query;
			EXECUTE stmt;
			DEALLOCATE PREPARE stmt;
    END IF;
 END??
 DELIMITER ;
 call filtrar_laboratorios('a','Quimica','-');
 -- *****************************************************************************************************
-- Obtener todos los estudiantes para la tabla de crear grupos y añadir
DELIMITER ??
CREATE PROCEDURE llenar_estudiantes()
BEGIN
	SELECT * from vw_estudiante_tabla;
END ??
DELIMITER ;
 -- *****************************************************************************************************
-- Filtra los estudiantes 
DELIMITER ??
 CREATE PROCEDURE filtrar_estudiantes(IN corr VARCHAR (30),IN program VARCHAR(50))
 BEGIN
	IF corr LIKE '' AND program LIKE '-'
		THEN SELECT * FROM vw_estudiante_tabla;
	ELSEIF corr LIKE '' 
		THEN SELECT * FROM vw_estudiante_tabla WHERE prg_nombre LIKE program;
	ELSEIF program LIKE '-' 
		THEN 
        SET @query = CONCAT('SELECT * FROM vw_estudiante_tabla WHERE est_correo LIKE "%', corr, '%"');
		PREPARE stmt FROM @query;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
	ELSE 
		SET @query = CONCAT('SELECT * FROM vw_estudiante_tabla WHERE prg_nombre LIKE \'', program, '\' AND est_correo LIKE "%', corr, '%"');
		PREPARE stmt FROM @query;
		EXECUTE stmt;
		DEALLOCATE PREPARE stmt;
    END IF;
 END??
 DELIMITER ;
-- *****************************************************************************************************
-- Muestra los proyectos pero solo de un grupo en especifico
-- drop procedure get_proyectos_un_grupo;
DELIMITER ??
CREATE PROCEDURE get_proyectos_un_grupo(IN id INT)
BEGIN
	SELECT * FROM ver_proyectos_grupo  WHERE gru_id=id;
END ??
DELIMITER ; 
-- call get_proyectos_un_grupo(2);
-- *****************************************************************************************************
-- Muestra las publicaciones pero solo de un grupo en especifico
DELIMITER ??
CREATE PROCEDURE get_publicaciones_un_grupo(IN id INT)
BEGIN
	SELECT * FROM ver_publicaciones_grupo  WHERE gru_id=id;
END ??
DELIMITER ; 
-- call get_publicaciones_un_grupo(4);
-- *****************************************************************************************************
-- Muestra los proyectos pero solo de un grupo en especifico
-- drop procedure get_proyectos_un_grupoCombobox;
DELIMITER ??
CREATE PROCEDURE get_proyectos_un_grupoCombobox(IN id INT)
BEGIN
	SELECT DISTINCT pry_nombre FROM ver_proyectos_grupo  WHERE gru_id=id;
END ??
DELIMITER ; 
-- *****************************************************************************************************
-- Perfil del profesor
DELIMITER ??
CREATE PROCEDURE perfil_profesor_mostrar(IN cedula INT)
BEGIN
	SELECT * FROM perfil_profesor WHERE pro_cedula=cedula;
END ??
DELIMITER ;

-- *****************************************************************************************************
-- Editar perfil del profesor
DELIMITER ??
CREATE PROCEDURE editar_profesor_perfil(IN ced INT, IN tel VARCHAR(75), IN direc VARCHAR(75))
BEGIN
	UPDATE perfil_profesor SET pro_telefono=tel, pro_direccion=direc WHERE pro_cedula=ced; 
END ??
DELIMITER ;
-- *****************************************************************************************************
-- crear un grupo como profesor
DELIMITER ??
CREATE PROCEDURE crear_grupo
(IN id INT, IN nom VARCHAR(100),IN area VARCHAR(100),IN lider INT,IN contra VARCHAR(100))
BEGIN
	INSERT INTO vw_grupo_crear VALUES (id,nom,area,lider,aes_encrypt(contra,'clave'));
END ??
DELIMITER ;
-- *****************************************************************************************************
-- crear un proyecto como grupo
DELIMITER ??
CREATE PROCEDURE crear_proyecto
(IN id INT, IN nom VARCHAR(100),IN prop VARCHAR(100),IN estado VARCHAR(100),IN gru INT)
BEGIN
	INSERT INTO vw_insert_proyecto VALUES(id,nom,prop,estado,gru);
END ??
DELIMITER ;
select * from vw_insert_proyecto;
-- *****************************************************************************************************
-- OBTENER EL NUM DE PROYECTO SEGUN EL NOMBRE
DELIMITER ??
CREATE PROCEDURE get_proyId(IN nom VARCHAR(50))
	BEGIN
		SELECT pry_id FROM proyecto WHERE pry_nombre LIKE nom;
    END ??
DELIMITER ;
-- *****************************************************************************************************
-- crear una publicación como grupo
DELIMITER ??
CREATE PROCEDURE crear_publicacion
(IN id INT, IN title VARCHAR(100),IN pag INT,IN tema VARCHAR(100),IN pry INT)
BEGIN
	INSERT INTO vw_insert_pubi VALUES(id,title,pag,tema,pry);
END ??
DELIMITER ;
-- *****************************************************************************************************
DELIMITER ??
CREATE PROCEDURE mostrar_perfil_grupo(IN id INT)
 BEGIN
	SELECT * FROM perfil_grupo WHERE gru_id=id;
 END ??
 DELIMITER ;
-- *****************************************************************************************************
 DELIMITER ??
 CREATE PROCEDURE editar_nombre_grupo (IN id INT, IN nombre VARCHAR(75))
 BEGIN
	UPDATE perfil_grupo SET gru_nombre=nombre WHERE gru_id = id;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- FIN DEL SCRIPT
