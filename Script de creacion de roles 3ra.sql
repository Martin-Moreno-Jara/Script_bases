use investigacion;
-- ####################################################################################################
-- SCRIPT DE CREACIÓN DE ROLES Y ASIGNACIÓN DE PERMISOS
-- ####################################################################################################
-- DROP ROLE role_estudiante;
-- DROP ROLE role_profesor;
-- DROP ROLE role_empleado;
-- DROP ROLE role_grupo;

-- *****************************************************************************************************
-- PERMISOS, RIVILEGIOS Y VISTAS ASIGNADOS AL ROL ESTUDIANTE
CREATE ROLE role_estudiante;
GRANT SELECT,UPDATE ON vw_estudiante_estudiante TO role_estudiante ;
GRANT SELECT,UPDATE ON perfil TO role_estudiante;
GRANT SELECT ON vw_group_table TO role_estudiante;
GRANT SELECT ON vw_proyecto_grupo TO role_estudiante;
GRANT SELECT ON ver_publicaciones TO role_estudiante;
GRANT SELECT ON vw_grupo_estudiante TO role_estudiante;
GRANT SELECT ON ver_proyectos TO role_estudiante;
GRANT SELECT ON vw_papers_de_proyecto TO role_estudiante;
GRANT SELECT ON ver_publicaciones_grupo TO role_estudiante;
GRANT EXECUTE ON PROCEDURE get_programas_academicos TO role_estudiante;
GRANT EXECUTE ON PROCEDURE get_facultades TO role_estudiante;
GRANT EXECUTE ON PROCEDURE get_grupos_areas TO role_estudiante;
GRANT EXECUTE ON PROCEDURE llenar_tabla_grupos TO role_estudiante;
GRANT EXECUTE ON PROCEDURE ver_all_proyectos TO role_estudiante;
GRANT EXECUTE ON PROCEDURE ver_all_publicaciones TO role_estudiante;
GRANT EXECUTE ON PROCEDURE mostrar_perfiles TO role_estudiante;
GRANT EXECUTE ON PROCEDURE mostrar_un_perfil TO role_estudiante;
GRANT EXECUTE ON PROCEDURE all_papers_proy TO role_estudiante;
GRANT EXECUTE ON PROCEDURE all_proy_group TO role_estudiante;
GRANT EXECUTE ON PROCEDURE one_proy_group TO role_estudiante;
GRANT EXECUTE ON PROCEDURE filtrar_grupos TO role_estudiante;
GRANT EXECUTE ON PROCEDURE get_grupos TO role_estudiante;
GRANT EXECUTE ON PROCEDURE filtrar_proyectos TO role_estudiante;
GRANT EXECUTE ON PROCEDURE get_temas TO role_estudiante;
GRANT EXECUTE ON PROCEDURE get_proyectos TO role_estudiante;
GRANT EXECUTE ON PROCEDURE filtrar_publicaciones TO role_estudiante;
GRANT EXECUTE ON PROCEDURE editar_estudiante_perfil TO role_estudiante;




