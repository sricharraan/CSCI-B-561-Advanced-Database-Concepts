-- Script for B561 2021 Assignment 7

create database sricharraanramaswamy;

\c sricharraanramaswamy

\qecho 'Problem 7'
create table PC(parent int, child int);

insert into PC values 
   (1,2),
   (1,3),
   (1,4),
   (2,5),
   (2,6),
   (3,7),
   (4,8),
   (5,9),
   (7,10),
   (7,11),
   (9,12);

-- Consider the following recursive query that computes the {\tt
-- sameGeneration} relation:

WITH RECURSIVE sameGeneration(m, n) AS
          ((SELECT parent, parent FROM PC) UNION (select child, child from PC)
          UNION
          SELECT  t1.child, t2.child
          FROM    sameGeneration pair, PC t1, PC t2
          WHERE   pair.m = t1.parent and pair.n = t2.parent)
SELECT DISTINCT pair.m, pair.n from sameGeneration pair order by m, n;

-- Write a non-recursive function sameGeneration() in the language
-- plpgsql that computes the sameGeneration relation.

create or replace function nonrecursivesameGeneration()
returns table(m int,n int) as
$$
declare
i record;
begin
drop table if exists same_pairs;
create table same_pairs(m int, n int);
drop table if exists all_pairs;
create table all_pairs(m int,n int);
insert into all_pairs select p1.child,p2.child from pc p1,pc p2 where p1.child<>p2.child;
insert into same_pairs (SELECT parent, parent FROM PC) UNION (select child, child from PC);
for i in (select a.m,a.n from all_pairs a)
loop
     insert into same_pairs SELECT i.m, i.n
                            FROM same_pairs pair, PC t1, pc t2
                            WHERE i.m=t1.child and i.n=t2.child and pair.m = t1.parent and pair.n = t2.parent;
end loop;
return QUERY (select distinct s.m,s.n from same_pairs s);
end;
$$language plpgsql;
select * from nonrecursivesameGeneration() order by m, n;


\qecho 'Problem 8'

create table partSubpart(pid int, sid int, quantity int);
create table basicPart(pid int, weight int);

insert into partSubpart values 
   (1,2,1),
   (1,3,3),
   (1,4,2),
   (2,5,1),
   (2,6,4),
   (3,7,2),
   (4,8,1),
   (5,9,2),
   (7,10,2),
   (7,11,3),
   (9,12,5);

insert into basicPart values
  (6,  1),
  (8,  4),
  (10, 1),
  (11, 5),
  (12, 3);

\qecho 'Problem 8.a'

-- Write a {\bf recursive} function {\tt recursiveAggregatedWeight(p
-- integer)} that returns the aggregated weight of a part {\tt p}.

-- Test your function.
-- Run the following query which for each part, computed is aggregatd
-- weight

CREATE OR REPLACE FUNCTION recursiveAggregatedWeight (n integer)
RETURNS integer AS
$$
declare
summ int:=0;
flag int;
child record;
w int;
BEGIN
flag:= (select count(*) from basicPart bp where bp.pid=n) ;
if flag=1 then
return (select bp.weight from basicPart bp where bp.pid=n) ;
else
for child in select p.sid,p.quantity from partSubPart p where p.pid=n loop  
   summ:= summ+ child.quantity * recursiveAggregatedWeight(child.sid);
end loop;
return summ;
end if;

END;
$$ language plpgsql;

select * from partSubpart;
select * from basicPart;

with part as 
  (select pid as P
   from   partSubPart
   union  
   select sid as P
   from   partSubpart)
select part.P, recursiveAggregatedWeight(part.P) 
from   part order by 1;

\qecho 'Problem 8.b'

-- Write a {\bf non-recursive} function {\tt
-- nonRecursiveAggregatedWeight(p integer)} that returns the aggregated
-- weight of a part {\tt p}.  Test your function.

-- Test your function.
-- Run the following query which for each part, computed is aggregatd
-- weight

CREATE OR REPLACE FUNCTION nonRecursiveAggregatedWeight(n int)
RETURNS table(weight bigint) AS
$$
BEGIN
drop table if exists ANC;
CREATE TABLE ANC(pid int, weight int);
INSERT INTO ANC SELECT * FROM basicPart;
WHILE EXISTS (SELECT * FROM new_ANC_pairs())
LOOP
INSERT INTO ANC SELECT * FROM new_ANC_pairs();
END LOOP;
return query select q.weight from (select p.pid,sum(p.weight) as weight from anc p where p.pid=n group by p.pid order by 1,2)q;
END;
$$ language plpgsql;

