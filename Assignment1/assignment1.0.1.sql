--Creating all the Tables 

Create Table Person(pid Integer,pname VARCHAR(20),city VARCHAR(20), PRIMARY KEY(pid));
Create Table Company(cname VARCHAR(20),headquarters VARCHAR(20),PRIMARY KEY(cname));
Create Table Skill(skill VARCHAR(20),PRIMARY KEY(skill));
Create Table worksFor(pid Integer, cname VARCHAR(20),salary Integer, PRIMARY KEY(pid),
					 FOREIGN KEY(pid) REFERENCES Person(pid),
					 FOREIGN KEY(cname) REFERENCES Company(cname));
Create Table companyLocation(cname VARCHAR(20),city VARCHAR(20),PRIMARY KEY(cname,city),
							FOREIGN KEY(cname) REFERENCES Company(cname));
Create Table personSkill(pid Integer,skill VARCHAR(20),PRIMARY KEY(pid,skill),
						FOREIGN KEY(pid) REFERENCES Person(pid),
						FOREIGN KEY(skill) REFERENCES Skill(skill));
Create Table hasManager(eid Integer, mid Integer, PRIMARY KEY(eid,mid),
					   FOREIGN KEY(eid) REFERENCES Person(pid),
					   FOREIGN KEY(mid) REFERENCES Person(pid));
					   
--Creation of tables process complete 
--Inserting values of Person  

INSERT INTO Person VALUES
     (1001,'Jean','Cupertino'),
     (1002,'Vidya', 'Cupertino'),
     (1003,'Anna', 'Seattle'),
     (1004,'Qin', 'Seattle'),
     (1005,'Megan', 'MountainView'),
     (1006,'Ryan', 'Chicago'),
     (1007,'Danielle','LosGatos'),
     (1008,'Emma', 'Bloomington'),
     (1009,'Hasan', 'Bloomington'),
     (1010,'Linda', 'Chicago'),
     (1011,'Nick', 'MountainView'),
     (1012,'Eric', 'Cupertino'),
     (1013,'Lisa', 'Indianapolis'), 
     (1014,'Deepa', 'Bloomington'), 
     (1015,'Chris', 'Denver'),
     (1016,'YinYue', 'Chicago'),
     (1017,'Latha', 'LosGatos'),
     (1018,'Arif', 'Bloomington'),
     (1019,'John', 'NewYork');

--Inserting values of Company 

INSERT INTO Company VALUES
     ('Apple', 'Cupertino'),
     ('Amazon', 'Seattle'),
     ('Google', 'MountainView'),
     ('Netflix', 'LosGatos'),
     ('Microsoft', 'Redmond'),
     ('IBM', 'NewYork'),
     ('ACM', 'NewYork');
	 
--Inserting values of worksFor
	 
INSERT INTO worksFor VALUES
     (1001,'Apple', 65000),
     (1002,'Apple', 45000),
     (1003,'Amazon', 55000),
     (1004,'Amazon', 55000),
     (1005,'Google', 60000),
     (1006,'Amazon', 55000),
     (1007,'Netflix', 50000),
     (1008,'Amazon', 50000),
     (1009,'Apple',60000),
     (1010,'Amazon', 55000),
     (1011,'Google', 70000), 
     (1012,'Apple', 50000),
     (1013,'Netflix', 55000),
     (1014,'Apple', 50000), 
     (1015,'Amazon', 60000),
     (1016,'Amazon', 55000),
     (1017,'Netflix', 60000),
     (1018,'Apple', 50000),
     (1019,'Microsoft', 50000);
	 
--Inserting for companyLocation

INSERT INTO companyLocation VALUES
   ('Apple', 'Bloomington'),
   ('Amazon', 'Chicago'),
   ('Amazon', 'Denver'),
   ('Amazon', 'Columbus'),
   ('Google', 'NewYork'),
   ('Netflix', 'Indianapolis'),
   ('Netflix', 'Chicago'),
   ('Microsoft', 'Bloomington'),
   ('Apple', 'Cupertino'),
   ('Amazon', 'Seattle'),
   ('Google', 'MountainView'),
   ('Netflix', 'LosGatos'),
   ('Microsoft', 'Redmond'),
   ('IBM', 'NewYork');
   
 -- Inserting for Skill
 
INSERT INTO Skill VALUES
   ('Programming'),
   ('AI'),
   ('Networks'),
   ('OperatingSystems'),
   ('Databases');

--Inserting for personSkill

INSERT INTO personSkill VALUES
 (1001,'Programming'),
 (1001,'AI'),
 (1002,'Programming'),
 (1002,'AI'),
 (1004,'AI'),
 (1004,'Programming'),
 (1005,'AI'),
 (1005,'Programming'),
 (1005,'Networks'),
 (1006,'Programming'),
 (1006,'OperatingSystems'),
 (1007,'OperatingSystems'),
 (1007,'Programming'),
 (1009,'OperatingSystems'),
 (1009,'Networks'),
 (1010,'Networks'),
 (1011,'Networks'),
 (1011,'OperatingSystems'),
 (1011,'AI'),
 (1011,'Programming'),
 (1012,'AI'),
 (1012,'OperatingSystems'),
 (1012,'Programming'),
 (1013,'Programming'),
 (1013,'AI'),
 (1013,'OperatingSystems'),
 (1013,'Networks'),
 (1014,'OperatingSystems'),
 (1014,'AI'),
 (1014,'Networks'),
 (1015,'Programming'),
 (1015,'AI'),
 (1016,'OperatingSystems'),
 (1016,'AI'),
 (1017,'Networks'),
 (1017,'Programming'),
 (1018,'AI'),
 (1019,'Networks');
 
 --Inserting for hasManager 
 
 INSERT INTO hasManager VALUES
 (1004, 1003),
 (1006, 1003),
 (1015, 1003),
 (1016, 1004),
 (1016, 1006),
 (1008, 1015),
 (1010, 1008),
 (1013, 1007),
 (1017, 1013),
 (1002, 1001),
 (1009, 1001),
 (1014, 1012);
 
 -- Data Loading process complete 
 

 
 SELECT *
 FROM Company
 --Problem 2 
 
