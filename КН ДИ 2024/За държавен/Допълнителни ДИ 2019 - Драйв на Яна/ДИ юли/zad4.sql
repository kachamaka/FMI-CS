

select
  m1.NETWORTH
from
  MOVIEEXEC m1
where
  not exists(
    select
      *
    from
      MOVIEEXEC m2
    where
      m1.NETWORTH < m2.NETWORTH
  );
SELECT
  NETWORTH
FROM
  MOVIEEXEC
WHERE
  NETWORTH <= ALL (
    SELECT
      NETWORTH
    FROM
      MOVIEEXEC
  );