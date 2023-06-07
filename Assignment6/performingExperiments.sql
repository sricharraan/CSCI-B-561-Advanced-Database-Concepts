-- The function queryPlan returns the query plan for the given sqlStatement

create or replace function queryPlan (sqlStatement text) 
returns table (queryPlanRow text) as
$$
begin
 return  query execute 'explain analyze ' || sqlStatement;
end;
$$ language plpgsql;

-- The function extractExecutionTime extracts the execution time of
-- the query plan for the given sqlStatement

create or replace function extractExecutionTime(sqlStatement text)
returns       float as
$$
   select substring(q.queryPlan,'([0-9.]+)')::float
   from   (select queryPlan from queryPlan(sqlStatement)) q
   where  q.queryPlan like '%Exec%';
$$ language sql;

-- The function runExperiment runs 'n' experiment for the
-- given queryStatement and returns their average execution time

create or replace function runExperiment(n int, queryStatement text) 
returns float as
$$
    select avg((select * from extractExecutionTime(queryStatement)))
    from   generate_series(1,n);
$$ language sql;

-- The 'experiment' function creates m relation S, with |S| = 10^k for k
-- in [k_1,k_2] and runs the (scan) query `SELECT x FROM S' n times.
-- Then the function returns the average execution times of these n
-- runs.

create or replace function experiment(m int, k_1 int, k_2 int, n int, sqlstatement text)
returns table(s int, e numeric) as
$$
begin
   drop table if exists executionTimeTable;
   create table executionTimeTable (size int, executionTime    float);   
   
   for i in 1..m loop
     for k in k_1..k_2 loop
      perform makeS(floor(power(10,k))::int);
      insert into executionTimeTable values(floor(power(10,k))::int, (select runexperiment(n,sqlstatement)));
    end loop;
   end loop;
   return query select size::int, round(avg(executiontime)::numeric,3)
                from   executionTimeTable 
                group by(size) order by 1;
end;
$$ language plpgsql;


-- Example:  SCANNING
-- Average execution times to analyze scanning a set S of increasing size
-- using the SQL statement  'SELECT x FROM S' statement.

select s as "size of relation S", e as "Average execution time for SELECT * FROM S"
from   experiment(5,1,7,5,'SELECT x FROM S');


/*
 size of relation S | Average execution time for SELECT x FROM S 
--------------------+--------------------------------------------
                 10 |                                      0.008
                100 |                                      0.023
               1000 |                                      0.142
              10000 |                                      1.352
             100000 |                                     13.343
            1000000 |                                    133.687
           10000000 |                                   1377.334
          100000000 |                                  14040.783
(8 rows)
*/

-- These execution times makes sense since scanning a relation is O(|S|).

