/*
**************************************************************************************************
SCRIPT PAS - VISTAS INTERFAZ DE USUARIO -------------------------
**************************************************************************************************
*/
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
 
 DELIMITER ??
CREATE PROCEDURE mostrar_perfiles_profesores ()
BEGIN
	SELECT * FROM perfil_profesor;
END ??
CREATE PROCEDURE mostrar_un_perfil_profesor(IN ced INT)
BEGIN
	SELECT * FROM perfil_profesor WHERE pro_cedula = ced;
END??
DELIMITER ;


