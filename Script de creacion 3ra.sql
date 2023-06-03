CREATE SCHEMA investigacion;
use Investigacion;
-- drop schema investigacion;
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA SEDE
CREATE TABLE sede(
	sed_id INT NOT NULL PRIMARY KEY,
    sed_nombre VARCHAR(45) NOT NULL,
    sed_ubicacion VARCHAR(45) NOT NULL,
    sed_numEstudiantes INT
	);
	
INSERT INTO sede(sed_id,sed_nombre,sed_ubicacion,sed_numEstudiantes)
	VALUES	(1,'sede Bogotá','Bogotá',40000),
			(2,'sede Medellín','Medellín',12437),
            (3,'sede Manizales','Manizales',10000),
            (4,'sede Palmira','Valle del Cauca',5000),
            (5,'sede de La Paz','Valledupar',5240),
            (6,'sede Amazonia','Leticia',2500),
            (7,'sede Orinoquia','Orinoquia',2000),
            (8,'sede Caribe','San Andrés',2000),
            (9,'sede Tumaco','Nariño',2750);
            
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA FACULTDAD
CREATE TABLE facultad(
	fac_id INT NOT NULL PRIMARY KEY,
    fac_nombre VARCHAR(45) NOT NULL
	);
    
    INSERT INTO facultad(fac_id,fac_nombre)
    VALUES	(1,'Ingenieria'),
			(2,'Derecho, ciencias políticas y sociales'),
            (3,'Ciencias humanas'),
            (4,'Medicina'),
            (5,'Ciencias'),
            (6,'Artes'),
            (7,'Veterinaria y Zootecnia'),
            (8,'Odontologia'),
            (9,'Enfermeria'),
            (10,'Ciencias agrarias'),
            (11,'Ciencias económicas');


