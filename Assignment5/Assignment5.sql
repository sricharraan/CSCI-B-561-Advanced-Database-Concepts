-- Script for Assignment 5

-- Creating database with full name

CREATE DATABASE sricharraanramaswamy;

-- Connecting to database 
\c sricharraanramaswamy

-- Relation schemas and instances for assignment 5

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


-- We define the following functions and predicates

/*
Functions:
set_union(A,B)               A union B
set_intersection(A,B)        A intersection B
set_difference(A,B)          A - B
add_element(x,A)             {x} union A
remove_element(x,A)          A - {x}
make_singleton(x)            {x}
choose_element(A)            choose some element from A
bag_union(A,B)               the bag union of A and B
bag_to_set(A)                coerce a bag A to the corresponding set

Predicates:
is_in(x,A)                   x in A
is_not_in(x,A)               not(x in A)
is_empty(A)                  A is the emptyset
is_not_emptyset(A)           A is not the emptyset
subset(A,B)                  A is a subset of B
superset(A,B)                A is a super set of B
equal(A,B)                   A and B have the same elements
overlap(A,B)                 A intersection B is not empty
disjoint(A,B)                A and B are disjoint 
*/

-- Set Operations: union, intersection, difference

-- Set union $A \cup B$:
create or replace function set_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) union select unnest(B) order by 1);
$$ language sql;

-- Set intersection $A\cap B$:
create or replace function set_intersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Set difference $A-B$:
create or replace function set_difference(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) except select unnest(B) order by 1);
$$ language sql;


-- Add element to set
create or replace function add_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select bag_to_set(x || A);
$$ language sql;


-- Add element to set
create or replace function remove_element(x anyelement, A anyarray) 
returns anyarray as
$$
   select array_remove(A, x);
$$ language sql;


-- Make singleton  x --->  {x}

create or replace function make_singleton(x anyelement) 
returns anyarray as
$$
   select add_element(x,'{}');
$$ language sql;


-- Choose some element from set A
create or replace function choose_element(A anyarray) 
returns anyelement as
$$
   select x 
   from (select UNNEST(A) as x) q
   order by random();
$$ language sql;


-- Bag operations

-- Bag union 
create or replace function bag_union(A anyarray, B anyarray) 
returns anyarray as
$$
   select A || B;
$$ language sql;

-- bag To set
create or replace function bag_to_set(A anyarray)
returns anyarray as
$$
   select array(select distinct unnest(A) order   by 1);
$$ language sql;


-- Set Predicates: set membership, set non membership, emptyset, subset, superset, overlap, disjoint

-- Set membership $x \in A$:
create or replace function is_in(x anyelement, A anyarray) 
returns boolean as
$$
   select x = SOME(A);
$$ language sql;

-- Set non membership $x \not\in A$:
create or replace function is_not_in(x anyelement, A anyarray) 
returns boolean as
$$
   select not(x = SOME(A));
$$ language sql;

-- emptyset test $A = \emptyset$:
create or replace function is_empty(A anyarray) 
returns boolean as
$$
   select A <@ '{}';
$$ language sql;


-- non emptyset test $A \neq \emptyset$:
create or replace function is_not_empty(A anyarray) 
returns boolean as
$$
   select not(A <@ '{}');
$$ language sql;

-- Subset test $A\subseteq B$:
create or replace function subset(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B;
$$ language sql;

-- Superset test $A \supseteq B$:
create or replace function superset(A anyarray, B anyarray) 
returns boolean as
$$
   select A @> B;
$$ language sql;

-- Equality test $A = B$
create or replace function equal(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B and A @> B;
$$ language sql;

-- Overlap test $A\cap B \neq \emptyset$:
create or replace function overlap(A anyarray, B anyarray) 
returns boolean as
$$
   select A && B;
$$ language sql;

-- Disjointness test $A\cap B = \emptyset$:
create or replace function disjoint(A anyarray, B anyarray) 
returns boolean as
$$
   select not A && B;
$$ language sql;


-- Set Operations: union, intersection, difference

-- Set union $A \cup B$:
create or replace function setunion(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) union select unnest(B) order by 1);
$$ language sql;

-- Set intersection $A\cap B$:
create or replace function setintersection(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) intersect select unnest(B) order by 1);
$$ language sql;

-- Set difference $A-B$:
create or replace function setdifference(A anyarray, B anyarray) 
returns anyarray as
$$
   select array(select unnest(A) except select unnest(B) order by 1);
$$ language sql;


