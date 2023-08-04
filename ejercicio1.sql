use personal;


/*
1. Obtener los datos completos de los empleados.*/
select *
from empleados;

/*
2. Obtener los datos completos de los departamentos.*/
select *
FROM departamentos;

/*
3. Listar el nombre de los departamentos.*/
select distinct nombre_depto
from departamentos;
/*
4. Obtener el nombre y salario de todos los empleados.*/
select nombre, sal_emp
from empleados;
/*
5. Listar todas las comisiones.*/
select comision_emp
from empleados;
/*
6. Obtener los datos de los empleados cuyo cargo sea ‘Secretaria’.*/
select *
from empleados
where cargo_emp ='Secretaria';
/*
7. Obtener los datos de los empleados vendedores, ordenados por nombre
alfabéticamente.*/
select *
from empleados
where cargo_emp = 'Vendedor'
order by nombre asc;
/*
8. Obtener el nombre y cargo de todos los empleados, ordenados por salario de menor a
mayor.*/
select nombre, cargo_emp, sal_emp
from empleados
order by sal_emp desc;
/*
9. Obtener el nombre de o de los jefes que tengan su departamento situado en la ciudad
de “Ciudad Real”
*/
select e.nombre, d.ciudad
from departamentos d inner join empleados e on d.id_depto=e.id_depto
where d.ciudad = 'Ciudad Real';
/*
10. Elabore un listado donde para cada fila, figure el alias ‘Nombre’ y ‘Cargo’ para las
respectivas tablas de empleados.*/
select concat('Nombre ' , nombre)  Nombre , concat('Cargo ' , cargo_emp) as Cargo
from empleados;
/*
11. Listar los salarios y comisiones de los empleados del departamento 2000, ordenado
por comisión de menor a mayor.*/
select nombre, sal_emp, comision_emp, id_depto
from empleados
where id_depto=2000
order by comision_emp desc;

/*
12. Obtener el valor total a pagar a cada empleado del departamento 3000, que resulta
de: sumar el salario y la comisión, más una bonificación de 500. Mostrar el nombre del
empleado y el total a pagar, en orden alfabético.*/
select nombre, (sal_emp+comision_emp+500) as Total_Pago
from empleados
order by nombre;

/*
13. Muestra los empleados cuyo nombre empiece con la letra J.*/
select nombre
from empleados
where nombre like ch;

SELECT substring_index(nombre, ' ',1) AS Nombre, substring_index(nombre, ' ',-1) AS Apellido  
FROM empleados;
/*
14. Listar el salario, la comisión, el salario total (salario + comisión) y nombre, de aquellos
empleados que tienen comisión superior a 1000.*/
select sal_emp, comision_emp, (sal_emp+comision_emp), nombre
from empleados
where comision_emp >1000;
/*
15. Obtener un listado similar al anterior, pero de aquellos empleados que NO tienen
comisión.*/
select sal_emp, comision_emp, (sal_emp+comision_emp), nombre
from empleados
where comision_emp in (0); 
/*
16. Obtener la lista de los empleados que ganan una comisión superior a su sueldo.*/
select nombre, comision_emp, sal_emp
from empleados
where comision_emp>sal_emp;
/*
17. Listar los empleados cuya comisión es menor o igual que el 30% de su sueldo.*/
select nombre, comision_emp, sal_emp
from empleados
where comision_emp<=(0.3*sal_emp);
/*
18. Hallar los empleados cuyo nombre no contiene la cadena “MA”*/
select nombre
from empleados
where nombre not like '%ma%';

/*
19. Obtener los nombres de los departamentos que sean “Ventas”, “Investigación” o
‘Mantenimiento.*/
select nombre_depto
from departamentos
where nombre_depto in ('ventas','Investigación','mantenimiento');
/*
20. Ahora obtener el contrario, los nombres de los departamentos que no sean “Ventas” ni
“Investigación” ni ‘Mantenimiento.*/
select nombre_depto
from departamentos
where nombre_depto not in ('ventas','Investigación','mantenimiento');
/*
21. Mostrar el salario más alto de la empresa.*/
select max(sal_emp)
from empleados;
/*
22. Mostrar el nombre del último empleado de la lista por orden alfabético.*/
select nombre
from empleados
order by nombre asc 
limit 1;

select min(nombre)
from empleados;

/*
23. Hallar el salario más alto, el más bajo y la diferencia entre ellos.*/
select max(sal_emp), min(sal_emp), (max(sal_emp)-min(sal_emp))
from empleados;
/*
24. Hallar el salario promedio por departamento.*/
select avg(sal_emp), departamentos.nombre_depto
from empleados inner join departamentos on empleados.id_depto=departamentos.id_depto
group by departamentos.nombre_depto;
/*
Consultas con Having
25. Hallar los departamentos que tienen más de tres empleados. Mostrar el número de
empleados de esos departamentos.*/
select count(*),empleados.id_depto, nombre_depto
FROM empleados inner join departamentos on empleados.id_depto=departamentos.id_depto
group by id_depto
having count(*)>3;
/*
26. Hallar los departamentos que no tienen empleados*/
select empleados.id_depto, nombre_depto
FROM empleados right join departamentos on empleados.id_depto=departamentos.id_depto
where empleados.id_depto is null;

/*
Consulta con Subconsulta
28. Mostrar la lista de los empleados cuyo salario es mayor o igual que el promedio de la
empresa. Ordenarlo por departamento.
*/
select *
from empleados
where sal_emp>=(select avg(sal_emp) from empleados)
order by id_depto;
