# performance_schema データベースにて
## setup_consumers テーブルでは、パフォーマンススキーマが計測した統計を記録するかどうかを設定
UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%events_statements_%';
UPDATE performance_schema.setup_consumers SET ENABLED = 'YES' WHERE NAME LIKE '%events_stages_%';

## setup_instruments テーブルでは、setup_consumersテーブルよりさらに細分化された「パフォーマンススキーマがどのイベントの統計情報を記録するか」を設定
UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', TIMED = 'YES' WHERE NAME LIKE '%statement/%';
UPDATE performance_schema.setup_instruments SET ENABLED = 'YES', TIMED = 'YES' WHERE NAME LIKE '%stage/%';

# 測定
# noinspection SqlResolve
SELECT EVENT_ID,
       TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
       SQL_TEXT
FROM performance_schema.events_statements_history_long
WHERE SQL_TEXT = "select * from item_index where str2 like '2525%'";


SELECT EVENT_ID,
       TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
       SQL_TEXT
FROM performance_schema.events_statements_history_long
WHERE SQL_TEXT like 'select%'
ORDER BY EVENT_ID DESC
LIMIT 1;


SELECT EVENT_ID,
       TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
       SQL_TEXT
FROM performance_schema.events_statements_history_long
WHERE SQL_TEXT = "select * from item where str like '%2%' and str2 like '%525%'";


SELECT EVENT_ID,
       TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
       SQL_TEXT
FROM performance_schema.events_statements_history_long
WHERE SQL_TEXT = "select * from item where str2 like '%525%' and str like '%2%'";


SELECT table_schema, table_name, data_free, table_rows
FROM information_schema.tables
WHERE table_schema = 'performance';




