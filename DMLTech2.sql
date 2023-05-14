/*
	Inserción de valores de ejemplo en las tablas
*/
insert into tienda values(1, "Exito");
insert into tienda values(2, "Carulla");
insert into tienda values(3, "Jumbo");
insert into tienda values(4, "D1");
insert into tienda values(5, "Surtimax");
insert into bebida values(1, "Colombiana");
insert into bebida values(2, "Coca cola");
insert into bebida values(3, "Pepsi");
insert into bebida values(4, "Sol");
insert into bebida values(5, "Panelada");
insert into bebedor values(19432847, "Andres Camilo Restrepo");
insert into bebedor values(92837652, "Luis Perez");
insert into bebedor values(3822379, "Mateo Fabian Rosero");
insert into bebedor values(49342232, "Santiago Andres Fernandez");
insert into bebedor values(387249323, "Johan Felipe Olarte");
insert into gusta values(49342232, 1);
insert into gusta values(19432847, 1);
insert into gusta values(3822379, 4);
insert into gusta values(387249323, 1);
insert into gusta values(49342232, 2);
insert into gusta values(19432847, 5);
insert into gusta values(3822379, 5);
insert into gusta values(387249323, 2);
insert into gusta values(3822379, 3);
insert into gusta values(387249323, 3);
insert into frecuenta values(92837652, 4);
insert into frecuenta values(3822379, 1);
insert into frecuenta values(387249323, 1);
insert into frecuenta values(3822379, 5);
insert into frecuenta values(92837652, 2);
insert into frecuenta values(387249323, 3);
insert into frecuenta values(3822379, 2);
insert into frecuenta values(92837652, 1);
insert into frecuenta values(19432847, 5);
insert into frecuenta values(3822379, 3);
insert into vende values(1, 1, 20000);
insert into vende values(1, 3, 20000);
insert into vende values(1, 4, 20000);
insert into vende values(2, 2, 20000);
insert into vende values(2, 5, 20000);
insert into vende values(3, 2, 20000);
insert into vende values(3, 3, 20000);
insert into vende values(3, 4, 20000);
insert into vende values(3, 5, 20000);
insert into vende values(4, 1, 20000);
insert into vende values(4, 2, 20000);
insert into vende values(5, 1, 20000);

-- Consulta 1 bebedores que no les gusta la colombiana
select * from bebedor where bebedor.nombre not in (select distinct bebedor.nombre from bebedor inner join gusta on (bebedor.cedula = gusta.cedula) right join bebida on (bebida.codigo = gusta.codigo) where bebida.nombre = "Colombiana");

-- Consulta 2 tiendas que no son frecuentadas por Andres Camilo restrepo
select * from tienda where tienda.nombre not in (select tienda.nombre from tienda inner join frecuenta on (tienda.codigo = frecuenta.codigo) left outer join bebedor on (frecuenta.cedula = bebedor.cedula) where bebedor.nombre = "Andres Camilo Restrepo");

-- Consulta 3 bebedores que les gusta minimo una bebida y visitan minimo una tienda
select bebedor.nombre from gusta left join bebedor on(bebedor.cedula = gusta.cedula) where bebedor.nombre in (select bebedor.nombre from frecuenta left join bebedor on(bebedor.cedula = frecuenta.cedula) group by frecuenta.cedula having count(frecuenta.codigo) > 0 ) group by gusta.cedula having count(gusta.codigo) > 0 ;

-- Consulta 4 bebidas que no les gusta a cada bebedor
select bebedor.nombre , bebida.nombre  from bebedor join bebida where (bebedor.nombre, bebida.nombre) not in (select bebedor.nombre, bebida.nombre from bebedor right join gusta on (bebedor.cedula = gusta.cedula) left join bebida on (gusta.codigo = bebida.codigo));

-- Consulta 5 bebedores que suelen ir a las mismas tiendas que Luis Perez
with tiendasluis(codigo) as (select tienda.codigo from tienda right join frecuenta on (tienda.codigo = frecuenta.codigo) left join bebedor on (bebedor.cedula = frecuenta.cedula) where bebedor.nombre = "Luis Perez")
select distinct bebedor.nombre from bebedor right join frecuenta on(bebedor.cedula = frecuenta.cedula) inner join tiendasluis on (frecuenta.codigo = tiendasluis.codigo);

-- Consulta 6 bebedores que solo van a una tienda que la única bebida que venden es la que les gusta
with visita1tienda(nombre, cedula) as (select bebedor.nombre, bebedor.cedula from frecuenta left join bebedor on(bebedor.cedula = frecuenta.cedula) group by frecuenta.cedula having count(frecuenta.codigo) = 1),
	 vende1bebida(codigotienda, codigobebida) as (select vende.codigotienda, vende.codigobebida from vende group by vende.codigotienda having count(vende.codigobebida) = 1)
select visita1tienda.nombre from gusta inner join visita1tienda on(gusta.cedula = visita1tienda.cedula) inner join frecuenta on (visita1tienda.cedula = frecuenta.cedula) inner join vende1bebida on (frecuenta.codigo = vende1bebida.codigotienda) where gusta.codigo = vende1bebida.codigobebida;
