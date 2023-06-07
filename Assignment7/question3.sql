-- Helper Functions
drop function if exists SetOfIntegers(int, int, int);
create or replace function SetOfIntegers(n int, l int, u int)
	returns table (x int) as
	$$
		select floor(random() * (u-l+1) + l)::int as x
		from generate_series(1,n)
		group by (x) order by 1;
	$$ language sql;

drop function if exists BinaryRelationOverIntegers(int, int, int, int, int);
create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
	returns table (x int, y int) as
	$$
		select floor(random() * (u_1-l_1+1) + l_1)::int as x,
		floor(random() * (u_2-l_2+1) + l_2)::int as y
		from generate_series(1,n)
		group by (x,y) order by 1,2;
	$$ language sql;

-- Creating Tables


-- 1

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 100);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 100);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 100, 1, 10000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));


-----------------------------------------------------------------------------------------------------------
-- 2

-- Generate R - 10^3
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000, 1, 100, 1, 100);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

-----------------------------------------------------------------------------------------------------------
-- 3

-- Generate R - 10^4
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(10000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

-----------------------------------------------------------------------------------------------------------
-- 4

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^3
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

----------------------------------------------------------------------------------------------------------
-- 5

-- Generate P - 10^2
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100, 1, 1000);

-- Generate S - 10^4
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(10000, 1, 1000);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

----------------------------------------------------------------------------------------------------------
-- 6

-- Generate P - 10^3
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate S - 10^2
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

----------------------------------------------------------------------------------------------------------
-- 7

-- Generate P - 10^4
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(10000, 1, 1000);

-- Generate S - 10^3
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(1000, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));

---------------------------------------------------------------------------------------------------------
-- 8

-- Generate P - 10^5
drop table if exists p;
vacuum;
create table P(a int);
insert into p
	select * from SetOfIntegers(100000, 1, 1000);

-- Generate S - 10^5
drop table if exists s;
vacuum;
create table S(b int);
insert into S
	select * from SetOfIntegers(100000, 1, 1000);

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 1000, 1, 1000);

-- Analyzing Q5 1
explain analyze
select p.a
from P p
where exists (select 1
from R r
where r.a = p.a and
not exists (select 1 from S s where r.b = s.b));

-- Analyzing Q6 1
explain analyze
select p.a
from p p
natural join (select r.*
			  from r
			  except
			  select r.*
			  from r
			  natural join s) q;

-- Analyzing Q7 1
explain analyze
with nestedR as (select P.a, array_agg(R.b) as bs
				 from P natural join R
				 group by (P.a)),
	 Ss as (select array(select b from S) as bs)
select a
from nestedR
where not (bs <@ (select bs from Ss));