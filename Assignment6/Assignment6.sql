-- Script for Assignment 6

-- Creating database with full name

CREATE DATABASE sricharraanramaswamy;

-- Connecting to database 
\c sricharraanramaswamy

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




\qecho 'Problem 1'

create table P (outcome int,
                probability float);

\qecho 'Test case 1 - uniform mass function'
CREATE or REPLACE function RelationOverProbabilityFunction(n integer , l1 integer, u1 integer, l2 integer, u2 integer)
returns table(x int,y int) as
$$
WITH sample as (select outcome,probability,sum(probability) over (partition by batch order by outcome) as cumprobability from (select *,0 as batch from P) as x),
distribute as(SELECT min(outcome) from sample,(select random() x from generate_series(1,n)) y where y.x<cumprobability group by y.x)
SELECT floor(random()*(u1-l1+1)+1)::int x, min::int y FROM distribute;
$$ language sql;

insert into P values
  (1, 0.2),
  (2, 0.2),
  (3, 0.2),
  (4, 0.2),
  (5, 0.2);

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 5);

delete from P;

\qecho 'Test case 2 - non-uniform function'
insert into P values
  (1, 0.25),
  (2, 0.10),
  (3, 0.40),
  (4, 0.10),
  (5, 0.15);

select * from RelationOverProbabilityFunction(100, 1, 150, 1, 5);

\qecho 'Problem 5'

-- Data
-- Relation schemas and instances for assignment 6

create table Student(sid text,
                     sname text,
                     major text,
                     byear int,
                     primary key(sid));

-- We don't specify any constraints on enroll
create table Enroll (sid text,
                     cno text,
                     grade text);

insert into Student values 
 ('s100','Eric','CS',1988),
 ('s101','Nick','Math',1991),
 ('s102','Chris','Biology',1977),
 ('s103','Dinska','CS',1978),
 ('s104','Zanna','Math',2001),
 ('s105','Vince','CS',2001);


insert into Enroll values 
 ('s100','c200','A'),
 ('s100','c201','B'),
 ('s100','c202','A'),
 ('s101','c200','B'),
 ('s101','c201','A'),
 ('s102','c200','B'),
 ('s103','c201','A'),
 ('s101','c202','A'),
 ('s101','c301','C'),
 ('s101','c302','A'),
 ('s102','c202','A'),
 ('s102','c301','B'),
 ('s102','c302','A'),
 ('s104','c201','D');
 
CREATE OR REPLACE VIEW Enroll_Data AS
(SELECT ROW_NUMBER() OVER(ORDER BY SID,CNO ASC) AS TID,* FROM Enroll);
 
CREATE OR REPLACE FUNCTION FindStudents(INPUT_BOOL TEXT, INPUT_CNO TEXT, INPUT_GRADE TEXT)
RETURNS TABLE (SID TEXT, SNAME TEXT, MAJOR TEXT, BYEAR INT) AS
$$
BEGIN
RETURN QUERY
EXECUTE(SELECT REPLACE(
	REPLACE(
		REPLACE ('SELECT S.SID,S.SNAME,S.MAJOR,S.BYEAR 
		FROM STUDENT S
		WHERE S.SID IN 
		(SELECT E.SID 
		 FROM Enroll_Data E  
		 WHERE E.TID IN (SELECT TID1 :: BIGINT FROM UNNEST('||INPUT_BOOL||'(ARRAY(SELECT * FROM indexOnCno('''||INPUT_CNO||''')),
				 ARRAY(SELECT * FROM indexOnGrade('''||INPUT_GRADE||''')))) as TID1) )', 'and not(ARRAY', 'set_difference(ARRAY')
	,'or(ARRAY','set_union(ARRAY'),
	'and(ARRAY','set_intersection(ARRAY'));
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION indexOnCno(INPUT_CNO TEXT)
RETURNS TEXT[] AS
$$
SELECT ARRAY(SELECT TID 
			 FROM Enroll_Data 
			 WHERE CNO = INPUT_CNO) as TID;
$$ LANGUAGE SQL IMMUTABLE;


CREATE OR REPLACE FUNCTION indexOnGrade(INPUT_Grade TEXT)
RETURNS TEXT[] AS
$$
SELECT ARRAY(SELECT TID 
			 FROM Enroll_Data 
			 WHERE Grade = INPUT_Grade) as TID;
$$ LANGUAGE SQL IMMUTABLE;


\qecho 'Problem 5.a'
-- select * from FindStudents('and', 'c202', 'A');

SELECT * FROM FindStudents('and', 'c202', 'A');

SELECT sid, sname, major, byear
FROM  Student
WHERE sid IN (SELECT sid
              FROM Enroll sid
              WHERE cno = 'c202' AND grade = 'A');
			  

\qecho 'Problem 5.b'
-- select * from FindStudents('or', 'c202', 'A');

SELECT * FROM FindStudents('or', 'c202', 'A');

SELECT sid, sname, major, byear
FROM  Student
WHERE sid IN (SELECT sid
              FROM Enroll sid
              WHERE cno = 'c202' OR grade = 'A');


\qecho 'Problem 5.c'
-- select * from FindStudents('and not', 'c202', 'A');

SELECT * FROM FindStudents('and not', 'c202', 'A');

SELECT sid, sname, major, byear
FROM  Student
WHERE sid IN (SELECT sid
              FROM Enroll sid
              WHERE cno = 'c202' AND NOT grade = 'A');

\qecho "COLLABORATED WITH SRIVARSHA CHELLAPILLA, ATHULYA ANAND, SIDDHANT SUNIL MESHRAM"

\c postgres

drop database sricharraanramaswamy;