-- *****************************************************************************************************
-- PERMISOS, RIVILEGIOS Y VISTAS ASIGNADOS AL ROL PROFESOR
CREATE ROLE role_profesor;
GRANT SELECT, UPDATE ON perfil_profesor TO role_profesor;
GRANT SELECT ON lista_integrantes_gi TO role_profesor; 
GRANT SELECT ON vw_estudiante_tabla TO role_profesor;
GRANT SELECT ON vw_depNombres TO role_profesor;
GRANT SELECT,INSERT ON vw_group_table TO role_profesor;
GRANT SELECT ON vw_proyecto_grupo TO role_profesor;
GRANT SELECT ON ver_publicaciones TO role_profesor;
GRANT SELECT ON vw_grupo_estudiante TO role_profesor;
GRANT SELECT ON ver_proyectos TO role_profesor;
GRANT SELECT ON vw_papers_de_proyecto TO role_profesor;
GRANT SELECT ON vw_laboratorios TO role_profesor;
GRANT SELECT ON ver_publicaciones_grupo TO role_profesor;
GRANT EXECUTE ON PROCEDURE mostrar_un_perfil_profesor TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_edificios TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_labTipo TO role_profesor;
GRANT EXECUTE ON PROCEDURE filtrar_laboratorios TO role_profesor;
GRANT EXECUTE ON PROCEDURE llenar_estudiantes TO role_profesor;
GRANT EXECUTE ON PROCEDURE filtrar_estudiantes TO role_profesor;
GRANT EXECUTE ON PROCEDURE perfil_profesor_mostrar TO role_profesor;
GRANT EXECUTE ON PROCEDURE editar_profesor_perfil TO role_profesor;
GRANT EXECUTE ON PROCEDURE crear_grupo TO role_profesor;
GRANT EXECUTE ON PROCEDURE getNum_dep TO role_profesor;
GRANT EXECUTE ON PROCEDURE llenar_tabla_laboratorios TO role_profesor;
GRANT SELECT ON  vw_papers_de_proyecto TO role_profesor;
GRANT SELECT ON  ver_publicaciones_grupo TO role_profesor;
GRANT EXECUTE ON PROCEDURE getNum_prg TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_programas_academicos TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_facultades TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_grupos_areas TO role_profesor;
GRANT EXECUTE ON PROCEDURE llenar_tabla_grupos TO role_profesor;
GRANT EXECUTE ON PROCEDURE ver_all_proyectos TO role_profesor;
GRANT EXECUTE ON PROCEDURE ver_all_publicaciones TO role_profesor;
GRANT EXECUTE ON PROCEDURE all_papers_proy TO role_profesor;
GRANT EXECUTE ON PROCEDURE all_proy_group TO role_profesor;
GRANT EXECUTE ON PROCEDURE one_proy_group TO role_profesor;
GRANT EXECUTE ON PROCEDURE filtrar_grupos TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_grupos TO role_profesor;
GRANT EXECUTE ON PROCEDURE filtrar_proyectos TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_temas TO role_profesor;
GRANT EXECUTE ON PROCEDURE get_proyectos TO role_profesor;
GRANT EXECUTE ON PROCEDURE filtrar_publicaciones TO role_profesor;



-- *****************************************************************************************************
-- PERMISOS, RIVILEGIOS Y VISTAS ASIGNADOS AL ROL GRUPO
CREATE ROLE role_grupo;
GRANT SELECT,INSERT,UPDATE ON vw_insert_proyecto TO role_grupo;
GRANT SELECT,UPDATE ON perfil_grupo TO role_grupo;
GRANT SELECT,UPDATE ON lista_integrantes_gi TO role_grupo; 
GRANT SELECT,UPDATE ON vw_estudiante_tabla TO role_grupo;
GRANT SELECT,INSERT ON vw_group_table TO role_grupo;
GRANT SELECT,INSERT,DELETE,UPDATE ON vw_proyecto_grupo TO role_grupo;
GRANT SELECT,INSERT,DELETE,UPDATE ON ver_publicaciones TO role_grupo;
GRANT SELECT ON vw_grupo_estudiante TO role_grupo;
GRANT SELECT,INSERT,DELETE,UPDATE ON ver_proyectos TO role_grupo;
GRANT SELECT,INSERT,DELETE,UPDATE ON vw_papers_de_proyecto TO role_grupo;
GRANT SELECT ON vw_laboratorios TO role_grupo;
GRANT SELECT,INSERT,DELETE,UPDATE ON ver_publicaciones_grupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE one_paper_proy TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_proyectos_un_grupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_publicaciones_un_grupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_proyectos_un_grupoCombobox TO role_grupo;
GRANT EXECUTE ON PROCEDURE crear_proyecto TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_proyId TO role_grupo;
GRANT EXECUTE ON PROCEDURE crear_publicacion TO role_grupo;
GRANT EXECUTE ON PROCEDURE mostrar_perfil_grupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE editar_nombre_grupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE actualizar_grupo_estudiante TO role_grupo;
GRANT EXECUTE ON PROCEDURE actualizarNombreProyecto TO role_grupo;
GRANT EXECUTE ON PROCEDURE eliminarProyecto TO role_grupo;
GRANT EXECUTE ON PROCEDURE mostrar_estudiantes_singrupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE actualizarPaper TO role_grupo;
GRANT EXECUTE ON PROCEDURE lista_est_grupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE eliminarPaperPorNombre TO role_grupo;
GRANT EXECUTE ON PROCEDURE ObtenerProfesoresSinGrupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE ObtenerProfesoresPorGrupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE add_profesor TO role_grupo;
GRANT EXECUTE ON PROCEDURE sumProfesorGrupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE remove_profesor TO role_grupo;
GRANT EXECUTE ON PROCEDURE lessProGrupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE ActualizarGrupoEstudiante TO role_grupo;
GRANT EXECUTE ON PROCEDURE remove_estudiante TO role_grupo;
GRANT SELECT ON  vw_papers_de_proyecto TO role_grupo;
GRANT SELECT ON  ver_publicaciones_grupo TO role_grupo;
GRANT EXECUTE ON PROCEDURE getNum_prg TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_programas_academicos TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_facultades TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_grupos_areas TO role_grupo;
GRANT EXECUTE ON PROCEDURE llenar_tabla_grupos TO role_grupo;
GRANT EXECUTE ON PROCEDURE ver_all_proyectos TO role_grupo;
GRANT EXECUTE ON PROCEDURE ver_all_publicaciones TO role_grupo;
GRANT EXECUTE ON PROCEDURE all_papers_proy TO role_grupo;
GRANT EXECUTE ON PROCEDURE all_proy_group TO role_grupo;
GRANT EXECUTE ON PROCEDURE one_proy_group TO role_grupo;
GRANT EXECUTE ON PROCEDURE filtrar_grupos TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_grupos TO role_grupo;
GRANT EXECUTE ON PROCEDURE filtrar_proyectos TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_temas TO role_grupo;
GRANT EXECUTE ON PROCEDURE get_proyectos TO role_grupo;
GRANT EXECUTE ON PROCEDURE filtrar_publicaciones TO role_grupo;

