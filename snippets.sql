-- get number of active database connections in postgres
SELECT COUNT(*) FROM pg_stat_activity;

-- get count of column values
SELECT locale, COUNT(locale) AS locale_occurrence FROM users GROUP BY locale ORDER BY locale_occurrence DESC;