-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA DEPARTAMENTO
CREATE TABLE departamento(
	dep_id INT NOT NULL PRIMARY KEY,
    dep_nombre  VARCHAR(45),
    dep_numGrupos INT NOT NULL,
    dep_fac_id INT NOT NULL,
    FOREIGN KEY(dep_fac_id) REFERENCES facultad(fac_id)
	);
    
    INSERT INTO departamento(dep_id,dep_nombre,dep_numGrupos,dep_fac_id)
    VALUES 	(1,'Civil y agrícola',3,1),
			(2,'Sistema e industrial',10,1),
			(3,'Eléctrica y Electrónica',5,1),
            (4,'Mecánica y mecatrónica',3,1),
            (5,'Quimica y ambiental',3,1),
            (6,'Civil y agrícola',3,1),
            (7,'Derecho',3,2),
			(8,'Ciencia política',3,2),
            (9,'Antropología',5,3),
            (10,'Psicología',3,3),
            (11,'Filosofía',3,3),
            (12,'Salud pública',10,4),
            (13,'Escuela de educación médica',15,4),
            (14,'Arquitectura',3,6),
            (15,'Música',3,6),
            (16,'Artes plásticas',3,6),
            (17,'Salud animal',3,7),
            (18,'Producción animal',3,7),
            (19,'Salud oral',3,8),
            (20,'Enfermería',3,9),
            (21,'Agronomía',3,10),
            (22,'Administración y contaduría pública',3,11),
            (23,'Economía',3,11);
            
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
    
    INSERT INTO programa_academico(prg_id,prg_nombre,prg_cantidadCreditos,prg_tipoPrograma,prg_dep_id)
    VALUES	(1,'Ingenieria de sistemas y computación',64,'Pregrado',2),
			(2,'Ingenieria civil',70,'Pregrado',1),
            (3,'Derecho',65,'Pregrado',7),
            (4,'Ciencia política',65,'Pregrado',8),
            (5,'Derecho administrativo',68,'Posgrado',7),
            (6,'Antropología',68,'Pregrado',9),
            (7,'Filosofía ',68,'Pregrado',11),
            (8,'Psicología',68,'Pregrado',10),
            (9,'Infecciones y salud en el trópico',68,'Posgrado',12),
            (10,'Medicina',68,'Pregrado',13),
            (11,'Música',68,'Pregrado',15),
            (12,'Arquitectura',68,'Pregrado',14),
            (13,'Musicoterapia',68,'Pregrado',15),
            (14,'Veterinaria',68,'Pregrado',17),
            (15,'Administración de empresas',68,'Pregrado',22),
            (16,'Contaduría pública ',68,'Pregrado',22),
            (17,'Economía',68,'Pregrado',23);
            
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA DE EQUIPOS DE LABORATORIO
CREATE TABLE equipo(
	equ_id INT NOT NULL PRIMARY KEY,
    equ_nom VARCHAR(45) NOT NULL,
    equ_CantidadElementos INT
	);
    
    INSERT INTO equipo(equ_id,equ_nom,equ_CantidadElementos)
    VALUES 	(1,'Medición de temperatura',4),
			(2,'Ensamblaje de hardware',8),
            (3,"Dinámica",5),
            (4,'Microscopio',8),
				(5,'Tubo de ensayo',15),
            	(6,'Rejilla',7),
				(7,'Probeta',9),
				(8,'Placa de petri',11),
            	(9,'Bascula',6),
				(10,'Relojes medicos',20),
				(11,'Tiras reactivas',13),
            	(12,'Computadores Intel Cori9',10),
				(13,'Marcadores',13),
				(14,'Mesas',12),
            	(15,'Resistencias',6);

		
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA DE SEMILLEROS DE INVESTIGACIÓN
CREATE TABLE semillero(
	sem_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sem_nombre VARCHAR(50) NOT NULL,
    sem_numIntegrantes INT DEFAULT 0,
    sem_area VARCHAR(45) NOT NULL,
    sem_lider INT NOT NULL
	);
    
    INSERT INTO semillero(sem_id,sem_nombre,sem_numIntegrantes,sem_area,sem_lider)
    VALUES	(1,'TULLPA',20,'Agricultura',1),
    (2,'semillero1',10,'informatica',4),
		(3,'semillero2',9,'informatica',5),
		(4,'semillero3',12,'informatica',8),
		(5,'semillero4',33,'informatica',2),
		(6,'semillero5',7,'informatica',7);

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA GRUPOS DE INVESTIGACIÓN
CREATE TABLE grupo_investigacion(
	gru_id INT NOT NULL PRIMARY KEY,
	gru_nombre VARCHAR(45) NOT NULL,
    gru_numIntegrantes INT DEFAULT 0,
    gru_numPapers INT DEFAULT 0,
    gru_area VARCHAR(45) NOT NULL,
    gru_numProyectos INT DEFAULT 0,
    gru_lider INT NOT NULL
	);
    
    INSERT INTO grupo_investigacion(gru_id,gru_nombre,gru_numIntegrantes,gru_numPapers,gru_area,gru_numProyectos,gru_lider)
    VALUES (1,'MIDAS',25,13,'Mineria de datos',13,1),
    (2,'5G',25,13,'Computacion Cientifica',33,9),
		(3,'Uqbar',35,5,'Seguridad Informatica',10,5),
		(4,'CSI',11,20,'Criminalistica/Medicina Forense',9,3),
		(5,'Materials',18,13,'Ciencia de materiles avanzados',3,7),
		(6,'Sistemas simbioticos',7,6,'Biologia/Ecología',3,6);

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA PROYECTOS
CREATE TABLE proyecto(
	pry_id INT NOT NULL PRIMARY KEY,
    pry_nombre VARCHAR(45) NOT NULL,
    pry_propuesta VARCHAR(45) NOT NULL,
    pry_estado VARCHAR(45) NOT NULL,
    pry_fechaInicio DATE NOT NULL,
    pry_fechaFin DATE,
    pry_gru_id INT NOT NULL,
    FOREIGN KEY(pry_gru_id) REFERENCES grupo_investigacion(gru_id)
	);
    INSERT INTO proyecto(pry_id,pry_nombre,pry_propuesta,pry_estado,pry_fechaInicio,pry_gru_id)
    VALUES (1,'Crypto mineria','Mineria de bitcoins','Aceptado','2021-01-03',1),
    (2,'Biodiversidad','Biologia/Ecología','Aceptado','2021-01-03',6),
		(3,'Crypto mineria','Mineria de bitcoins','Negado','2021-01-03',1),
		(4,'Hacking','Computacion Cientifica','Aceptado','2021-01-03',2),
		(5,'Minory Report','Criminalistica/Medicina Forense','Aceptado','2021-01-03',4),
		(6,'Cobre','Ciencia de materiles avanzados','Negado','2021-01-03',5),
		(7,'Hacking2','Computacion Cientifica','Aceptado','2021-01-03',2),
		(8,'Hierro','Ciencia de materiles avanzados','Negado','2021-01-03',5),
		(9,'La ley y el orden UVE','Criminalistica/Medicina Forense','Aceptado','2021-01-03',4);

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
    
    INSERT INTO paper(pap_id,pap_titulo,pap_numPaginas,pap_tema,pap_pry_id)
    VALUES (1,'Hechos de la mineria de datos sobre bitcoin',28,'Mineria de datos',1),
    (2,'p2',208,'tema2',2),
		(3,'p3',38,'tema3',3),
		(4,'p4',28,'tema4',4),
		(5,'p5',8,'tema3',5),
		(6,'p6',63,'tema5',6),
		(7,'p7',13,'tema4',7),
		(8,'p8',52,'tema2',8),
		(9,'p9',666,'tema3',9),
		(10,'p10',88,'tema2',1),
		(11,'p11',77,'tema5',2),
		(12,'p12',38,'tema3',3),
		(13,'p13',28,'tema4',4),
		(14,'p14',8,'tema3',5),
		(15,'p15',63,'tema5',6),
		(16,'p16',13,'tema4',7),
		(17,'p17',52,'tema2',8),
		(18,'p18',666,'tema3',9),
		(19,'p19',88,'tema2',1),
		(20,'p20',77,'tema5',2);
	
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA EDITORIALES
CREATE TABLE editorial(
	edi_id INT NOT NULL PRIMARY KEY,
    edi_nombre VARCHAR(45) NOT NULL,
    edi_direccion VARCHAR(45) NOT NULL,
    edi_numPapers INT DEFAULT 0,
    edi_telefono VARCHAR(45)
	);
    
    INSERT INTO editorial(edi_id,edi_nombre,edi_direccion,edi_numPapers,edi_telefono)
    VALUES(1,'Pinguin','Cra 50 #26',10,'3158821011'),
    (2,'Elmatador','Cra 25 #13',15,'3158821011'),
		(3,'M&M','Cra 60 #52',20,'3158821011');

    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA PUBLICACIONES