SELECT DISTINCT p.pid,p.pname FROM Person p, worksFor w, hasManager M WHERE p.city = 'Bloomington' AND w.salary > 30000 AND M.eid = p.pid ;

 --Problem 3 
 
 SELECT c1.cname,c2.cname FROM Company c1,Company c2 WHERE c1.headquarters = c2.headquarters AND c1.cname <> c2.cname ;
 
 --Problem 4  

SELECT DISTINCT p.pid, p.pname
FROM Person p, hasManager M
WHERE M.eid=p.pid AND p.city NOT IN (SELECT p1.city 
									 FROM Person p1, hasManager M1 
									 WHERE M.eid = M1.eid AND M1.mid = p1.pid)
ORDER BY p.pid;

 --Problem 5 

SELECT s.skill
FROM Skill s
WHERE NOT EXISTS(SELECT DISTINCT p1.skill 
				 FROM personSkill p1, personSkill p2, personSkill p3
				 WHERE p1.pid <> p2.pid AND p2.pid <> p3.pid AND p1.pid <> p3.pid AND p2.skill = p1.skill AND p2.skill = s.skill AND p2.skill = p3.skill AND p3.skill = p1.skill);

 --Problem 6  
 
SELECT p.pid, p.pname, w.salary
FROM Person p, worksFor w 
WHERE p.pid = w.pid AND EXISTS (SELECT DISTINCT h1.eid 
								FROM hasManager h1, hasManager h2 
					            WHERE h1.eid = h2.eid AND h1.mid <> h2.mid AND h1.eid = p.pid AND (h1.mid,h2.mid) IN (SELECT ps1.pid,ps2.pid 
																													  FROM personSkill ps1, personSkill ps2  
																													  WHERE ps1.pid = h1.mid AND ps2.pid = h2.mid and ps1.skill = ps2.skill and ps1.skill <> 'Networks'));
 
 --Problem 7  
 
SELECT DISTINCT w.cname 
FROM worksFor w
WHERE w.pid in (SELECT p.pid 
				FROM Person p 
				WHERE p.city<> 'MountainView' AND w.pid = p.pid);
 
 --Problem 8  
 
SELECT DISTINCT w.cname, w.salary
FROM worksFor w
WHERE w.salary >= ALL (SELECT w1.salary 
					   FROM worksFor w1 
					   WHERE w1.cname = w.cname);
 
 --Problem 9  
 
SELECT p.pid, p.pname
FROM Person p,hasManager h1
WHERE (SELECT w1.salary FROM worksFor w1  WHERE w1.pid = p.pid AND w1.pid = h1.eid) > 
	(SELECT w2.salary FROM worksFor w2 WHERE w2.pid = h1.mid)
	ORDER BY p.pid;
 
 --Problem 10  
 
 SELECT p.pid, p.pname,w.cname,w.salary
 FROM Person p,worksFor w
 WHERE p.pid = w.pid AND p.city = 'Bloomington' AND w.salary >= 40000 AND w.cname <> 'Apple'
 
 --Problem 11 
 
 SELECT p.pid, p.pname 
 FROM Person p
 WHERE EXISTS (SELECT  1
	   	FROM Company c,worksFor w
	    WHERE c.cname = w.cname AND p.pid = w.pid AND c.headquarters = 'LosGatos' AND EXISTS(SELECT 1
																						    FROM hasManager hm,Person m
																						    WHERE hm.eid = p.pid AND hm.mid = m.pid AND m.city <> 'LosGatos'))
																							
--Problem 12 

SELECT s.skill
FROM Skill s
WHERE NOT EXISTS(SELECT 1
				 FROM Person p,personSkill ps
				 WHERE p.pid = ps.pid AND ps.skill = s.skill AND p.city = 'Bloomington')
 
--Problem 13 

SELECT m.pid,m.pname
FROM Person m
WHERE NOT EXISTS(SELECT 1
		     FROM hasManager hm
			 WHERE hm.mid = m.pid AND NOT EXISTS(SELECT 1
											 FROM Person e
											 WHERE hm.eid = e.pid AND e.city = m.city))
--Problem 18

SELECT NOT EXISTS(SELECT 1
			  FROM personSkill ps1, personSkill ps2, worksFor w
			  WHERE w.pid = ps1.pid AND w.pid = ps2.pid AND ps1.pid = ps2.pid AND ps1.skill <> ps2.skill)

--Problem 19  

SELECT EXISTS(SELECT 1
FROM worksFor w1, hasManager M , worksFOR w2 
WHERE w1.pid = M.eid AND w2.pid = M.mid AND w1.salary > w2.salary);

--Problem 20  

SELECT EXISTS(SELECT 1
FROM worksFor w1, hasManager M , worksFor w2 
WHERE w1.pid = M.eid AND w2.pid = M.mid AND w1.cname = w2.cname);