-- Set Predicates: set membership, subset, superset, overlap, disjoint

-- Set membership $x \in A$:
create or replace function isIn(x anyelement, A anyarray) 
returns boolean as
$$
   select x = SOME(A);
$$ language sql;

-- Subset test $A\subseteq B$:
create or replace function subset(A anyarray, B anyarray) 
returns boolean as
$$
   select A <@ B;
$$ language sql;

-- Superset test $A \supseteq B$:
create or replace function superset(A anyarray, B anyarray) 
returns boolean as
$$
   select A @> B;
$$ language sql;

-- Overlap test $A\cap B \neq \emptyset$:
create or replace function overlap(A anyarray, B anyarray) 
returns boolean as
$$
   select A && B;
$$ language sql;

-- Disjointness test $A\cap B = \emptyset$:
create or replace function disjoint(A anyarray, B anyarray) 
returns boolean as
$$
   select not A && B;
$$ language sql;

-- Complex-object views on the Person, Company, companyLocation,
-- worksFor, Skill, personSkill, and Knows database

-- Define the view {\tt companyHasEmployees(cname,employees)} which
-- associates with each company, identified by a cname, the set of
-- pids of persons who work for that company. 

create or replace view companyHasEmployees as
   select cname, array(select pid 
                       from   worksfor w
                       where  w.cname = c.cname order by 1) as employees
   from   company c order by 1;


-- Define a view {\tt cityHasCompanies(city,companies)} which associates
-- with each city the set of cnames of companies who are located in that
-- city. 

create or replace view cityHasCompanies as
   select city, array_agg(cname order by 1) as companies
   from   companyLocation 
   group by city order by 1;




-- Define a view {\tt companyLocations(cname,locations)} which associates
-- with each company, identified by a cname, the set of cities in which
-- that company is located.  

create or replace view companyHasLocations     as
   select cname, array(select city 
                       from   companyLocation cc
                       where  c.cname = cc.cname order by 1) as locations
   from   company c
   order by 1;



-- Define a view {\tt knowsPersons(pid,persons)} which associates with each
-- person, identified by a pid, the set of pids of persons he or she
-- knows.

create or replace view knowsPersons as
   select p.pid, array(select k.pid2 
                       from   knows k
                       where  k.pid1 = p.pid order by pid2) as persons
   from   person p
   order by 1;




-- The view {\tt isKnownByPersons(pid,persons)} which associates with
-- each person, identified by a pid, the set of pids of persons who know
-- that person.  Observe that there may be persons who are not known by
-- any one.

create or replace view isKnownByPersons as
   select distinct p.pid, array(select k.pid1 
                                from   knows k
                                where  k.pid2 = p.pid order by pid1) as persons
   from   person p
   order by 1;


-- Define a view {\tt personHasSkills(pid,skills)} which associates with
-- each person, identified by a pid, his or her set of job skills.
-- Observe that a person may not have any job skills.  (Test your view.)

create or replace view personHasSkills  as
   select distinct p.pid, array(select s.skill
                                from   personSkill s
                                where  s.pid = p.pid order by 1) as skills
   from   person p order by 1;





-- Define a view {\tt skillOfPersons(skills,persons)} which associates
-- with each job skill the set of pids of persons who have that job
-- skill.  Observe that there may be job skills that are not job skills
-- of any person.  (Test your view.)

create or replace view  skillOfPersons as
    select js.skill, array(select ps.pid
                           from   personSkill ps
                           where  ps.skill = js.skill order by 1) as persons
    from   Skill js order by 1;


-- Problem 1

\qecho 'Problem 1.a' 

-- Find the cname and headquarter of each company that employs at
-- least two persons who each have both the AI and the Programming job
-- skills.

select c.cname, c.headquarter
from company c
where cardinality(array(select ps.pid
                   from personHasSkills ps
                   where is_in(ps.pid, (select che.employees
                                         from companyHasEmployees che
                                         where che.cname = c.cname))and subset('{"AI", "Programming"}', ps.skills)))>= 2
order by 1;

\qecho 'Problem 1.b'  
-- Find each skill that is not a job skill of any person who works for
-- Yahoo or for Netflix.

create or replace view jBOfYorN as (select  distinct sop.skill as  skill 
			 						from companyHasEmployees che , skillOfPersons sop 
			 						where (che.cname= 'Yahoo' or che.cname = 'Netflix') and overlap(sop.persons, che.employees ));

