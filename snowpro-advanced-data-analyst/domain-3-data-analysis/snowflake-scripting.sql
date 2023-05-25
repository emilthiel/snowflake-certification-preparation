use role sysadmin;
use database snowflake_sample_data;
use schema tpch_sf1;
use warehouse prep_wh;
select current_schema();

-- EXCEPTION handling

/*
To raise an exception use the RAISE command
 */

 declare 
    my_exception exception (-20020, 'Raised MY EXCEPTION');
begin
    let counter := 0;
    let should_raise_exception := true; -- try to set to false and see that it executes oks
    if (should_raise_exception) then
        raise my_exception;
    end if;
    counter := counter + 1;
    return counter;
end;


DECLARE
  my_exception EXCEPTION (-20002, 'Raised MY_EXCEPTION.');
BEGIN
  LET counter := 0;
  LET should_raise_exception := true;
  IF (should_raise_exception) THEN
    RAISE my_exception;
  END IF;
  counter := counter + 1;
  RETURN counter;
EXCEPTION
  WHEN statement_error THEN
    RETURN OBJECT_CONSTRUCT('Error type', 'STATEMENT_ERROR',
                            'SQLCODE', sqlcode,
                            'SQLERRM', sqlerrm,
                            'SQLSTATE', sqlstate);
  WHEN my_exception THEN
    RETURN OBJECT_CONSTRUCT('Error type', 'MY_EXCEPTION',
                            'SQLCODE', sqlcode,
                            'SQLERRM', sqlerrm,
                            'SQLSTATE', sqlstate);
  WHEN OTHER THEN
    RETURN OBJECT_CONSTRUCT('Error type', 'Other error',
                            'SQLCODE', sqlcode,
                            'SQLERRM', sqlerrm,
                            'SQLSTATE', sqlstate);
END;