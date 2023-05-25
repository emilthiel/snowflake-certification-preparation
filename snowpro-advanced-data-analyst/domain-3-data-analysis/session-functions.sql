use role sysadmin;
use database snowflake_sample_data;
use schema tpch_sf1;
use warehouse prep_wh;
select current_schema();

-- EXPLAIN function

/*
Returns the logical execution plan for the specified SQL statement.

An explain plan shows the operations (for example, table scans and joins) that Snowflake would perform to execute the query.
 */

 explain using tabular
    select * from
      tpch_sf1.customer 
      where c_custkey > 10;

 explain using json
    select * from
      tpch_sf1.customer 
      where c_custkey > 10;

      