select unnest(set_difference(array_agg(sop.skill), array_agg(yn.skill)) ) as skill
from skillOfPersons sop , jBOfYorN yn;

\qecho 'Problem 1.c'  
-- Find the set of companies that employ at least 3 persons who each
-- know at least five persons.  (So this query returns {\bf only one}
-- object, i.e., the set of companies specified in the query.)

create or replace view knowsfive as(select array_agg(k.pid) pid 
				  					from knowsPersons k 
				  					where cardinality(k.persons) >= 5 );

select array_agg(che.cname)
from companyHasEmployees che , knowsfive kf  
where cardinality(set_intersection(che.employees,kf.pid)) >=3;

\qecho 'Problem 1.d' 
-- Find the pid and name of each person $p$ along with the set of pids
-- of persons who (1) know $p$ and (2) who have the AI skill but not
-- the Programming skill.

select p.pid, p.pname, set_intersection((ikbp.persons) , (select  set_difference ((select sop.persons from skillOfPersons sop where skill='AI'),(select sop.persons from skillOfPersons sop where skill='Programming'))))  
from person p , isKnownByPersons ikbp    
where p.pid = ikbp.pid;   

\qecho 'Problem 1.e' 
-- Find each pairs $(s_1,s_2)$ of different skills $s_1$ and $s_2$
-- such that the number of employees who have skill $s_1$ and who make
-- strictly more than 55000 is strictly less than the number of
-- employees who have skill $s_2$ and who make at most 55000.

create or replace view sformore as(select array_agg(pid) as pid 
								   from worksfor 
								   where salary > 55000);
				 
create or replace view sforless  as(select array_agg(pid) as pid 
									from worksfor 
									where salary <= 55000);

select sop1.skill as s1, sop2.skill as s2
from skillOfPersons sop1 , skillOfPersons sop2 , sformore sfm, sforless sfl
where sop1.skill <> sop2.skill and cardinality(set_intersection(sop1.persons, sfm.pid)) < cardinality(set_intersection(sop2.persons, sfl.pid)) 
order by 1,2;

\qecho 'Problem 2' 
-- Find the following set of sets \[\{S \mid S \subseteq \text{Skill}
-- \land |S| \leq 3\}.\] I.e., this is the set consisting of each set of
-- job skills whose size (cardinality) is at most 3.

create or replace view  skill1 as (select array_agg(s.skill) as skills
                  from skill s
                  group by s.skill);
				  
create or replace view skill2 as (select setunion(s1.skills, s2.skills) as skills2
                   from skill1 s1, skill1 s2);
select s.skills
from skill1 s
union
select s.skills2
from skill2 s
union
select setunion(s1.skills, s2.skills2)
from skill1 s1, skill2 s2
union
select '{}';

\qecho 'Problem 4'
-- Let $t$ be a number called a \emph{threshold}.  We say that a
-- (unordered) pair of different person pids $\{p_1,p_2\}$
-- \emph{co-occur} with frequency at least $t$ if there are at least $t$
-- skills that are skills of both the person with pid $p_1$ and the
-- person with pid $p_2$.

-- Write a function {\tt coOccur(t integer)} that returns the (unordered)
-- pairs $\{p_1,p_2\}$ of person pid that co-occur with frequency at
-- least {\tt t}.

CREATE OR REPLACE FUNCTION coOccur(t INTEGER)
RETURNS TABLE(pair TEXT[]) AS
$$
SELECT DISTINCT ARRAY[p1.pid, p2.pid]
FROM person p1, person p2
WHERE p1.pid <> p2.pid AND p1.pid < p2.pid AND CARDINALITY(ARRAY(SELECT s.skill
                                             FROM skill s, personhasskills phs1, personhasskills phs2
                                             WHERE p1.pid = phs1.pid AND p2.pid = phs2.pid AND is_in(s.skill, phs1.skills) AND is_in(s.skill, phs2.skills))) >= t;
$$ LANGUAGE SQL;

-- Test your {\tt coOccur} function for $t$ in the range $[0,3]$.
 select * from coOccur(0);
 select * from coOccur(1);
 select * from coOccur(2);
 select * from coOccur(3);

\qecho 'Problem 5' 
-- Let $A$ and $B$ be sets such that $A\cup B\neq\emptyset$.  The
-- \emph{Jaccard index} $J(A,B)$ is defined as the quantity \[
-- \frac{|A\cap B|}{|A \cup B|}.\] The Jaccard index is a frequently used
-- measure to determine the similarity between two sets.  Note that if
-- $A\cap B=\emptyset$ then $J(A,B) = 0$, and if $A = B$ then $J(A,B) =
-- 1$.

