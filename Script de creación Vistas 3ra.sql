-- SCRIPT DE CREACIÓN DE VISTAS
-- *****************************************************************************************************
-- ESTUDIANTE SIN CONTRASEÑA
CREATE VIEW vw_estudiante_estudiante AS SELECT 
est_cedula, est_nombre, est_apellido, est_edad, est_correo, est_telefono, est_direccion, est_tipoEstudiante, est_gru_id, est_prg_id,est_sem_id
FROM estudiante;
-- *****************************************************************************************************
-- VISTA PARA LA TABLA DE GRUPOS, JOIN DE GRUPO Y PROFESOR
CREATE VIEW vw_group_table AS SELECT 
gru_nombre,gru_area,gru_numIntegrantes,gru_numProyectos,gru_numPapers,concat(pro_nombre,' ',pro_apellido)
FROM grupo_investigacion join profesor ON (grupo_investigacion.gru_lider=profesor.pro_cedula);
-- *****************************************************************************************************
-- VISTA CON JOIN DE GRUPO DE INVESTIGACIÓN Y PROYECTO
CREATE VIEW vw_proyecto_grupo AS
 SELECT gru_id,gru_nombre,gru_numIntegrantes,gru_numPapers,pry_id,pry_gru_id,pry_nombre, pry_estado,gru_numProyectos 
 FROM proyecto JOIN grupo_investigacion ON (grupo_investigacion.gru_id= proyecto.pry_gru_id);
 -- *****************************************************************************************************
-- VISTA CON JOIN DE GRUPO DE INVESTIGACIÓN Y PROYECTO PARA LA TABLA

 -- *****************************************************************************************************
 -- VISTA CON JOIN DE PAPER, PROYECTO Y GRUPO DE INVESTIGACIÓN.
 CREATE VIEW ver_publicaciones AS 
 SELECT pap_titulo, pap_tema, pry_nombre, gru_nombre
 FROM  grupo_investigacion JOIN (paper JOIN proyecto ON (paper.pap_pry_id = proyecto.pry_id)) 
 ON (grupo_investigacion.gru_id=proyecto.pry_gru_id);
  -- *****************************************************************************************************
 -- VISTA CON JOIN DE PAPER, PROYECTO Y GRUPO DE INVESTIGACIÓN.
 CREATE VIEW vw_grupo_estudiante AS SELECT * FROM grupo_investigacion JOIN estudiante ON (gru_id=est_gru_id);
 -- *****************************************************************************************************
-- VISTA CON JOIN DE ESTUDIANTE, GRUPO DE INVESTIGACIÓN, PROGRAMA ACADÉMICO Y SEMILLERO 
 CREATE VIEW perfil AS 
SELECT est_nombre, est_apellido, est_edad, est_correo, est_telefono, est_direccion, est_cedula, 
programa_academico.prg_nombre, grupo_investigacion.gru_nombre, semillero.sem_nombre 
FROM semillero JOIN (grupo_investigacion JOIN (estudiante JOIN programa_academico 
ON (estudiante.est_prg_id=programa_academico.prg_id)) 
ON (grupo_investigacion.gru_id= estudiante.est_gru_id)) 
ON (semillero.sem_id=estudiante.est_sem_id);

-- *****************************************************************************************************
-- VISTA CON JOIN DE PROYECTO Y GRUPO DE INVESTIGACIÓN
 CREATE VIEW ver_proyectos AS
 SELECT pry_nombre, gru_nombre, pry_estado 
 FROM proyecto 
 JOIN grupo_investigacion ON (grupo_investigacion.gru_id= proyecto.pry_gru_id);
-- *****************************************************************************************************
-- VISTA PARA PERFIL DE PROFESOR, JOIN DE PROFESOR, PROGRAMA ACADEMICO, ESTUDIANTE, SEMILLERO (Puede cambiar)
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
-- *****************************************************************************************************
-- VISTA CON JOIN DE ESTUDIANTES Y GRUPO DE INVESTIGACIÓN
CREATE VIEW lista_integrantes_gi AS 
SELECT concat(est_nombre," ",est_apellido  ) as Nombre_Completo, est_tipoEstudiante, gru_nombre 
 FROM estudiante JOIN grupo_investigacion ON (estudiante.est_gru_id = grupo_investigacion.gru_id);
-- *****************************************************************************************************
-- VISTA CON JOIN DE PAPER Y PROYECTO
 CREATE VIEW vw_papers_de_proyecto AS
 SELECT pap_titulo, pry_nombre 
 FROM paper 
 JOIN proyecto  ON (paper.pap_pry_id = proyecto.pry_id);
-- *****************************************************************************************************
-- VISTA CON JOIN DE LABORATORIO, EMPLEADO Y EDIFICIO
CREATE VIEW vw_laboratorios AS SELECT lab_id,lab_nombre,lab_tipoLaboratorio,edf_nombre,concat(emp_nombre,' ',emp_apellido) 
	FROM laboratorio JOIN empleado ON (emp_cedula =lab_ayudante) JOIN edificio ON (lab_edf_id=edf_id);
-- *****************************************************************************************************
CREATE VIEW vw_estudiante_tabla AS SELECT concat(est_nombre,' ',est_apellido) AS nombre,est_correo,prg_nombre 
from estudiante join programa_academico on (prg_id=est_prg_id);
-- *****************************************************************************************************