-- *****************************************************************************************************
-- PERMISOS, RIVILEGIOS Y VISTAS ASIGNADOS AL ROL EMPLEADO
CREATE ROLE role_empleado;
GRANT SELECT ON vw_group_table TO role_empleado;
GRANT SELECT ON vw_proyecto_grupo TO role_empleado;
GRANT SELECT ON ver_publicaciones TO role_empleado;
GRANT SELECT ON vw_grupo_estudiante TO role_empleado;
GRANT SELECT ON ver_proyectos TO role_empleado;
GRANT SELECT ON vw_papers_de_proyecto TO role_empleado;
GRANT SELECT ON ver_publicaciones_grupo TO role_empleado;
GRANT SELECT,UPDATE ON vw_laboratorios TO role_empleado;
GRANT EXECUTE ON llenar_tabla_laboratorios TO role_empleado;
GRANT SELECT ON vw_papers_de_proyecto TO role_empleado;
GRANT SELECT ON ver_publicaciones_grupo TO role_empleado;
GRANT EXECUTE ON PROCEDURE getNum_prg TO role_empleado;
GRANT EXECUTE ON PROCEDURE get_programas_academicos TO role_empleado;
GRANT EXECUTE ON PROCEDURE get_facultades TO role_empleado;
GRANT EXECUTE ON PROCEDURE get_grupos_areas TO role_empleado;
GRANT EXECUTE ON PROCEDURE llenar_tabla_grupos TO role_empleado;
GRANT EXECUTE ON PROCEDURE ver_all_proyectos TO role_empleado;
GRANT EXECUTE ON PROCEDURE ver_all_publicaciones TO role_empleado;
GRANT EXECUTE ON PROCEDURE all_papers_proy TO role_empleado;
GRANT EXECUTE ON PROCEDURE all_proy_group TO role_empleado;
GRANT EXECUTE ON PROCEDURE one_proy_group TO role_empleado;
GRANT EXECUTE ON PROCEDURE filtrar_grupos TO role_empleado;
GRANT EXECUTE ON PROCEDURE get_grupos TO role_empleado;
GRANT EXECUTE ON PROCEDURE filtrar_proyectos TO role_empleado;
GRANT EXECUTE ON PROCEDURE get_temas TO role_empleado;
GRANT EXECUTE ON PROCEDURE get_proyectos TO role_empleado;
GRANT EXECUTE ON PROCEDURE filtrar_publicaciones TO role_empleado;


