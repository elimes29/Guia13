use nba;
/*1. Mostrar el nombre de todos los jugadores ordenados alfabéticamente.*/
select nombre
from jugadores
order by Nombre asc;

/*contando jugadores*/
select count(nombre)
from jugadores;

/*2. Mostrar el nombre de los jugadores que sean pivots (‘C’) y que pesen más de 200 libras,
ordenados por nombre alfabéticamente.*/
select Nombre,Posicion , Peso
from jugadores
where Posicion='C' and Peso>200
order by Nombre asc;

/*3. Mostrar el nombre de todos los equipos ordenados alfabéticamente.*/
select *
from equipos
order by Nombre asc;

/*4. Mostrar el nombre de los equipos del este (East).*/
select nombre, Conferencia
from equipos
where Conferencia in ('east');

/*5. Mostrar los equipos donde su ciudad empieza con la letra ‘c’, ordenados por nombre.*/
select nombre, Ciudad
from equipos
where Ciudad like 'C%'
order by nombre;

/*6. Mostrar todos los jugadores y su equipo ordenados por nombre del equipo.*/
select j.nombre, e.nombre
from jugadores j
inner join equipos e
on j.Nombre_equipo=e.Nombre
order by e.nombre, j.nombre;

/*otra forma*/
select j.nombre, e.nombre
from jugadores j, equipos e
where j.Nombre_equipo=e.Nombre
order by e.nombre, j.nombre;

/*7. Mostrar todos los jugadores del equipo “Raptors” ordenados por nombre.*/
select j.nombre, e.nombre
from jugadores j
inner join equipos e
on j.Nombre_equipo=e.Nombre
where j.Nombre_equipo in ('Raptors')
order by j.nombre;

/*8. Mostrar los puntos por partido del jugador ‘Pau Gasol’.*/
select Puntos_por_partido, j.nombre
from estadisticas e, jugadores j
where e.jugador=j.codigo and j.nombre in ('Pau Gasol');

/*otra forma*/
select Puntos_por_partido, j.nombre
from estadisticas e
inner join jugadores j
on e.jugador=j.codigo
where j.nombre in ('Pau Gasol');

/*9. Mostrar los puntos por partido del jugador ‘Pau Gasol’ en la temporada ’04/05′.*/
select Puntos_por_partido, j.nombre, temporada
from estadisticas e
inner join jugadores j
on e.jugador=j.codigo
where j.nombre in ('Pau Gasol') and temporada = '04/05';

/*otra forma*/
select Puntos_por_partido, j.nombre, temporada
from estadisticas e, jugadores j
where e.jugador=j.codigo and j.nombre in ('Pau Gasol') and temporada = '04/05';

/*10. Mostrar el número de puntos de cada jugador en toda su carrera.*/
select j.codigo, j.nombre, sum(Puntos_por_partido) as Puntos_de_por_vida
from estadisticas e, jugadores j
where e.jugador=j.codigo 
group by e.jugador
order by sum(Puntos_por_partido) desc;

/*otra forma*/
select j.codigo, j.nombre, sum(Puntos_por_partido) as Puntos_de_por_vida
from estadisticas e
inner join jugadores j
on e.jugador=j.codigo 
group by e.jugador
order by j.codigo;

/*para confirmar*/
select jugador, Puntos_por_partido
from estadisticas
where jugador=5;

/*11. Mostrar el número de jugadores de cada equipo.*/
select e.nombre, count(j.nombre) as Num_jugadores
from equipos e, jugadores j
where e.Nombre=j.Nombre_equipo
group by e.nombre
order by e.nombre;

/*Confirmar*/
select nombre, nombre_equipo
from jugadores
where Nombre_equipo = 'bobcats';

/*12. Mostrar el jugador que más puntos ha realizado en toda su carrera.*/
select j.codigo, j.nombre, sum(Puntos_por_partido) as Puntos_de_por_vida
from estadisticas e, jugadores j
where e.jugador=j.codigo 
group by e.jugador
order by sum(Puntos_por_partido) desc
limit 1;

/*otra forma*/
select j.codigo, j.nombre, sum(Puntos_por_partido) as Puntos_de_por_vida
from estadisticas e
inner join jugadores j
on e.jugador=j.codigo 
group by e.jugador
order by sum(Puntos_por_partido) desc
limit 1;

/*13. Mostrar el nombre del equipo, conferencia y división del jugador más alto de la NBA.*/
select e.Nombre,Conferencia,Division,j.Nombre, j.Altura
from equipos e, jugadores j
where e.Nombre=j.Nombre_equipo
order by  j.Altura desc
limit 1;

/*otra forma*/
select e.Nombre,Conferencia,Division,j.Nombre, j.Altura
from equipos e
inner join  jugadores j
on e.Nombre=j.Nombre_equipo
order by  j.Altura desc
limit 1;

/*14. Mostrar el partido o partidos (equipo_local, equipo_visitante y diferencia) con mayor
diferencia de puntos.*/
select equipo_local, equipo_visitante, abs(puntos_local-puntos_visitante) as diferencia
from partidos
where abs(puntos_local-puntos_visitante) = (select abs(puntos_local-puntos_visitante)
											from partidos 
											order by abs(puntos_local-puntos_visitante) desc 
											limit 1);

/*15. Mostrar quien gana en cada partido (codigo, equipo_local, equipo_visitante,
equipo_ganador), en caso de empate sera null.*/
select codigo, equipo_local, puntos_local, equipo_visitante, puntos_visitante,if(puntos_local>puntos_visitante,equipo_local,if(puntos_local<puntos_visitante,equipo_visitante,null)) as Ganador
from partidos;

