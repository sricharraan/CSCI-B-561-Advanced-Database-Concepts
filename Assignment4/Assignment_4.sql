-- Script for Assignment 3

-- Creating database with full name

CREATE DATABASE sricharraanramaswany;

-- Connecting to database 
\c sricharraanramaswany

-- Relation schemas and instances for assignment 2

CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid));

CREATE TABLE Company(cname text,
                     headquarter text,
                     primary key (cname));

CREATE TABLE Skill(skill text,
                   primary key (skill));


CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid),
                      foreign key (pid) references Person (pid),
                      foreign key (cname) references Company(cname));


CREATE TABLE companyLocation(cname text,
                             city text,
                             primary key (cname, city),
                             foreign key (cname) references Company (cname));


CREATE TABLE personSkill(pid integer,
                         skill text,
                         primary key (pid, skill),
                         foreign key (pid) references Person (pid) on delete cascade,
                         foreign key (skill) references Skill (skill) on delete cascade);


CREATE TABLE hasManager(eid integer,
                        mid integer,
                        primary key (eid, mid),
                        foreign key (eid) references Person (pid),
                        foreign key (mid) references Person (pid));

CREATE TABLE Knows(pid1 integer,
                   pid2 integer,
                   primary key(pid1, pid2),
                   foreign key (pid1) references Person (pid),
                   foreign key (pid2) references Person (pid));



INSERT INTO Person VALUES
     (1001,'Jean','Cupertino'),
     (1002,'Vidya', 'Cupertino'),
     (1003,'Anna', 'Seattle'),
     (1004,'Qin', 'Seattle'),
     (1005,'Megan', 'MountainView'),
     (1006,'Ryan', 'Chicago'),
     (1007,'Danielle','LosGatos'),
     (1008,'Emma', 'Bloomington'),
     (1009,'Hasan', 'Bloomington'),
     (1010,'Linda', 'Chicago'),
     (1011,'Nick', 'MountainView'),
     (1012,'Eric', 'Cupertino'),
     (1013,'Lisa', 'Indianapolis'), 
     (1014,'Deepa', 'Bloomington'), 
     (1015,'Chris', 'Denver'),
     (1016,'YinYue', 'Chicago'),
     (1017,'Latha', 'LosGatos'),
     (1018,'Arif', 'Bloomington'),
     (1019,'John', 'NewYork');

INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Amazon', 'Seattle'),
     ('Google', 'MountainView'),
     ('Netflix', 'LosGatos'),
     ('Microsoft', 'Redmond'),
     ('IBM', 'NewYork'),
     ('ACM', 'NewYork'),
     ('Yahoo', 'Sunnyvale');


INSERT INTO worksFor VALUES
     (1001,'Apple', 65000),
     (1002,'Apple', 45000),
     (1003,'Amazon', 55000),
     (1004,'Amazon', 55000),
     (1005,'Google', 60000),
     (1006,'Amazon', 55000),
     (1007,'Netflix', 50000),
     (1008,'Amazon', 50000),
     (1009,'Apple',60000),
     (1010,'Amazon', 55000),
     (1011,'Google', 70000), 
     (1012,'Apple', 50000),
     (1013,'Yahoo', 55000),
     (1014,'Apple', 50000), 
     (1015,'Amazon', 60000),
     (1016,'Amazon', 55000),
     (1017,'Netflix', 60000),
     (1018,'Apple', 50000),
     (1019,'Microsoft', 50000);

INSERT INTO companyLocation VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington'),
   ('Apple', 'Cupertino'),
   ('Amazon', 'Seattle'),
   ('Google', 'MountainView'),
   ('Netflix', 'LosGatos'),
   ('Microsoft', 'Redmond'),
   ('IBM', 'NewYork'),
   ('Yahoo', 'Sunnyvale');

INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');

INSERT INTO personSkill VALUES
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI'),
 (1019,'Networks'),
 (1010,'Databases'),
 (1011,'Databases'),
 (1013,'Databases'),
 (1014,'Databases'),
 (1017,'Databases'),
 (1019,'Databases'),
 (1005,'Databases'),
 (1006,'AI'),
 (1009,'Databases');
 

INSERT INTO hasManager VALUES
 (1004, 1003),
 (1006, 1003),
 (1015, 1003),
 (1016, 1004),
 (1016, 1006),
 (1008, 1015),
 (1010, 1008),
 (1013, 1007),
 (1017, 1013),
 (1002, 1001),
 (1009, 1001),
 (1014, 1012),
 (1011, 1005);


