-- maintenance database
-- mysql version
Drop database maintenance;
CREATE DATABASE IF NOT EXISTS maintenance DEFAULT CHARSET = utf8;
USE maintenance;

-- info table
DROP TABLE IF EXISTS PersonalInfo;
CREATE TABLE PersonalInfo (
  Personalno INT NOT NULL AUTO_INCREMENT,
  FirstName CHAR(9) NOT NULL,
  LastName CHAR (9) NOT NULL,
  Pass CHAR (20) NOT NULL,
  CWID INT(9) NOT NULL,
  PhoneNumber CHAR(12) DEFAULT NULL,
  Email varCHAR(100) DEFAULT NULL,
  KEY (CWID),
  PRIMARY KEY (Personalno)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS RequestInfo;
CREATE TABLE RequestInfo (
  ID INT,
  Requestno INT NOT NULL AUTO_INCREMENT,
  Location CHAR(100) NOT NULL,
  Descript CHAR(100) NOT NULL,
  Category CHAR(100) NOT NULL,
  Emergency BOOL NOT NULL,
  PRIMARY KEY (Requestno),
  FOREIGN KEY (ID) REFERENCES PersonalInfo(CWID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO PersonalInfo VALUES (1,'John', 'Jones', 1234, 123456789, '123-456-7899','johnjones@gmail.com');
INSERT INTO RequestInfo VALUES (123456789,1,'UFC','There is a broken wire in the fight ring.','Electrical',TRUE);
INSERT INTO PersonalInfo VALUES (2,'Tom', 'Brady', 4598, 444444444, '919-349-1000','tombrady@yahoo.com');
INSERT INTO RequestInfo VALUES (444444444,2,'Bucaneer Stadium','There is a broken sprinkler on the field.','Water/Irrigation',False);
INSERT INTO PersonalInfo (FirstName, LastName, Pass, CWID) VALUES ('Chris', 'Hemsworth', 0000, 838383838);
INSERT INTO RequestInfo VALUES (838383838,3,'Marvel HQ','There is a tree on the road.','ROAD',False);
INSERT INTO PersonalInfo (FirstName, LastName, Pass, CWID) VALUES ('John', 'Cena', 9875, 987654321);
INSERT INTO RequestInfo (ID, Location, Descript, Category, Emergency) VALUES (987654321,'WWE Stadium','There is a fire in the stadium seats.','FIRE',TRUE);
INSERT INTO PersonalInfo VALUES (5,'Gordon', 'Ramsey', 'Kitchen', 404293980, '999-212-9211','gordonramsey@bing.com');
INSERT INTO RequestInfo (ID, Location, Descript, Category, Emergency) VALUES (404293980,'Hells Kitchen','There is a hole in the walls and broken door.','Structural',FALSE);
INSERT INTO RequestInfo (ID, Location, Descript, Category, Emergency) VALUES (404293980,'Gordon Steak House','There is a leaky toilet.','Plumbing/Sewer',FALSE);
COMMIT;