CREATE TABLE publicacion(
	pub_edi_id INT NOT NULL,
    pub_pap_id INT NOT NULL,
	pub_fechaPublicacion DATE NOT NULL,
    FOREIGN KEY(pub_edi_id) REFERENCES editorial(edi_id),
    FOREIGN KEY(pub_pap_id) REFERENCES paper(pap_id)
    );
	INSERT INTO publicacion(pub_edi_id,pub_pap_id,pub_fechaPublicacion)
    VALUES(1,1,'2020-10-01'),
    (1,2,'2020-10-01'),
		(2,3,'2020-10-01'),
		(3,4,'2020-10-01'),
		(1,5,'2020-10-01'),
		(2,6,'2020-10-01'),
		(3,7,'2020-10-01'),
		(1,8,'2020-10-01'),
		(2,9,'2020-10-01'),
		(3,10,'2020-10-01'),
		(1,11,'2020-10-01'),
		(2,12,'2020-10-01'),
		(3,13,'2020-10-01'),
		(1,14,'2020-10-01'),
		(2,15,'2020-10-01'),
		(3,16,'2020-10-01');
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA BIBLIOTECAS
CREATE TABLE biblioteca(
	bib_id INT NOT NULL PRIMARY KEY,
    bib_nombre VARCHAR(45) NOT NULL
	);

	INSERT INTO biblioteca(bib_id,bib_nombre)
    VALUES (1,'Hermes'),
    (2,'Diomedez'),
		(3,'Gabriel Garcia Marques'),
		(4,'Apolo'),
		(5,'Creed'),
		(6,'C&T');
    
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
    est_gru_id INT,
    est_prg_id INT NOT NULL,
    est_sem_id INT,
    est_contrasena VARCHAR(50),
    FOREIGN KEY (est_gru_id) REFERENCES grupo_investigacion(gru_id),
    FOREIGN KEY (est_prg_id)  REFERENCES programa_academico(prg_id),
    FOREIGN KEY (est_sem_id)  REFERENCES semillero(sem_id)
    );
    
    INSERT INTO estudiante(est_cedula, est_nombre,est_apellido, est_edad, est_correo, est_telefono,est_direccion,est_fechaVinculacion,est_tipoEstudiante,est_gru_id, est_prg_id,est_sem_id)
    VALUES(1,'Jose','Gonzales',18,'josego@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Pregrado',1,1,1)
    ,(2,'Jonas','J',18,'jonasj@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Pregrado',2,3,2),
		(3,'Julia','J',18,'juliaj@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Pregrado',5,5,3),
		(4,'Gonzo','G',18,'gonzog@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Posgrado',3,3,2),
		(5,'Kevin','K',18,'kevinK@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Pregrado',6,8,4),
		(6,'Bruin','B',18,'bruinb@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Pregrado',4,6,1),
		(7,'Zapato','Z',18,'zapatoz@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Posgrado',2,7,5),
		(8,'Spike','S',18,'spikes@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Posgrado',1,10,1),
		(9,'Bruce','B',18,'bruceb@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Pregrado',2,11,5),
		(10,'Tony','T',18,'tonyt@unal.edu.co','310311222','Cra 45a #56','2022-01-01','Posgrado',6,12,6);
    

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
    pro_tituloPregrado VARCHAR(45) NOT NULL,
    pro_tituloPosgrado VARCHAR(45),
    pro_gru_id INT,
    pro_sem_id INT,
    pro_contrasena VARCHAR(50),
    FOREIGN KEY (pro_gru_id) REFERENCES grupo_investigacion(gru_id),
	FOREIGN KEY (pro_sem_id)  REFERENCES semillero(sem_id)
	);
	INSERT INTO profesor(pro_cedula,pro_nombre,pro_apellido,pro_edad,pro_correo,pro_telefono,pro_direccion,pro_fechaVinculacion,pro_tipoProfesor, pro_tituloPregrado,pro_tituloPosgrado, pro_horasSemanales,pro_salario)
    VALUES	(1,'Alberto','Martinez',58,'albmar@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Planta','Ingeniería industrial','Maestria en ingeniería industrial',30,3000000),
			(2,'Juan','A',25,'juanj@unal.edu.co','12312445','Cra 21b # 56a','2009-10-01','Planta','Ingeniería Sistemas','Maestria en ingeniería sistemas',30,3000000),
	(3,'Felipe','F',30,'felipeg@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Catedra','Ingeniería Quimica','Maestria en ingeniería Quimica',30,3000000),
	(4,'Gabriel','G',55,'gabrielg@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Planta','Ciencias humanas','Maestria en ciencias humanas',30,3000000),
	(5,'Luis','L',28,'luisl@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Planta','Ingeniería Sistemas','Maestria en ingeniería sistemas',30,3000000),
	(6,'Gustavo','G',58,'gustavog@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Planta','Ingeniería industrial','Maestria en ingeniería industrial',30,3000000),
	(7,'Martin','M',58,'martinm@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Planta','Ingeniería industrial','Maestria en ingeniería industrial',30,3000000),
	(8,'Enrique','E',58,'enriquee@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Catedra','Ingenieria Mecanica','Maestria en ingeniería mecanica',30,3000000),
	(9,'Sandra','S',58,'sandras@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Planta','Medicina','Maestria en Medicina',30,3000000),
	(10,'Mariana','M',58,'marianam@unal.edu.co','12312445','Cra 93b # 56a','2008-10-01','Planta','Medicina Veterinaria','Maestria en Medicina Veterinaria',30,3000000);

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
    emp_salario INT NOT NULL,
    emp_cargo VARCHAR(50) NOT NULL,
	emp_contrasena VARCHAR(50)
    );
	INSERT INTO empleado (emp_cedula,emp_nombre,emp_apellido,emp_edad,emp_correo,emp_telefono,emp_direccion,emp_fechaVinculacion,emp_tipoEmpleado,emp_salario,emp_cargo,emp_horasSemanales)
    VALUES (1,'Hernando','Rodriguez',39,'HernanRo@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25),
    (2,'Ricardo','R',39,'ricardor@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25),
		(3,'Cruz','C',39,'cruzc@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Gerente',1800000,'Vicerrector',25),
		(4,'Sanabria','S',39,'sanabrias@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25),
		(5,'Tomas','T',39,'tomast@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25),
		(6,'Camila','C',39,'camilac@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Gerente',1800000,'Ayudante de Vicerrector',25),
		(7,'Maria','M',39,'mariam@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25),
		(8,'Jessica','J',39,'jessicaj@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25),
		(9,'Mayerly','M',39,'mayerlym@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25),
		(10,'David','D',39,'davidd@unal.edu.co','1234512221','Cra 34 #54','2019-10-10','Asitente',1800000,'Ayudante de laboratorio',25);
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA EDIFICIOS 
CREATE TABLE edificio(
	edf_id INT NOT NULL PRIMARY KEY,
    edf_nombre VARCHAR(45) NOT NULL,
    edf_numSalones INT NOT NULL,
    edf_sed_id INT NOT NULL,
    FOREIGN KEY(edf_sed_id) REFERENCES sede(sed_id)
	);
    
    INSERT INTO edificio(edf_id,edf_nombre,edf_numSalones,edf_sed_id) 
    VALUES	(1,'Yu takeuchi',30,1),
			(2,'Patios de ingenieria',20,1),(3,'Edificio3',30,2),
		(4,'Edificio4',30,2),
		(5,'Edificio5',30,3),
		(6,'Edificio6',30,3),
		(7,'Edificio7',30,4),
		(8,'Edificio8',30,4),
		(9,'Edificio9',30,5),
		(10,'Edificio10',30,5),
		(11,'Edificio11',30,6),
		(12,'Edificio12',30,6),
		(13,'Edificio13',30,7),
		(14,'Edificio14',30,7),
		(15,'Edificio15',30,8),
		(16,'Edificio16',30,8),
		(17,'Edificio17',30,9),
		(18,'Edificio18',20,9);
            
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
    
    INSERT INTO laboratorio(lab_id,lab_capacidad,lab_nombre,lab_tipoLaboratorio,lab_edf_id,lab_ayudante)
    VALUES (1,23,'Laboratorio Curie','Física',1,1),(2,23,'L2','Física',2,2),
		(3,23,'L3','Física',3,3),
		(4,23,'L4','Física',4,4),
		(5,23,'L5','Física',5,5),
		(6,23,'L6','Física',6,6),
		(7,23,'L7','Física',7,7),
		(8,23,'L8','Física',8,8),
		(9,23,'L9','Física',9,9),
		(10,23,'L10','Física',10,10),
		(11,23,'L11','Física',11,1),
		(12,23,'L12','Física',12,2),
		(13,23,'L13','Física',13,3);
            

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ENTRE LABORATORIOS Y EQUIPOS
CREATE TABLE equipos_laboratorio(
	eql_lab_id INT NOT NULL,
    eql_equ_id INT NOT NULL,
    FOREIGN KEY (eql_lab_id) REFERENCES laboratorio(lab_id),
    FOREIGN KEY (eql_equ_id) REFERENCES equipo(equ_id)
	);
    
	INSERT INTO equipos_laboratorio(eql_lab_id,eql_equ_id)
    VALUES	(1,1),(2,1),
		(3,1),
		(4,1),
		(5,1),
		(6,1),
		(7,1),
		(9,1),
		(10,1),
		(11,1),
		(12,1),
		(13,1),
		(2,2),
		(3,2),
		(4,2),
		(5,2),
		(6,2),
		(7,2),
		(9,2),
		(10,2),
		(11,2),
		(12,2),
		(13,2),
		(2,5),
		(3,5),
		(4,5),
		(5,5),
		(6,5),
		(7,5),
		(9,5),
		(10,5),
		(11,5),
		(12,5),
		(13,5);
    
    
-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ENTRE LABORATORIO Y PROYECTO
CREATE TABLE laboratorio_proyecto(
	lap_lab_id INT NOT NULL,
    lap_pry_id INT NOT NULL,
    FOREIGN KEY (lap_lab_id) REFERENCES laboratorio(lab_id),
    FOREIGN KEY (lap_pry_id) REFERENCES proyecto(pry_id)
	);
    
    INSERT INTO laboratorio_proyecto(lap_lab_id,lap_pry_id)
    VALUES (1,1),(2,2),
		(3,3),
		(4,4),
		(5,5),
		(6,6),
		(7,7),
		(8,8),
		(9,9),
		(10,1),
		(11,4),
		(12,2),
		(13,3);

-- *************************************************************************************************************************************************************
-- CREACIÓN E INSERCIÓN DE DATOS EN LA TABLA ENTRE FACULTAD Y SEDE
CREATE TABLE facultad_sede(
	fas_sed_id INT NOT NULL,
	fas_fac_id INT NOT NULL,
    FOREIGN KEY(fas_fac_id) REFERENCES facultad(fac_id),
    FOREIGN KEY(fas_sed_id) REFERENCES sede(sed_id)
	);
    
    INSERT INTO facultad_sede (fas_sed_id,fas_fac_id)
    VALUES	
	    (1,1),(2,1),
			(2,2),
            (2,3),
            (2,4),
            (2,5),
            (2,6),
            (2,7),
            (2,8),
            (2,9),
            (2,10),
            (2,11),
	    (3,1),
			(3,2),
            (3,3),
            (3,4),
            (3,5),
            (3,6),
            (3,7),
            (3,8),
            (3,9),
            (3,10),
            (3,11),
	    (4,1),
			(4,2),
            (4,3),
            (4,4),
            (4,5),
            (4,6),
            (4,7),
            (4,8),
            (4,9),
            (4,10),
            (4,11),
	    (5,1),
			(5,2),
            (5,3),
            (5,4),
            (5,5),
            (5,6),
            (5,7),
            (5,8),
            (5,9),
            (5,10),
            (5,11);
            
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
        
     INSERT INTO existencia (exi_bib_id,exi_pub_edi_id,exi_pub_pap_id)
    VALUES 	(1,1,1),
		(1,1,2),
		(2,2,3),
		(3,3,4),
		(4,1,5),
		(5,2,6),
		(6,3,7),
		(1,1,8),
		(2,2,9),
		(3,3,10),
		(4,1,11),
		(5,2,12),
		(6,3,13),
		(1,1,14),
		(2,2,15),
		(3,3,16);

-- *************************************************************************************************************************************************************
-- FIN DEL SCRIPT        




    

    


