
use role sysadmin;
use database snowflake_sample_data;
use schema tpch_sf1;
use warehouse prep_wh;
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