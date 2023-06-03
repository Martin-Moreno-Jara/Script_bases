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
 -- *****************************************************************************************************
 -- *****************************************************************************************************
 -- *****************************************************************************************************