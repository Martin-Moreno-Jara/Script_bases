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
-- drop view perfil;
CREATE VIEW perfil AS 
SELECT est_nombre, est_apellido, est_edad, est_correo, est_telefono, est_direccion, est_cedula, 
programa_academico.prg_nombre, grupo_investigacion.gru_nombre, semillero.sem_nombre 
FROM semillero RIGHT JOIN (grupo_investigacion RIGHT JOIN (estudiante JOIN programa_academico 
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
-- drop VIEW perfil_profesor;
CREATE VIEW perfil_profesor AS
SELECT pro_nombre, pro_apellido, pro_edad, pro_correo, 
pro_telefono, pro_direccion,pro_tipoProfesor,pro_cedula,gru_nombre,sem_nombre,dep_nombre
FROM profesor JOIN grupo_investigacion on (pro_gru_id=gru_id) JOIN semillero ON (sem_id=pro_sem_id)
JOIN departamento ON (dep_id=pro_dep_id);




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
-- VISTA CON JOIN DE PROYECTO Y GRUPO DE INVESTIGACIÓN VISTA INVESTIGACIÓN
 CREATE VIEW ver_proyectos_grupo AS
 SELECT pry_nombre, gru_nombre, pry_estado, gru_id
 FROM proyecto 
 JOIN grupo_investigacion ON (grupo_investigacion.gru_id= proyecto.pry_gru_id);
  -- *****************************************************************************************************
 -- VISTA CON JOIN DE PAPER, PROYECTO Y GRUPO DE INVESTIGACIÓN DE UN GRUPO
 CREATE VIEW ver_publicaciones_grupo AS 
 SELECT pap_titulo, pap_tema, pry_nombre, gru_nombre, gru_id
 FROM  grupo_investigacion JOIN (paper JOIN proyecto ON (paper.pap_pry_id = proyecto.pry_id)) 
 ON (grupo_investigacion.gru_id=proyecto.pry_gru_id);
  -- *****************************************************************************************************
 -- Grupo sin los defalt en 0
 CREATE VIEW vw_grupo_crear AS
 SELECT gru_id,gru_nombre,gru_area,gru_lider,gru_contrasena FROM grupo_investigacion;
-- *****************************************************************************************************
 -- proyecto con los atributos para insertar
 CREATE VIEW vw_insert_proyecto AS
 SELECT pry_id,pry_nombre,pry_propuesta,pry_estado,pry_gru_id FROM proyecto;
-- *****************************************************************************************************
 -- papers con los atributos para insertar
 CREATE VIEW vw_insert_pubi AS SELECT pap_id,pap_titulo,pap_numPaginas,pap_tema,pap_pry_id FROM paper;
 -- *****************************************************************************************************
 -- VISTA PARA LA INFO DEL GRUPO
 CREATE VIEW perfil_grupo AS
 SELECT gru_id, gru_nombre,gru_numIntegrantes,
 gru_numPapers,gru_area, gru_numProyectos, 
 CONCAT(pro_nombre,' ',pro_apellido) as Profesor_lider
 FROM grupo_investigacion JOIN profesor  ON (grupo_investigacion.gru_lider=profesor.pro_cedula);
-- *****************************************************************************************************
  /*select pap_titulo,pap_tema,pap_numPaginas,pry_nombre,gru_nombre 
  FROM paper JOIN proyecto ON (pry_id=pap_pry_id) JOIN grupo_investigacion ON (gru_id=pry_gru_id);
  */
  
  CREATE VIEW vw_paper_editorial_bib AS SELECT pap_titulo,edi_nombre,bib_nombre FROM publicacion 
  JOIN paper on (pap_id=pub_pap_id) JOIN editorial on (pub_edi_id=edi_id)
  JOIN existencia on (exi_pub_pap_id=pap_id) JOIN biblioteca ON (bib_id=exi_bib_id); 
  
-- *****************************************************************************************************
CREATE VIEW vw_depNombres AS
select dep_nombre from departamento;
   -- *****************************************************************************************************