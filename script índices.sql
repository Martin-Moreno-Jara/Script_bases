USE investigacion;
-- ESTUDIANTE, PROFESOR Y EMPLEADO
CREATE INDEX index_est_correo ON estudiante(est_correo);
CREATE INDEX index_est_cedula ON estudiante(est_cedula);

CREATE INDEX index_pro_correo ON profesor(pro_correo);
CREATE INDEX index_pro_cedula ON profesor(pro_cedula);

CREATE INDEX index_emp_correo ON empleado(emp_correo);
CREATE INDEX index_emp_cedula ON empleado(emp_cedula);

/*Para estas tres tablas se consideran los indices sobre la cédula y el correo, ya que para muchas de las consultas
se requiere la cedula o id de estas tablas, y un índice mejoraría el tiempo de respuesta. Además sobre la columna correo, 
ya que pensando en la implementación de la interfaz, será necesario que estos usuarios se registren y hagan log in, y para esto
será necesario hacer consultas a esta columna en especifico.*/

-- GRUPO
CREATE INDEX index_gru_numProyectos ON grupo_investigacion(gru_numProyectos);
CREATE INDEX index_gru_numPapers ON grupo_investigacion(gru_numPapers);
CREATE INDEX index_gru_area ON grupo_investigacion(gru_area);

/* Para la tabla de grupo de investigación se consideran estos tres índices: sobre la columna de número de proyectos, ya que
es una columna sobre la cual se pueden hacer una buena cantidad de consultas interesantes y actualizaciones, al igual que
el número de papers. Por otro lado, para la columna de área se considera un índice, ya que puede ser útil para consultas
en las que se quiera saber el área de algun grupo de investigación.*/

-- PROYECTO 
CREATE INDEX index_pry_estado ON proyecto(pry_estado);
CREATE INDEX index_pry_id ON proyecto(pry_id);
/*Para la tabla de proyectos se considera un índice sobre la columna id, ya que muchas consultas y join se realizan con este
atributo, y sobre la columna estado, ya que en el modelo es relevante saber si un proyecto se encuentra activo. principalemte
para las consultas */
-- PAPER 
CREATE INDEX index_pap_tema ON paper(pap_tema);
CREATE INDEX index_pap_id ON paper(pap_id);
/*Para la tabla paper se considerán índices sobre las columnas id y tema, id ya que se hacen joins y consultas sobre este
atributo, y el tema, ya que es una columna de interés para las consultas, y por ello un índice facilitaría el tiempo que 
se tarda en acceder a la columna */

-- EDITORIAL 
CREATE INDEX index_edi_numPapers ON editorial(edi_numPapers);
/*Para la tabla editorial se considera un índice sobre la columa del número de papers, ya que en las consultas que se plantean, 
este es un atributo bastante usado y por lo tanto un índice podría mejorar su rendimiento*/

-- DEPARTAMENTO
CREATE INDEX index_dep_numGrupos ON departamento(dep_numGrupos);
/*Para la tabla departamento se considera un índice sobre la columna del número de grupos, ya que con respecto al modulo de 
investigación, es el atributo con el que más se harían consultas.*/

-- LABORATORIO
CREATE INDEX index_lab_id ON laboratorio(lab_id);
/*Para la tabla de laboratorio se considera un índice sobre la columna de id, ya que se usa bastante para hacer joins y 
consultas*/


