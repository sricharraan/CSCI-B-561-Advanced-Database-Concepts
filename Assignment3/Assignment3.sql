-- Script for Assignment 3

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

\qecho 'Problem 6'

-- Consider the query ``Find the cname and headquarter of
-- each company that employs persons who earns less than 55000 and who do
-- not live in Bloomington.''

-- A possible way to write this query in Pure SQL is 

select c.cname, c.headquarter
from   company c
where  c.cname in (select w.cname
                   from   worksfor w
                   where  w.salary < 55000 and 
                          w.pid = SOME (select p.pid
                                        from   person p
                                        where  p.city <> 'Bloomington'));

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

\qecho 'translation step 6.1 (removing "and" in where)'

SELECT q.cname, q.headquarter
FROM (select c.*
	  from Company c
	  where c.cname in (select z.cname
						from((select w.cname,w.pid
					          from worksFor w
					    	  where w.salary < 55000) intersect (select w.cname,w.pid
	   													  	     from worksFor w
	   													  	     where w.pid = some (select p.pid
	                       													         from Person p
	                       													         where p.city <> 'Bloomington')))z))q;

\qecho 'translation step 6.2 (removing "in" and "some")'

SELECT DISTINCT q.cname, q.headquarter
FROM (select c.*
	  from Company c
	  intersect 
	  (select c.*
	   from Company c,((select w.cname,w.pid
					          from worksFor w
					    	  where w.salary < 55000) intersect (select w.cname,w.pid
	   													  	     from worksFor w ,(select p.pid from Person p where p.city <> 'Bloomington')p1
	   													  	     where w.pid = p1.pid ))z
	   where c.cname = z.cname))q;

\qecho 'translation step 6.3 (Introducing "joins" and "natural joins")'

SELECT DISTINCT q.cname, q.headquarter
FROM (select c.*
	  from Company c
	  intersect 
	 (select c1.*
	  from Company c1
	  join((select w.cname,w.pid from worksFor w where w.salary < 55000)intersect(select w1.cname, w1.pid from worksFor w1 natural join(select p.pid from Person p where p.city <> 'Bloomington')p1))z on(z.cname = c1.cname)))q;

\qecho 'Problem 7'

-- Consider the query ``Find the pid of each person who has
-- all-but-one job skill."

-- A possible way to write this query in Pure SQL is


select p.pid
from   person p
where  exists (select 1
               from   skill s
               where  (p.pid, s.skill) not in (select ps.pid, ps.skill 
                                               from   personSkill ps)) and
        not exists (select 1
                    from   skill s1, skill s2
                    where  s1.skill <> s2.skill and
                           (p.pid, s1.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps) and
                           (p.pid, s2.skill) not in (select ps.pid, ps.skill 
                                                     from   personSkill ps));

\qecho 'Removing "EXISTS" and "NOT EXISTS"'

select distinct p.pid 
from Person p, Skill s
where (p.pid,s.skill) not in (select ps.pid, ps.skill
							  from personSkill ps) EXCEPT (select distinct p.pid 
														   from Person p, skill s1, skill s2
														   where s1.skill <> s2.skill and (p.pid,s1.skill) not in (select ps.pid, ps.skill
							  																					   from personSkill ps) and (p.pid, s2.skill) not in (select ps.pid, ps.skill
							  																																		  from personSkill ps));

\qecho 'Removing "and" in where'

select q.pid from (select distinct q2.pid from (select p.pid from person p,skill s where (p.pid, s.skill) not in (select ps.pid, ps.skill 
from   personSkill ps))q2
intersect
select q1.pid from (select p.pid from person p
except
select distinct q3.pid from (select p.pid,s1.skill,s2.skill from person p,skill s1,skill s2 where s1.skill<>s2.skill
intersect
select p.pid,s1.skill,s2.skill from person p,skill s1,skill s2 where (p.pid, s1.skill) not in (select ps.pid, ps.skill 
from   personSkill ps)
intersect
select p.pid,s1.skill,s2.skill from person p,skill s1,skill s2 where (p.pid, s2.skill) not in (select ps.pid, ps.skill 
from   personSkill ps))q3)q1)q;
											 
\qecho 'Introducing "cross joins" and "joins"'

select q.pid from (select distinct q2.pid from (select p.pid,s.skill from person p cross join skill s where (p.pid, s.skill) not in (select ps.pid, ps.skill 
from   personSkill ps))q2
intersect
select q1.pid from (select p.pid from person p
except
select distinct q3.pid from (select p.pid,s1.skill,s2.skill from person p cross join skill s1 join skill s2 on(s1.skill<>s2.skill)
intersect
select p.pid,s1.skill,s2.skill from person p cross join skill s1 cross join skill s2 where (p.pid, s1.skill) not in (select ps.pid, ps.skill 
from   personSkill ps)
intersect
select p.pid,s1.skill,s2.skill from person p cross join skill s1 cross join skill s2 where (p.pid, s2.skill) not in (select ps.pid, ps.skill 
from   personSkill ps))q3)q1)q;