CREATE OR REPLACE FUNCTION new_ANC_pairs()
RETURNS TABLE (pid int, weight int) AS
$$
BEGIN
return query
(SELECT distinct ps.pid, a.weight * ps.quantity
FROM ANC a JOIN partSubPart ps ON (a.pid = ps.sid)
except
select * from ANC); 
end;
$$ language plpgsql;

with part as 
  (select pid as P
   from   partSubPart
   union  
   select sid as P
   from   partSubpart)
select part.P, nonRecursiveAggregatedWeight(part.P) 
from   part order by 1;

\qecho 'Problem 11'

-- Write a PostgreSQL program frequentSets(t int) that returns the set
-- of all t-frequent set.


create table document(doc int, words text[]);

insert into document values
  (1, '{"A", "B", "C", "D", "E"}'),
  (2, '{"A", "B", "C", "E", "F"}'),
  (3, '{"A", "E", "F"}'),
  (4, '{"E", "A"}');

drop view if exists unique_words;

create view uniquew as
(select distinct unnest(d.words) as word
        from   document d);

CREATE OR REPLACE FUNCTION combinations(anyarray) RETURNS SETOF anyarray AS $$
WITH RECURSIVE
    items AS (
            SELECT row_number() OVER (ORDER BY item) AS rownum, item
            FROM (SELECT unnest($1) AS item) unnested
    ),
    q AS (
            SELECT 1 AS i, $1[1:0] arr
            UNION ALL
            SELECT (i+1), CASE x
                    WHEN 1 THEN array_append(q.arr,(SELECT item FROM items WHERE rownum = i))
                    ELSE q.arr END
            FROM generate_series(0,1) x CROSS JOIN q WHERE i <= array_upper($1,1)
    )
SELECT q.arr AS mods
FROM q WHERE i = array_upper($1,1)+1;
$$ LANGUAGE 'sql';



drop table if exists all_combinations;

create table all_combinations as
select combinations(array_agg(word)) from uniquew;

drop function if exists frequentsets;

CREATE OR REPLACE FUNCTION frequentSets(t int)
RETURNS table(result1 text[]) AS $$

declare i record;
begin


drop table if exists result;
create table result(sets text[], threshold int);


for i in (select * from all_combinations)
loop

insert into result
select i.combinations,count(1)
from document d
where i.combinations<@ d.words;

end loop;
  return query (select r.sets from result r where threshold >= t);
end;
$$ LANGUAGE plpgsql;


-- Tests:

\qecho 'frequentSets(0)'
select * from frequentSets(0) order by 1;

\qecho 'frequentSets(1)'
select * from frequentSets(1) order by 1;

\qecho 'frequentSets(2)'
select * from frequentSets(2) order by 1;

\qecho 'frequentSets(3)'
select * from frequentSets(3) order by 1;

\qecho 'frequentSets(4)'
select * from frequentSets(4) order by 1;

\qecho 'frequentSets(5)'
select * from frequentSets(5) order by 1;


\qecho 'Problem 12'

drop table if exists Graph;
create table Graph(source int, target int);

\qecho 'Problem 12.a'

-- Write a {\bf recursive} function {\tt recursiveHamiltonian()} that
-- returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise.  

-- Test your function on the following graphs.


CREATE TABLE tempGraph(source int, target int);
create or replace function recursiveHamiltonian() returns text AS 
$$
DECLARE
initialSource integer;
initialTarget integer;
countOfPaths integer;
BEGIN
   
   countOfPaths := (SELECT count(*) FROM Graph);
   SELECT INTO initialSource, initialTarget 
               source, target
               from Graph
               LIMIT 1;
   INSERT INTO tempGraph VALUES(initialSource, initialTarget);

   return (SELECT recursiveFunctionToDetectGraph(initialSource, initialTarget, countOfPaths));

END;
$$ LANGUAGE plpgsql;

create or replace function recursiveFunctionToDetectGraph(initialSource integer, initialTarget integer, countOfPaths integer) returns text AS 
$$
DECLARE
tempSource integer := 0;
tempDestination integer := 0;
countTempGraph integer := 0;
BEGIN
   SELECT INTO tempSource, tempDestination 
               source, target
               FROM Graph where source = initialTarget;
   
   if tempDestination IS NULL OR tempSource IS NULL THEN
      return 'f';
   else 
      if tempSource = 0 AND tempDestination = 0 THEN
         return 'f';
      END IF;
      
      IF EXISTS(SELECT 1 from tempGraph where source = tempSource AND target = tempDestination) THEN
         return 'f';
      ELSE
         INSERT INTO tempGraph VALUES(tempSource, tempDestination);
         countTempGraph:= (SELECT count(*) from tempGraph);
         if tempDestination=initialSource AND countTempGraph=countOfPaths THEN
            return 't';
         else 
            if not tempSource = 0 AND not tempDestination = 0 THEN
               return (SELECT recursiveFunctionToDetectGraph(initialSource, tempDestination, countOfPaths)); 
            else 
               return 'f';
            END IF;
         END IF;
      END IF;
   END IF;  

