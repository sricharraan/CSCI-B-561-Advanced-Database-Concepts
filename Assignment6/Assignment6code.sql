\qecho 'Problem 3'
vacuum;
---Setting the value of memory as '4MB for default condition for question no. 3(a),3(b),3(c)'
set work.mem = '4MB';
--- Setting the memory to '64kB' for question 3(d) part 1 and reiterating sets same as question 3(a)
--set work.mem = '64kB';
--- Setting the memory to '1GB' for question 3(d) part 2 and reiterating sets same as question 3(a)
--set work.mem = '1GB';
create or replace function SetOfIntegers(n int, l int, u int)
returns table (x int) as
$$
    select floor(random() * (u-l+1) + l)::int from generate_series(1,n);
$$ language sql;

create or replace function makeS (n integer)
returns void as
$$
   begin
      drop table if exists S;
      create table S (x int);
      insert into S select * from SetOfIntegers(n,1,n);
   end;
$$ language plpgsql;
-- Problem 3.a
select makeS(10);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
select makeS(100);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
select makeS(1000);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
select makeS(10000);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
select makeS(100000);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
select makeS(1000000);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
select makeS(10000000);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
select makeS(100000000);
explain analyze select x from S;
vacuum;
explain analyze select x from S order by 1;
vacuum;
--Problem 3.e

create or replace function SetOfIntegers(n int, l int, u int)
    returns table (x int) as
$$
    select floor(random() * (u-l+1) + l)::int from generate_series(1,n);
$$ language sql;

create table indexedS (x integer);
 
drop table if exists indexedS;
--drop table executiontable
vacuum;
create table indexedS (x integer);
--create table executiontable (size integer, tm1 timestamp, tm2 timestamp);
insert into executiontable values (10, timeofday()::timestamp,null);
insert into executiontable values (10, timeofday()::timestamp,null);
insert into indexedS select * from SetOfIntegers(10,1,10);
insert into executiontable values (10, null, timeofday()::timestamp);
select *  from executiontable
drop table if exists indexedS; 
vacuum;
create table indexedS (x integer);
insert into indexedS select * from SetOfIntegers(10,1,10);
create index on indexedS using btree (x);
explain analyze select  x from indexedS where x between 1 and 10;

\qecho 'Question 10'
---Creating data for worksFor table
CREATE TABLE worksForMaster(pid integer,
                      cname text,
                      salary integer,
                      primary key (pid));

CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer);
					  
INSERT INTO worksForMaster VALUES
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
---For simplicity purposes creating an execute function to   generate large values of input 
select execute1('insert into worksFor
				select * from worksForMaster')
from generate_series(1, 1000);
drop table worksfor;
drop function if exists execute1(text);
create or replace function execute1 (sqlStatement text) 
returns table (pid int, cname text, salary integer) as
$$
begin
 return  query execute concat(sqlStatement, ' returning * ');
end;
$$ language plpgsql;
----Analysing the statement without using indexing
explain analyze select pid from worksFor where cname = 'Netflix';
----Analysing the statement with using btree indexing
create index wf_indx on worksFor(cname);
explain analyze select pid from worksFor where cname = 'Netflix';
drop index wf_indx;
----Analysing the statement with using hash indexing
create index wf_indx on worksFor using hash(cname);
explain analyze select pid from worksFor where cname = 'Netflix';
drop index wf_indx;
vacuum;

\qecho 'Question 11'
drop table worksfor;
CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer);
---For simplicity purposes creating an execute function to   generate large values of input 
select execute1('insert into worksFor
				select * from worksForMaster')
from generate_series(1, 1000);
----Analysing the statement without using indexing
explain analyze select pid,cname from worksFor where salary >= 50000 and salary <=60000;
----Analysing the statement with using btree indexing
create index wf_indx on worksFor(salary);
explain analyze select pid,cname from worksFor where salary >= 50000 and salary <=60000;
drop index wf_indx;
----Analysing the statement with using hash indexing
create index wf_indx on worksFor using hash(salary);
explain analyze select pid,cname from worksFor where salary >= 50000 and salary <=60000;
drop index wf_indx;
vacuum;

\qecho 'Question 12'
drop table worksfor;
CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer);
---For simplicity purposes creating an execute function to   generate large values of input 
select execute1('insert into worksFor
				select * from worksForMaster')
from generate_series(1, 1000);
----Analysing the statement without using indexing
explain analyze select pid from worksFor where salary = 50000 and cname = 'Netflix';
----Analysing the statement with using btree indexing
create index w_salary_cname_index on worksFor(salary,cname);
explain analyze select pid from worksFor where salary = 50000 and cname = 'Netflix';
drop index w_salary_cname_index;
----Analysing the statement with using hash indexing
create index w_salary_cname_index on worksFor using hash(salary,cname);
explain analyze select pid from worksFor where salary = 50000 and cname = 'Netflix';
drop index w_salary_cname_index;
vacuum;

\qecho 'Question 13'
---Creating data for Person table
CREATE TABLE Person(pid integer,
                    pname text,
                    city text,
                    primary key (pid))
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

create or replace function execute2 (n text) 
returns table (pid int, pname text, city text) as
$$
begin
 return  query execute concat(n, ' returning * ');
end;
$$ language plpgsql;

drop table worksFor;
drop table Pr;
CREATE TABLE Pr(pid integer,
                    pname text,
                    city text);
CREATE TABLE worksFor(pid integer,
                      cname text,
                      salary integer);
---For simplicity purposes creating an execute function to   generate large values of input 
select execute1('insert into worksFor
				select * from worksForMaster')
from generate_series(1, 10);
select execute2('insert into Pr
                select * from Person')
from generate_series(1, 1000);
----Analysing the statement without using indexing
explain analyze select pid,pname from Pr where pid in (select pid from worksFor where cname = 'Apple');
----Analysing the statement with using btree indexing
create index pr_indx on Pr(pid);
create index wf_indx on worksFor(cname);
explain analyze select pid,pname from Pr where pid in (select pid from worksFor where cname = 'Apple');
drop index pr_indx;
drop index wf_indx;
----Analysing the statement with using hash indexing
create index pr_indx on Pr using hash(pid);
create index wf_indx on worksFor using hash(cname);
explain analyze select pid,pname from Pr where pid in (select pid from worksFor where cname = 'Apple');

drop index pr_indx;
drop index wf_indx;
vacuum;
