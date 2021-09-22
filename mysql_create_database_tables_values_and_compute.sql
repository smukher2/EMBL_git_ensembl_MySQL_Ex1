/*We delete any previous versions of this dataset user may have to start fresh*/
DROP DATABASE IF EXISTS student_subject_db1;

/* Database student_subject_db1 */
CREATE DATABASE student_subject_db1;

/* Shows list of databases, database we made should appear here*/
SHOW DATABASES;

/* Use the student_subject_db1 database */
USE student_subject_db1;

/* A few points to note:
1) Put Primary Key last in all tables, so when adding values to tables
by order of coulumns I know by default I've put Primary Key last
2) Primary key has to be there to create a table.
3) 'NOT NULL' means it requires a value so unless its set to 'AUTO_INCREMENT'
when entering data put NULL if don't know value for that position.
4) To put an actual default value next to a column name type 'NOT NULL DEFAULT "NA"'
or some value or word instead of NA don't say NULL cause its already used up in sql
language*/

/* Table student */
CREATE TABLE student (
  student_name VARCHAR(128) NOT NULL,
  student_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

/* Table subject */
CREATE TABLE subject (
  subject_name VARCHAR(128) NOT NULL,
  subject_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY
);

/* Table scores primary key generated by linking two other linked
table primary key this establishes relations in relational databases*/
CREATE TABLE scores (
  score INT NOT NULL,
  student_id INT NOT NULL,
  subject_id INT NOT NULL,
  PRIMARY KEY(student_id, subject_id)
);

/* Shows list of tables we made */
SHOW TABLES;

/* We can also see table columns rows summary*/
DESCRIBE student;
DESCRIBE subject;
DESCRIBE scores;

/* Values are always put in '' except numbers*/

/* Insert multiple values in student table at once and order according to column order of table.
Put NULL under primary key as we have set it to auto*/
INSERT INTO student VALUES
  ('John', NULL), ('Harry', NULL), ('HERMIONE', NULL), ('RONALD', NULL)
;

/* Insert multiple values in subject table at once and order according to column order of table.
Put NULL under primary key as we have set it to auto*/
INSERT INTO subject VALUES
  ('English', NULL), ('Science', NULL), ('Arts', NULL)
;

/* Insert multiple values in scores table at once and order according to column order of table.
Primary key will be calculated automatically when we manually put the subject_id and student_id*/
INSERT INTO scores VALUES
  (100, 1, 1), (70, 1, 2), (76, 1, 3),
  (100, 2, 1), (99, 2, 2), (96, 2, 3),
  (100, 3, 1), (100, 3, 2), (100, 3, 3),
  (50, 4, 1), (50, 4, 2), (56, 4, 3)
;

/*We can view the table columns and rows with the data entries*/
SELECT * FROM student;
SELECT * FROM subject;
SELECT * FROM scores;

/* Add Foreign Keys to scores so that it links to other two tables.
This makes the 'relations' or schema of this 'relational database' we made.
This also causes a constrint that we cannot have a student_id or subject_id
in scores table that's not in student and subject table. We have filled
out test scores for all students and all subjects in 'scores' table.
So now we need to add new entities or values to 'student.student_id' or
'subject.subject_id' before we can add any more values to 'scores' tables in other
words we have creates linked or related tables aka a relational database.*/
ALTER TABLE scores ADD FOREIGN KEY (student_id) REFERENCES student(student_id);
ALTER TABLE scores ADD FOREIGN KEY (subject_id) REFERENCES subject(subject_id);

/* lets demonstrate how we can add new student.student_id' or
'subject.subject_id' before we can add any more values to 'scores' tables.
Say we got a new student Albus so we change 'student' table but not 'subject' table */
INSERT INTO student VALUES
  ('Albus', NULL)
;

/* Inset scores for 'Albus' into 'scores' table, he's 5th student so I put 5 */
INSERT INTO scores VALUES
  (100, 5, 1), (100, 5, 2), (100, 5, 3)
;

/*We can view the table columns and rows with the data entries we see 'Albus' is now included*/
SELECT * FROM student;
SELECT * FROM subject;
SELECT * FROM scores;

/*Now that we've created database, tables and put values into it, let use them
for doing some queries i.e. compute stuff from the data to gain insights*/

/*1. Get all students with name John */
SELECT student_name FROM student WHERE student_name='John';

/*Alternatively, above code can also be written in multiple lines for same result
but don't put , in between, just put ; to indicate end of code*/
SELECT student_name
FROM student
WHERE student_name='John';

/*2. List the IDs and names of all students who have scored maximum (100) in English*/
SELECT student.student_id, student.student_name,
subject.subject_id, subject.subject_name,
scores.student_id, scores.subject_id, scores.score
FROM student, subject, scores
WHERE score=100 AND subject_name='English'
AND student.student_id = scores.student_id
AND subject.subject_id = scores.subject_id;

/*we used syntax above in 'FROM' where we put 'table.column_name' for all columns
we need for computation. Under 'FROM' provided the table names. Under 'WHERE'
we specified the conditions or computation of our query here the value of 'score'
and 'subject_name'. The last two AND statements are specifying the Foreign KEY
equivalance/link/relation between tables.*/

/*Done*/
