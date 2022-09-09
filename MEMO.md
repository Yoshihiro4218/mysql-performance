# やろうかと思っていること
- インデックスの有無での SELECT, INSERT, 文字列や数値
- インデックスを無駄に大量に貼ったとき
- 絞り込みのタイミング
- あとで index を貼る時間(レコード数ごと)


# ログのメモ
## index なしの INSERT
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

mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 524288 rows affected (5.07 sec)
Records: 524288  Duplicates: 0  Warnings: 0
```

## index ありの INSERT
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

mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 524288 rows affected (7.73 sec)
Records: 524288  Duplicates: 0  Warnings: 0
```

## 無駄な index ありの INSERT
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

mysql> INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
Query OK, 524288 rows affected (19.93 sec)
Records: 524288  Duplicates: 0  Warnings: 0
```

## 100万 全レコード UPDATE
### インデックスなし
```
mysql> UPDATE item
    -> SET num  = CEIL(RAND() * 100000000),
    ->     str  = SUBSTRING(MD5(RAND()), 1, 30),
    ->     str2 = SUBSTRING(MD5(RAND()), 1, 30),
    ->     str3 = SUBSTRING(MD5(RAND()), 1, 30);

Query OK, 1048576 rows affected (22.64 sec)
Rows matched: 1048576  Changed: 1048576  Warnings: 0
```

### インデックスあり
```
mysql> UPDATE item_index
    -> SET num  = CEIL(RAND() * 100000000),
    ->     str  = SUBSTRING(MD5(RAND()), 1, 30),
    ->     str2 = SUBSTRING(MD5(RAND()), 1, 30),
    ->     str3 = SUBSTRING(MD5(RAND()), 1, 30);

Query OK, 1048576 rows affected (2 min 2.74 sec)
Rows matched: 1048576  Changed: 1048576  Warnings: 0
```

### 無駄にインデックスあり
```
mysql> UPDATE item_index_2
    -> SET num  = CEIL(RAND() * 100000000),
    ->     str  = SUBSTRING(MD5(RAND()), 1, 30),
    ->     str2 = SUBSTRING(MD5(RAND()), 1, 30),
    ->     str3 = SUBSTRING(MD5(RAND()), 1, 30);

Query OK, 1048576 rows affected (30 min 19.58 sec)
Rows matched: 1048576  Changed: 1048576  Warnings: 0
```

## SELECT (like 前方一致: index なしとあり)

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

## SELECT (like 前方一致: index なし/1つ/2つ(複合))
```
mysql> explain select * from item where str like '25%' and str2 like '25%';
+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
| id | select_type | table | partitions | type | possible_keys | key  | key_len | ref  | rows   | filtered | Extra       |
+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
|  1 | SIMPLE      | item  | NULL       | ALL  | NULL          | NULL | NULL    | NULL | 974382 |     1.23 | Using where |
+----+-------------+-------+------------+------+---------------+------+---------+------+--------+----------+-------------+
1 row in set, 1 warning (0.00 sec)

mysql> explain select * from item_index where str like '25%' and str2 like '25%';
+----+-------------+------------+------------+-------+---------------+------+---------+------+------+----------+------------------------------------+
| id | select_type | table      | partitions | type  | possible_keys | key  | key_len | ref  | rows | filtered | Extra                              |
+----+-------------+------------+------------+-------+---------------+------+---------+------+------+----------+------------------------------------+
|  1 | SIMPLE      | item_index | NULL       | range | str           | str  | 123     | NULL | 6976 |    11.11 | Using index condition; Using where |
+----+-------------+------------+------------+-------+---------------+------+---------+------+------+----------+------------------------------------+
1 row in set, 1 warning (0.00 sec)

mysql> explain select * from item_index_2 where str like '25%' and str2 like '25%';
+----+-------------+--------------+------------+-------+-------------------------------------------------------+--------+---------+------+------+----------+----------------------------------+
| id | select_type | table        | partitions | type  | possible_keys                                         | key    | key_len | ref  | rows | filtered | Extra                            |
+----+-------------+--------------+------------+-------+-------------------------------------------------------+--------+---------+------+------+----------+----------------------------------+
|  1 | SIMPLE      | item_index_2 | NULL       | range | str,str2,str_2,str_3,str2_2,str_4,str_5,str2_3,str2_4 | str2_4 | 123     | NULL | 6668 |     0.65 | Using index condition; Using MRR |
+----+-------------+--------------+------------+-------+-------------------------------------------------------+--------+---------+------+------+----------+----------------------------------+
1 row in set, 1 warning (0.02 sec)

