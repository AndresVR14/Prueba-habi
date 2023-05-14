use mydb;
/*
	Eliminación de tablas creadas
*/
DROP TABLE vende;
DROP TABLE frecuenta;
DROP TABLE gusta;
DROP TABLE bebedor;
DROP TABLE bebida;
DROP TABLE tienda;

/*
	Creación de tablas con llaves primarias y llaves foraneas
*/

CREATE TABLE tienda (
    codigo INT,
    nombre VARCHAR(100),
	PRIMARY KEY (codigo)
);

CREATE TABLE bebida (
    codigo INT,
    nombre VARCHAR(100),
	PRIMARY KEY (codigo)
);

CREATE TABLE bebedor (
    cedula BIGINT,
    nombre VARCHAR(100),
	PRIMARY KEY (cedula)
);

CREATE TABLE gusta (
    cedula BIGINT,
    codigo INT,
	CONSTRAINT FK_CedulaGusta FOREIGN KEY (cedula)
    REFERENCES Bebedor(cedula),
    CONSTRAINT FK_CodigoBebida FOREIGN KEY (codigo)
    REFERENCES Bebida(codigo)
);

CREATE TABLE frecuenta (
    cedula BIGINT,
    codigo INT,
	CONSTRAINT FK_CedulaTienda FOREIGN KEY (cedula)
    REFERENCES Bebedor(cedula),
    CONSTRAINT FK_CodigoTienda FOREIGN KEY (codigo)
    REFERENCES Tienda(codigo)
);

CREATE TABLE vende (
    codigotienda INT,
    codigobebida INT,
    precio float,
    CONSTRAINT FK_VendeTienda FOREIGN KEY (codigotienda)
    REFERENCES Tienda(codigo),
    CONSTRAINT FK_VendeBebida FOREIGN KEY (codigobebida)
    REFERENCES Bebida(codigo)
);