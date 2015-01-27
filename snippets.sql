-- get count of column values
SELECT locale, COUNT(locale) AS locale_occurrence FROM users GROUP BY locale ORDER BY locale_occurrence DESC;
