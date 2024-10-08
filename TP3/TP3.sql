CREATE TABLE IF NOT EXISTS player (
  id SERIAL,
  name TEXT NOT NULL,
  money INT CHECK (money >= 0),
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS type (
  id SERIAL,
  name TEXT NOT NULL,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS possession (
  id SERIAL,
  type INT NOT NULL,
  owner INT NOT NULL,
  price INT,
  PRIMARY KEY (id),
  FOREIGN KEY (owner) REFERENCES player(id),
  FOREIGN KEY (type) REFERENCES type(id)
);

INSERT INTO
  player (id, name, money)
VALUES
  (DEFAULT, < name >, < money >);

UPDATE
  player
SET
  name = < name >
WHERE
  id = < id >;

INSERT INTO
  possession (type, owner, price)
VALUES
  (< typeId >, < ownerId >, NULL);

UPDATE
  player
SET
  money = money + < diff >
WHERE
  id = < id >;

SELECT
  type,
  owner
FROM
  possession
WHERE
  owner = < playerId >;

SELECT
  money
FROM
  player
WHERE
  id = < id >;

UPDATE
  possession
SET
  price = < price >
WHERE
  id = < id >
  AND owner = < playerId >;

START TRANSACTION;

SELECT
  id,
  price,
  owner as curOwner
FROM
  possession
WHERE
  price IS NOT NULL
  AND type = < desired_type >
ORDER BY
  price ASC
LIMIT
  1;

UPDATE
  player
SET
  money = money + price
WHERE
  id = < curOwner >;

UPDATE
  player
SET
  money = money - price
WHERE
  id = < buyerId >;

UPDATE
  possession
SET
  owner = < buyerId >
  AND price = NULL
WHERE
  id = < objectId >;

COMMIT;

-- ===============================================================
CREATE TABLE IF NOT EXISTS department (
  dnumber INT NOT NULL,
  dname TEXT,
  d_head INT,
  d_building TEXT,
  PRIMARY KEY (dnumber)
);

SELECT
  *
FROM
  department
WHERE
  d_building LIKE '%BuildingB%';

SELECT
  *
FROM
  department
WHERE
  d_building = 'BuildingB';

CREATE TABLE IF NOT EXISTS department_normalized (
  id SERIAL,
  dnumber INT,
  dname TEXT,
  d_head INT,
  d_building TEXT,
  PRIMARY KEY (id)
);

SELECT
  *
FROM
  department_normalized
WHERE
  d_building = 'BuildingB';

CREATE TABLE IF NOT EXISTS teach (
  student TEXT,
  course TEXT,
  professor TEXT
);

CREATE TABLE teach_1_1 AS
SELECT
  student,
  professor
FROM
  teach;

ALTER TABLE
  teach_1_1
ADD
  PRIMARY KEY (student, professor);

CREATE TABLE teach_1_2 AS
SELECT
  student,
  course
FROM
  teach;

ALTER TABLE
  teach_1_2
ADD
  PRIMARY KEY (student, course);

CREATE TABLE teach_2_1 AS
SELECT
  course,
  professor
FROM
  teach;

ALTER TABLE
  teach_2_1
ADD
  PRIMARY KEY (professor);

CREATE TABLE teach_2_2 AS
SELECT
  course,
  student
FROM
  teach;

ALTER TABLE
  teach_2_2
ADD
  PRIMARY KEY (course, student);

CREATE TABLE teach_3_1 AS
SELECT
  course,
  professor
FROM
  teach;

ALTER TABLE
  teach_3_1
ADD
  PRIMARY KEY (professor);

CREATE TABLE teach_3_2 AS
SELECT
  student,
  professor
FROM
  teach;

ALTER TABLE
  teach_3_2
ADD
  PRIMARY KEY (student, professor);

SELECT
  course,
  professor,
  t1.student
FROM
  teach_1_1 AS t1,
  teach_1_2 AS t2
WHERE
  t1.student = t2.student;

SELECT
  t1.course,
  professor,
  student
FROM
  teach_2_1 AS t1,
  teach_2_2 AS t2
WHERE
  t1.course = t2.course;

SELECT
  course,
  t1.professor,
  student
FROM
  teach_3_1 AS t1,
  teach_3_2 AS t2
WHERE
  t1.professor = t2.professor;

CREATE TABLE IF NOT EXISTS employee (
  id SERIAL,
  name TEXT,
  salary INT,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS professor (
  pid INT NOT NULL,
  fieLd TEXT,
  PRIMARY KEY (pid)
) INHERITS (employee);

CREATE TABLE IF NOT EXISTS secretary (
  sid INT NOT NULL,
  building TEXT,
  PRIMARY KEY (sid)
) INHERITS (employee);

SELECT
  *
FROM
  employee;

SELECT
  *
FROM
  ONLY employee;

SELECT
  *
FROM
  professor;

SELECT
  *
FROM
  secretary;

CREATE TABLE IF NOT EXISTS course (
  id SERIAL,
  name TEXT,
  PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS session (
  course INT,
  num INT,
  name TEXT,
  PRIMARY KEY (course, num),
  FOREIGN KEY (course) REFERENCES course(id)
);