-- Let $t$ be a number called a \emph{threshold}.  We assume that $t$ is
-- a {\tt float} in the range $[0,1]$.

-- Write a function {\tt JaccardSimilar(t float)} that returns the set of
-- unordered pairs $\{s_1,s_2\}$ of different skills such that the set of
-- persons who have skill $s_1$ and the set of persons who have skill
-- $s_2$ have a Jaccard index of at least {\tt t}.

CREATE OR REPLACE FUNCTION JaccardSimilar(t float) 
RETURNS TABLE (Pair text[]) AS
$$

SELECT ARRAY[sop1.skill, sop2.skill]
FROM skillOfPersons sop1, skillOfPersons sop2
WHERE sop1.skill <> sop2.skill AND sop1.skill < sop2.skill AND CARDINALITY(set_intersection(sop1.persons,sop2.persons)):: NUMERIC/CARDINALITY(set_union(sop1.persons,sop2.persons))>=t
Group By (sop1.skill, sop2.skill);

$$ Language SQL;

-- Test your function {\tt JaccardSimilar} for the following values for
-- $t$: $0$, $0.25$, $0.5$, $0.75$, and $1$.

\qecho 't = 0.0'

SELECT DISTINCT *
FROM JaccardSimilar (0)
ORDER BY 1;

\qecho 't = 0.25'

SELECT DISTINCT *
FROM JaccardSimilar (0.25)
ORDER BY 1;

\qecho 't = 0.50'

SELECT DISTINCT *
FROM JaccardSimilar (0.50)
ORDER BY 1;

\qecho 't = 0.75'

SELECT DISTINCT *
FROM JaccardSimilar (0.75)
ORDER BY 1;

\qecho 't = 1.0'

SELECT DISTINCT *
FROM JaccardSimilar (1)
ORDER BY 1;

-- \section{Nested Relations and Semi-structured databases}

-- Consider the lecture on Nested and Semi-structured Data models.  In
-- that lecture, we considered the {\tt studentGrades} nested relation
-- and we constructed it using a PostgreSQL query starting from the {\tt
-- Enroll} relation.

CREATE TABLE student (sid TEXT, sname TEXT, major TEXT, byear INT);
INSERT INTO student VALUES
('s100', 'Eric'  , 'CS'     , 1988),
('s101', 'Nick'  , 'Math'   , 1991),
('s102', 'Chris' , 'Biology', 1977),
('s103', 'Dinska', 'CS'     , 1978),
('s104', 'Zanna' , 'Math'   , 2001),
('s105', 'Vince' , 'CS'     , 2001);

CREATE TABLE course (cno TEXT, cname TEXT, dept TEXT);
INSERT INTO course VALUES
('c200', 'PL'      , 'CS'),
('c201', 'Calculus', 'Math'),
('c202', 'Dbs'     , 'CS'),
('c301', 'AI'      , 'CS'),
('c302', 'Logic'   , 'Philosophy');

CREATE TABLE enroll (sid TEXT, cno TEXT, grade TEXT);
insert into enroll values 
     ('s100','c200', 'A'),
     ('s100','c201', 'B'),
     ('s100','c202', 'A'),
     ('s101','c200', 'B'),
     ('s101','c201', 'A'),
     ('s102','c200', 'B'),
     ('s103','c201', 'A'),
     ('s101','c202', 'A'),
     ('s101','c301', 'C'),
     ('s101','c302', 'A'),
     ('s102','c202', 'A'),
     ('s102','c301', 'B'),
     ('s102','c302', 'A'),
     ('s104','c201', 'D');



\qecho 'Problem 6'

-- Write a PostgreSQL view {\tt courseGrades} that creates the nested
-- relation of type \[{\tt (cno, gradeInfo\{(grade, students
-- \{(sid)\})\})}\] This view should compute for each course, the grade
-- information of the students enrolled in this course.  In particular,
-- for each course and for each grade, this relation stores in a set the
-- students who obtained that grade in that course.

CREATE TYPE studentType AS (sid text);

CREATE TYPE gradeInfotype AS (grade text, students studentType[]);

CREATE VIEW courseGrades AS WITH s AS 
(SELECT cno,grade,array_agg(row(sid)::studentType) students 
FROM enroll 
GROUP BY cno,grade order by 1,2) 
SELECT cno, array_agg(row(grade,students)::GradeInfotype) as gradeInfo from s group by cno;


