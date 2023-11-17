/*==============================================================*/
/* Nivel 1                                                      */
/*==============================================================*/

create table actor.ocupacion (
	id        					integer          not null,
	codigo_ocupacion        	integer          not null,
	nombre_ocupacion        	varchar(60)      not null,
	nombre_ocupacion_resumido   varchar(20)      not null,
   
	constraint pk_ocupacion 	primary key (id),
	constraint unq_ocupacion 	unique (codigo_ocupacion)
);


create table actor.funcion (
	id        					integer          not null,
	codigo_funcion        		integer          not null,
	nombre_funcion       		varchar(60)      not null,
	nombre_funcion_resumido    	varchar(20)      null,
   
	constraint pk_funcion  		primary key (id),
	constraint unq_funcion 		unique (codigo_funcion)
);


create table actor.tipo_persona_juridica (
	id        						integer          not null,
	codigo_tipo_persona_juridica 	integer          not null,
	nombre_tipo_persona_juridica 	varchar(60)         not null,
	nombre_tipo_persona_juridica_resumido 	varchar(20) not null,
   
	constraint pk_tipo_persona_juridica  	primary key (id),
	constraint unq_tipo_persona_juridica 	unique (codigo_tipo_persona_juridica)
);

create table actor.pais (
	id        				integer          not null,
	codigo_pais        		varchar(3)          not null,
	nombre_pais      		varchar(60)         not null,
	nombre_pais_resumido    varchar(20)         not null,
	gentilicio				varchar(255)		 not null,
   
	constraint pk_pais  		primary key (id),
	constraint unq_pais			unique (codigo_pais)
);

create index idx_pais_nombre_pais on actor.pais (nombre_pais);

create table solicitud.subtributo (
	id        				integer          not null,
	codigo_subtributo  		smallint         not null,
	nombre_subtributo       varchar(120)        null,
	
	constraint pk_subtributo  primary key (id),
	constraint unq_subtributo unique (codigo_subtributo)
);

create table solicitud.concepto_medico (
	id        				integer          not null,
	codigo_concepto_medico  smallint         not null,
	nombre_concepto_medico  varchar(60)      not null,
	
	constraint pk_concepto_medico  primary key (id),
	constraint unq_concepto_medico unique (codigo_concepto_medico)
);

create table solicitud.motivo_rechazo(
	id 	  						integer         not null,
	codigo_motivo_rechazo		integer			not null,
	descripcion_motivo_rechazo 	varchar(120)	not null,
	
	constraint pk_motivo_rechazo 			primary key (id), 
	constraint unq_motivo_rechazo 			unique (codigo_motivo_rechazo), 
	constraint chk_motivo_rechazo_codigo 	check (codigo_motivo_rechazo >= 0)--??

);

create table solicitud.clase_licencia_conducir(
	id						integer          not null,
	clase 					varchar(10)	     not null,
	descripcion_clase 		varchar(255)	 not null,
	edad_maxima 			integer			 null,
	edad_minima 			integer			 not null,
	fecha_baja 				date			 null,
	observaciones 			varchar(255)	 null,
	requiere_examen_psquiatrico Boolean		 not null,
	es_profesional 			Boolean			 not null,

	constraint pk_clase_licencia_conducir 				primary key (id), 
	constraint unq_clase_licencia_conducir 				unique (clase),
	constraint chk_clase_licencia_conducir_edad_maxima 	check (edad_maxima >= 0),
	constraint chk_clase_licencia_conducir_edad_minima 	check (edad_minima >= 0),
	constraint chk_clase_licencia_conducir_edad 		check (edad_maxima >= edad_minima)
);


/*==============================================================*/
/* Nivel 2                                                      */
/*==============================================================*/

create table actor.actor (
	id        			integer          not null,
	id_pais				integer			 null,
	codigo_actor		integer			 not null,
	cuit_codigo1		integer			 null,	
	cuit_codigo2		integer			 null,
	cuit_codigo3		integer			 null,
	email_principal		varchar(255)	 null,
	fecha_alta			date			 not null,
	fecha_baja			date			 null,
	telefono_ppal		varchar(255)	 null,

	constraint pk_actor  	primary key (id),
	constraint fk_actor  	foreign key (id_pais)	references actor.pais (id),
	constraint unq_actor	unique (codigo_actor)
);

