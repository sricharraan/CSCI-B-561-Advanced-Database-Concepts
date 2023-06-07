-- Script for Assignment 2

-- Creating database with full name

CREATE DATABASE sricharraanramaswamy;

-- Connecting to database 
\c sricharraanramaswamy

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
 (1019,'Networks');

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
 (1014,1012);



create table tree(parent integer,
                  child integer);

insert into tree values
 (1,2),
 (1,3),
 (1,4),
 (2,5),
 (2,6),
 (3,7),
 (5,8),
 (8,9),
 (8,10),
 (8,11),
 (7,12),
 (7,13),
 (12,14),
 (14,15);


\qecho 'Problem 1'

-- Consider the query “Find the pid and name of each person who works
-- for Google and who has a higher salary than some other person who he
-- or she knows and who also works for Google.”

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS set predicates.
SELECT p.pid,p.pname 
FROM Person p
WHERE EXISTS (select 1
			  from worksFor w
			  where p.pid = w.pid and w.cname = 'Google' and exists(select 1
																	 from Knows k
																	 where p.pid =k.pid1 and exists(select 1 
																								    from Person p2, worksFor w2
																								    where k.pid2 = p2.pid and k.pid2 = w2.pid and w2.cname = 'Google'and w.salary > w2.salary)));
																									
-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME,
-- or ALL set membership predicates.
select p.pid, p.pname 
from Person p
where p.pid in (select w.pid
			    from worksFor w
			    where cname = 'Google' and 
			   
			   p.pid in (select k.pid1
						 from knows k
						 where k.pid2 in (select p2.pid 
										  from Person p2, worksFor w1
										  where w.salary>w1.salary and w1.cname = 'Google' and p2.pid = w1.pid)));

-- (c) Formulate this query in SQL without using set predicates.
SELECT p.pid, p.pname 
FROM Person p, worksFor w
WHERE p.pid = w.pid and w.cname = 'Google'
Intersect
select p1.pid , p1.pname 
from Person p1, Knows k, Person p2, worksFor w1, worksFor w2
where k.pid1 = p1.pid and p1.pid = w1.pid and k.pid2 = p2.pid and k.pid2 = w2.pid and w2.cname = 'Google'and w1.salary > w2.salary;

\qecho 'Problem 2'

-- Consider the query “Find the cname of each company with headquarter in
-- Cupertino, but that is not located in Indianapolis, along with the
-- pid, name, and salary of each person who works for that company and
-- who has the next-to-lowest salary at that company.

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS
-- set predicates. You can not use the set operations INTERSECT, UNION,
-- and EXCEPT.
with except_lowest as (select distinct w.salary 
					   from worksFor w, worksFor w1, Person p, Company c, companyLocation cl
					   where  w1.salary < w.salary and w.pid = p.pid and c.cname = w.cname and c.headquarter = 'Cupertino' and cl.city <> 'Indianapolis')

select distinct w1.cname,w1.pid,p.pname,w1.salary
from worksFor w1,Person p,Company c, companyLocation cl
where c.cname = w1.cname and w1.pid = p.pid and c.headquarter = 'Cupertino' and cl.city <> 'Indianapolis' and  not exists (select w1.salary
																													   	   from except_lowest el,except_lowest el2
																													  	   where w1.salary = el.salary and el.salary > el2.salary) and exists (select w1.salary from except_lowest el where w1.salary = el.salary);

-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME, or
-- ALL set membership predicates. You can not use the set oper- ations
-- INTERSECT, UNION, and EXCEPT.
with except_lowest as (select distinct w.salary 
from worksFor w, worksFor w1, Person p,  Company c, companyLocation cl 
where  w1.salary < w.salary and w.pid = p.pid and c.cname = w.cname and c.headquarter = 'Cupertino' and cl.city not in ('Indianapolis'))

select distinct w1.cname, w1.pid, p.pname, w1.salary 
from worksFor w1 , Person p, Company c, companyLocation cl
where  w1.pid = p.pid and c.cname = w1.cname and  w1.salary not in (select el.salary from except_lowest el, except_lowest el2 where el.salary > el2.salary) and w1.salary in (select el.salary from except_lowest el) and c.headquarter = 'Cupertino' and cl.city not in ('Indianapolis');

-- (c) Formulate this query in SQL without using set predicates.

with except_lowest as (select distinct w.salary 
					   from worksFor w, worksFor w1, Person p, Company c, companyLocation cl
					   where  w1.salary < w.salary and w.pid = p.pid and c.cname = w.cname and c.headquarter = 'Cupertino' and cl.city <> 'Indianapolis')
					   
