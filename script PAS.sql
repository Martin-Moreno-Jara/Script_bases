/*
**************************************************************************************************
SCRIPT PAS - VISTAS INTERFAZ DE USUARIO -------------------------
**************************************************************************************************
*/
-- ramita de gabito
-- nombre completo concatenado? 
-- todos los dsatos del perfil del estudiante
-- SELECT * FROM estudiante;
CREATE VIEW perfil AS 
SELECT 
est_nombre, est_apellido, est_edad, est_correo, 
est_telefono, est_direccion, 
est_cedula, programa_academico.prg_nombre, 
grupo_investigacion.gru_nombre, semillero.sem_nombre 
FROM semillero JOIN (grupo_investigacion JOIN (estudiante JOIN programa_academico 
ON (estudiante.est_prg_id=programa_academico.prg_id)) 
ON (grupo_investigacion.gru_id= estudiante.est_gru_id)) 
ON (semillero.sem_id=estudiante.est_sem_id);

DELIMITER ??
CREATE PROCEDURE mostrar_perfiles ()
BEGIN
	SELECT * FROM perfil;
END ??
CREATE PROCEDURE mostrar_un_perfil(IN ced INT)
BEGIN
	SELECT * FROM perfil WHERE est_cedula = ced;
END??
DELIMITER ;

-- Ver publicaciones: Titulo Tema Proyecto Grupo
CREATE VIEW ver_publicaciones AS 
 SELECT pap_titulo, pap_tema, pry_nombre, gru_nombre
 FROM  grupo_investigacion 
 JOIN (paper JOIN proyecto 
 ON (paper.pap_pry_id = proyecto.pry_id)) 
 ON (grupo_investigacion.gru_id=proyecto.pry_gru_id);

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

-- VER PROYECTOS: NOMBRE PROYECTO, NOMBRE GRUPO, ESTADO DEL PROYECTO
 CREATE VIEW ver_proyectos AS
 SELECT pry_nombre, gru_nombre, pry_estado 
 FROM proyecto 
 JOIN grupo_investigacion ON (grupo_investigacion.gru_id= proyecto.pry_gru_id);


  DELIMITER ??
 CREATE PROCEDURE ver_all_proyectos()
 BEGIN
	SELECT * FROM ver_proyectos;
 END??
 
 CREATE PROCEDURE consultar_proyecto(IN v_p_nombre VARCHAR (60),IN v_gru_nombre VARCHAR (60),IN v_p_estado VARCHAR (60))
 BEGIN
	SELECT * FROM ver_proyectos 
    WHERE pry_nombre= v_p_nombre 
    OR gru_nombre = v_gru_nombre OR pry_estado=v_p_estado;
 END??
 DELIMITER ;

CREATE VIEW perfil_profesor AS
SELECT 
pro_nombre, pro_apellido, pro_edad, pro_correo, 
pro_telefono, pro_direccion, 
pro_cedula, programa_academico.prg_nombre, 
grupo_investigacion.gru_nombre, semillero.sem_nombre 
FROM   programa_academico  RIGHT JOIN
 (estudiante right JOIN 
(semillero right JOIN 
(profesor LEFT JOIN grupo_investigacion
ON (profesor.pro_cedula= grupo_investigacion.gru_lider)) 
ON (semillero.sem_id=profesor.pro_sem_id)) 
ON (estudiante.est_gru_id= grupo_investigacion.gru_id)) 
ON ( programa_academico.prg_id= estudiante.est_prg_id) GROUP BY(pro_nombre);
 
CREATE VIEW to_edit_profesor AS
SELECT pro_cedula, pro_telefono, pro_direccion FROM profesor;
 
 DELIMITER ??
CREATE PROCEDURE mostrar_perfiles_profesores ()
BEGIN
	SELECT * FROM perfil_profesor;
END ??
CREATE PROCEDURE mostrar_un_perfil_profesor(IN ced INT)
BEGIN
	SELECT * FROM perfil_profesor WHERE pro_cedula = ced;
END??

CREATE PROCEDURE editar_profesor(IN ced INT, IN tel VARCHAR(75), IN direc VARCHAR(75))
BEGIN
	UPDATE to_edit_profesor SET pro_telefono=tel, pro_direccion=direc WHERE pro_cedula=ced; 
END ??
DELIMITER ;

 -- CREAR VISTA PERFIL GRUPO
 CREATE VIEW perfil_grupo AS
 SELECT gru_id, gru_nombre,gru_numIntegrantes,
 gru_numPapers,gru_area, gru_numProyectos, 
 CONCAT(pro_nombre,' ',pro_apellido) as Profesor_lider
 FROM grupo_investigacion JOIN profesor  ON (grupo_investigacion.gru_lider=profesor.pro_cedula);
 
 -- CREAR PROCEDIMIENTOS ALMACENADOS perfil grupo
 DELIMITER ??
 CREATE PROCEDURE mostrar_perfiles_grupo() 
 BEGIN
	SELECT * FROM perfil_grupo;
 END ??
 
 CREATE PROCEDURE mostrar_perfil_grupo(IN id INT)
 BEGIN
	SELECT * FROM perfil_grupo WHERE gru_id=id;
 END ??
 
 CREATE PROCEDURE editar_nombre_grupo (IN id INT, IN nombre VARCHAR(75))
 BEGIN
	UPDATE perfil_grupo SET gru_nombre=nombre WHERE gru_id = id;
 END ??
 DELIMITER ;
 
 -- CREACION VISTA DE PERFIL EMPLEADO
 CREATE VIEW perfil_empleado AS
 SELECT emp_nombre,emp_apellido,emp_edad,emp_correo,
 emp_telefono,emp_direccion,emp_cedula
 FROM empleado;
 
 -- PROCEDIMIENTO ALMACENADO perfiles empleado
 DELIMITER ??
 CREATE PROCEDURE mostrar_perfiles_empleado()
 BEGIN 
		SELECT * FROM perfil_empleado;
 END ??
 
 CREATE PROCEDURE mostrar_perfil_un_empleado(IN ced INT)
BEGIN
	SELECT * FROM perfil_empleado WHERE emp_cedula = ced;
END ??

CREATE PROCEDURE editar_perfil_empleado(IN ced INT, IN telefono VARCHAR(75), IN dir VARCHAR(75))
BEGIN
	UPDATE perfil_empleado SET emp_telefono=telefono, emp_direccion=dir WHERE emp_cedula = ced;
END ??
 DELIMITER ;
 