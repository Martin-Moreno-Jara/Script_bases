-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA SEDE
INSERT INTO sede(sed_id,sed_nombre,sed_ubicacion)
	VALUES	(1,'sede Bogotá','Bogotá'),(2,'sede Medellín','Medellín'),(3,'sede Manizales','Manizales'),
            (4,'sede Palmira','Valle del Cauca'),(5,'sede de La Paz','Valledupar'),(6,'sede Amazonia','Leticia'),
            (7,'sede Orinoquia','Orinoquia'),(8,'sede Caribe','San Andrés'),(9,'sede Tumaco','Nariño');
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA FACULTAD
    INSERT INTO facultad(fac_id,fac_nombre)
    VALUES	(1,'Ingenieria'),(2,'Derecho, ciencias políticas y sociales'),
            (3,'Ciencias humanas'),(4,'Medicina'),(5,'Ciencias'),(6,'Artes'),
            (7,'Veterinaria y Zootecnia'),(8,'Odontologia'),(9,'Enfermeria'),
            (10,'Ciencias agrarias'),(11,'Ciencias económicas');
            
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA DEPARTAMENTO
 INSERT INTO departamento(dep_id,dep_nombre,dep_fac_id)
    VALUES 	(1,'Civil y agrícola',1),(2,'Sistema e industrial',1),(3,'Eléctrica y Electrónica',1),
            (4,'Mecánica y mecatrónica',1),(5,'Quimica y ambiental',1),(6,'Civil y agrícola',1),
            (7,'Derecho',2),(8,'Ciencia política',2),(9,'Antropología',3),
            (10,'Psicología',3),(11,'Filosofía',3),(12,'Salud pública',4),
            (13,'Escuela de educación médica',4),(14,'Arquitectura',6),(15,'Música',6),
            (16,'Artes plásticas',6),(17,'Salud animal',7),(18,'Producción animal',7),
            (19,'Salud oral',8),(20,'Enfermería',9),(21,'Agronomía',10),
            (22,'Administración y contaduría pública',11),(23,'Economía',11);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA PROGRAMA ACADÉMICO
    INSERT INTO programa_academico(prg_id,prg_nombre,prg_cantidadCreditos,prg_tipoPrograma,prg_dep_id)
    VALUES	(1,'Ingenieria de sistemas y computación',64,'Pregrado',2),(2,'Ingenieria civil',70,'Pregrado',1),
            (3,'Derecho',65,'Pregrado',7),(4,'Ciencia política',65,'Pregrado',8),
            (5,'Derecho administrativo',68,'Posgrado',7),(6,'Antropología',68,'Pregrado',9),
            (7,'Filosofía ',68,'Pregrado',11),(8,'Psicología',68,'Pregrado',10),
            (9,'Infecciones y salud en el trópico',68,'Posgrado',12),(10,'Medicina',68,'Pregrado',13),
            (11,'Música',68,'Pregrado',15),(12,'Arquitectura',68,'Pregrado',14),
            (13,'Musicoterapia',68,'Pregrado',15),(14,'Veterinaria',68,'Pregrado',17),
            (15,'Administración de empresas',68,'Pregrado',22),(16,'Contaduría pública ',68,'Pregrado',22),
            (17,'Economía',68,'Pregrado',23);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA EQUIPO
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
-- INSERCIÓN DE DATOS EN LA TABLA PROFESOR
	INSERT INTO profesor(pro_cedula,pro_nombre,pro_apellido,pro_edad,pro_correo,pro_telefono,pro_direccion,pro_tipoProfesor, pro_tituloPregrado,pro_tituloPosgrado,pro_contrasena)
    VALUES	(1,'Alberto','Martinez',58,'albmar@unal.edu.co','12312445','Cra 93b # 56a','Planta','Ingeniería industrial','Maestria en ingeniería industrial',aes_encrypt('123','clave')),
			(2,'Juan','Armando',25,'juanj@unal.edu.co','12312445','Cra 21b # 56a','Planta','Ingeniería Sistemas','Maestria en ingeniería sistemas',aes_encrypt('123','clave')),
	(3,'Felipe','Fonseca',30,'felipeg@unal.edu.co','12312445','Cra 93b # 56a','Catedra','Ingeniería Quimica','Maestria en ingeniería Quimica',aes_encrypt('123','clave')),
	(4,'Gabriel','Guerrero',55,'gabrielg@unal.edu.co','12312445','Cra 93b # 56a','Planta','Ciencias humanas','Maestria en ciencias humanas',aes_encrypt('123','clave')),
	(5,'Luis','Suarez',28,'luis@unal.edu.co','12312445','Cra 93b # 56a','Planta','Ingeniería Sistemas','Maestria en ingeniería sistemas',aes_encrypt('123','clave')),
	(6,'Gustavo','Gattuso',58,'gustavog@unal.edu.co','12312445','Cra 93b # 56a','Planta','Ingeniería industrial','Maestria en ingeniería industrial',aes_encrypt('123','clave')),
	(7,'Martin','Moreno',58,'martinm@unal.edu.co','12312445','Cra 93b # 56a','Planta','Ingeniería industrial','Maestria en ingeniería industrial',aes_encrypt('123','clave')),
	(8,'Enrique','Peña',58,'enriquee@unal.edu.co','12312445','Cra 93b # 56a','Catedra','Ingenieria Mecanica','Maestria en ingeniería mecanica',aes_encrypt('123','clave')),
	(9,'Sandra','Sierra',58,'sandras@unal.edu.co','12312445','Cra 93b # 56a','Planta','Medicina','Maestria en Medicina',aes_encrypt('123','clave')),
	(10,'Mariana','Mendez',58,'marianam@unal.edu.co','12312445','Cra 93b # 56a','Planta','Medicina Veterinaria','Maestria en Medicina Veterinaria',aes_encrypt('123','clave'));
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA EMPLEADO
	INSERT INTO empleado (emp_cedula,emp_nombre,emp_apellido,emp_edad,emp_correo,emp_telefono,emp_direccion,emp_tipoEmpleado,emp_cargo,emp_contrasena)
    VALUES (1,'Hernando','Rodriguez',42,'HernanRo@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave')),
		(2,'Ricardo','Rojas',26,'ricardor@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave')),
		(3,'Camilo','Cruz',56,'cruzc@unal.edu.co','1234512221','Cra 34 #54','Gerente','Vicerrector',aes_encrypt('123','clave')),
		(4,'Jose','Sanabria',32,'sanabrias@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave')),
		(5,'Josep','Guardiola',39,'guardiola@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave')),
		(6,'Roberto','De Zerbi',39,'Roberto@unal.edu.co','1234512221','Cra 34 #54','Gerente','Ayudante de Vicerrector',aes_encrypt('123','clave')),
		(7,'Maria','Mendez',50,'mariam@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave')),
		(8,'Gustavo','Fring',45,'Gus@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave')),
		(9,'Mayerly','Martinez',39,'mayerlym@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave')),
		(10,'David','Moyes',29,'davidm@unal.edu.co','1234512221','Cra 34 #54','Asitente','Ayudante de laboratorio',aes_encrypt('123','clave'));
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA SEMILLERO
    INSERT INTO semillero(sem_id,sem_nombre,sem_area,sem_lider)
    VALUES	(1,'TULLPA','Agricultura',1),
    (2,'semillero1','informatica',4),
		(3,'semillero2','informatica',5),
		(4,'semillero3','informatica',8),
		(5,'semillero4','informatica',2),
		(6,'semillero5','informatica',7);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA GRUPO DE INVESTIGACIÓN
    INSERT INTO grupo_investigacion(gru_id,gru_nombre,gru_area,gru_lider,gru_contrasena)
    VALUES (1,'MIDAS','Mineria de datos',1,aes_encrypt('123','clave')),
    (2,'5G','Computacion Cientifica',9,aes_encrypt('123','clave')),
		(3,'Uqbar','Seguridad Informatica',5,aes_encrypt('123','clave')),
		(4,'CSI','Criminalistica/Medicina Forense',3,aes_encrypt('123','clave')),
		(5,'Materials','Ciencia de materiles avanzados',7,aes_encrypt('123','clave')),
		(6,'Sistemas simbioticos','Biologia/Ecología',6,aes_encrypt('123','clave'));
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA ESTUDIANTE
    INSERT INTO estudiante(est_cedula, est_nombre,est_apellido, est_edad, est_correo, est_telefono,est_direccion,est_tipoEstudiante,est_gru_id, est_prg_id,est_sem_id,est_contrasena)
    VALUES(1,'Jose','Gonzales',18,'josego@unal.edu.co','310311222','Cra 45a #56','Pregrado',1,1,1,aes_encrypt('123','clave'))
    ,(2,'Jonas','Jimenez',22,'jonasj@unal.edu.co','310311222','Cra 50 #58','Pregrado',2,3,2,aes_encrypt('321','clave')),
		(3,'Julia','Martinez',17,'juliaj@unal.edu.co','310311222','Cra 78a #98','Pregrado',5,5,3,aes_encrypt('123','clave')),
		(4,'Gonzalo','Ramirez',20,'gonzog@unal.edu.co','310311222','Cra 30 #32','Posgrado',3,3,2,aes_encrypt('456','clave')),
		(5,'Kevin','De Bruyne',23,'kevinK@unal.edu.co','310311222','Cra 75b #55','Pregrado',6,8,4,aes_encrypt('654','clave')),
		(6,'Declan','Rice',25,'declan@unal.edu.co','310311222','Cra 45a #68','Pregrado',4,6,1,aes_encrypt('123','clave')),
		(7,'Paulo','Hernandez',18,'paulos@unal.edu.co','310311222','Cra 80 #43','Posgrado',2,7,5,aes_encrypt('789','clave')),
		(8,'Julian','Alvarez',17,'julian@unal.edu.co','310311222','Cra 59a #10','Posgrado',1,10,1,aes_encrypt('987','clave')),
		(9,'Erling','Haaland',17,'erling@unal.edu.co','310311222','Cra 22a #45','Pregrado',2,11,5,aes_encrypt('123','clave')),
		(10,'Toni','Kroos',20,'toni@unal.edu.co','310311222','Cra 45a #56','Posgrado',6,12,6,aes_encrypt('123','clave'));
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA PROYECTO
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
-- INSERCIÓN DE DATOS EN LA TABLA PAPER
    INSERT INTO paper(pap_id,pap_titulo,pap_numPaginas,pap_tema,pap_pry_id)
    VALUES (1,'Hechos de la mineria de datos sobre bitcoin',28,'Mineria de datos',1),
    (2,'Estudio en células madres',208,'Biología molecular',2),
		(3,'El arte de la zoologóa',38,'Zoología',3),
		(4,'Sociedad y nosotros',28,'Sociología',4),
		(5,'Ensayo sobre la depresión',8,'Psicología',5),
		(6,'Peces del pacífico',63,'Matemáticas',6),
		(7,'Matrices en la vida diaria',13,'tema4',7),
		(8,'Aplicaciones de la inteligencia artificial',52,'tema2',8),
		(9,'Arte contemporaneo y moderno',666,'tema3',9),
		(10,'Campesinado colombiano',88,'tema2',1),
		(11,'Matemáticas del nuevo milenio',77,'tema5',2),
		(12,'Industria farmaceutica en Colombia',38,'tema3',3),
		(13,'Desigualdad y meritocracia',28,'tema4',4),
		(14,'Música del siglo XVIII',8,'tema3',5),
		(15,'Ensayo de la revolución cubana',63,'tema5',6),
		(16,'Cuarta revolución industrial',13,'tema4',7),
		(17,'Clonación de células madre',52,'tema2',8),
		(18,'Nuevas teconologías en Colombia',666,'tema3',9),
		(19,'Problemas de la alimentación colombiana',88,'tema2',1),
		(20,'Ensayo de la ceguera',77,'tema5',2);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA EDITORIAL
    INSERT INTO editorial(edi_id,edi_nombre,edi_direccion,edi_telefono)
    VALUES(1,'Pinguin','Cra 50 #26','3158821011'),
    (2,'Elmatador','Cra 25 #13','3158821011'),
		(3,'M&M','Cra 60 #52','3158821011');
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA PUBLICACIÓN
INSERT INTO publicacion(pub_edi_id,pub_pap_id,pub_fechaPublicacion)
    VALUES(1,1,'2020-10-01'),(1,2,'2020-10-01'),(2,3,'2020-10-01'),(3,4,'2020-10-01'),
		(1,5,'2020-10-01'),(2,6,'2020-10-01'),(3,7,'2020-10-01'),(1,8,'2020-10-01'),
		(2,9,'2020-10-01'),(3,10,'2020-10-01'),(1,11,'2020-10-01'),(2,12,'2020-10-01'),
		(3,13,'2020-10-01'),(1,14,'2020-10-01'),(2,15,'2020-10-01'),(3,16,'2020-10-01');
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA BIBLIOTECA
	INSERT INTO biblioteca(bib_id,bib_nombre)
    VALUES (1,'Hermes'),(2,'Diomedez'),(3,'Gabriel Garcia Marques'),
		(4,'Apolo'),(5,'Creed'),(6,'C&T');
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA EDIFICIO
    INSERT INTO edificio(edf_id,edf_nombre,edf_numSalones,edf_sed_id) 
    VALUES	(1,'Yu takeuchi',30,1),
			(2,'Patios de ingenieria',20,1),(3,'Edificio3',30,2),
		(4,'Aulas de ingeniería',30,2),
		(5,'Posgrados de humanas',30,3),
		(6,'C y T',30,3),
		(7,'Julio Garavito',30,4),
		(8,'Hemeroteca',30,4),
		(9,'Edificio de enfermería',30,5),
		(10,'Edificio de medicina',30,5),
		(11,'Edificio de ciencias',30,6),
		(12,'Edificio de agronomía',30,6),
		(13,'IPARM',30,7),
		(14,'Edificio de Quimica',30,7),
		(15,'Edificio de odontología',30,8);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA LABORATORIO
    INSERT INTO laboratorio(lab_id,lab_capacidad,lab_nombre,lab_tipoLaboratorio,lab_edf_id,lab_ayudante)
    VALUES (1,23,'Laboratorio Curie','Física',1,1),(2,23,'L2','Física',2,2),
		(3,23,'Lab3','Quimica',3,3),
		(4,23,'L4','Física',4,4),
		(5,23,'L5','Física',5,5),
		(6,23,'L6','Quimica',6,6),
		(7,23,'L7','Física',7,7),
		(8,23,'L8','Quimica',8,8),
		(9,23,'L9','Física',9,9),
		(10,23,'L10','Electrónica',10,10),
		(11,23,'L11','Electrónica',11,1),
		(12,23,'L12','Física',12,2),
		(13,23,'L13','Sistemas',13,3);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA EQUIPO LABORATORIO
	INSERT INTO equipos_laboratorio(eql_lab_id,eql_equ_id)
    VALUES	(1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(9,1),(10,1),(11,1),(12,1),(13,1),
			(2,2),(3,2),(4,2),(5,2),(6,2),(7,2),(9,2),(10,2),(11,2),(12,2),(13,2),(2,5),
            (3,5),(4,5),(5,5),(6,5),(7,5),(9,5),(10,5),(11,5),(12,5),(13,5);
        
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA LABORATORIO PROYECTO
    INSERT INTO laboratorio_proyecto(lap_lab_id,lap_pry_id)
    VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),
			(8,8),(9,9),(10,1),(11,4),(12,2),(13,3);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA FACULTAD-SEDE
 INSERT INTO facultad_sede(fas_sed_id,fas_fac_id)
			VALUES	(1,1),(2,1),(2,2),(2,3),(2,4),(2,5),(2,6),(2,7),(2,8),(2,9),(2,10),(2,11),
			(3,1),(3,2),(3,3),(3,4),(3,5),(3,6),(3,7),(3,8),(3,9),(3,10),(3,11),(4,1),
			(4,2),(4,3),(4,4),(4,5),(4,6),(4,7),(4,8),(4,9),(4,10),(4,11),(5,1),(5,2),
            (5,3),(5,4),(5,5),(5,6),(5,7),(5,8),(5,9),(5,10),(5,11);
-- *************************************************************************************************************************************************************
-- INSERCIÓN DE DATOS EN LA TABLA EXISTENCIA
     INSERT INTO existencia (exi_bib_id,exi_pub_edi_id,exi_pub_pap_id)
    VALUES 	(1,1,1),(1,1,2),(2,2,3),(3,3,4),(4,1,5),(5,2,6),(6,3,7),(1,1,8),(2,2,9),
            (3,3,10),(4,1,11),(5,2,12),(6,3,13),(1,1,14),(2,2,15),(3,3,16);
-- *************************************************************************************************************************************************************
-- FIN DEL SCRIPT