END;
$$ LANGUAGE plpgsql;

insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

select * from recursiveHamiltonian();
TRUNCATE table tempGraph;

delete from Graph;

insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

select * from recursiveHamiltonian();
TRUNCATE table tempGraph;
delete from Graph;

\qecho 'Problem 12.b'

-- Write a {\bf non-recursive} function {\tt nonRecursiveHamiltonian}
-- that returns {\tt true} if the graph stored in {\tt Graph} is
-- Hamiltonian, and {\tt false} otherwise. 

-- Test your function on the following graphs.
CREATE OR REPLACE function nonRecursiveHamiltonian() returns text AS
$$
DECLARE
initialSource integer := 0;
initialTarget integer := 0;
tempSource integer:= 0;
countTempGraph integer:= 0;
countGraph integer:= 0;
BEGIN
SELECT INTO initialSource, initialTarget
   source, target 
   from graph
   LIMIT 1;
   INSERT INTO tempGraph VALUES(initialSource, initialTarget);

   WHILE EXISTS(SELECT 1 from graph where source = initialTarget) 
   LOOP
      SELECT INTO tempSource, initialTarget
         source, target 
         from graph
         where source = initialTarget;
      IF EXISTS(SELECT 1 from tempGraph where source = tempSource AND target = initialTarget) THEN
         EXIT;
      ELSE
         INSERT INTO tempGraph VALUES(tempSource, initialTarget);
      END IF;
   END LOOP;
   countGraph := (SELECT count(*) FROM Graph);
   countTempGraph:= (SELECT count(*) from tempGraph);
   if initialSource = tempSource AND countGraph = countTempGraph THEN
      return 't';
   else 
      return 'f';
   END IF;   
END;
$$ LANGUAGE plpgsql;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,1);

SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;
delete from Graph;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,1),
 (4,5),
 (5,4);

SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;
delete from Graph;


delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10),
 (10,1);


SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;

delete from Graph;
insert into Graph values
 (1,2),
 (2,3),
 (3,4),
 (4,5),
 (5,6),
 (6,7),
 (7,8),
 (8,9),
 (9,10);

SELECT * FROM nonRecursiveHamiltonian();
TRUNCATE table tempGraph;
delete from Graph;


\qecho 'Problem 14'

-- Write, in PostgreSQL, a basic MapReduce program, i.e., a mapper func-
-- tion and a reducer function, as well as a 3-phases simulation that
-- imple- ments the semijoin of two relations R(A,B) and S(A,B,C),

-- Test the function on the following relations:

drop table if exists R;
drop table if exists S;
create table R(A integer, B integer);
create table S(A integer, B integer, C integer);

insert into R values
   (1,1),
   (1,2),
   (1,3),
   (2,2),
   (2,3);

insert into S values
   (1,1,1),
   (1,1,2),
   (1,2,3),
   (1,4,1),
   (2,2,1),
   (3,4,2);

Create table EncodingRandS(key text,value jsonb);
Insert into EncodingRandS Select 'R' as key,jsonb_build_object('a',r.a,'b',r.b) as value from R r
union
Select 'S' as key,jsonb_build_object('a',s.a,'b',s.b,'c',s.c) as value from S s order by 1,2;

Create or Replace Function mapper(key text, value jsonb) returns table(key jsonb, value text) as
$$
  Select value, key;
$$ language sql;


Create or Replace Function reducer(key jsonb,valuesArray text[]) returns table(key text,value jsonb) as
$$
  Select 'R semijoin S'::text,key where Array['R','S'] <@ valuesArray;
$$ language sql;

Insert into EncodingRandS Select 'R' as key,jsonb_build_object('a',r.a,'b',r.b) as value from R r
union
Select 'S' as key,jsonb_build_object('a',s.a,'b',s.b) as value from S s order by 1,2;

  
With Map_Phase as (Select m.key,m.value from EncodingRandS, Lateral(Select key,value from mapper(key,value))m),
     Group_Phase as (Select key,array_agg(value) as value from Map_Phase Group by (key)),
     Reducer_Phase as (Select r.key,r.value from Group_Phase, Lateral(Select key,value from reducer(key,value))r)
