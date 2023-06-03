-- DROP ROLE role_estudiante;
-- DROP ROLE profesor;
-- DROP ROLE empleado;
-- DROP ROLE grupo;

use investigacion;
-- ROL ESTUDIANTE
CREATE ROLE role_estudiante;
GRANT SELECT, UPDATE ON perfil TO role_estudiante;
GRANT SELECT ON ver_publicaciones TO role_estudiante;
GRANT SELECT ON ver_proyectos TO role_estudiante;
GRANT SELECT, UPDATE ON investigacion.vw_estudiante_estudiante TO role_estudiante;
GRANT SELECT ON investigacion.vw_estudiante_profesor TO role_estudiante;
GRANT SELECT ON investigacion.vw_estudiante_empleado TO role_estudiante;
GRANT INSERT,SELECT ON investigacion.vw_equipo TO role_estudiante;
GRANT SELECT ON investigacion.vw_grupo_investigacion TO role_estudiante;
GRANT SELECT ON investigacion.vw_semillero TO role_estudiante;
GRANT SELECT ON investigacion.vw_laboratorio TO role_estudiante;
GRANT SELECT ON vw_proyecto TO role_estudiante;
GRANT INSERT,SELECT ON vw_paper TO role_estudiante;
GRANT SELECT ON vw_publicacion TO role_estudiante;
GRANT SELECT ON vw_editorial TO role_estudiante;
GRANT SELECT ON vw_sede TO role_estudiante;
GRANT SELECT ON vw_edificio TO role_estudiante;
GRANT SELECT ON vw_facultad_sede TO role_estudiante;
GRANT SELECT ON vw_facultad TO role_estudiante;
GRANT SELECT ON vw_departamento TO role_estudiante;
GRANT SELECT ON vw_biblioteca TO role_estudiante;
GRANT SELECT ON vw_existencia TO role_estudiante;
GRANT SELECT ON vw_laboratorio_proyecto TO role_estudiante;
GRANT SELECT ON vw_equipo_laboratorio TO role_estudiante;
GRANT SELECT ON vw_programa_academico TO role_estudiante;

show grants for role_estudiante;
create user test0@localhost identified by '1';
show grants for test0@localhost;
GRANT role_estudiante to test0@localhost;
flush privileges;
alter user 'test0'@'localhost'  default role role_estudiante;

show grants for test0@localhost;



-- ROL PROFESOR
CREATE ROLE role_profesor;

GRANT SELECT ON perfil_profesor TO role_profesor;
GRANT SELECT ON vw_profesor_estudiante TO role_profesor;
GRANT SELECT, UPDATE ON vw_profesor_profesor TO role_profesor;
GRANT SELECT ON vw_profesor_empleado TO role_profesor;
GRANT INSERT,SELECT ON vw_equipo TO role_profesor;
GRANT INSERT,SELECT,UPDATE ON vw_grupo_investigacion TO role_profesor;
GRANT INSERT,SELECT,UPDATE ON vw_semillero TO role_profesor;
GRANT SELECT ON vw_laboratorio TO role_profesor;
GRANT INSERT,SELECT,UPDATE ON vw_proyecto TO role_profesor;
GRANT INSERT,SELECT ON vw_paper TO role_profesor;
GRANT SELECT ON vw_publicacion TO role_profesor;
GRANT SELECT ON vw_editorial TO role_profesor;
GRANT SELECT ON vw_sede TO role_profesor;
GRANT SELECT ON vw_edificio TO role_profesor;
GRANT SELECT ON vw_facultad_sede TO role_profesor;
GRANT SELECT ON vw_facultad TO role_profesor;
GRANT SELECT ON vw_departamento TO role_profesor;
GRANT SELECT ON vw_biblioteca TO role_profesor;
GRANT SELECT ON vw_existencia TO role_profesor;
GRANT SELECT ON vw_laboratorio_proyecto TO role_profesor;
GRANT SELECT ON vw_equipo_laboratorio TO role_profesor;
GRANT SELECT ON vw_programa_academico TO role_profesor;


-- ROL GRUPO DE INVESTIGACIÓN
CREATE ROLE rol_grupo;

GRANT SELECT ON vw_grupo_estudiante TO rol_grupo;
GRANT SELECT ON vw_grupo_profesor TO rol_grupo;
GRANT SELECT ON vw_grupo_empleado TO rol_grupo;
GRANT INSERT,SELECT ON vw_equipo TO rol_grupo;
GRANT SELECT,UPDATE ON vw_grupo_investigacion TO rol_grupo;
GRANT INSERT ON vw_semillero TO rol_grupo;
GRANT SELECT ON vw_laboratorio TO rol_grupo;
GRANT INSERT,SELECT,UPDATE ON vw_proyecto TO rol_grupo;
GRANT INSERT,SELECT ON vw_paper TO rol_grupo;
GRANT SELECT ON vw_publicacion TO rol_grupo;
GRANT SELECT ON vw_editorial TO rol_grupo;
GRANT SELECT ON vw_sede TO rol_grupo;
GRANT SELECT ON vw_edificio TO rol_grupo;
GRANT SELECT ON vw_facultad_sede TO rol_grupo;
GRANT SELECT ON vw_facultad TO rol_grupo;
GRANT SELECT ON vw_departamento TO rol_grupo;
GRANT SELECT ON vw_biblioteca TO rol_grupo;
GRANT SELECT ON vw_existencia TO rol_grupo;
GRANT SELECT ON vw_laboratorio_proyecto TO rol_grupo;
GRANT SELECT ON vw_equipo_laboratorio TO rol_grupo;
GRANT SELECT ON vw_programa_academico TO rol_grupo;


-- ROL EMPLEADO
CREATE ROLE rol_empleado;

GRANT SELECT ON vw_grupo_estudiante TO rol_empleado;
GRANT SELECT ON vw_grupo_profesor TO rol_empleado;
GRANT SELECT,UPDATE ON vw_grupo_empleado TO rol_empleado;
GRANT INSERT,SELECT ON vw_equipo TO rol_empleado;
GRANT SELECT ON vw_grupo_investigacion TO rol_empleado;
GRANT INSERT ON vw_semillero TO rol_empleado;
GRANT SELECT ON vw_laboratorio TO rol_empleado;
GRANT SELECT ON vw_proyecto TO rol_empleado;
GRANT SELECT ON vw_paper TO rol_empleado;
GRANT SELECT ON vw_publicacion TO rol_empleado;
GRANT SELECT ON vw_editorial TO rol_empleado;
GRANT SELECT ON vw_sede TO rol_empleado;
GRANT SELECT ON vw_edificio TO rol_empleado;
GRANT SELECT ON vw_facultad_sede TO rol_empleado;
GRANT SELECT ON vw_facultad TO rol_empleado;
GRANT SELECT ON vw_departamento TO rol_empleado;
GRANT SELECT ON vw_biblioteca TO rol_empleado;
GRANT SELECT ON vw_existencia TO rol_empleado;
GRANT SELECT ON vw_laboratorio_proyecto TO rol_empleado;
GRANT SELECT ON vw_equipo_laboratorio TO rol_empleado;
GRANT SELECT ON vw_programa_academico TO rol_empleado;

flush privileges;