select distinct w1.cname,w1.pid,p.pname,w1.salary
from worksFor w1,Person p,Company c, companyLocation cl, worksFor w2
where c.cname = w1.cname and w1.pid = p.pid and c.headquarter = 'Cupertino' and cl.city <> 'Indianapolis' and w1.salary > w2.salary
except
(select w1.cname,w1.pid,p.pname,w1.salary
from except_lowest el,except_lowest el2, worksFor w1,Person p,Company c, companyLocation cl
where c.headquarter = 'Cupertino' and cl.city <> 'Indianapolis' and w1.salary = el.salary and el.salary > el2.salary) intersect (select w1.cname,w1.pid,p.pname,w1.salary from except_lowest el, worksFor w1,Person p,Company c, companyLocation cl where w1.salary = el.salary);

\qecho 'Problem 3'


-- Consider the query “Find each (c, p) pair where c is the cname of a 
-- company and p is the pid of a person who works for that company and 
-- who is known by all other persons who work for that company.

-- (a) Formulate this query in SQL by only using the EXISTS or NOT EXISTS set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.

select c.cname, p.pid 
from company c , person p, worksfor w3 
where w3.cname =c.cname and p.pid=w3.pid 
and exists 
(select 1 
 from worksfor w2 
 where p.pid=w2.pid and c.cname=w2.cname)and not exists (select 1 
														 from worksfor w 
														 where p.pid <> w.pid and c.cname=w.cname and not exists (select 1 
																												  from knows k 
																												  where k.pid1=w.pid and k.pid2=p.pid)) 
ORDER BY 1;

-- (b) Formulate this query in SQL by only using the IN, NOT IN, SOME, or ALL set membership predicates. 
-- You can not use the set oper- ations INTERSECT, UNION, and EXCEPT.

SELECT DISTINCT w.cname, w.pid
FROM Knows k, worksFor w
WHERE w.pid = k.pid2 and k.pid1 = ALL(select w1.pid
									  from worksFor w1
									  where w1.cname = w.cname and w1.pid <> k.pid2);

-- (c) Formulate this query in SQL without using set predicates.

SELECT DISTINCT W.cname, W.pid
FROM worksFor AS W
EXCEPT
(SELECT Q1.w5cname AS cname, Q1.w5pid AS pid
 FROM((SELECT W5.pid AS w5pid, W5.cname AS w5cname, W2.pid AS w2pid, w2.cname AS w2cname
       FROM worksFor AS W2, worksFor AS W5
       WHERE W2.pid <> W5.pid AND W2.cname = W5.cname)
       EXCEPT 
      (SELECT W4.pid, W4.cname, W3.pid, W3.cname
       FROM Knows AS k1, worksFor AS W3, worksFor AS W4
       WHERE K1.pid1 = W3.pid AND K1.pid2 = W4.pid AND W3.pid <> W4.pid AND W3.cname = W4.cname))Q1);

\qecho 'Problem 4'

-- Consider the query “Find each skill that is not a jobskill of any person
-- who works for Yahoo or for Netflix.

-- (a) Formulate this query in SQL using subqueries and set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.
with yn_skill as (select distinct s.skill
				  from personskill s, worksFor w
				  where w.pid = s.pid and (w.cname = 'Netflix' or w.cname = 'Yahoo'))
				  
select s.skill
from Skill s
where s.skill not in(select yn.skill from yn_skill yn);

-- (b) Formulate this query in SQL without using predicates.
with yn_skill as (select distinct s.skill
				  from personskill s, worksFor w
				  where w.pid = s.pid and (w.cname = 'Netflix' or w.cname = 'Yahoo'))
				
select s.skill
from Skill s 
except 
select yn.skill 
from yn_skill yn;

\qecho 'Problem 5'

--  Consider the query “Find the pid and name of each person who
--  manages all but 1 person who work for Google.


-- (a) Formulate this query in SQL using subqueries and set predicates. 
-- You can not use the set operations INTERSECT, UNION, and EXCEPT.

with mg_employee as(select h.mid
				    from worksFor w, hasManager h
				    where h.mid = w.pid and w.cname ='Google')
					
SELECT p.pid, p.pname
FROM Person p, mg_employee h
WHERE p.pid = h.mid and  Exists (select 1
			  				   from worksFor w,hasManager hm
							   where w.cname = 'Google' and hm.mid <> h.mid and (w.pid = hm.mid) or (w.pid = hm.eid));

-- (b) Formulate this query in SQL without using set predicates.
-- Needs work

