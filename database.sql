CREATE DATABASE Facturacion;

USE Facturacion;

 CREATE TABLE t_rol(                                                                                                                    
    id_rol          int(11)         AUTO_INCREMENT     NOT NULL,
    t_rol           varchar(100)                       NOT NULL,
    CONSTRAINT      pk_rol      PRIMARY KEY(id_rol)
 )ENGINE=InnoDb;

 CREATE TABLE t_usuario(
    id_usuario      int(11)         AUTO_INCREMENT      NOT NULL,
    nombre          varchar(100)        NOT NULL,
    apellido        varchar(100)        NOT NULL,
    correo          varchar(100)        NOT NULL,
    password        varchar(100)        NOT NULL,
    id_rol          int(11)             NOT NULL,
    CONSTRAINT      pk_usuario          PRIMARY KEY(id_usuario),
    CONSTRAINT      fk_rol              FOREIGN KEY(id_rol) REFERENCES  t_rol(id_rol)
 )ENGINE=InnoDb;

CREATE TABLE t_ciudad(
    id_ciudad       int(11)         AUTO_INCREMENT      NOT NULL,
    ciudad          varchar(100),
    CONSTRAINT      pk_ciudad       PRIMARY KEY(id_ciudad)  
)ENGINE=InnoDb;

INSERT INTO t_ciudad (id_ciudad, ciudad) VALUES (NULL,"Bogota");
INSERT INTO t_ciudad (id_ciudad, ciudad) VALUES (NULL,"Ibague");
INSERT INTO t_ciudad (id_ciudad, ciudad) VALUES (NULL,"Cartagena");

CREATE TABLE t_unidad(
    id_unidad       int(11)     AUTO_INCREMENT      NOT NULL,
    unidad          varchar(50),
    CONSTRAINT      pk_unidad       PRIMARY KEY(id_unidad)
)ENGINE=InnoDb;

INSERT INTO t_unidad (id_unidad, unidad) VALUES(NULL,"UNIDAD");
INSERT INTO t_unidad (id_unidad, unidad) VALUES(NULL,"kILO");
INSERT INTO t_unidad (id_unidad, unidad) VALUES(NULL,"RESMA");

CREATE TABLE t_cliente(
    id_cliente      int(11)     AUTO_INCREMENT      NOT NULL,
    nombre_cliente  varchar(100),
    direccion       varchar(100),
    id_ciudad       int(11),
    CONSTRAINT      pk_cliente      PRIMARY KEY(id_cliente),
    CONSTRAINT      fk_ciudad       FOREIGN KEY(id_ciudad) REFERENCES t_ciudad(id_ciudad)
)ENGINE=InnoDb;
 
 CREATE TABLE t_producto(
    id_producto     int(11)     AUTO_INCREMENT      NOT NULL,
    producto        varchar(100),
    id_unidad       int(11),
    valor_unitario  float(10,2),
    CONSTRAINT      pk_producto     PRIMARY KEY(id_producto),
    CONSTRAINT      fk_unidad       FOREIGN KEY(id_unidad) REFERENCES t_unidad(id_unidad)
 )ENGINE=InnoDb;

 CREATE TABLE t_factura(
    id_factura      int(11)     AUTO_INCREMENT      NOT NULL,
    id_usuario      int(11),    
    id_cliente      int(11),
    id_producto     int(11),
    fecha           date,
    cantidad        varchar(50),
    valor_unitario  float(10,2),
    CONSTRAINT      pk_factura   PRIMARY KEY(id_factura),
    CONSTRAINT      fk_usuario      FOREIGN KEY(id_usuario) REFERENCES t_usuario(id_usuario),
    CONSTRAINT      fk_cliente      FOREIGN KEY(id_cliente) REFERENCES t_cliente(id_cliente),
    CONSTRAINT      fk_producto       FOREIGN KEY(id_producto) REFERENCES t_producto(id_producto)
 )ENGINE=InnoDb;


--Factura
SELECT	FAC.id_factura,
		FAC.fecha,
		USU.nombre,
        USU.apellido,
        FAC.id_cliente,
        CLI.nombre_cliente,
        CLI.direccion,
        FAC.id_producto,
        PRO.producto,
        FAC.cantidad,
        FAC.valor_unitario,
        FAC.cantidad * FAC.valor_unitario AS Total
        
FROM t_factura FAC
INNER JOIN t_usuario USU ON USU.id_usuario = FAC.id_usuario
INNER JOIN t_cliente CLI ON CLI.id_cliente = FAC.id_cliente
INNER JOIN t_producto PRO ON PRO.id_producto = PRO.id_producto