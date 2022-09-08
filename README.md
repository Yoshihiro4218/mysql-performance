# MySQL でのパフォーマンス測定
WIP...

# MEMO

- インデックスの有無での SELECT, INSERT, 文字列や数値
- インデックスを無駄に大量に貼ったとき
- 絞り込みのタイミング
- あとで index を貼る時間(レコード数ごと)

# 計測
## 50万 NULL レコード INSERT
### インデックスなし
```
mysql> INSERT INTO item (id) SELECT 0 FROM item;
Query OK, 524288 rows affected (5.07 sec)
Records: 524288  Duplicates: 0  Warnings: 0
```

### インデックスあり
```
mysql> INSERT INTO item_index (id) SELECT 0 FROM item_index;
Query OK, 524288 rows affected (7.73 sec)
Records: 524288  Duplicates: 0  Warnings: 0
```

### 無駄にインデックスあり
```
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




