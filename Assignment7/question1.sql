-- Helper Functions
drop function if exists SetOfIntegers(int, int, int);
create or replace function SetOfIntegers(n int, l int, u int)
	returns table (x int) as
	$$
		select floor(random() * (u-l+1) + l)::int as x
		from generate_series(1,n)
		group by (x) order by 1;
	$$ language sql;

drop function if exists BinaryRelationOverIntegers(int, int, int, int ,int);
create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
	returns table (x int, y int) as
	$$
		select floor(random() * (u_1-l_1+1) + l_1)::int as x,
		floor(random() * (u_2-l_2+1) + l_2)::int as y
		from generate_series(1,n)
		group by (x,y) order by 1,2;
	$$ language sql;

drop table if exists P; create table P(x int);
drop table if exists Q; create table Q(x int);
drop table if exists R; create table R(x int, y int);
drop table if exists S; create table S(x int, z int);

INSERT INTO P
	select * from SetOfIntegers(1000, 1, 100);

INSERT INTO Q
	select * from SetOfIntegers(1000, 1, 100);

INSERT INTO R
	select * from BinaryRelationOverIntegers(1000, 1, 100, 1, 100);

INSERT INTO S
	select * from BinaryRelationOverIntegers(1000, 1, 100, 1, 100);


-- Query 1
set enable_mergejoin = off; set enable_hashjoin = off; set enable_material = off;
explain
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and exists (select 1 
			  						      from s s
			  						      where s.x <> q.x or r.y <> s.z));

-- Query 2
set enable_mergejoin = on; set enable_hashjoin = on;
explain
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and exists (select 1 
			  						      from s s
			  						      where s.x <> q.x or r.y <> s.z));

-- Query 3
drop index if exists indexed_s;
create index indexed_s on s using hash (x);
explain
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and exists (select 1 
			  						      from s s
			  						      where s.x <> q.x or r.y <> s.z));


-- Query 4
drop index if exists indexed_s;
explain
select p.x, q.x
from P p, Q q
where exists (select 1 
			  from r r
			  where r.x = p.x and (q.x not in (select s.x 
			  								   from s s) or r.y not in(select s.z
			  								   						   from s s)));

-- Query 5
explain
select p.x, q.x
from P p, Q q, R r
where r.x = p.x and (q.x not in (select s.x 
		  					 	 from s s) or r.y not in(select s.z
		  					 	 						 from s s));

-- Query 6
explain
select p.x, q.x
from P p, Q q, R r, S s
where r.x = p.x and (q.x <> s.x or r.y <> s.z);


-- Query 7
explain
select p.x, qs.x
from (select x, y from P natural join R) p
join
(select q.x, s.z from Q inner join S on Q.x <> S.x) qs on (p.y <> qs.z);




	

