-- DROP SCHEMA investigacion;
CREATE SCHEMA investigacion;
USE Investigacion;

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA SEDE
CREATE TABLE sede(
	sed_id INT NOT NULL PRIMARY KEY,
    sed_nombre VARCHAR(45) NOT NULL,
    sed_ubicacion VARCHAR(45) NOT NULL,
    sed_numEstudiantes INT DEFAULT 0
	);
	
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA FACULTDAD
CREATE TABLE facultad(
	fac_id INT NOT NULL PRIMARY KEY,
    fac_nombre VARCHAR(45) NOT NULL
	);

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA DEPARTAMENTO
CREATE TABLE departamento(
	dep_id INT NOT NULL PRIMARY KEY,
    dep_nombre  VARCHAR(45),
    dep_numGrupos INT DEFAULT 0,
    dep_fac_id INT NOT NULL,
    FOREIGN KEY(dep_fac_id) REFERENCES facultad(fac_id)
	);
            
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA PROGRAMAS ACADÉMICOS
CREATE TABLE programa_academico(
	prg_id INT NOT NULL PRIMARY KEY,
    prg_nombre VARCHAR(45),
    prg_cantidadCreditos INT,
    prg_tipoPrograma VARCHAR(45),
    prg_dep_id INT NOT NULL,
    FOREIGN KEY(prg_dep_id) REFERENCES departamento(dep_id)
    );
            
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA DE EQUIPOS DE LABORATORIO
CREATE TABLE equipo(
	equ_id INT NOT NULL PRIMARY KEY,
    equ_nom VARCHAR(45) NOT NULL,
    equ_CantidadElementos INT
	);
    		
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA DE SEMILLEROS DE INVESTIGACIÓN
CREATE TABLE semillero(
	sem_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sem_nombre VARCHAR(50) NOT NULL,
    sem_numIntegrantes INT DEFAULT 0,
    sem_area VARCHAR(45) NOT NULL,
    sem_lider INT NOT NULL
	);
    

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA GRUPOS DE INVESTIGACIÓN
CREATE TABLE grupo_investigacion(
	gru_id INT NOT NULL PRIMARY KEY,
	gru_nombre VARCHAR(45) NOT NULL,
    gru_numIntegrantes INT DEFAULT 1,
    gru_numPapers INT DEFAULT 0,
    gru_area VARCHAR(45) NOT NULL,
    gru_numProyectos INT DEFAULT 0,
    gru_lider INT NOT NULL,
    gru_contrasena BLOB
	);
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA PROYECTOS
CREATE TABLE proyecto(
	pry_id INT NOT NULL PRIMARY KEY,
    pry_nombre VARCHAR(45) NOT NULL,
    pry_propuesta VARCHAR(45) NOT NULL,
    pry_estado VARCHAR(45) NOT NULL,
    pry_fechaInicio DATE DEFAULT NULL ,
    pry_fechaFin DATE DEFAULT NULL,
    pry_gru_id INT NOT NULL,
    FOREIGN KEY(pry_gru_id) REFERENCES grupo_investigacion(gru_id)
	);


-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA PAPERS 
CREATE TABLE paper(
	pap_id INT NOT NULL PRIMARY KEY,
    pap_titulo VARCHAR(45) NOT NULL,
    pap_numPaginas INT NOT NULL,
    pap_tema VARCHAR(45),
    pap_pry_id INT NOT NULL,
    FOREIGN KEY(pap_pry_id) REFERENCES proyecto(pry_id)
    );
	
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA EDITORIALES
CREATE TABLE editorial(
	edi_id INT NOT NULL PRIMARY KEY,
    edi_nombre VARCHAR(45) NOT NULL,
    edi_direccion VARCHAR(45) NOT NULL,
    edi_numPapers INT DEFAULT 0,
    edi_telefono VARCHAR(45)
	);
    
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA PUBLICACIONES
CREATE TABLE publicacion(
	pub_edi_id INT NOT NULL,
    pub_pap_id INT NOT NULL,
	pub_fechaPublicacion DATE NOT NULL,
    FOREIGN KEY(pub_edi_id) REFERENCES editorial(edi_id),
    FOREIGN KEY(pub_pap_id) REFERENCES paper(pap_id)
    );
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA BIBLIOTECAS
CREATE TABLE biblioteca(
	bib_id INT NOT NULL PRIMARY KEY,
    bib_nombre VARCHAR(45) NOT NULL
	);
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ESTUDIANTES
CREATE TABLE estudiante(
	est_cedula INT NOT NULL PRIMARY KEY,
    est_nombre VARCHAR(45) NOT NULL,
    est_apellido VARCHAR(45) NOT NULL,
    est_edad INT NOT NULL,
    est_correo VARCHAR(45) NOT NULL,
    est_telefono VARCHAR(45),
    est_direccion VARCHAR(45) NOT NULL,
    est_tipoEstudiante VARCHAR(45),
    est_gru_id INT DEFAULT NULL,
    est_prg_id INT NOT NULL,
    est_sem_id INT DEFAULT NULL,
    est_contrasena BLOB DEFAULT NULL,
    FOREIGN KEY (est_gru_id) REFERENCES grupo_investigacion(gru_id),
    FOREIGN KEY (est_prg_id)  REFERENCES programa_academico(prg_id),
    FOREIGN KEY (est_sem_id)  REFERENCES semillero(sem_id)
    );
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA PROFESORES
CREATE TABLE profesor(
	pro_cedula INT NOT NULL PRIMARY KEY,
    pro_nombre VARCHAR(45) NOT NULL,
    pro_apellido VARCHAR(45) NOT NULL,
    pro_edad INT NOT NULL,
    pro_correo VARCHAR(45) NOT NULL,
    pro_telefono VARCHAR(45),
    pro_direccion VARCHAR(45),
	pro_tipoProfesor VARCHAR(45) NOT NULL,
    pro_gru_id INT DEFAULT NULL,
    pro_sem_id INT DEFAULT NULL,
    pro_contrasena BLOB DEFAULT NULL,
    pro_dep_id INT DEFAULT NULL,
    FOREIGN KEY (pro_gru_id) REFERENCES grupo_investigacion(gru_id),
	FOREIGN KEY (pro_sem_id)  REFERENCES semillero(sem_id),
    FOREIGN KEY (pro_dep_id) REFERENCES departamento(dep_id)
	);