create table actor.provincia_estado (
	id        					integer          not null,
	id_pais						integer			 not null,
	codigo_provincia        	char(3)          not null,
	nombre_provincia      		char(60)         not null,
	nombre_provincia_resumido   char(20)         not null,
   
	constraint pk_provincia  	primary key (id),
	constraint fk_provincia  	foreign key (id_pais)	references actor.pais (id),
	constraint unq_provincia	unique (id_pais, codigo_provincia)
   
   );
create index idx_provincia_nombre  on actor.provincia_estado (nombre_provincia);

create table solicitud.clase_licencia_conducir_requerida(
	id 					integer          not null,
	id_clase 			integer			 not null,
	id_claseLic 		integer			 not null,
	secuencia 			integer			 not null,
	tenencia_minima 	integer			 not null,

	constraint pk_clase_licencia_conducir_requerida 			primary key (id),
	constraint fk_clase_licencia_conducir_requerida_clase 	 	foreign key (id_clase) 		references solicitud.clase_licencia_conducir (id_clase),
	constraint fk_clase_licencia_conducir_requerida_claseLic 	foreign key (id_claseLic) 	references solicitud.clase_licencia_conducir (id_clase),
	constraint unq_clase_licencia_conducir_requerida   		 	unique (id_clase),
	constraint unq_clase_licencia_conducir_requerida_secuencia 	unique (secuencia)
);

/*==============================================================*/
/* Nivel 3                                                      */
/*==============================================================*/


create table actor.usuario(
	id					integer			 not null,
	id_actor			integer			 null,
	id_usuario			varchar(60)		 not null,
	apellido_nombre		varchar(255)	 not null,
	fecha_alta			date 			 not null,
	hash				varchar(255)	 null,
	time_hash			integer			 null,
	fecha_baja			date			 null,

	constraint pk_usuario 				primary key (id), 
	constraint fk_usuario_actor 		foreign key (id_actor) references actor.actor (id),
	constraint unq_usuario 				unique (id_usuario), 
	constraint chk_usuario_fecha_baja 	check (fecha_baja >= fecha_alta)

);

create index idx_usuario_nombre on actor.usuario(apellido_nombre);

create table actor.rol(
	id					integer			 not null,
	id_actor			integer 		 not null,
	tipo_rol			varchar(60)		 not null,
	codigo_rol			integer			 not null,

	constraint pk_rol 			primary key (id), 
	constraint fk_rol_actor 	foreign key (id_actor) references actor.actor (id), 
	constraint unq_rol 			unique (tipo_rol, codigo_rol), 
	constraint unq_rol_actor 	unique (id_actor), 
	constraint chk_rol 			check (tipo_rol in ('INSPECTOR_TRANSITO', 'MEDICO'))

);
create index idx_rol_tipo on actor.rol(tipo_rol);
create table actor.persona_fisica(
	id					integer			 not null,
	id_actor			integer			 not null,
	id_ocupacion 		integer			 null,
	documento_identidad_tipo varchar(1)  not null,
	documento_identidad_numero integer	 not null, 
	apellido			varchar(255)	 not null,
	fechaNacimiento 	date			 not null,
	nombre				varchar(255)	 not null,
	movil_princiapl		varchar(255)	 null,
	sexo				char(1)			 not null, 
	apellido_materno 	varchar(255)	 null,
	donante_organos		varchar(255)	 null,
	email_personal		varchar(255)	 null,
	identidad_genero	varchar(255)	 null,
	estado_civil		char(1)			 not null, 

	constraint pk_persona_fisica 			primary key (id), 
	constraint fk_persona_fisica_actor 		foreign key (id_actor)	 	references actor.actor (id), 
	constraint fk_persona_fisica_ocupacion 	foreign key (id_ocupacion) 	references actor.ocupacion (id), 
	constraint unq 							unique (id_actor, documento_identidad_tipo, documento_identidad_numero),
	constraint chk_persona_fisica_fecha_nacimiento 	check (fechaNacimiento <= current_date),
	constraint chk_persona_fisica_estado_civil 		check (estado_civil in ('S', 'C', 'E','D', 'V', 'N'))
);

create index idx_persona_fisica_apellido on actor.persona_fisica (apellido);