INSERT INTO Knows VALUES
 (1011,1009),
 (1007,1016),
 (1011,1010),
 (1003,1004),
 (1006,1004),
 (1002,1014),
 (1009,1005),
 (1018,1009),
 (1007,1017),
 (1017,1019),
 (1019,1013),
 (1016,1015),
 (1001,1012),
 (1015,1011),
 (1019,1006),
 (1013,1002),
 (1018,1004),
 (1013,1007),
 (1014,1006),
 (1004,1014),
 (1001,1014),
 (1010,1013),
 (1010,1014),
 (1004,1019),
 (1018,1007),
 (1014,1005),
 (1015,1018),
 (1014,1017),
 (1013,1018),
 (1007,1008),
 (1005,1015),
 (1017,1014),
 (1015,1002),
 (1018,1013),
 (1018,1010),
 (1001,1008),
 (1012,1011),
 (1002,1015),
 (1007,1013),
 (1008,1007),
 (1004,1002),
 (1015,1005),
 (1009,1013),
 (1004,1012),
 (1002,1011),
 (1004,1013),
 (1008,1001),
 (1008,1019),
 (1019,1008),
 (1001,1019),
 (1019,1001),
 (1004,1003),
 (1006,1003),
 (1015,1003),
 (1016,1004),
 (1016,1006),
 (1008,1015),
 (1010,1008),
 (1017,1013),
 (1002,1001),
 (1009,1001),
 (1011,1005),
 (1014,1012),
 (1010,1002),
 (1010,1012),
 (1010,1018);

\qecho 'Problem 1'
-- Find each pair $(c,n)$ where $c$ is the cnameof a company that pays
-- an average salary between 50000 and 55000 and where $n$ is the number
-- of employees who work for company $c$.
create view company_avg as(select w.cname,avg(w.salary) as avg_salary
				    	   from worksFor w
				           group by (w.cname));
						      
SELECT w.cname, count(w.pid) AS No_of_employees
FROM worksFor w, company_avg ca
WHERE ca.cname = w.cname and ca.avg_salary >= 50000 and ca.avg_salary <= 55000 
GROUP BY (w.cname);

\qecho 'Problem 2'
-- Find the pid and name of each person who lacks at least 4 job skils
-- and who knows at least 4 persons.
create view no_of_skill as (select p.pid,count(ps.skill) as nskill
					    from personSkill ps, Person p
						where ps.pid = p.pid
					    group by (p.pid)
					    union
					    select p.pid, 0 as nskill
					    from Person p 
						where p.pid not in (select ps1.pid
										    from personSkill ps1));
											
create view no_of_knows as(select k.pid1 as pid,count(k.pid2) as npeople
						   from knows k
						   group by(k.pid1));
						   
create view no_of_lacks as(select ns.pid, ((select count(skill)
										   from Skill)-ns.nskill) as nlack
						   from Skill s, no_of_skill ns);

select distinct p.pid, p.pname
from Person p, no_of_lacks nl, no_of_knows np
where p.pid = nl.pid and nl.pid = np.pid and nlack >= 4 and npeople >=4
order by (p.pid);


\qecho 'Problem 3'
-- Find the pid and name of each person who has fewer than 2 of the
-- combined set of job skills of persons who work for Google.

create view skills_of_google as(select distinct ps.skill
							    from worksFor w, personSkill ps
							    where w.pid = ps.pid and w.cname = 'Google');

create view count_same_as_google as (select ps.pid, count(ps.skill) as nj
									 from personSkill ps, skills_of_google sg 
									 where ps.skill = sg.skill
									 group by (ps.pid)
									 union
					    			 select p.pid, 0 as nskill
					    			 from Person p 
									 where p.pid not in (select ps1.pid
										    			 from personSkill ps1));

SELECT p.pid, p.pname
FROM Person p, count_same_as_google cg
WHERE cg.pid = p.pid and cg.nj < 2
order by (p.pid);

\qecho 'Problem 4'
-- Find the cname of each company that employs at least 3 persons and
-- that pays the lowest average salary among such companies.

create view min_company_avg as(select w.cname,avg(w.salary) as avg_salary
				    	   	   		 from worksFor w
				               		 group by (w.cname));

create view more_than_three_employees as(SELECT q.cname, q.avg_salary, q.no_of_employees
	 									 FROM(SELECT ca.cname,ca.avg_salary,count(w.pid) AS No_of_employees
	 	  									  FROM worksFor w, min_company_avg ca
	 	  									  WHERE  w.cname = ca.cname
	 	  									  GROUP BY (ca.cname,ca.avg_salary))q
	 									 WHERE q.no_of_employees >=3);

select z.cname
from more_than_three_employees z
where z.avg_salary = (select min(avg_salary)
					  from more_than_three_employees);
					  
\qecho 'Problem 5'
-- Find each pair $(c_1,c_2)$ of different company cnames such that,
-- among all companies, company $c_2$ pays the closest average salary
--- compared to the average salary paid by company $c_1$.

create view company_average as(select w.cname,avg(w.salary) as avg_salary

				    	   	   from worksFor w
				               group by (w.cname));
create view avg_diff as(select ca1.cname as c1, ca2.cname as c2,
						CASE WHEN ca2.avg_salary >= ca1.avg_salary THEN(ca2.avg_salary-ca1.avg_salary)
						     ELSE (ca1.avg_salary-ca2.avg_salary)
						END AS DIFF
						from company_average ca1, company_average ca2
						where ca1.cname <> ca2.cname);

select ad.c1,ad.c2
from avg_diff ad
where ad.diff = (select min(diff)
				 from avg_diff
				 where c1 = ad.c1);
				 
