-- get number of active database connections in postgres
SELECT COUNT(*) FROM pg_stat_activity;

-- get count of column values
SELECT locale, COUNT(locale) AS locale_occurrence FROM users GROUP BY locale ORDER BY locale_occurrence DESC;

-- query for locks
SELECT t.relname,l.locktype,page,virtualtransaction,pid,mode,granted FROM pg_locks l, pg_stat_all_tables t WHERE l.relation=t.relid ORDER BY relation ASC;

-- kill a lock
SELECT pg_cancel_backend(pid);


-- mysql initialize
mysqld --initialize

-- remove mysql password:
--mysqladmin -u root -p CURRENT_PASSWORD password ""
SET PASSWORD FOR root@localhost=PASSWORD('');
-- if current password is unknown:
-- stop mysql server
-- mysqld_safe --skip-grant-tables
-- mysql -u root mysql
UPDATE user SET authentication_string=PASSWORD('') WHERE user='root';