with mg_employee as(select h.mid
				    from worksFor w, hasManager h
				    where h.mid = w.pid and w.cname ='Google')
					
SELECT p.pid,p.pname
FROM Person p,(select distinct h.mid
			   from mg_employee h
			   Intersect 
			   (select h1.mid
			    from worksFor w, hasManager hm, mg_employee h1
			    where w.cname = 'Google' and hm.mid <> h1.mid and (w.pid = hm.mid) or (w.pid = hm.eid)))h2
WHERE p.pid = h2.mid;


\qecho 'Problem 6'
-- Problem 1 in RA SQL2
SELECT pid, pname 
FROM Person 
	 Natural JOIN (select cname
		   		   from worksFor
		  		   where cname = 'Google')w
Intersect
SELECT p1.pid, p1.pname
FROM Person p1
	 JOIN (select pid,salary
		   from worksFor)w1 ON (p1.pid = w1.pid)
	 JOIN Knows ON(p1.pid = pid1)
	 JOIN (select cname, pid, salary
		   from worksFor
		   where cname = 'Google')w2 ON (pid2 = w2.pid and w1.salary > w2.salary)
	 JOIN Person p2 ON (p2.pid = w2.pid);
	
\qecho 'Problem 7'
-- Problem 2 in RA SQL

SELECT DISTINCT w.cname, w.pid, p.pname, w.salary
FROM worksFor w
	 JOIN(select pname,pid
		 from Person)p on (w.pid = p.pid)
	 JOIN (select cname
		   from Company
		   where headquarter = 'Cupertino')c on (c.cname = w.cname)
 	JOIN(select cname
		 from companyLocation
		 where city <> 'Indianapolis')cl on (cl.cname = w.cname)
	JOIN(select salary
		 from worksFor)w1 on (w.salary > w1.salary)
EXCEPT
SELECT DISTINCT w.cname, w.pid, p.pname, w.salary
FROM worksFor w
	JOIN(select pname,pid
		 from Person)p on (w.pid = p.pid)
	JOIN (select salary,cname
		  from worksFor)w1 on (w1.salary < w.salary)
	JOIN (select salary,cname
		  from worksFor)w2 on (w2.salary < w.salary and w2.salary <> w1.salary)
	JOIN (select cname
		  from Company)c1 on (w1.cname = c1.cname and w2.cname = c1.cname);

\qecho 'Problem 8'
-- Problem 3 in RA SQL

SELECT DISTINCT W.cname, W.pid
FROM worksFor AS W
EXCEPT
(SELECT Q1.wcname AS cname, Q1.wpid AS pid
 FROM((SELECT W5.pid AS wpid, W5.cname AS wcname, W2.pid AS w2pid, w2.cname AS w2cname
       FROM worksFor AS W2
	   JOIN worksFor AS W5 ON (W2.pid <> W5.pid AND W2.cname = W5.cname))
       EXCEPT 
      (SELECT W4.pid, W4.cname, W3.pid, W3.cname
       FROM worksFor AS W3
	   JOIN Knows AS k1 ON (k1.pid1 = W3.pid)  
	   JOIN worksFor AS W4 ON (K1.pid2 = W4.pid AND W3.pid <> W4.pid AND W3.cname = W4.cname)))Q1);

\qecho 'Problem 9'
-- Problem 4 in RA SQL
				
select skill
from Skill  
except 
select s.skill 
from personSkill s
	 JOIN (select pid
		   from worksFor 
		   where (cname ='Netflix' or cname = 'Yahoo'))w ON (w.pid = s.pid);

\qecho 'Problem 10'
-- Problem 5 in RA SQL

SELECT DISTINCT p.pid, p.pname
FROM Person p 
	 JOIN hasManager h ON (p.pid = h.mid)
	 JOIN worksFor w ON (w.pid = h.eid AND w.cname = 'Google')			  
INTERSECT
SELECT DISTINCT p1.pid, p1.pname
FROM Person p1 
	 JOIN worksFor w1 ON (w1.cname = 'Google' AND p1.pid = w1.pid);

\qecho 'Problem 16'

-- Create a view {\tt Triangle} that contains each triple of pids of different persons $(p_1,p_2,p_3)$
-- that mutually know each other.   

-- Then test your view.

CREATE VIEW Triangle AS 
SELECT P2.pid as P1,P3.pid as P2,P1.pid as P3 
FROM Person P1, Person P2, Person P3 
WHERE 
(P2.pid,P1.pid) IN (SELECT k.pid1,k.pid2 from Knows k) and
(P1.pid,P2.pid) IN (SELECT k.pid1,k.pid2 from Knows k) and
(P3.pid,P2.pid) IN (select k.pid1,k.pid2 from Knows k) and 
(P2.pid,P3.pid) in (select k.pid1,k.pid2 from Knows k) and 
(P1.pid,P3.pid) IN (select k.pid1,k.pid2 from Knows k) and 
(P3.pid,P1.pid) IN (select k.pid1,k.pid2 from Knows k);

