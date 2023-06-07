-- Helper Functions
create or replace function SetOfIntegers(n int, l int, u int)
	returns table (x int) as
	$$
		select floor(random() * (u-l+1) + l)::int as x
		from generate_series(1,n)
		group by (x) order by 1;
	$$ language sql;

create or replace function BinaryRelationOverIntegers(n int, l_1 int, u_1 int, l_2 int, u_2 int)
	returns table (x int, y int) as
	$$
		select floor(random() * (u_1-l_1+1) + l_1)::int as x,
		floor(random() * (u_2-l_2+1) + l_2)::int as y
		from generate_series(1,n)
		group by (x,y) order by 1,2;
	$$ language sql;

-- Creating Tables

drop table if exists P;create table P(a int);
drop table if exists S;create table S(b int);

-- Generate P
insert into p
	select * from SetOfIntegers(1000000, 1, 10000);

-- Generate S
insert into S
	select * from SetOfIntegers(1000000, 1, 10000);

-- Generate R - 10^2
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^3
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^4
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(10000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^5
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(100000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^6
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(1000000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;

-- Generate R - 10^7
drop table if exists R;
vacuum;
create table R(a int, b int);
insert into R
	select * from BinaryRelationOverIntegers(10000000, 1, 10000, 1, 10000);

-- Analyzing unoptimized query
explain analyze
select distinct p.a
from P p, R r1, R r2, R r3, S s
where p.a = r1.a and r1.b = r2.a and r2.b = r3.a and r3.b = S.b;

-- Analyzing optimized RA-SQL Query
explain analyze
select distinct p.a
from P as p
inner join R as r1 on p.a = r1.a
inner join R as r2 on r1.b = r2.a
inner join R as r3 on r2.a = r3.a
inner join S as s on r3.b = s.b;



