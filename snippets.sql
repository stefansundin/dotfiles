-- sqlite:
-- show table structure:
PRAGMA table_info(table_name);
select quote(flags) from users;
select quote(x'01');


-- psql:
-- show tables: \dt
-- list table: \d tablename
-- list installed extensions: \dx

-- list available extensions:
-- SELECT * FROM pg_available_extensions ORDER BY name ASC;
-- SELECT * FROM pg_available_extension_versions ORDER BY name ASC;
-- upgrade extension:
-- ALTER EXTENSION vector UPDATE TO '0.7.0';

-- pgAdmin disable update check:
-- echo 'UPGRADE_CHECK_ENABLED=False' >> '/Applications/pgAdmin 4.app/Contents/Resources/web/config_local.py'

-- Create postgres read-only user:
CREATE ROLE readonly WITH LOGIN PASSWORD 'readonly' NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE NOREPLICATION VALID UNTIL 'infinity';
GRANT CONNECT ON DATABASE YourDatabaseName TO readonly;
GRANT USAGE ON SCHEMA public TO readonly;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO readonly;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO readonly;

create table "users" (
  "id" uuid not null default gen_random_uuid(),
  "created_at" timestamptz not null default now(),
  "updated_at" timestamptz not null default now(),
  "name" varchar(255) not null,
  "email" varchar(255) unique not null,
  constraint "users_pkey" primary key ("id")
);

insert into "users" ("name", "email")
select
  'User ' || i::text,
  'user-' || i::text || '@example.com'
from generate_series(1, 100) s(i);


SELECT SLEEP(5);

-- get number of active database connections in postgres
SELECT COUNT(*) FROM pg_stat_activity;

-- get count of column values
SELECT locale, COUNT(locale) AS locale_occurrence FROM users GROUP BY locale ORDER BY locale_occurrence DESC;

-- query for locks
SELECT t.relname,l.locktype,page,virtualtransaction,pid,mode,granted FROM pg_locks l, pg_stat_all_tables t WHERE l.relation=t.relid ORDER BY relation ASC;

-- kill a lock
SELECT pg_cancel_backend(pid);

-- one-off max execution time
SELECT /*+ MAX_EXECUTION_TIME(1000) */ * FROM posts;

-- output results vertically with \G
SELECT * FROM posts\G

CREATE TABLE posts (
  `id` bigint(20) PRIMARY KEY AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `title` text NOT NULL,
  `body` text NOT NULL
);
INSERT INTO posts (user_id,title,body) VALUES (1, 'first post', 'first!');
INSERT INTO other_database.dummy (user_id,title,body) VALUES (1, 'first post', 'first!');

-- login path
mysql_config_editor set --login-path=root --user=root --skip-warn --password
mysql --login-path=root -e "SHOW DATABASES"
-- get plain text password:
my_print_defaults -s root


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


-- mysqldump \
--   --protocol=tcp --host=localhost --port=3366 \
--   --user=root --password=asd \
--   --all-databases \
--   --single-transaction \
--   --routines \
--   --triggers \
--   --compress \
--   --compact > mysql-$(date +%F-%T).dump



-- https://upload.wikimedia.org/wikipedia/commons/e/e2/MySQL.pdf
-- https://en.wikibooks.org/wiki/MySQL/Language/Definitions:_what_are_DDL,_DML_and_DQL%3F
--
-- DDL (Data Definition Language) refers to the CREATE, ALTER and DROP statements: DDL allows to add / modify / delete the logical structures which contain the data or which allow users to access / maintain the data (databases, tables, keys, views...). DDL is about "metadata".
-- DML (Data Manipulation Language) refers to the INSERT, UPDATE and DELETE statements: DML allows to add / modify / delete data itself.
-- DQL (Data Query Language) refers to the SELECT, SHOW and HELP statements (queries): SELECT is the main DQL instruction. It retrieves data you need. SHOW retrieves infos about the metadata. HELP is for people who need help.
-- DCL (Data Control Language) refers to the GRANT and REVOKE statements: DCL is used to grant / revoke permissions on databases and their contents. DCL is simple, but MySQL's permissions are rather complex. DCL is about security.
-- DTL (Data Transaction Language) refers to the START TRANSACTION, SAVEPOINT, COMMIT and ROLLBACK [TO SAVEPOINT] statements: DTL is used to manage transactions (operations which include more instructions none of which can be executed if one of them fails).