ALTER TABLE grupo_investigacion ADD CONSTRAINT FK_gru_lider FOREIGN KEY (gru_lider) REFERENCES profesor(pro_cedula);
ALTER TABLE semillero ADD CONSTRAINT FK_sem_lider FOREIGN KEY (sem_lider) REFERENCES profesor(pro_cedula);

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA EMPLEADOS
CREATE TABLE empleado(
	emp_cedula INT NOT NULL PRIMARY KEY,
    emp_nombre VARCHAR(45) NOT NULL,
    emp_apellido VARCHAR(45) NOT NULL,
    emp_edad INT NOT NULL,
    emp_correo VARCHAR(50) NOT NULL,
    emp_telefono VARCHAR(10),
    emp_direccion VARCHAR(50),
    emp_tipoEmpleado VARCHAR(45) NOT NULL,
    emp_cargo VARCHAR(50) NOT NULL,
	emp_contrasena BLOB DEFAULT NULL
    );
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA EDIFICIOS 
CREATE TABLE edificio(
	edf_id INT NOT NULL PRIMARY KEY,
    edf_nombre VARCHAR(45) NOT NULL,
    edf_numSalones INT NOT NULL,
    edf_sed_id INT NOT NULL,
    FOREIGN KEY(edf_sed_id) REFERENCES sede(sed_id)
	);
    
            
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA LABORATORIOS  
CREATE TABLE laboratorio(
	lab_id INT NOT NULL PRIMARY KEY,
    lab_capacidad INT NOT NULL,
    lab_nombre VARCHAR(45),
    lab_tipoLaboratorio VARCHAR(45) NOT NULL,
    lab_edf_id INT NOT NULL,
    lab_ayudante INT NOT NULL,
    FOREIGN KEY (lab_edf_id) REFERENCES edificio(edf_id),
    FOREIGN KEY (lab_ayudante) REFERENCES empleado(emp_cedula)
	);
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ENTRE LABORATORIOS Y EQUIPOS
CREATE TABLE equipos_laboratorio(
	eql_lab_id INT NOT NULL,
    eql_equ_id INT NOT NULL,
    FOREIGN KEY (eql_lab_id) REFERENCES laboratorio(lab_id),
    FOREIGN KEY (eql_equ_id) REFERENCES equipo(equ_id)
	);
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ENTRE LABORATORIO Y PROYECTO
CREATE TABLE laboratorio_proyecto(
	lap_lab_id INT NOT NULL,
    lap_pry_id INT NOT NULL,
    FOREIGN KEY (lap_lab_id) REFERENCES laboratorio(lab_id),
    FOREIGN KEY (lap_pry_id) REFERENCES proyecto(pry_id)
	);

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ENTRE FACULTAD Y SEDE
CREATE TABLE facultad_sede(
	fas_sed_id INT NOT NULL,
	fas_fac_id INT NOT NULL,
    FOREIGN KEY(fas_fac_id) REFERENCES facultad(fac_id),
    FOREIGN KEY(fas_sed_id) REFERENCES sede(sed_id)
	);
            
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ENTRE BIBLIOTECA Y PUBLICACIÓN
CREATE TABLE existencia(
	exi_bib_id INT NOT NULL,
    exi_pub_edi_id INT NOT NULL,
    exi_pub_pap_id INT NOT NULL,
    FOREIGN KEY(exi_bib_id) REFERENCES biblioteca(bib_id),
    FOREIGN KEY(exi_pub_edi_id) REFERENCES publicacion(pub_edi_id),
    FOREIGN KEY(exi_pub_pap_id) REFERENCES publicacion(pub_pap_id)

	);
	
-- *************************************************************************************************************************************************************
-- FIN DEL SCRIPT        




    

    


