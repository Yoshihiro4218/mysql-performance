# MEMO
## やろうかと思っていること
- インデックスの有無での SELECT, INSERT, 文字列や数値
- インデックスを無駄に大量に貼ったとき
- 絞り込みのタイミング
- あとで index を貼る時間(レコード数ごと)


## ログのメモ
### index なしの INSERT
```
mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 1024 rows affected (0.02 sec)
Records: 1024  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 2048 rows affected (0.04 sec)
Records: 2048  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 4096 rows affected (0.08 sec)
Records: 4096  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 8192 rows affected (0.15 sec)
Records: 8192  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 16384 rows affected (0.29 sec)
Records: 16384  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 32768 rows affected (0.37 sec)
Records: 32768  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 65536 rows affected (0.84 sec)
Records: 65536  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 131072 rows affected (1.12 sec)
Records: 131072  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 262144 rows affected (2.54 sec)
Records: 262144  Duplicates: 0  Warnings: 0
```

### index ありの INSERT
```
mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 1024 rows affected (0.05 sec)
Records: 1024  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 2048 rows affected (0.09 sec)
Records: 2048  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 4096 rows affected (0.10 sec)
Records: 4096  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 8192 rows affected (0.23 sec)
Records: 8192  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 16384 rows affected (0.31 sec)
Records: 16384  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 32768 rows affected (0.54 sec)
Records: 32768  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 65536 rows affected (0.81 sec)
Records: 65536  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 131072 rows affected (2.16 sec)
Records: 131072  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 262144 rows affected (4.08 sec)
Records: 262144  Duplicates: 0  Warnings: 0

```

### 無駄な index ありの INSERT
```
mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 1024 rows affected (0.12 sec)
Records: 1024  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 2048 rows affected (0.28 sec)
Records: 2048  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 4096 rows affected (0.17 sec)
Records: 4096  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 8192 rows affected (0.39 sec)
Records: 8192  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 16384 rows affected (0.72 sec)
Records: 16384  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 32768 rows affected (1.67 sec)
Records: 32768  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 65536 rows affected (2.55 sec)
Records: 65536  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 131072 rows affected (6.20 sec)
Records: 131072  Duplicates: 0  Warnings: 0

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 262144 rows affected (10.29 sec)
Records: 262144  Duplicates: 0  Warnings: 0
```