\qecho 'Removing "not in" from where'

select q.pid from (select distinct q2.pid from (select q4.pid from (select p.pid, s.skill from person p cross join skill s
except
select p.pid,s.skill from person p join personSkill ps on (ps.pid=p.pid) join skill s on (ps.skill=s.skill))q4)q2
intersect
select q1.pid from (select p.pid from person p
except
select distinct q3.pid from (select p.pid,s1.skill,s2.skill from person p cross join skill s1 join skill s2 on(s1.skill<>s2.skill)
intersect
select q5.pid,q5.skill,q5.skill2 from (select p.pid,s1.skill,s2.skill as skill2 from person p cross join skill s1 cross join skill s2
except
select p.pid,s1.skill,s2.skill from person p join personSkill ps on (ps.pid=p.pid) join skill s1 on (ps.skill=s1.skill) cross join skill s2)q5
intersect
select q6.pid,q6.skill,q6.skill2 from (select p.pid,s1.skill,s2.skill as skill2 from person p cross join skill s1 cross join skill s2
except
select p.pid,s1.skill,s2.skill from person p join personSkill ps on (ps.pid=p.pid) join skill s2 on (ps.skill=s2.skill) cross join skill s1)q6)q3)q1)q;

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.

\qecho 'Problem 8'

-- Consider the query ``Find the pid and name of each person who
-- works for a company located in Bloomington but who does not knows any
-- person who lives in Chicago.''

 
-- A possible way to write this query in Pure SQL is

