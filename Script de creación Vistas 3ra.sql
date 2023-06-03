-- SCRIPT DE CREACIÓN DE VISTAS
-- *****************************************************************************************************
-- VISTA CON JOIN DE GRUPO DE INVESTIGACIÓN Y PROYECTO
CREATE VIEW ver_proyectos AS
 SELECT pry_nombre, gru_nombre, pry_estado 
 FROM proyecto JOIN grupo_investigacion ON (grupo_investigacion.gru_id= proyecto.pry_gru_id);
 -- *****************************************************************************************************
 -- VISTA CON JOIN DE PAPER, PROYECTO Y GRUPO DE INVESTIGACIÓN.
 CREATE VIEW ver_publicaciones AS 
 SELECT pap_titulo, pap_tema, pry_nombre, gru_nombre
 FROM  grupo_investigacion JOIN (paper JOIN proyecto ON (paper.pap_pry_id = proyecto.pry_id)) 
 ON (grupo_investigacion.gru_id=proyecto.pry_gru_id);
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
-- VISTA CON JOIN GRUPO DE INVESTIGACIÓN, PAPER Y PROYECTO
 CREATE VIEW ver_publicaciones AS 
 SELECT pap_titulo, pap_tema, pry_nombre, gru_nombre
 FROM  grupo_investigacion 
 JOIN (paper JOIN proyecto ON (paper.pap_pry_id = proyecto.pry_id)) ON (grupo_investigacion.gru_id=proyecto.pry_gru_id);
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
-- *****************************************************************************************************
-- *****************************************************************************************************