mysql> select * from item where str like '25%' and str2 like '25%';
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
| id      | num      | str                            | str2                           | str3                           |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
|  153949 | 49774956 | 25d600ac2c7fb8251a476b8d3bea01 | 25d2b1c4f5afae110851df9c9cb648 | b952498c75c34d85499479b0266b0a |
|  373144 | 20906882 | 2503963b768ab2ebe01f9a0d2aa8eb | 251207092fa644ec3b3cccaf663958 | 0746ba6f5a41bda72f0c647c3ec69c |
|  539548 | 25948911 | 25246fc80211409af3d4bcdecbb6d5 | 25a7f32ae272f245493275ecee2cb4 | d5ed60e65ef84750f6e000e34ac6b1 |
|  652618 | 63390992 | 25fcc3300b6cb3ca95e28ce95d3f04 | 25575dbc6620852c174c1254a90907 | 610b88e712b6ea37b70c8ece24de0f |
|  711712 | 78767158 | 2562900b14f1f728c8a03b7394c567 | 25ebf0d9bb74c46e59b03653b5791f | 0363354a83841fb2dbe64c93210fed |
|  861367 | 21899693 | 257f26dc34181e954cb1ff115caf7d | 2511c6f2777ba546c1eb46104650c5 | 9d2fe81969d9b6fdf3672b25ec3a60 |
|  941446 | 13647986 | 25df6f6c01213af3ce498f5982fe3f | 25592c127b51ba7e34381d97bf6563 | eaa3fc271c86de51c699dc96a63c32 |
|  990901 |  8767633 | 2553199700facaa36d5e442d4d16c4 | 2550a70c0b4c5b4d4ec85f10c97086 | ffa1e4825549aeb7edd333c1ff4dfb |
| 1077636 | 40475056 | 25b5b94c5d7ea0ecfce09f8da47c90 | 2520804ebe0653c483663f345cde17 | 6972ed7752911b52fd4a0578b3cb6d |
| 1241963 | 71155402 | 253e0566d242aaaf46f25bf67ff2d8 | 25a9e40a1565cab36565fe50bea6bf | ad98d4cb0223425dc3aa3620c90bc4 |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
10 rows in set (0.57 sec)

