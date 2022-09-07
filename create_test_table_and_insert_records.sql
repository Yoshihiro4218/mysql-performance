# index なし
CREATE TABLE item
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    str  VARCHAR(30),
    str2 VARCHAR(30),
    str3 VARCHAR(30)
);

INSERT INTO item () VALUES ();
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;

UPDATE item
SET str  = SUBSTRING(MD5(RAND()), 1, 30),
    str2 = SUBSTRING(MD5(RAND()), 1, 30),
    str3 = SUBSTRING(MD5(RAND()), 1, 30);

# index あり
CREATE TABLE item_index
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    str  VARCHAR(30),
    str2 VARCHAR(30),
    str3 VARCHAR(30),
    index (str)
);

UPDATE item
SET str  = SUBSTRING(MD5(RAND()), 1, 30),
    str2 = SUBSTRING(MD5(RAND()), 1, 30),
    str3 = SUBSTRING(MD5(RAND()), 1, 30);

# 無駄に index あり
CREATE TABLE item_index
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    str  VARCHAR(30),
    str2 VARCHAR(30),
    str3 VARCHAR(30),
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

UPDATE item
SET str  = SUBSTRING(MD5(RAND()), 1, 30),
    str2 = SUBSTRING(MD5(RAND()), 1, 30),
    str3 = SUBSTRING(MD5(RAND()), 1, 30);

#DELETE FROM item;