SELECT * FROM Triangle;


\qecho 'Problem 17'


-- Define a parameterized view SalaryBelow(cname text, salary integer) that returns, 
-- for a given company identified by cname and a given salary value, 
-- the subrelation of Person of persons who work for company cname and whose salary is strictly below salary.

-- Test your view for the parameter values (’IBM’,60000), (’IBM’,50000), and (’Apple’,65000).

CREATE FUNCTION SalaryBelow(c TEXT, s integer)
RETURNS TABLE(pid integer, pname TEXT, city TEXT) AS
$$                      
	SELECT p.pid, p.pname,p.city                     
	FROM   worksFor w , Person p                    
	WHERE w.cname = c and w.salary < s and w.pid = p.pid;               
$$LANGUAGE  SQL;
select * from SalaryBelow('IBM', 60000);
select * from SalaryBelow('IBM', 50000);
select * from SalaryBelow('Apple', 65000);

\qecho 'Problem 18'

-- Define a parameterized view KnowsPersonAtCompany(p integer, c text) that returns
-- for a person with pid p the subrelation of Person of persons who p knows and 
-- who work for the company with cname c.

-- Test you view for the parameters (1001, ‘Amazon’), (1001,‘Apple’), and (1015,‘Netflix’).

CREATE FUNCTION KnowsPersonAtCompany(p integer, c text)
RETURNS TABLE(pid integer, pname TEXT, city TEXT) AS
$$                      
	SELECT DISTINCT k.pid2 , p1.pname, p1.city                    
	FROM   worksFor w ,Knows k , worksFor w1, Person p1                 
	WHERE w.cname = c and k.pid1 = p and w1.pid = k.pid2 and w1.cname = c and p1.pid = k.pid2;               
$$LANGUAGE  SQL;


select * from KnowsPersonAtCompany(1001, 'Amazon');
select * from KnowsPersonAtCompany(1001, 'Apple');
select * from KnowsPersonAtCompany(1015, 'Netflix');

\qecho 'Problem 19'

-- Define a parameterized view KnownByPersonAtCompany(p integer, c text)
-- that returns the subrelation of Person of persons who know the person
-- with pid p and who work for the company with cname c.  

-- Test your view for the parameters (1001, ‘Amazon’), (1001,‘Apple’),
-- and (1015,‘Netflix’).

CREATE FUNCTION KnownPersonAtCompany(p integer, c text)
RETURNS TABLE(pid integer, pname TEXT, city TEXT) AS
$$                      
	SELECT DISTINCT k.pid1 , p1.pname, p1.city                    
	FROM   worksFor w ,Knows k , worksFor w1, Person p1                 
	WHERE w.cname = c and k.pid2 = p and w1.pid = k.pid1 and w1.cname = c and p1.pid = k.pid1;               
$$LANGUAGE  SQL;


select * from KnownPersonAtCompany(1001, 'Amazon');
select * from KnownPersonAtCompany(1001, 'Apple');
select * from KnownPersonAtCompany(1015, 'Netflix');

\qecho 'Problem 20'

-- Let Tree(parent : integer, child : integer) be a rooted parent-child tree. 
-- So a pair (n,m) in Tree indicates that node n is a parent of node m. 

-- The sameGeneration(n1, n2) binary relation is inductively defined using the following two rules:
--  If n is a node in T , then the pair (n, n) is in the sameGeneration relation. (Base rule)

--   If $n_1$ is the parent of $m_1$ in $Tree$ and $n_2$ is the parent of
--   $m_2$ in $Tree$ and $(n_1,n_2)$ is a pair in the {\tt sameGeneration}
--   relation then $(m_1,m_2)$ is a pair in the {\tt sameGeneration}
--   relation. ({\bf Inductive Rule})

-- Write a \blue{recursive view} for the {\tt sameGeneration} relation.
-- 
-- Test your view.

CREATE RECURSIVE VIEW samegeneration(n1, n2) AS
(SELECT T.parent, T.parent FROM tree T
UNION
SELECT T1.child, T2.child FROM tree T1, tree T2,
samegeneration sg WHERE T1.parent = sg.n1 and T2.parent=sg.n2);

select * FROM samegeneration
order by 1;
-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE sricharraanramaswamy;





