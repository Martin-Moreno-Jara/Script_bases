Use investigacion;
-- ####################################################################################################
-- SCRIPT DE CREACIÓN DE PROCEDIMIENTOS ALMACENADOS
-- ####################################################################################################


-- *****************************************************************************************************
-- LOGIN PARA ESTUDIANTE
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
-- LOGIN PARA PROFESOR 
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
-- *****************************************************************************************************
-- LOGIN PARA EMPLEADO 
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
-- *****************************************************************************************************
-- LOGIN PARA GRUPO DE INVESTIGACIÓN 
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
-- *****************************************************************************************************
-- OBTENER DEL ID DEL PROGRAMA SEGÚN SU NOMBRE
DELIMITER ??
CREATE PROCEDURE getNum_prg(IN programa VARCHAR(50))
BEGIN
	SELECT prg_id from programa_academico WHERE prg_nombre LIKE programa;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- CREAR UN USUARIO TIPO ESTUDIANTE DESDE EL REGISTER
DELIMITER ??
CREATE PROCEDURE estudiante_register
(IN cedula INT,IN nombre VARCHAR(50),IN apellido VARCHAR(50),IN edad int,IN correo VARCHAR(50),
IN telefono VARCHAR(50),IN direccion VARCHAR(50),IN tipo VARCHAR(50),IN programa INT,pass VARCHAR(50))
BEGIN
	INSERT INTO estudiante(est_cedula,est_nombre,est_apellido,est_edad,est_correo,
				est_telefono,est_direccion,est_tipoEstudiante,est_prg_id,est_contrasena)
    VALUES (cedula,nombre,apellido,edad,correo,telefono,direccion,tipo,programa,aes_encrypt(pass,'clave'));
    
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
-- CREAR UN USUARIO DE TIPO PROFESOR DESDE EL REGISTER
DELIMITER ??
CREATE PROCEDURE profesor_register
(IN cedula INT,IN nombre VARCHAR(50),IN apellido VARCHAR(50),IN edad int,IN correo VARCHAR(50),
IN telefono VARCHAR(50),IN direccion VARCHAR(50),IN tipo VARCHAR(50),IN departamento INT,pass VARCHAR(50))
BEGIN
	INSERT INTO profesor(pro_cedula,pro_nombre,pro_apellido,pro_edad,pro_correo,
				pro_telefono,pro_direccion,pro_tipoProfesor,pro_dep_id,pro_contrasena)
    VALUES (cedula,nombre,apellido,edad,correo,telefono,direccion,tipo,departamento,aes_encrypt(pass,'clave'));
    
    SET @createUserQuery = CONCAT('CREATE USER \'', correo, '\'@\'localhost\' IDENTIFIED BY \'', pass, '\';');
        PREPARE createUserStmt FROM @createUserQuery;
        EXECUTE createUserStmt;
        DEALLOCATE PREPARE createUserStmt;
	-- ALTER USER correo@'localhost'  default role role_estudiante;
    SET @grantRoleQuery = CONCAT('GRANT role_profesor TO \'', correo, '\'@\'localhost\';');
        PREPARE grantRoleStmt FROM @grantRoleQuery;
        EXECUTE grantRoleStmt;
        DEALLOCATE PREPARE grantRoleStmt;
    SET @sql = CONCAT('ALTER USER ''', correo, '''@''localhost'' DEFAULT ROLE role_profesor;');
        PREPARE stmt FROM @sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
END??
DELIMITER ;
-- *****************************************************************************************************
-- MOSTRAR TODOS LOS PROGRAMAS ACADÉMICOS PARA LLENAR COMBOBOX
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
-- MOSTRAR TODAS LAS ÁREAS DE LOS GRUPOS DE INVESTIGACIÓN PARA COMBOBOX
DELIMITER ??
CREATE PROCEDURE get_grupos_areas()
BEGIN 
	select distinct gru_area FROM grupo_investigacion;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- MUESTRA LA INFORMACIÓN PARA LA TABLA DE LOS GRUPOS DE INVESTIGACIÓN.
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
-- FILTRAR LA TABLA DE GRUPOS DE INVESTIGACIÓN
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
-- OBTENER NOMBRE DE LOS GRUPOS PARA COMBOBOX
DELIMITER ??
CREATE PROCEDURE get_grupos()
BEGIN
	SELECT gru_nombre FROM grupo_investigacion;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- FILTRAR TABLA DE PROYECTOS
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
-- OBTENER TODOS LOS TEMAS PARA EL COMBOBOX
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
-- FILTRAR TABLA PUBLICACIONES
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
-- FILTRAR LA TABLA DE LABORATORIOS
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
 -- *****************************************************************************************************
-- Obtener todos los estudiantes para la tabla de crear grupos y añadir
DELIMITER ??
CREATE PROCEDURE llenar_estudiantes()
BEGIN
	SELECT * from vw_estudiante_tabla;
END ??
DELIMITER ;
 -- *****************************************************************************************************
-- FILTRAR LA TABLA DE ESTUDIANTES
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
DELIMITER ??
CREATE PROCEDURE get_proyectos_un_grupo(IN id INT)
BEGIN
	SELECT * FROM ver_proyectos_grupo  WHERE gru_id=id;
END ??
DELIMITER ; 
-- *****************************************************************************************************
-- Muestra las publicaciones pero solo de un grupo en especifico
DELIMITER ??
CREATE PROCEDURE get_publicaciones_un_grupo(IN id INT)
BEGIN
	SELECT * FROM ver_publicaciones_grupo  WHERE gru_id=id;
END ??
DELIMITER ; 
-- *****************************************************************************************************
-- Muestra los proyectos pero solo de un grupo en especifico
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
-- Editar perfil del profesor drop PROCEDURE editar_profesor_perfil;
DELIMITER ??
CREATE PROCEDURE editar_profesor_perfil(IN ced INT, IN tel VARCHAR(75), IN direc VARCHAR(75))
BEGIN
	UPDATE profesor SET pro_telefono=tel, pro_direccion=direc WHERE pro_cedula=ced; 
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
-- MUESTRA PERFIL O INFORMACIÓN DEL GRUPO DE INVESTIGACIÓN
DELIMITER ??
CREATE PROCEDURE mostrar_perfil_grupo(IN id INT)
 BEGIN
	SELECT * FROM perfil_grupo WHERE gru_id=id;
 END ??
 DELIMITER ;
-- *****************************************************************************************************
-- EDITAR EL NOMBRE DEL GRUPO
 DELIMITER ??
 CREATE PROCEDURE editar_nombre_grupo (IN id INT, IN nombre VARCHAR(75))
 BEGIN
	UPDATE perfil_grupo SET gru_nombre=nombre WHERE gru_id = id;
END ??
DELIMITER ;
-- ***************************************************************************************************** 
-- EDITAR TELEFONO Y DIRECCIÓN DE UN ESTUDIANTE
DELIMITER ??
CREATE PROCEDURE editar_estudiante_perfil(IN ced INT, IN tel VARCHAR(75), IN direc VARCHAR(75))
BEGIN
	START TRANSACTION;
		UPDATE estudiante SET est_telefono=tel, est_direccion=direc WHERE est_cedula=ced; 
    IF length(tel)<10
		THEN ROLLBACK;
	ELSE 
		COMMIT;
	END IF;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- OBTENER TODOS LOS DEPARTAMENTOS PARA COMBOBOX
DELIMITER ??
CREATE PROCEDURE get_departamentos()
BEGIN
	SELECT * from vw_depNombres;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- OBTENER EL NÚMERO DE DEPARTAMENTO SEGÚN SU NOMBRE
DELIMITER ??
CREATE PROCEDURE getNum_dep(IN dep VARCHAR(50))
BEGIN
	select dep_id from departamento WHERE dep_nombre LIKE dep;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- CAMBIAR EL GRUPOD DE UN ESTUDIANTE
DELIMITER ??
CREATE PROCEDURE actualizar_grupo_estudiante (IN estudiante_id INT,IN nuevo_grupo INT)
BEGIN
    UPDATE estudiante
    SET est_gru_id = nuevo_grupo
    WHERE est_cedula = estudiante_id;
END ??
DELIMITER ;
-- *****************************************************************************************************
-- ACTUALIZAR EL NOMBRE DE UN PROYECTO
DELIMITER $$
CREATE PROCEDURE actualizarNombreProyecto(
    IN nombreantiguo VARCHAR(45),
    IN nombrenuevo VARCHAR(45)
)
BEGIN
    UPDATE proyecto
    SET pry_nombre = nombrenuevo
    WHERE pry_nombre = nombreantiguo;
END$$
DELIMITER ;

-- *****************************************************************************************************
-- ELIMINAR UN PROYECTO
DELIMITER $$
CREATE PROCEDURE eliminarProyecto(IN nombre VARCHAR(45))
BEGIN
    DELETE FROM proyecto
    WHERE pry_nombre = nombre;
END$$
DELIMITER ;
-- *****************************************************************************************************
-- MOSTRAR LOS ESTUDIANTES QUE NO TIENEN GRUPO
DELIMITER ??
CREATE PROCEDURE mostrar_estudiantes_singrupo()
BEGIN
	SELECT concat(est_nombre,' ',est_apellido),est_correo,prg_nombre FROM perfil WHERE gru_nombre is NULL;
END ??
DELIMITER ;
call mostrar_estudiantes_singrupo();
-- *****************************************************************************************************
-- ACTUALIZAR TITULO Y TEMA DE PAPER
DELIMITER $$
CREATE PROCEDURE actualizarPaper(IN pap VARCHAR(100),IN titulo VARCHAR(45),IN tema VARCHAR(45))
BEGIN
	IF titulo like '' and tema like '' THEN
    BEGIN
    END;
	ELSEIF titulo LIKE '' THEN
        UPDATE paper SET pap_tema = tema WHERE pap_titulo like pap;
    ELSEIF tema LIKE '' THEN
        UPDATE paper SET pap_titulo = titulo WHERE pap_titulo like pap;
    ELSE
        UPDATE paper SET pap_titulo = titulo, pap_tema = tema WHERE pap_titulo like pap;
    END IF;
END$$
DELIMITER ;
-- *****************************************************************************************************
-- ESTUDIANTES QUE ESTAN EN UN GRUPO EN ESPECIFICO
DELIMITER ??
CREATE PROCEDURE lista_est_grupo(IN id INT)
BEGIN
	DECLARE nombre_grupoinvest VARCHAR (75);
    SELECT gru_nombre INTO nombre_grupoinvest FROM perfil_grupo WHERE gru_id=id;
    SELECT concat(est_nombre,' ',est_apellido),est_correo,prg_nombre FROM perfil WHERE gru_nombre LIKE nombre_grupoinvest; 
END??
DELIMITER ;
-- *****************************************************************************************************
-- ELIMINAR UN PAPER
DELIMITER $$
CREATE PROCEDURE eliminarPaperPorNombre(IN pap_nombre VARCHAR(45))
BEGIN
    DELETE FROM paper WHERE pap_titulo = pap_nombre;
END $$
DELIMITER ;
-- ***************************************************************************************************** 
-- PROFESORES QUE NO TIENEN GRUPO
DELIMITER $$
CREATE PROCEDURE ObtenerProfesoresSinGrupo()
BEGIN
    SELECT concat(pro_nombre,' ',pro_apellido),pro_correo,dep_nombre FROM perfil_profesor WHERE pro_gru_id IS NULL;
END $$
DELIMITER ;
-- ***************************************************************************************************** 
-- PROFESORES EN UN GRUPO EN ESPECÍFICO
DELIMITER $$
CREATE PROCEDURE ObtenerProfesoresPorGrupo(IN grupo_id INT)
BEGIN
		 SELECT concat(pro_nombre,' ',pro_apellido),pro_correo,dep_nombre FROM perfil_profesor WHERE pro_gru_id = grupo_id 
        AND pro_cedula!=(select gru_lider from grupo_investigacion where gru_id=grupo_id );	

END $$
DELIMITER ;
-- ***************************************************************************************************** 
-- AÑADIR UN PROFESOR A UN GRUPO
DELIMITER ??
CREATE PROCEDURE add_profesor(IN gru INT,IN prof VARCHAR(70))
BEGIN
	UPDATE profesor SET pro_gru_id=gru WHERE pro_correo LIKE prof;
END ??
DELIMITER ;
-- ***************************************************************************************************** 
-- QUITAR UN PROFESOR DE UN GRUPO
DELIMITER ??
CREATE PROCEDURE remove_profesor(IN prof VARCHAR(70))
BEGIN
	UPDATE profesor SET pro_gru_id=null WHERE pro_correo LIKE prof;
END ??
DELIMITER ;
-- ***************************************************************************************************** 
-- AÑADE ESTUDIANTE A UN GRUPO DE INVESTIGACIÓN
DELIMITER $$
CREATE PROCEDURE ActualizarGrupoEstudiante(IN id INT, IN cor VARCHAR(70))
BEGIN
    UPDATE estudiante SET est_gru_id = id WHERE est_correo LIKE cor;
END $$
DELIMITER ;
-- *****************************************************************************************************
-- QUITA ESTUDIANTE DE UN GRUPO DE INVESTIGACIÓN
DELIMITER $$
CREATE PROCEDURE remove_estudiante(IN correo VARCHAR(45))
BEGIN
    UPDATE estudiante SET est_gru_id = NULL WHERE est_correo like correo;
END $$
DELIMITER ;
-- *****************************************************************************************************
-- FIN DEL SCRIPT
