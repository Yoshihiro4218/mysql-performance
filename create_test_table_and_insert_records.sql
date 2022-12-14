################################################
# index ăȘă
CREATE TABLE item
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    num  INT UNSIGNED,
    str  VARCHAR(30),
    str2 VARCHAR(30),
    str3 VARCHAR(30)
);

INSERT INTO item () VALUES ();
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;
INSERT INTO item (id) SELECT 0 FROM item;


UPDATE item
SET num  = CEIL(RAND() * 100000000),
    str  = SUBSTRING(MD5(RAND()), 1, 30),
    str2 = SUBSTRING(MD5(RAND()), 1, 30),
    str3 = SUBSTRING(MD5(RAND()), 1, 30);

################################################
# index ăă
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

INSERT INTO item_index () VALUES ();
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;
INSERT INTO item_index (id) SELECT 0 FROM item_index;

UPDATE item_index
SET num  = CEIL(RAND() * 100000000),
    str  = SUBSTRING(MD5(RAND()), 1, 30),
    str2 = SUBSTRING(MD5(RAND()), 1, 30),
    str3 = SUBSTRING(MD5(RAND()), 1, 30);

################################################
# çĄé§ă« index ăă
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

INSERT INTO item_index_2 () VALUES ();
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;
INSERT INTO item_index_2 (id) SELECT 0 FROM item_index_2;


UPDATE item_index_2
SET num  = CEIL(RAND() * 100000000),
    str  = SUBSTRING(MD5(RAND()), 1, 30),
    str2 = SUBSTRING(MD5(RAND()), 1, 30),
    str3 = SUBSTRING(MD5(RAND()), 1, 30)
LIMIT 50;



ALTER TABLE item ADD INDEX test(num);

