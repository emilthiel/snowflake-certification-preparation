
use role sysadmin;
use database snowflake_sample_data;
use schema tpch_sf1;
use warehouse compute_wh;
select current_schema();

-- DENSE_RANK function

/*

Returns the rank of a value within a group of values, without gaps in the ranks.

The rank value starts at 1 and continues up sequentially.

If two values are the same, they have the same rank.
    

 */

use database prep_snowpro_data_analyst;

create or replace table corn_production (farmer_ID INTEGER, state varchar, bushels float);
insert into corn_production (farmer_ID, state, bushels) values
    (1, 'Iowa', 100),
    (2, 'Iowa', 110),
    (3, 'Kansas', 120),
    (4, 'Kansas', 130),
    (5, 'Iowa', 110),
    (6, 'Iowa', 110);

-- We see here that the RANK function returns 5 for the last rows and effectivly skips 4 as there is a tie for 3rd.
-- DENSE_RANK does not.
select 
    state,
    bushels,
    rank() over (order by bushels desc),
    dense_rank() over (order by bushels desc)
from
    public.corn_production;

select 
    state,
    bushels,
    dense_rank() over (partition by state order by bushels desc)
from
    public.corn_production;


/*
NTILE
Divides an ordered data set equally into the number of buckets specified by constant_value. Buckets are sequentially numbered 1 through constant_value.

Usage Notes
If the data is partitioned, then the data is divided into buckets equally within each partition. For example, if the number of buckets is 3, and if the data is partitioned by province, then approximately 1/3 of the rows for each province are put into each bucket.

If the statement has an ORDER BY clause for the output, as well as an ORDER BY clause for the NTILE function, the two operate independently; the ORDER BY for the NTILE function influences which rows are assigned to each bucket, while the ORDER BY for the output determines the order in which the output rows are shown.
 */

select * from tpch_sf1.customer limit 100;

select 
    *,
    ntile(4) over (partition by c_nationkey order by c_nationkey)
from 
    tpch_sf1.customer 
limit 10000;


with data as (
    select 
        $1 as farmer_id,
        $2 as state,
        $3 as bushels
    from
        (
            values
            (1, 'Iowa', 100),
            (2, 'Iowa', 110),
            (3, 'Kansas', 120),
            (4, 'Kansas', 130),
            (5, 'Iowa', 110),
            (6,'Iowa', 110)
        )
)

select
    *,
    ntile(2) over (partition by state order by farmer_id) as ntile_3
from  
    data
order by ntile_3; 