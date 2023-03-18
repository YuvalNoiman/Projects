-- maintenance database
-- mysql version

CREATE DATABASE IF NOT EXISTS maintenance DEFAULT CHARSET = utf8;
USE maintenance;

-- info table

DROP TABLE IF EXISTS PersonalInfo;
CREATE TABLE PersonalInfo (
  FirstName CHAR(9) NOT NULL,
  LastName CHAR (9) NOT NULL,
  ID INT(9) NOT NULL,
  PhoneNumber CHAR(12) DEFAULT NULL,
  Email CHAR(100) DEFAULT NULL,
  PRIMARY KEY (ID)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS Locational;
CREATE TABLE Locational (
  Location CHAR(100) NOT NULL,
  Descript CHAR(100) NOT NULL,
  Category CHAR(100) NOT NULL,
  Emergency BOOL NOT NULL,
  PRIMARY KEY (Location, Descript)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO PersonalInfo VALUES ('John', 'Jones', 123456789, '123-456-7899','johnjones@gmail.com');
Insert INTO Locational VALUES ('UFC','There is a broken wire in the fight ring.','Eletrical',TRUE);
INSERT INTO PersonalInfo VALUES ('Tom', 'Brady', 444444444, '919-349-1000','tombrady@yahoo.com');
Insert INTO Locational VALUES ('Bucaneer Stadium','There is a broken sprinkler on the field.','Plumbing/Sewer',False);
INSERT INTO PersonalInfo (FirstName, LastName,ID) VALUES ('Chris', 'Hemsworth', 838383838);
Insert INTO Locational VALUES ('Marvel HQ','There is a tree on the road.','ROAD',False);
INSERT INTO PersonalInfo (FirstName, LastName,ID) VALUES ('John', 'Cena',987654321);
Insert INTO Locational VALUES ('WWE Stadium','There is a fire in the stadium seats.','FIRE',TRUE);
INSERT INTO PersonalInfo VALUES ('Gordon', 'Ramsey',404293980, '999-212-9211','gordonramsey@bing.com');
Insert INTO Locational VALUES ('Hells Kitchen','There is a hole in the walls and broken door.','Structural',FALSE);
COMMIT;
