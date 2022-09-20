# MySQL でのパフォーマンス測定
普段パフォーマンスを気にしながらインデックスを貼ったりクエリを投げているわけですが、無頓着だとどれくらい差がでるのか気になったので計測してみます。

# 計測
## INSERT
### テーブル
#### index なし
```
CREATE TABLE item
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    num  INT UNSIGNED,
    str  VARCHAR(30),
    str2 VARCHAR(30),
    str3 VARCHAR(30)
);
```

#### index あり
```
CREATE TABLE item_index
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    num  INT UNSIGNED,
    str  VARCHAR(30),
    str2 VARCHAR(30),
    str3 VARCHAR(30),
    index (num),
    index (str)
);
```

#### 無駄に index あり
```
CREATE TABLE item_index_2
(
id   INT PRIMARY KEY AUTO_INCREMENT,
num  INT UNSIGNED,
str  VARCHAR(30),
str2 VARCHAR(30),
str3 VARCHAR(30),
index (num),
index (str),
index (str2),
index (str3),
index (str, str2),
index (str, str3),
index (str2, str3),
index (str, str2, str3),
index (str, str3, str2),
index (str2, str, str3),
index (str2, str3, str),
index (str3, str2, str)
);
```

### 結果
![](images/2.png)
![](images/1.png)
![](images/3.png)


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