Select p.value->'a'as a,p.value->'b' as b from Reducer_Phase p order by value;




\qecho 'Problem 16'

-- Write, in PostgreSQL, a basic MapReduce program, i.e., a mapper func-
-- tion and a reducer function, as well as a 3-phases simulation that
-- imple- ments the SQL query

SELECT r.A, array_agg(r.B), sum(r.B) FROM R r
GROUP BY (r.A)
HAVING COUNT(r.B) < 3;

-- Here R is a relation with schema (A, B). You can assume that the
-- domains of A and B are integers. Use the encoding and decoding methods
-- described above.

drop table R;
create table R(A integer, B integer);

insert into R values
   (1,1),
   (1,2),
   (1,3),
   (2,2),
   (2,3),
   (3,2);

Create table RS2(key int,value int);
Insert into RS2 Select r.a as key,r.b as value from R r;


Create or Replace Function mapper16(key int, value int) returns table(key int, value int) as
$$
  Select value, key;
$$ language sql;

Create or Replace Function reducer16(key int,valuesArray int[]) returns table(key int,value int[],sum int) as
$$
  Select key,valuesArray as value, (SELECT SUM(s)
                                    FROM UNNEST(valuesArray) s) as sum 
                                    where cardinality(valuesArray)<3;
$$ language sql;


With Map_Phase as (Select m.key,m.value 
				   from RS2, Lateral(Select key,value from mapper16(key,value))m),
				   
     Group_Phase as (Select value as key,array_agg(key) as value 
					 from Map_Phase Group by (value)),
					 
     Reducer_Phase as (Select r.key,r.value,r.sum 
					   from Group_Phase, Lateral(Select key,value,sum from reducer16(key,value))r)
					   
Select * from Reducer_Phase order by 1;


\qecho 'Problem 17'

drop table if exists R;
drop table if exists S;

create table R(K int, V int);
create table S(K int, W int);

insert into R values
   (1,1),
   (1,2),
   (1,3),
   (2,2),
   (2,3),
   (3,2),
   (7,7);

insert into S values
   (1,1),
   (1,2),
   (1,3),
   (3,2),
   (4,1),
   (4,2),
   (5,1),
   (5,2),
   (6,4),
   (6,5);

\qecho 'Problem 17.a'

-- Define a PostgreSQL view coGroup that computes a complex-object
-- relation that represent the co-group transformation R.cogroup(S). Show
-- that this view works.

CREATE type value_arr as (v1 int[],v2 int[]);

CREATE or replace view cogroup as
With all_keys as (select r.k from R r union select s.k from S s),
R_k as (select r.k,array_agg(r.v) as rv_values from R r group by(r.k)
union select ak.k,array[]::int[] as rv_values from all_keys ak where ak.k not in (select r.k from R r)),
S_k as (select s.k,array_agg(s.w) as sw_values from S s group by(s.k)
union select ak.k,array[]::int[] as sw_values from all_keys ak where ak.k not in (select s.k from S s))
select r.k, (r.rv_values,s.sw_values)::value_arr as rsdata from R_k r join S_k s on r.k = s.k;

SELECT * from cogroup;


\qecho 'Problem 17.b'

-- Write a PostgreSQL query that use this {\tt coGroup} view to
-- compute the semi join $R\, \ltimes\, S$, in other words compute the
-- relation $R \bowtie \pi_{K}(S)$.

select r.k,r.v from cogroup c, R r where r.k=c.k and (rsdata).v1=(rsdata).v2;

\qecho 'Problem 17.c'

-- Write a PostgreSQL query that uses this coGroup view to implement
-- the SQL query

SELECT distinct r.K as rK, s.K as sK
FROM   R r, S s
WHERE  NOT ARRAY(SELECT r1.V
                 FROM   R r1
                 WHERE  r1.K = r.K) && ARRAY(SELECT s1.W
                                             FROM   S s1
                                             WHERE  s1.K=s.K);

WITH coGroupData as (SELECT k, rsdata as v FROM cogroup)
SELECT c1.k as R_key, c2.k as S_key
FROM cogroup c1, cogroup c2
WHERE not (c1.rsdata).v1 && (c2.rsdata).v2
and CARDINALITY((c1.rsdata).v1) > 0 AND CARDINALITY((c2.rsdata).v2) > 0 order by 1;

\qecho ' COLLABORATED WITH SRIVARSHA CHELLAPILLA, ATHULYA ANAND, SIDDHANT SUNIL MESHRAM'

\c postgres
drop database sricharraanramaswamy;