create table actor.persona_juridica(
	id					integer			 not null,
	id_actor			integer			 not null,
	id_tipo_persona_juridica integer	 not null,
	nombre_fantasia		varchar(255)	 null,
	razon_social		varchar(255)	 not null,

	constraint pk_persona_juridica 			primary key (id), 
	constraint fk_persona_juridica_actor 	foreign key (id_actor) references actor.actor(id), 
	constraint fk_persona_juridica_tipo 	foreign key (id_tipo_persona_juridica) references actor.tipo_persona_juridica (id), 
	constraint unq_persona_juridica 		unique (id_actor)
);

create index idx_persona_juridica on actor.persona_juridica (razon_social);

create table actor.organismo(
	id					integer			 not null,
	id_actor			integer			 not null,
	nombre_organismo	varchar(255)	 not null,
	sigla				varchar(60)	 	 null,

	constraint pk_organismo 		primary key (id),
	constraint fk_organismo_actor 	foreign key (id_actor) references actor.actor (id),
	constraint unq_organismo 		unique (id_actor)

);

create index idx_organismo_nombre on actor.organismo (nombre_organismo);

create table actor.departamento(
    id                    integer			 not null,
    id_provincia_estado   integer			 not null,
    secuencia             integer			 not null,
    codigo_departamento   integer			 not null,
    nombre_departamento   varchar(60)		 not null,
    nombre_departamento_resumido varchar(20) not null,

    constraint pk_departamento 					primary key (id),
    constraint fk_departamento_provincia_estado foreign key (id_provincia_estado) references actor.provincia_estado (id),
    constraint unq_departamento 				unique (id_provincia_estado, secuencia)  
);

create index idx_departamento_nombre on actor.departamento (nombre_departamento);

/*==============================================================*/
/* Nivel 4                                                      */
/*==============================================================*/


create table actor.integra_organismo (
	id 	  				integer          not null,
	id_organismo		integer			 not null,
	id_funcion			integer			 not null,
	id_persona_fisica	integer			 not null,
	secuencia			integer			 not null,
	fecha_alta			date			 not null,
	fecha_baja			date			 null,

	constraint pk_integra_organismo 				primary key (id),
	constraint fk_integra_organismo_organismo 		foreign key (id_organismo) 		references actor.organismo (id),
	constraint fk_integra_organismo_funcion 		foreign key (id_funcion) 		references actor.funcion (id),
	constraint fk_integra_organismo_persona_fisica 	foreign key (id_persona_fisica) references actor.persona_fisica (id),
	constraint unq_integra_organismo 				unique (id_organismo, secuencia),
	constraint chk_integra_organismo_fecha_baja 	check (fecha_baja >= fecha_alta)
);

create table actor.integra_persona_juridica(
	id					integer			 not null,
	id_persona_juridica	integer			 not null,
	id_persona_fisica	integer			 not null,
	id_funcion			integer			 not null,
	secuencia			integer			 not null,
	fecha_alta			date			 not null,
	fecha_baja			date			 null,

	constraint pk_integra_persona_juridica 					primary key (id),
	constraint fk_integra_persona_juridica_persona_juridica foreign key (id_persona_juridica) 	references actor.persona_juridica (id),
	constraint fk_integra_persona_juridica_persona_fisica 	foreign key (id_persona_fisica) 	references actor.persona_fisica (id),
	constraint fk_integra_persona_juridica_funcion 			foreign key (id_funcion) 			references actor.funcion (id),
	constraint unq_integra_persona_juridica 				unique (id_persona_juridica, secuencia),
	constraint chk_integra_persona_juridica_fecha_baja 		check (fecha_baja >= fecha_alta)
);

create table actor.localidad(
    id							integer			 not null,
    id_departamento				integer			 null,
    id_provincia_estado 		integer			 null,
    codigo_localidad			integer			 not null,
    nombre_localidad			varchar(60)		 not null,
    nombre_localidad_resumido 	varchar(20)		 not null,
    codigo_postal        		integer			 null,

    constraint pk_localidad 					primary key (id),
    constraint fk_localidad_departamento 		foreign key (id_departamento) 		references actor.departamento (id),
    constraint fk_localiadad_provincia_estado 	foreign key (id_provincia_estado) 	references actor.provincia_estado (id),
    constraint unq_localidad 					unique (id_departamento, codigo_localidad), 
    constraint chk_localidad_codigo_postal 		check (codigo_postal >= 0)
    
);


/*==============================================================*/
/* Nivel 5                                                      */
/*==============================================================*/