\qecho 'Problem 6'
--Without using set predicates, find each pid of a person who does not
--know each person who (1) works for Apple and
-- (2) who makes less than 55000.

create view works_for_apple as(select w.pid
							   from worksFor w
							   where w.cname ='Apple' and w.salary < 55000);
							   
SELECT distinct	k.pid1
from knows k  
where (select count(*)
       from (select wp.pid
             from works_for_apple wp
             except
             select k1.pid2
             from knows k1
             where k1.pid1 = k.pid1) q) > 0;
			 
\qecho 'Problem 7'
-- Without using set predicates, find each pairs $(s_1,s_2)$ of skills
-- such that the set of persons with skill $s_1$ is the same as the set
-- of persons with skill $s_2$.

create view skill_count as (select ps.pid , ps. skill , count(ps.pid) over (partition by ps.skill) as ct 
			  		 from personSkill ps); 

select q1.s1, q1.s2 
from(select q.* 
	 from(select count(cte2.pid) as ct1 , cte2.skill as s1 , cte1.skill as s2 , cte1.ct as ct  
		  from skill_count cte1,skill_count cte2  
		  where cte1.ct = cte2.ct and cte1.pid = cte2.pid   
		  group by 2,3,4)q 
	 where q.ct1 = q.ct )q1;

\qecho 'Problem 8'
-- Find each pairs $(s_1,s_2,n)$ of different skills $s_1$ an $s_2$ and
-- such that (1) the number of persons with skill $s_1$ is the same as
-- the number of persons with skill $s_2$ and (2) where $n$ is the number
-- of such persons associated with $s_1$ and $s_2$.

create view skill_c as  (select skill, count(pid) as ct1  from personSkill ps1 group by 1 ) ;
 
select cte1.skill, cte2.skill, cte1.ct1 
from skill_c cte1,skill_c cte2 
 where cte1.skill <> cte2.skill and cte1.ct1 = cte2.ct1 
order by 3,1,2;

\qecho 'Problem 9'

\qecho 'Problem 9a'

create or replace function numberOfSkills(c text)
returns table (pid integer, salary int, numberOfSkills bigint) as
$$
	select w.pid,w.salary,count(ps.skill)
	from worksFor w, personSkill ps
	where w.cname = c and w.pid = ps.pid
	group by(w.pid)
	union 
	select w.pid, w.salary, 0
	from worksFor w
	where w.cname = c and w.pid not in(select ps.pid from personSkill ps)
$$language sql;

\qecho 'Problem 9b'

select * from numberOfSkills('Apple');
select * from numberOfSkills('Amazon');
select * from numberOfSkills('ACM');

\qecho 'Problem 9c'

create or replace function numberOfSkills(c text)
returns table (pid integer, salary int, numberOfSkills bigint) as
$$
	select w.pid,w.salary,(select distinct count(*)
						   from personSkill ps
						   where w.pid = ps.pid)
	from worksFor w
	where w.cname = c
$$language sql;

\qecho 'Problem 9d'

select * from numberOfSkills('Apple');
select * from numberOfSkills('Amazon');
select * from numberOfSkills('ACM');

\qecho 'Problem 9e'
-- Using the function {\tt numberOfSkills} but without using set
-- predicates, write the following query: ``{\it Find each pair $(c,p)$
-- where $c$ is the name of a company and where $p$ is the pid of a
-- person who (1) works for company $c$, (2) makes more than 50000 and
-- (3) has the most job skills among all the employees who work for
-- company $c$}."

select w.cname, q.pid 
from worksFor w,numberOfSkills(w.cname)q
where q.salary > 50000 and q.pid = w.pid and q.numberOfSkills = (select max(numberOfSkills) from numberOfSkills(w.cname));


\qecho 'Problem 10'

create table P(coefficient integer,
			   deg integer);
			   
create table Q(coefficient integer,
			   deg integer);

INSERT INTO P VALUES
(2,2),
(-5,1),
(5,0);

INSERT INTO Q VALUES
(4,4),
(3,3),
(1,2),
(-1,1),
(0,0);

\qecho 'Problem 10a'

create or replace function multiplyPolynomials(polynomial1 text, polynomial2 text)
  returns table(coefficient integer, degree integer) as
$$
	begin 
		return query 
			execute 'select cast(sum(A.coefficient) as integer) , A.deg
			         from(select p.coefficient * q.coefficient as coefficient ,p.deg + q.deg as deg
					 	  from '||polynomial1||' p, '||polynomial2||' q
					 	  where (p.coefficient * q.coefficient) <>0)A
					 group by (A.deg)';	
	end;
$$language plpgsql;

\qecho 'Problem 10b.i'

select * from multiplyPolynomials('P','Q') order by degree DESC;

\qecho 'Problem 10b.ii'

select * from multiplyPolynomials('P','P')order by degree DESC;

\qecho 'Problem 10b.iii'

create view QP as (select coefficient, degree as deg from multiplyPolynomials('Q','P') order by degree DESC);
select * from multiplyPolynomials ('P','QP') order by degree DESC;

-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE sricharraanramaswany;