mysql> select * from item_index where str like '25%' and str2 like '25%';
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
| id      | num      | str                            | str2                           | str3                           |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
|  558933 | 41848411 | 252b335a3d67a5421589e69503a5a8 | 2552e13c8a102817a88652b6ec08b6 | d7c49ffb3ffb1f354e3087539b0926 |
|  392194 | 98744725 | 2539b6215404ee6a2733de0da46e96 | 2580de8cd7a266e53373bfffc877ed | 848bcce17651d061bba61debc3c673 |
| 1102172 | 55926101 | 25427cf1fbe33639df19ab0f2502ea | 25d4e012d06af1873512b61b3a3c81 | 3309f461f6ff26d3abd9f57910b5d4 |
| 1152888 | 51031297 | 254d6a602044a569f391bbef7cb45b | 2549cea80daad9ffaef99ddd93548d | d220451d9c9cc007ef7b4b2a72f5ff |
|  149605 | 81996400 | 255376208d858a7b75629b30a570a0 | 250c4ccdb4b7ca5e0ae1a9ca054526 | 705a58852a712ae1bc850b6987e924 |
|  921197 | 29528816 | 255ac3b37d65a893becaedfc65f6e7 | 256cd8822aff12b7da7d743067f5bc | c44ff9aa04a3ba4f3702bbd75fbaa8 |
| 1045154 | 72887137 | 2587ead7dea24eb2d2e1227d731110 | 25a3748e245e804c1b53101f52c927 | f651154b540b7f37ed8a8dc9a1b19d |
|  620445 | 83847591 | 2596768d33e859aed7c328b4d3bea4 | 2579badacf33740a1870703322b399 | 9ee8488c32fd50e3f3d041194d1ab7 |
| 1181850 | 71474024 | 25a410cf2afe18ca94181b47b851a7 | 25a3dd4ee1ff7038a08f2570aaf3be | d2c720c734560cc879e25b0784908b |
|   39812 | 41225470 | 25c8d48b26bd097e0c272a51bc1c6c | 2547d5c3f67636ce3de5cc8fd388c2 | c43c065eb0f189ccb2f82bf206c161 |
|  863844 | 14074028 | 25cbb64304c85c685614f0d8a66bd2 | 25e27fa1bcb089aa1ac96907cad499 | 858a52a6f4c3b3c0879ec727b15597 |
| 1034419 | 71995222 | 25ce037abd1453600dc9149c4f1e69 | 251c77ec65aca169431529969c28c7 | 79ee18c8219f2605fca6d15a2d84eb |
| 1027083 | 44198037 | 25e1f4b5ecc8c06010301d24bda849 | 25ccdce24e904c70e2580bdacbe127 | bbd90c2756e8a04fc2504848c5ecbb |
| 1164571 | 96485890 | 25e3e56d031a03d91c9582f620fc6a | 25b6f8151c74010f7b5412392f184a | 7e3536c3a0e6f77ec98396447a5e08 |
|   95749 | 84850061 | 25ea50f2ca9d8a09a74e8dd43c1165 | 254d42d6f00ab613b6973036789cac | 7d7418851ea8bd6cfe16ea21c769b2 |
|  477598 | 66972009 | 25eadf63559eb8f74b45f9e6f4accd | 25e684528906dc7b647344a417e2b8 | c8a8396b15faa1400095c46504564c |
| 1258707 |  8628585 | 25f350c0e7769184e1f20524f8000a | 25d656409ebd8f4b3293853bbe0b5e | 805bd6f97d1f3bba6ce1029963306d |
| 1111399 | 39939816 | 25fc73745aca46e693283bd7eea936 | 2587ecdd8f264e993ba38aab940b27 | 9af54e8ba252345eaf5ffe6e0c2cd4 |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
18 rows in set (0.03 sec)