create table actor.direccion_actor(
    id                    integer			 not null,
    id_actor              integer			 not null,
    id_localidad          integer			 null,
    secuencia             integer			 not null,
    domicilio             varchar(255)	     null,
    calle                 varchar(255)		 null,
    departamento          varchar(255)		 null,
    numero_postal         integer            null,
    piso                  varchar(255)		 null,
    edificio              varchar(255)		 null,
    manzana               varchar(255)		 null,
    monoblock             varchar(255)		 null,
    torre                 varchar(255)		 null,
    vivienda              varchar(255)		 null,
    tipo_domicilio        varchar(20)		 null,  

    constraint pk_direccion_actor 			primary key (id),
    constraint fk_direccion_actor_actor 	foreign key (id_actor) 		references actor.actor (id),
    constraint fk_direccion_actor_localidad foreign key (id_localidad) 	references actor.localidad (id),
    constraint unq_direccion_actor 			unique (id_actor, secuencia),
    constraint chk_direccion_actor_numero_postal 	check (numero_postal >= 0),
    constraint chk_direccion_actor_tipo_domicilio 	check (tipo_domicilio in ('SUCURSAL', 'LABORAL', 'CASA_CENTRAL', 'FISCAL', 'OTRO', 'PARTICULAR'))
);

create index idx_direccion_actor on actor.direccion_actor (domicilio);

create table solicitud.solicitud_licencia_conducir(
    id                    integer			 not null,
    numero		          integer            not null,
    id_persona            integer			 not null,
    id_localidad          integer			 null,
    id_usuario            integer			 not null,
    id_estado	          integer			 null,
    id_motivo             integer			 null,
    domicilio             varchar(255)	     not null,
    fecha                 date				 not null,
    libre_multa           bool				 not null,
    corresponde_charla    varchar(60)		 not null,
    corresponde_psiqui    varchar(60)		 not null,
    corresponde_teorico   varchar(60)		 not null,
    corresponde_fisico    varchar(60)		 not null,
    tipo                  varchar(60)		 not null,
    calle                 varchar(255)		 not null,
    departamento          varchar(255)		 not null, 
    numero_portal		  integer			 not null,
    piso				  varchar(255) 		 not null, 
    fecha_vencimiento	  date				 null,

    constraint pk_solicitud_licencia_conducir			primary key (id),
    constraint fk_solicitud_persona 	foreign key (id_persona) 		references actor.persona_fisica (id),
    constraint fk_solicitud_localidad 	foreign key (id_localidad) 		references actor.localidad (id),
    constraint fk_solicitud_usuario 	foreign key (id_usuario) 		references actor.usuario (id),
    constraint fk_solicitud_motivo	 	foreign key (id_motivo) 		references solicitud.motivo_rechazo (id),
    constraint unq_solicitud 			unique (numero),
    constraint chk_solicitud_tipo 		check (tipo in ('PROFESIONAL', 'COMUN'))
);

create index idx_solicitud_licencia on solicitud.solicitud_licencia_conducir (fecha_vencimiento);


/*==============================================================*/
/* Nivel 6                                                      */
/*==============================================================*/


create table solicitud.liquidacion_solicitud_licencia_conducir(
    id                  integer			not null,
    id_solicitud        integer			not null,
    id_usuario          integer			null,
    numero             	integer		    not null,
    fecha               date			not null,
    fecha_pago          date			null,
    fecha_vencimiento  	date			not null,
    importe_total    	decimal(19,2)	not null,
    pagada   			bool			not null,
    tipo             	varchar(60)		not null,
    tipo_pago          	varchar(60)		not null,

    constraint pk_liquidacion_solicitud_licencia_conducir			primary key (id),
    constraint fk_liquidacion_solicitud				foreign key (id_solicitud) 		references solicitud.solicitud_licencia_conducir (id),
    constraint fk_liquidacion_usuario				foreign key (id_usuario) 		references actor.usuario (id),
    constraint unq_liquidacion_solicitud 			unique (numero),
    constraint chk_liquidacion_tipo_pago	 		check (tipo_pago in ('NO_INFORMADO','USUARIO', 'COMUN'))
);


