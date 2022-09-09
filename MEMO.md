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

## SELECT (like 前方一致)
```
mysql> explain select * from item_index where str like '2525%';
+----+-------------+------------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
| id | select_type | table      | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                 |
+----+-------------+------------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
|  1 | SIMPLE      | item_index | NULL       | range | str           | str  | 123     | NULL |   16 |   100.00 | Using index condition |
+----+-------------+------------+------------+-------+---------------+------+---------+------+------+----------+-----------------------+
1 row in set, 1 warning (0.00 sec)

mysql> explain select * from item_index where str2 like '2525%';
+----+-------------+------------+------------+------+---------------+------+---------+------+---------+----------+-------------+
| id | select_type | table      | partitions | type | possible_keys | key  | key_len | ref  | rows    | filtered | Extra       |
+----+-------------+------------+------------+------+---------------+------+---------+------+---------+----------+-------------+
|  1 | SIMPLE      | item_index | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 1025729 |    11.11 | Using where |
+----+-------------+------------+------------+------+---------------+------+---------+------+---------+----------+-------------+
1 row in set, 1 warning (0.00 sec)


mysql> select * from item_index where str like '2525%';
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
| id      | num      | str                            | str2                           | str3                           |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
|  313398 | 85837869 | 252508d609f958630a9dcb2d9ba789 | bbdb77965cde796bf7a9d1e695f0fa | ffe0bab08765e1ac41307698f2df39 |
|  327790 |    50547 | 25251720222d7239e2405d6bc805e8 | 0fd9efdc8289697d0e799a4c0f4880 | 64b451b84e291812854b90913dc430 |
|  521856 | 29352380 | 25251838d8910a2272faee5570df50 | 0ab4e59d2ef4ea4b796f9e0f5a9755 | 29e39bb3da129f5695992e652ca0c3 |
|  476411 | 96355254 | 252526178bf641f6a7fbec8050477d | ed804e5b9d6d90b0483032c4ccfd17 | f0e75fad6789095efaa978e1306075 |
| 1001715 | 53102259 | 252536f24d6739dd7dcb41cbc01b8f | 26071fdd29e14438305688d329553f | e7de7b1bb239039e291d0273beed53 |
|  520034 | 23894284 | 25253892a526adab13884a7614394e | 3dca5d031578fd979f5ac218f60d91 | b7b60eb6a3d9ce7c78ae8641c3806c |
|  364937 | 61090270 | 25254323b383bdc412c6b27f63f983 | a770c5b3e79635f4984eeafddd764d | da43c2ad3ea6b86eeba2c6004abe09 |
|  805724 | 83106605 | 252551ef3cbc9c5c728249fe62de8e | a25121fb9667c8e0996b3f899b59ba | 877e4cb6522049d85a6ba4ed912aa5 |
| 1147724 | 68907209 | 252551ef3cbc9c5c728249fe62de8e | 9d3e094ba61c2af5dcce0b94fe20a5 | c9479567d4cb842bf804852ebe1695 |
|   35499 | 53232954 | 252553c1c0d8158232b8ad834f8660 | 02bcbae145f4199625acde12e6d213 | e0f5866dc3653a6a4266d247b09f7f |
|  557716 |  9728422 | 252553c1c0d8158232b8ad834f8660 | 0ae46e7c380856b8238eaa49050317 | c2ba054ca42a78bc2f6d81eeb6289b |
|  836963 | 87808934 | 2525540c7323db18084dcbc77ac425 | ff6c013e31d1fa1bbea1ab6fb99a8d | 5d5ecb628330634b35009809579bb4 |
|  358074 | 62078583 | 25256cb0cde2f34f61fa8d9b556452 | 0b15390a0c9ff11baf5b31e5919e1b | 58091fb343e86fde0039f928d7b437 |
|  878627 | 47839986 | 2525ab3f206348d993a337da3ead78 | f1e1c67d58e2ce71ba76a064fb4471 | d2ca8bbe66bcc9b0160b336b20e76f |
| 1015427 | 51767479 | 2525ab3f206348d993a337da3ead78 | 9e38bcdfeadc8b25c0f4a393050872 | 991a372a211e1e544b37873604e3dc |
|  625737 | 50604677 | 2525adce47e7beacddc3780f6e6e70 | 4b5a4c181e800a621a58028e7be53e | d2d90911a7321ae90790560a9166af |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
16 rows in set (0.00 sec)

mysql> select * from item_index where str2 like '2525%';
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
| id      | num      | str                            | str2                           | str3                           |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
|  490800 | 75122266 | cb4a3cb23eb6a52cd55ed4189b6968 | 2525bdf7d524db6ce70137797dd73f | 91798c00b708ff62d5dcd350cdc479 |
|  498313 | 69028910 | c3416789935b5e953be4132c3db062 | 25253cf750e2754b93953de76608ab | d9ea725c7a6f252de6525bbfc303eb |
|  621159 | 26519974 | 0a638fdba252cc3a4554cd4b305dcd | 2525fd4e4c22ca93d5dd7d9edfd272 | c12d8143ca6d55df3316ad56b2729b |
|  689017 | 29518800 | 4704829d80beff338fb22bfc943668 | 25253c8be4216de0a9af2abc1dfbc0 | ef81002194d654cb689bd87cd7ebe8 |
|  794961 |  9968089 | 4b39d2a8c221986633a85aa536e8d6 | 2525b5682be26f79f467f8433a5f6b | a11c668e43de312ceb675fcebee741 |
|  797089 |  5887060 | 2b139e074af36ffba197975ecafa65 | 252553c2e5c5c03d675aab0c609966 | db593b2d5f238759b666bd64f3a66f |
|  805006 | 25680228 | 0b25584d0ac86dcd7088ad4fb0d387 | 2525340315786cccb52fa710132888 | f5e7aa533bc1ee9310da1e7e4878a1 |
|  859691 | 54942597 | cde47ab541a6bfa824345b5a5ad571 | 2525bdf7d524db6ce70137797dd73f | e985e2a631b2c00c30bbadd8d710e5 |
|  868548 | 88431187 | 51c53e0a217e1e5b83673b47f6dc15 | 25253c8be4216de0a9af2abc1dfbc0 | 357a7a61a84aba8837aa30c8d8ffc4 |
|  920630 | 10397267 | 9004c51aba4961d3cab1301dc128f2 | 2525e1f4d4f53232e0014912f0afbd | e1fcb8538cd2c15ade605c3418de85 |
|  950891 | 23220543 | 36b6976f4227bf8246aff944b563cc | 2525bdf7d524db6ce70137797dd73f | a3e1dc2b055b3e8032c62fbbf998b6 |
|  957537 | 56719984 | f25e0821e135649b2e97e220becc51 | 2525fc92815ac36f7471782fc46a70 | 7d31ce2488553122f5dcb6d0f0bd63 |
|  983937 | 20880365 | d29db4f45d908bffa80c5991a6764b | 252575454811e7a0069a8829fef035 | 48e0269eb6b7b13325cf4ca42ad1b6 |
| 1210794 | 62946525 | 89375d1f026556f9d761bd65708221 | 25256e9d2c20373b00ac61868d209a | c306e65e1d7c11adc05888fe603ebc |
| 1272986 | 77616218 | d0c7d2d3381a48fda52b930cec3f6f | 25250198f0c2058e6f20b2c65a54eb | 3bb51a2b20dfa602bdd6c99fb5bbea |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
15 rows in set (0.36 sec)
```

```
mysql> SELECT EVENT_ID,
    ->        TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
    ->        SQL_TEXT
    -> FROM performance_schema.events_statements_history_long
    -> WHERE SQL_TEXT = "select * from item_index where str like '2525%'";
+----------+----------+-------------------------------------------------+
| EVENT_ID | Duration | SQL_TEXT                                        |
+----------+----------+-------------------------------------------------+
|       19 | 0.001083 | select * from item_index where str like '2525%' |
+----------+----------+-------------------------------------------------+
1 row in set (0.00 sec)

mysql> SELECT EVENT_ID,
    ->        TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
    ->        SQL_TEXT
    -> FROM performance_schema.events_statements_history_long
    -> WHERE SQL_TEXT = "select * from item_index where str2 like '2525%'";
+----------+----------+--------------------------------------------------+
| EVENT_ID | Duration | SQL_TEXT                                         |
+----------+----------+--------------------------------------------------+
|       38 | 0.360689 | select * from item_index where str2 like '2525%' |
+----------+----------+--------------------------------------------------+
1 row in set (0.00 sec)
```