mysql> select * from item_index_2 where str like '25%' and str2 like '25%';
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
| id      | num      | str                            | str2                           | str3                           |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
|   81331 | 98608772 | 25ee115c8ffe887de731f9f702c7c3 | 25c40eff5a34a8d9930e1b0c668943 | f86fd73ad16be779fd6f928a7b90c1 |
|  358921 |  1003437 | 25ea80089ca00d996776ba04787c20 | 25a7fb87bf9ace00af5aec5cc2ff30 | f83527b8ad5ffb16bbc931a64eed98 |
|  361693 | 25104443 | 25cfd853fbbb7dcc24f4b4e2213fb9 | 25bdecce294439c79a2909956c2854 | 99ae15f3f2857137ea0f8e98d56b06 |
|  600058 | 76627935 | 25eff0890bc616f18723c2d820dba1 | 25553fb8e7ff774cd98d2ac25e59fb | ca5f9d5b26575c145656092a543678 |
|  605915 | 98193351 | 25aaa270ae97e200f71dac8be884ce | 253db2f9a79d0c20f96a4fa0ee4fab | 04c8913d87369894ffd346e4e98431 |
|  618734 | 47068877 | 25bb26cdc27bca206a649380444d51 | 256fe1195040020b98476b0f588c0c | dcf45bcee8333e8aa4face7286d56b |
|  632376 |  2645473 | 254728b0f7ecb4fcd2803c4dc0a0a4 | 25ea9e6556b010b039424b4508ba9d | 05fbd4a9903db7f9290c447d2558fe |
|  693763 | 45502006 | 25359af5829b040e932348425b898b | 25150a55cc237c958493224502d7d5 | 99a742df60fe73504e72bec3d943f7 |
|  811357 |  5197846 | 250440ed0676bdf31038a6b8ddddb2 | 251d878cabc92a9081268fe0c0f4e3 | 4a053f07caf36516afa455f5a5a5a9 |
|  859925 | 16364649 | 2514dde1b63bf02db79f5c43af5ee9 | 25edcd3fde30ab0acc9bca527e6da1 | 64b9394aa1d6a34a41d04ceb2dd536 |
|  905759 |  6301185 | 25faed9bef2277630dfe76b3e9ce35 | 257a2a1d0cc3eed1f1194cad59f21b | 7ec011e6a27af0856db1f95c77c439 |
|  918138 | 27146134 | 25ea50f2ca9d8a09a74e8dd43c1165 | 25479ee47e348d13a9611df3615e78 | ed1a38bb06d58fb638b762f4aeffee |
|  941698 | 66494707 | 2509f719f55987b011d585b671abad | 25828d440ffac95c9f4feaeb69088a | 044e7fee369124e4ee99d28e9455c3 |
|  952144 | 15362288 | 251ffda4bb28246c7f2ceb905b8968 | 2585a26bd31003e660dba9ac107ea5 | 30c217f49c195f6d130dbeed184c93 |
|  954333 | 62124301 | 2506ea3aefd578dd39c9b56a55db40 | 258f6b12a6c69d1f1be8fdd75d6e94 | a366f0fa41ea0a78bbf0aabd957dec |
|  956050 | 18517502 | 25ebd7eeefccb25e99ad1d3a4d2960 | 25f949f63d18389f0eb56e39c12072 | 466348504010a779d3da53daf5b4ec |
| 1001036 | 28224953 | 2553c66f77644ab94ffc675836f815 | 2551d445cf84a85e4eb66a43538d2c | f18860db297f604bc4a7e4ffccad97 |
| 1230378 | 29364977 | 251b264ed7d2d298e22ffea7c39e84 | 25de3ebf62df3f117b4f2b48ad69b8 | 9786eef6524c1c1412d2d8104cccc6 |
| 1269066 | 32669699 | 257131ed527bb3c706e9a81583461c | 25de7308e29625ece62d35ee667b1f | 9d0cd5593c498427bb191fb2572725 |
| 1303206 | 13605809 | 2534ab653f59c91b952f427f9a365b | 258d695fc70bdc736443843ea8571c | 42d2e9954e4ae24aef40d4789f43ec |
+---------+----------+--------------------------------+--------------------------------+--------------------------------+
20 rows in set (0.02 sec)
```

```
mysql> SELECT EVENT_ID,                                                                                                                                                                                               ->        TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
    ->        SQL_TEXT
    -> FROM performance_schema.events_statements_history_long
    -> WHERE SQL_TEXT like 'select%'
    -> ORDER BY EVENT_ID DESC
    -> LIMIT 1;
+----------+----------+-------------------------------------------------------------+
| EVENT_ID | Duration | SQL_TEXT                                                    |
+----------+----------+-------------------------------------------------------------+
|      274 | 0.562961 | select * from item where str like '25%' and str2 like '25%' |
+----------+----------+-------------------------------------------------------------+
1 row in set (0.01 sec)

mysql> SELECT EVENT_ID,
    ->        TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
    ->        SQL_TEXT
    -> FROM performance_schema.events_statements_history_long
    -> WHERE SQL_TEXT like 'select%'
    -> ORDER BY EVENT_ID DESC
    -> LIMIT 1;
+----------+----------+-------------------------------------------------------------------+
| EVENT_ID | Duration | SQL_TEXT                                                          |
+----------+----------+-------------------------------------------------------------------+
|      217 | 0.025093 | select * from item_index where str like '25%' and str2 like '25%' |
+----------+----------+-------------------------------------------------------------------+
1 row in set (0.01 sec)

mysql> SELECT EVENT_ID,
    ->        TRUNCATE(TIMER_WAIT / 1000000000000, 6) AS Duration,
    ->        SQL_TEXT
    -> FROM performance_schema.events_statements_history_long
    -> WHERE SQL_TEXT like 'select%'
    -> ORDER BY EVENT_ID DESC
    -> LIMIT 1;
+----------+----------+---------------------------------------------------------------------+
| EVENT_ID | Duration | SQL_TEXT                                                            |
+----------+----------+---------------------------------------------------------------------+
|      236 | 0.018423 | select * from item_index_2 where str like '25%' and str2 like '25%' |
+----------+----------+---------------------------------------------------------------------+
1 row in set (0.00 sec)


```