-- Test your view.

select * from courseGrades;

-- Problem 7

-- Starting from the {\tt courseGrades} view in
-- Problem~\ref{nestedrelation} solve the following queries:

\qecho 'Problem 7.a'
-- Find each pair $(c,S)$ where $c$ is the cno of a course and $S$ is the
-- set of sids of students who received an `A' or a `B' in course $c$.
-- The type of your answer relation should be (cno: text,
-- students:(sid:text)[]).

SELECT cno, set_union((SELECT students 
                          FROM unnest(coursegrades.gradeinfo)g WHERE g.grade='A'),
                                     (SELECT students FROM unnest(coursegrades.gradeinfo)g WHERE g.grade='B')) 
as students FROM courseGrades;

\qecho 'Problem 7.b'
-- Find each $(s,C)$ pairs where $s$ is the sid of a students and $C$ is
-- the set of cnos of courses in which the student received an `A'.  The
-- type of your answer relation should be (sid:text,
-- courses:(cno:text)[]).

create type ctype as (cno text);

SELECT s.sid,array_agg(row(c.cno)::ctype) courses 
FROM courseGrades c, unnest(c.gradeinfo) g, unnest(g.students) s 
WHERE g.grade='A' group by s.sid order by 1;

\qecho 'Problem 8'
-- Write a PostgreSQL view {\tt jcourseGrades} that creates a
-- semi-structured database which stores {\tt jsonb} objects whose
-- structure conforms with the structure of tuples as described for the
-- {\tt courseGrades} in Problem 6.

create or replace view jcoursegrades as with e as 
(select cno,grade,jsonb_agg(jsonb_build_object('sid',sid)) as students 
from enroll group by(cno,grade) order by 1,2), 
f as (select jsonb_build_object('cno',cno,'gradeInfo',jsonb_agg(json_build_object('grade',grade,'students',students))) as courseinfo 
from e group by (cno)) select courseinfo from f;

-- Test your view.

select * from jcoursegrades;

-- Problem 9
-- Starting from the {\tt jcourseGrades} view in
-- Problem~\ref{jsoncourseGrades} solve the following queries. Note that
-- the output of each of these queries is a nested relation.

\qecho 'Problem 9.a'
-- Find each pair $(c,s)$ where $c$ is the cno of a course and $s$ is the
-- sid of a student who did not received an `A' in course $c$.  

SELECT	distinct j.courseInfo ->> 'cno' AS cno, s ->> 'sid' AS sid
FROM	jcoursegrades j, JSONB_ARRAY_ELEMENTS(j.courseInfo->'gradeInfo') g, JSONB_ARRAY_ELEMENTS(g -> 'students') s
WHERE	g ->> 'grade'<> 'A';

