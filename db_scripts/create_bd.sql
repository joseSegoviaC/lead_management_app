CREATE DATABASE lead_management;
USE lead_management;

CREATE TABLE IF NOT EXISTS aux_campanas (
	ident INT NOT NULL,
	servidor VARCHAR(50) NOT NULL,
	bbdd_report VARCHAR(50) NULL,
	id_campana INT NOT NULL,
	sistema VARCHAR(50) NOT NULL,
	nombre VARCHAR(50) NULL,
	activo SMALLINT NULL DEFAULT 0,
	spcarga_ws_salesland_leads VARCHAR(50) NULL,
	admite_duplicado SMALLINT NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(ident)
);

CREATE TABLE IF NOT EXISTS aux_disociar (
	id INT AUTO_INCREMENT NOT NULL,
	campo VARCHAR(50) NOT NULL DEFAULT "ape1, direccion, email, nif, nombre, telefono",
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS aux_campana_disociar (
	id INT AUTO_INCREMENT NOT NULL,
	campana INT NOT NULL,
	campo VARCHAR(50) NOT NULL,
	tipo VARCHAR(50) NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(id)
);

CREATE TABLE IF NOT EXISTS aux_proveedores (
	ident INT AUTO_INCREMENT NOT NULL,
	cod_proveedor VARCHAR(5) NULL,
	proveedor VARCHAR(50) NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(ident)
);

CREATE TABLE IF NOT EXISTS log_ws (
	ident INT AUTO_INCREMENT NOT NULL,
	cuerpo VARCHAR(255) NULL,
	error_ VARCHAR(255) NULL,
	fecha DATETIME NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(ident)
);

CREATE TABLE IF NOT EXISTS logs_carga (
	ident INT AUTO_INCREMENT NOT NULL,
	id_lead VARCHAR(50) NULL,
	campana INT NULL,
	proveedor VARCHAR(50) NULL,
	log_texto VARCHAR(4000) CHARACTER SET UTF8MB4 NULL,
	comando VARCHAR(4000) CHARACTER SET UTF8MB4 NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(ident)
);

CREATE TABLE IF NOT EXISTS ws_leads (
	ident INT AUTO_INCREMENT NOT NULL,
	id_timestamp varchar(50) NULL,
	cod_proveedor varchar(5) NULL,
	id_unico varchar(255) NULL,
	fecha_entrada datetime NULL,
	duplicado smallint NULL,
	cargado smallint DEFAULT 0,
	fecha_carga DATETIME DEFAULT NULL,
	id varchar(50) NULL,
	campana varchar(50) NULL,
	fecha_captacion datetime NULL,
	nombre varchar(50) NULL,
	ape1 varchar(50) NULL,
	ape2 varchar(50) NULL,
	telefono varchar(9) NULL,
	telefono_md5 varchar(50) NULL,
	email varchar(150) NULL,
	acepta1 varchar(2) NULL,
	acepta2 varchar(2) NULL,
	acepta3 varchar(2) NULL,
	num1 int NULL,
	num2 int NULL,
	num3 int NULL,
	dual1 varchar(2) NULL,
	dual2 varchar(2) NULL,
	dual3 varchar(2) NULL,
	variable1 varchar(50) NULL,
	variable2 varchar(50) NULL,
	variable3 varchar(50) NULL,
	memo varchar(255) NULL,
	fecha date NULL,
	hora time(6) NULL,
	foto1 varchar(500) NULL,
	foto2 varchar(500) NULL,
	comercial varchar(50) NULL,
	centro varchar(50) NULL,
	codigo_postal varchar(5) NULL,
	direccion varchar(50) NULL,
	poblacion varchar(50) NULL,
	provincia varchar(50) NULL,
	nif varchar(50) NULL,
	created_at timestamp NULL DEFAULT CURRENT_TIMESTAMP,
	updated_at timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY (ident)
)

CREATE TABLE IF NOT EXISTS ws_leads_disociados (
	ident INT AUTO_INCREMENT NOT NULL,
	ident_ori INT NULL,
	id_timestamp VARCHAR(50) NULL,
	id_unico VARCHAR(50) NULL,
	fecha_entrada DATETIME NULL,
	duplicado SMALLINT NULL,
	cod_proveedor VARCHAR(5) NULL,
	id VARCHAR(50) NULL,
	campana VARCHAR(50) NULL,
	fecha_captacion DATETIME NULL,
	nombre VARCHAR(50) NULL,
	ape1 VARCHAR(50) NULL,
	ape2 VARCHAR(50) NULL,
	telefono VARCHAR(9) NULL,
	telefono_md5 VARCHAR(50) NULL,
	email VARCHAR(150) NULL,
	acepta1 VARCHAR(2) NULL,
	acepta2 VARCHAR(2) NULL,
	acepta3 VARCHAR(2) NULL,
	num1 INT NULL,
	num2 INT NULL,
	num3 INT NULL,
	dual1 VARCHAR(2) NULL,
	dual2 VARCHAR(2) NULL,
	dual3 VARCHAR(2) NULL,
	variable1 VARCHAR(50) NULL,
	variable2 VARCHAR(50) NULL,
	variable3 VARCHAR(50) NULL,
	memo VARCHAR(255) NULL,
	fecha DATE NULL,
	hora TIME(6) NULL,
	foto1 VARCHAR(500) NULL,
	foto2 VARCHAR(500) NULL,
	comercial VARCHAR(50) NULL,
	centro VARCHAR(50) NULL,
	codigo_postal VARCHAR(5) NULL,
	direccion VARCHAR(50) NULL,
	poblacion VARCHAR(50) NULL,
	provincia VARCHAR(50) NULL,
	nif VARCHAR(50) NULL,
	cargado SMALLINT NULL,
	fecha_carga DATETIME NULL,
	fecha_disociado DATETIME NULL,
	nombre_enc VARBINARY(255) NULL,
	ape1_enc VARBINARY(255) NULL,
	ape2_enc VARBINARY(255) NULL,
	telefono_enc VARBINARY(255) NULL,
	email_enc VARBINARY(255) NULL,
	variable1_enc VARBINARY(255) NULL,
	variable2_enc VARBINARY(255) NULL,
	variable3_enc VARBINARY(255) NULL,
	memo_enc VARBINARY(255) NULL,
	foto1_enc VARBINARY(255) NULL,
	foto2_enc VARBINARY(255) NULL,
	codigo_postal_enc VARBINARY(255) NULL,
	direccion_enc VARBINARY(255) NULL,
	poblacion_enc VARBINARY(255) NULL,
	provincia_enc VARBINARY(255) NULL,
	nif_enc VARBINARY(255) NULL,
	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
	PRIMARY KEY(ident)
);

ALTER TABLE aux_campana_disociar ADD FOREIGN KEY (campana) REFERENCES aux_campanas(ident);