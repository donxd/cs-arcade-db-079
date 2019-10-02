/*Please add ; after each select statement*/
CREATE PROCEDURE unluckyEmployees()
BEGIN
    SET @n = 0;
    SET @nn = 0;

    SELECT 
      rrr.dep_name
    , rrr.emp_number
    , rrr.total_salary
    FROM (
        SELECT 
          rr.dep_name
        , rr.emp_number
        , rr.total_salary
        , (@nn := @nn + 1) id
        FROM (
            SELECT 
              r.dep_name
            , CASE WHEN r.total_salary IS NULL THEN 0 ELSE r.emp_number END emp_number
            , CASE WHEN r.total_salary IS NULL THEN 0 ELSE r.total_salary END total_salary
            , r.id
            -- , r.dep_id
            FROM (
                SELECT 
                (@n := @n + 1) id
                , d.*
                FROM (
                    SELECT 
                    d.name dep_name
                    , d.id dep_id
                    , COUNT(*) emp_number
                    , SUM(e.salary) total_salary
                    FROM Employee e RIGHT JOIN 
                    Department d ON e.department = d.id
                    GROUP BY d.id
                ) d
                ORDER BY d.total_salary DESC, d.emp_number DESC, d.dep_id ASC
            ) r
            WHERE 
            r.emp_number < 6 
        ) rr
    ) rrr
    WHERE 
    -- rrr.emp_number = 0 OR rrr.id % 2 != 0
    rrr.id % 2 != 0
    ;
END