\qecho 'Problem 9.b'
-- Find each $(s,C)$ pairs where $s$ is the sid of a students and $C$ is
-- the set of cnos of courses in which the student received an `A'.

SELECT DISTINCT coursePair.*, bag_to_set(ARRAY_AGG(ROW(s1 ->> 'sid')::studentType)) AS Students
FROM	jcourseGrades j1, jcourseGrades j2, bag_to_set(setUnion(make_singleton(ROW(j1.courseInfo ->> 'cno')::ctype), make_singleton(ROW(j2.courseInfo ->> 'cno')::ctype))) coursePair, JSONB_ARRAY_ELEMENTS(j1.courseInfo->'gradeInfo') g1, JSONB_ARRAY_ELEMENTS(j2.courseInfo->'gradeInfo') g2, JSONB_ARRAY_ELEMENTS(g1 -> 'students') s1, JSONB_ARRAY_ELEMENTS(g2 -> 'students') s2
WHERE	j1.courseInfo ->> 'cno' <> j2.courseInfo ->> 'cno' AND g1 ->> 'grade' = 'B' AND g2 ->> 'grade' = 'B' AND s1 ->> 'sid' = s2 ->> 'sid'
GROUP	BY coursePair
UNION
SELECT *, (SELECT '{}'::studentType[] AS Students)
FROM (SELECT DISTINCT coursePair.*
			FROM	jcourseGrades j1, jcourseGrades j2, bag_to_set(setUnion(make_singleton(ROW(j1.courseInfo ->> 'cno')::ctype), make_singleton(ROW(j2.courseInfo ->> 'cno')::ctype))) coursePair, JSONB_ARRAY_ELEMENTS(j1.courseInfo->'gradeInfo') g1, JSONB_ARRAY_ELEMENTS(j2.courseInfo->'gradeInfo') g2, JSONB_ARRAY_ELEMENTS(g1 -> 'students') s1, JSONB_ARRAY_ELEMENTS(g2 -> 'students') s2
			WHERE	j1.courseInfo ->> 'cno' <> j2.courseInfo ->> 'cno'
			EXCEPT
			SELECT DISTINCT coursePair.*
			FROM	jcourseGrades j1, jcourseGrades j2, bag_to_set(setUnion(make_singleton(ROW(j1.courseInfo ->> 'cno')::ctype), make_singleton(ROW(j2.courseInfo ->> 'cno')::ctype))) coursePair, JSONB_ARRAY_ELEMENTS(j1.courseInfo->'gradeInfo') g1, JSONB_ARRAY_ELEMENTS(j2.courseInfo->'gradeInfo') g2, JSONB_ARRAY_ELEMENTS(g1 -> 'students') s1, JSONB_ARRAY_ELEMENTS(g2 -> 'students') s2
			WHERE	j1.courseInfo ->> 'cno' <> j2.courseInfo ->> 'cno' AND g1 ->> 'grade' = 'B' AND g2 ->> 'grade' = 'B' AND s1 ->> 'sid' = s2 ->> 'sid'
			GROUP	BY coursePair) q;

\qecho 'For Grade:A'

SELECT DISTINCT coursePair.*, bag_to_set(ARRAY_AGG(ROW(s1 ->> 'sid')::studentType)) AS Students
FROM	jcourseGrades j1, jcourseGrades j2, bag_to_set(setUnion(make_singleton(ROW(j1.courseInfo ->> 'cno')::ctype), make_singleton(ROW(j2.courseInfo ->> 'cno')::ctype))) coursePair, JSONB_ARRAY_ELEMENTS(j1.courseInfo->'gradeInfo') g1, JSONB_ARRAY_ELEMENTS(j2.courseInfo->'gradeInfo') g2, JSONB_ARRAY_ELEMENTS(g1 -> 'students') s1, JSONB_ARRAY_ELEMENTS(g2 -> 'students') s2
WHERE	j1.courseInfo ->> 'cno' <> j2.courseInfo ->> 'cno' AND g1 ->> 'grade' = 'A' AND g2 ->> 'grade' = 'A' AND s1 ->> 'sid' = s2 ->> 'sid'
GROUP	BY coursePair
UNION
SELECT *, (SELECT '{}'::studentType[] AS Students)
FROM (SELECT DISTINCT coursePair.*
			FROM	jcourseGrades j1, jcourseGrades j2, bag_to_set(setUnion(make_singleton(ROW(j1.courseInfo ->> 'cno')::ctype), make_singleton(ROW(j2.courseInfo ->> 'cno')::ctype))) coursePair, JSONB_ARRAY_ELEMENTS(j1.courseInfo->'gradeInfo') g1, JSONB_ARRAY_ELEMENTS(j2.courseInfo->'gradeInfo') g2, JSONB_ARRAY_ELEMENTS(g1 -> 'students') s1, JSONB_ARRAY_ELEMENTS(g2 -> 'students') s2
			WHERE	j1.courseInfo ->> 'cno' <> j2.courseInfo ->> 'cno'
			EXCEPT
			SELECT DISTINCT coursePair.*
			FROM	jcourseGrades j1, jcourseGrades j2, bag_to_set(setUnion(make_singleton(ROW(j1.courseInfo ->> 'cno')::ctype), make_singleton(ROW(j2.courseInfo ->> 'cno')::ctype))) coursePair, JSONB_ARRAY_ELEMENTS(j1.courseInfo->'gradeInfo') g1, JSONB_ARRAY_ELEMENTS(j2.courseInfo->'gradeInfo') g2, JSONB_ARRAY_ELEMENTS(g1 -> 'students') s1, JSONB_ARRAY_ELEMENTS(g2 -> 'students') s2
			WHERE	j1.courseInfo ->> 'cno' <> j2.courseInfo ->> 'cno' AND g1 ->> 'grade' = 'A' AND g2 ->> 'grade' = 'A' AND s1 ->> 'sid' = s2 ->> 'sid'
			GROUP	BY coursePair) q;


\qecho 'Collabrated with Siddhant Meshram, Athulya Anand, Sri Varsha Chellapilla'

\c postgres

drop database sricharraanramaswamy;

