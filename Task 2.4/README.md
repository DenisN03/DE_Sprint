Для выполнения задания необходимо повторить пункты по настройке БД из задания 2.3.


*a. Попробуйте вывести не просто самую высокую зарплату во всей команде, а вывести именно фамилию сотрудника с самой высокой зарплатой:*
```sql
SELECT FirstName, salary FROM employees_info WHERE salary=(SELECT MAX(salary) FROM employees_info);
```

*b. Попробуйте вывести фамилии сотрудников в алфавитном порядке:*
```sql
SELECT FirstName from employees_info group by FirstName;
```

*c. Рассчитайте средний стаж для каждого уровня сотрудников:*
```sql
select ei.grade, avg(current_date-ei.startdate) as experience from employees_info ei
	group by ei.grade
	order by experience
```

*d. Выведите фамилию сотрудника и название отдела, в котором он работает:*
```sql
SELECT ei.FirstName, d.name  from employees_info ei left join department d on ei.departmentid=d.departmentid;
```

*e. Выведите название отдела и фамилию сотрудника с самой высокой зарплатой в данном отделе и саму зарплату также:*
```sql
with ms as (select i.departmentid, i.firstname, i.salary from employees_info i
			inner join (select ei.departmentid, max(ei.salary) from employees_info ei
						group by ei.departmentid) as dms
			on i.salary = dms.max)
select d.name, ms.firstname, ms.salary from ms
left join department d on ms.departmentid=d.departmentid
order by d.name;
```