select p.pid, p.pname
from   person p
where  exists (select 1
               from   worksFor w, companyLocation c
               where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington') and
       p.pid not in (select k.pid1
                     from   knows k
                     where  exists (select 1
                                    from   person p
                                    where  k.pid2 = p.pid and  p.city = 'Chicago'));
									
\qecho 'Removing "EXISTS" in WHERE'

select p.pid, p.pname
from   person p,worksFor w, companyLocation c
where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington' and
       p.pid not in (select k.pid1
                     from   knows k,person p
                     where  k.pid2 = p.pid and  p.city = 'Chicago');
					 
\qecho 'Removing "NOT IN" in WHERE'

select q.pid, q.pname
from   (SELECT p.pid,p.pname from person p,worksFor w, companyLocation c
where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington' 
EXCEPT
SELECT p.pid,p.pname from person p,worksFor w, companyLocation c,knows k,person p1
where  p.pid = w.pid and w.cname = c.cname and c.city = 'Bloomington'and
       p.pid = k.pid1 and k.pid2 = p1.pid and  p1.city = 'Chicago')q;
	   
\qecho 'Introducing "joins" and "Natural joins"'

select q1.pid,q1.pname 
from (SELECT p.*,w.cname,c.city from person p natural join worksFor w JOIN(SELECT c.cname,c.city from companyLocation c)c ON (w.cname = c.cname) 
INTERSECT
SELECT p.*,w.cname,c.city from person p natural join worksFor w JOIN(SELECT c.cname,c.city from companyLocation c where  c.city = 'Bloomington')c ON (w.cname = c.cname))q1 
EXCEPT
SELECT p.pid,p.pname from person p natural join worksFor w JOIN(SELECT c.cname from companyLocation c)c on(c.cname=w.cname) 
								   JOIN (SELECT k.* from knows k) k ON (p.pid=k.pid1) JOIN (SELECT p1.pid,p1.city from person p1 where p1.city = 'Chicago')p1 ON(k.pid2=p1.pid);

-- Using the Pure SQL to RA SQL translation algorithm, translate this
-- Pure SQL query to an equivalent RA SQL query.  Show the translation
-- steps you used to obtain your solution.


\qecho 'Problem 9'

-- Consider the query ''Find the cname and headquarter of each company
-- that (1) employs at least one person and (2) whose workers who make
-- at most 70000 have both the programming and AI skills.”

select c.cname, c.headquarter
from   company c
where  exists (select 1 from worksfor w where w.cname = c.cname) and
       not exists (select 1
                   from   worksfor w
                   where  w.cname = c.cname and w.salary <= 70000 and
                          (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
                           w.pid not in (select ps.pid from personskill ps where skill = 'AI')));

\qecho 'Removing "EXISTS" and "NOT EXISTS" in WHERE'


select q.cname,q.headquarter from
(select  DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where w.cname = c.cname 
EXCEPT
select c.cname,c.headquarter from worksfor w,company c
    where w.cname = c.cname and w.salary <= 70000 and
           (w.pid not in (select ps.pid from personskill ps where skill = 'Programming') or
            w.pid not in (select ps.pid from personskill ps where skill = 'AI')))q;


\qecho 'Removing "OR" in WHERE'

select q.cname,q.headquarter from
(select  DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where w.cname = c.cname 
EXCEPT
    (select c.cname,c.headquarter from worksfor w natural join company c
    where w.salary <= 70000 and
    w.pid not in (select ps.pid from personskill ps where skill = 'Programming')
    UNION
    select c.cname,c.headquarter from worksfor w natural join company c
    where w.salary <= 70000 and
    w.pid not in (select ps.pid from personskill ps where skill = 'AI')))q;

\qecho 'Removing "NOT IN" in WHERE'

select q.cname,q.headquarter from
(select  DISTINCT c.cname, c.headquarter
from   company c,worksfor w
where w.cname = c.cname 
EXCEPT
    ((select q1.cname,q1.headquarter 
    from (select w.pid,c.cname,c.headquarter from worksfor w natural join company c
    where w.salary <= 70000
    EXCEPT  
    select w.pid,c.cname,c.headquarter from worksfor w natural join company c, personskill ps
    where w.salary <= 70000 and ps.skill = 'Programming' and ps.pid=w.pid)q1)
    UNION
    (select q2.cname,q2.headquarter 
    from (select w.pid,c.cname,c.headquarter from worksfor w natural join company c
    where w.salary <= 70000
    EXCEPT
    select w.pid,c.cname,c.headquarter from worksfor w natural join company c, personskill ps
    where w.salary <= 70000 and ps.skill = 'AI'and ps.pid=w.pid)q2)))q;

\qecho 'Introducing "Joins" and "Natural Joins"'

select  DISTINCT c.cname, c.headquarter
from   company c JOIN (SELECT w.pid,w.cname from worksfor w) w on (w.cname = c.cname) 
EXCEPT
    ((select q1.cname,q1.headquarter 
    from (select w.pid,c.cname,c.headquarter from (select w.* from worksfor w where w.salary <= 70000) w natural join company c
    EXCEPT  
    select w.pid,c.cname,c.headquarter from (select w.* from worksfor w where w.salary <= 70000) w natural join company c join 
    (SELECT ps.pid from personskill ps where ps.skill = 'Programming')ps on (w.pid=ps.pid)) q1)
    UNION
    (select q2.cname,q2.headquarter 
    from (select w.pid,c.cname,c.headquarter from (select w.* from worksfor w where w.salary <= 70000) w natural join company c
    EXCEPT
    select w.pid,c.cname,c.headquarter from (select w.* from worksfor w where w.salary <= 70000) w natural join company c join 
    (SELECT ps.pid from personskill ps where ps.skill = 'AI')ps on (w.pid=ps.pid))q2));


\qecho 'Problem 10'

-- Consider the following Pure SQL query.

select p.pid, exists (select 1
                      from   hasManager hm1, hasManager hm2
                      where  hm1.mid = p.pid and hm2.mid = p.pid and
                             hm1.eid <> hm2.eid)
from   Person p;

\qecho 'Removing "EXISTS" from WHERE'

(select DISTINCT p.pid,(TRUE) from person p,hasManager hm1, hasManager hm2 where hm1.mid = p.pid and hm2.mid = p.pid and hm1.eid <> hm2.eid
UNION
(select DISTINCT q.pid, (FALSE) from
 (select DISTINCT p.pid from person p
    EXCEPT
    select DISTINCT p.pid from person p,hasManager hm1, hasManager hm2 where hm1.mid = p.pid and hm2.mid = p.pid and hm1.eid <> hm2.eid)q));


\qecho 'Introducing "JOINS"'

(select DISTINCT p.pid,(TRUE) from person p join hasManager hm1 on (hm1.mid = p.pid) join hasManager hm2 on (hm2.mid = p.pid) where hm1.eid <> hm2.eid
UNION
(select DISTINCT q.pid, (FALSE) from
 (select DISTINCT p.pid from person p
    EXCEPT
    select DISTINCT p.pid from person p join hasManager hm1 on (hm1.mid = p.pid) join hasManager hm2 on (hm2.mid = p.pid) where hm1.eid <> hm2.eid)q));


-- This query returns a pair (p,t) if p is the pid of a person who
-- manages at least two persons and returns the pair (p,f) otherwise.

-- Using the insights gained from Problem 2, translate
-- this Pure SQL query to an equivalent RA SQL query.





-- Connect to default database
\c postgres

-- Drop database created for this assignment
DROP DATABASE sricharraanramaswamy;





