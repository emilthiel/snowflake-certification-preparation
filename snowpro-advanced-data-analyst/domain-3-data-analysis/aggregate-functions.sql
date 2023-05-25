-- setup
use role sysadmin;
use database snowflake_sample_data;
use schema tpch_sf1;
use warehouse prep_wh;
select current_schema();

-- APPROX_COUNT_DISTINCT aka HLL function

/*
Uses HyperLogLog to return an approximation of the distinct cardinality of the input 
(i.e. HLL(col1, col2, ... ) returns an approximation of COUNT(DISTINCT col1, col2, ... )).
 */

select
    -- Uses the HyperLogLog method to find a approx distinct count of values in a given set of columns
   approx_count_distinct(a.c_custkey, a.c_name),
   approx_count_distinct(*),
   HLL(a.c_custkey, a.c_name) -- This is an name for the same function (HLL == HyperLogLog)
from
 tpch_sf1.customer as a;

-- Can also be used with a window function

select
    a.c_nationkey,
    approx_count_distinct(a.c_custkey) over (partition by a.c_nationkey)
FROM
    tpch_sf1.customer as a;


