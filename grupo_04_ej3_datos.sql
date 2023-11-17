
/*			    INSERCIONES EN ESQUEMA ACTOR	                */
/*==============================================================*/

-- Inserción en la tabla actor.ocupacion
insert into actor.ocupacion values (1, 1001, 'Médico', 'Médico');

-- Inserción en la tabla actor.funcion
insert into actor.funcion values (1, 101, 'Inspector de Tránsito', 'Inspector Tránsito');

-- inseción en la tabla actor.tipo_persona_juridica
insert into actor.tipo_persona_juridica values (1, 101, 'Mercado Libre', 'MeLi');

-- Inserción en la tabla actor.pais
insert into actor.pais values (4, 'ARG', 'Argentina', 'Arg', 'argentino');

-- Inserción en la tabla actor.provincia_estado
insert into actor.provincia_estado values  (7, 4, 'BA', 'Buenos Aires', 'BSAS')

-- Inserción en la tabla actor.actor
insert into actor.actor values (8, 4, 1001, 20, 12345678, 9, 'fausto@gmail.com', '2023-09-12', null, '123-456-7890');

-- Inserción en la tabla actor.usuario
insert into actor.usuario values (10, 8, 'Juan99', 'Juan Perez','2023-09-12', 'as019askasdoa01', 1219123818, null);

-- Inserción en la tabla actor.rol
insert into actor.rol values (11, 8, 'INSPECTOR_TRANSITO', 201);

-- Inserción en la tabla actor.persona_fisica
insert into actor.persona_fisica values (12, 8, 1, 'D', 12345678, 'González', '1990-01-15', 'María', '123-456-7890', 'F', null, 'No', null, null, 'S');

-- Inserción en la tabla actor.departamento
insert into actor.departamento values (15, 7, 1, 101, 'San Nicolas de los Arroyos', 'San Nicolas');

-- Inserción en la tabla actor.localidad
insert into actor.localidad values (16, 15, 7, 1001, 'Conesa' , 'CNA', 90001);

-- Inserción en la tabla actor.direccion_actor
insert into actor.direccion_actor values (17, 8, 16, 1, 'Segurola 123', 'Segurola', null, 90001, null, null, null, null, null, null, 'CASA_CENTRAL');

--Inserción en la tabla actor.persona_juridica
INSERT INTO actor.persona_juridica VALUES (1, 8, 1, 'MyNombreFantasia', 'Responsable Inscripto');

--Inserción en la tabla actor.integra_persona_juridica
INSERT INTO actor.integra_persona_juridica VALUES (1, 1, 12, 1, 1234, '2022-05-16', null);

--Inserción en la tabla actor.organismo
INSERT INTO actor.organismo VALUES (1, 8, 'MyNombreOrganismo', 'MNO');

--Inserción en la tabla actor.integra_organismo
INSERT INTO actor.integra_organismo VALUES (19, 1, 1, 12, 8765, '1995-06-25', null);

/*			    INSERCIONES EN ESQUEMA SOLICITUD                */
/*==============================================================*/

-- Inserción en la tabla solicitud.motivo_rechazo
insert into solicitud.motivo_rechazo values (5, 501, 'Falta de documentacion requerida');

-- Incerción en la tabla solicitud.concepto_medico
insert into solicitud.concepto_medico values (1, 601, 'Concepto Médico 601');

-- Inserción en la tabla solicitud.solicitud_licencia_conducir
insert into solicitud.solicitud_licencia_conducir values (1, 1001, 12, 16, 10, null, 5, 'Calle 1', '2023-09-23', true, 'Sí', 'No', 'Sí', 'No', 'PROFESIONAL', 'Calle Principal', 'Dpto 101', 123, '2', NULL);

-- Inserción en la tabla solicitud.clase_licencia_conducir
insert into solicitud.clase_licencia_conducir values (4, 'D', 'Clase D', 40, 25, NULL, 'Observación Clase D', true, false);

-- Inserción en la tabla solicitud.clase_licencia_conducir_requerida
insert into solicitud.clase_licencia_conducir_requerida values (4, 4, 4, 1, 2);

-- Inserción en la tabla solicitud.liquidacion_solicitud_licencia_conducir 
insert into solicitud.liquidacion_solicitud_licencia_conducir values (1, 1, 10, 1001, '2023-09-23', '2023-09-24', '2023-10-23', 100.00, true, 'Tipo 1', 'USUARIO');


-- Inserción en la tabla solicitud.estado_solicitud 
insert into solicitud.estado_solicitud values (1, 1, 1, 'PRESENTADA', '2023-09-23');

-- Inserción en la tabla solicitud.solicitud_licencia_conductor_clase 
insert into solicitud.solicitud_licencia_conductor_clase values (1, 1, NULL, 4, 1, NULL, 'EXTRAVIO', '2023-09-23', NULL, NULL, 'Sí', 'No', 'Sí', NULL, 'APROBADA');


-- Insercion en la tabla solicitud.subtributo
insert into solicitud.subtributo values (1, 12, 'Subtributo 1');

-- Inserción en la tabla solicitud.detalle_liquidacion_solicitud_licencia_conductor
insert into solicitud.detalle_liquidacion_solicitud_licencia_conductor values (1, 1, 1, 1, 1, 2);