create table solicitud.estado_solicitud(
    id                  integer			not null,
    id_solicitud        integer			not null,
    item             	integer		    not null,
    tipo             	varchar(60)	    not null,
    fecha             	date		    not null,
   

    constraint pk_estado_solicitud	primary key (id),
    constraint fk_estado_solicitud	foreign key (id_solicitud) 		references solicitud.solicitud_licencia_conducir (id),
    constraint unq_estado			unique (id_solicitud, item),
   	constraint chk_tipo_estado		check (tipo in ('EXAMEN_PSIQUIATRICO_NO_APTO',
													'EXAMEN_PRACTICO_APROBADO',
													'PRESENTADA',
													'EXAMEN_PRACTICO_PARCIALMENTE_APROBADO',
													'APROBADA_SIMUCO',
													'EXAMEN_PSICO_FISICO_INTERCONSULTA',
													'EXAMEN_PRACTICO_REPROBADO_N_VECES',
													'RECHAZADA',
 													'EXAMEN_PSIQUIATRICO_APTO_PRACTICO_N_VECES',
													'EXAMEN_TEORICO_REPROBADO_N_VECES',
													'EXAMEN_PRACTICO_REPROBADO',
													'EXAMEN_PSIQUIATRICO_APTO_TEORICO_N_VECES',
													'EXAMEN_PSICO_FISICO_NO_APTO',
													'EXAMEN_PSICO_FISICO_APTO_CON_RESTRICCIONES',
													'EXAMEN_PSICO_FISICO_APTO',
													'APROBADA',
													'EXAMEN_PSIQUIATRICO_APTO',
													'EXAMEN_TEORICO_APROBADO',
													'PARCIALMENTE_APROBADA',
													'EXAMEN_TEORICO_REPROBADO'))
);

alter table solicitud.solicitud_licencia_conducir add constraint fk_solicitud_estado	 	foreign key (id_estado) 		references solicitud.estado_solicitud(id) ;


create table solicitud.solicitud_licencia_conductor_clase(
    id                  		integer			not null,
    id_solicitud        		integer			null,
    id_motivo					integer			null,
    id_clase					SMALLINT		not null,
    secuencia					SMALLINT		not null,
    fecha_rechazo				date			null,
    tipo_gestion				varchar(60)		not null,
    fecha_impresion				date			null,
    fecha_validacion_final		date			null,
    fecha_entrega				date			null,
    corresponde_charla			varchar(60)		not null,
    corresponde_fisico			varchar(60)		not null,
    corresponde_psiquiatrico	varchar(60)		not null,
    fecha_practico				date			null,
    resultado_practico			varchar(60)		not null,
    
    constraint pk_solicitud_licencia_conductor_clase primary key (id),
    constraint fk_solicitud_clase					 foreign key (id_solicitud) 	references solicitud.solicitud_licencia_conducir (id),
    constraint fk_clase_solicitud					 foreign key (id_clase) 		references solicitud.clase_licencia_conducir (id_clase),
    constraint fk_motivo_solicitud					 foreign key (id_motivo)	 	references solicitud.motivo_rechazo (id),
    constraint uniq_secuencia_solicitud_licencia_conductor 		unique (secuencia),
    constraint uniq_id_solicitud_solicitud_licencia_conductor 	unique (id_solicitud),
    constraint chk_tipo_gestion						 			check (tipo_gestion in ('REVALIDA_ANUAL', 
																			 'EXTRAVIO', 
																			 'RENOVACION', 
																			 'AMPLIACION', 
																			 'NUEVO', 
																			 'PROVINCIAL_A_NACIONAL', 
																			 'CAMBIO_DATOS'))
);

/*==============================================================*/
/* Nivel 7                                                      */
/*==============================================================*/

create table  solicitud.detalle_liquidacion_solicitud_licencia_conductor(
	id				integer			not null, 
	id_concepto		integer			null,
	id_liquidacion	integer			not null,
	secuencia		smallint		not null,
	id_subtributo	integer			null,
	cantidad		smallint		not null,
	
	constraint pk_detalle_liquidacion_solicitud_licencia_conductor	primary key (id),
	constraint fk_concepto_detalle 									foreign key (id_concepto) 			references solicitud.concepto_medico (id),
	constraint fk_subtributo_detalle								foreign key (id_subtributo) 		references solicitud.subtributo (id),
	constraint fk_liquidacion_detalle								foreign key (id_liquidacion) 		references solicitud.liquidacion_solicitud_licencia_conducir (id),
	constraint unq_liquidacion_detalle 								unique (id_liquidacion, secuencia)
);