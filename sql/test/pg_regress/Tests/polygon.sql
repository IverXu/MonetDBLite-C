--
-- string
--
-- string logic
--
-- 3	      o
--	      |
-- 2	    + |
--	   /  |
-- 1	  # o +
--       /    |
-- 0	#-----o-+
--
--	0 1 2 3 4
--

CREATE TABLE POLYGON_TBL(f1 string);


INSERT INTO POLYGON_TBL(f1) VALUES ('(2.0,0.0),(2.0,4.0),(0.0,0.0)');

INSERT INTO POLYGON_TBL(f1) VALUES ('(3.0,1.0),(3.0,3.0),(1.0,0.0)');

-- degenerate polygons 
INSERT INTO POLYGON_TBL(f1) VALUES ('(0.0,0.0)');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0.0,1.0),(0.0,1.0)');

-- bad string input strings 
INSERT INTO POLYGON_TBL(f1) VALUES ('0.0');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0.0 0.0');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0,1,2)');

INSERT INTO POLYGON_TBL(f1) VALUES ('(0,1,2,3');

INSERT INTO POLYGON_TBL(f1) VALUES ('asdf');


SELECT '' AS four, POLYGON_TBL.*;

-- overlap 
SELECT '' AS three, p.*
   FROM POLYGON_TBL p
   WHERE p.f1 && '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

-- left overlap 
SELECT '' AS four, p.* 
   FROM POLYGON_TBL p
   WHERE p.f1 &< '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

-- right overlap 
SELECT '' AS two, p.* 
   FROM POLYGON_TBL p
   WHERE p.f1 &> '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

-- left of 
SELECT '' AS one, p.*
   FROM POLYGON_TBL p
   WHERE p.f1 << '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

-- right of 
SELECT '' AS zero, p.*
   FROM POLYGON_TBL p
   WHERE p.f1 >> '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

-- contained 
SELECT '' AS one, p.* 
   FROM POLYGON_TBL p
   WHERE p.f1 @ string '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

-- same 
SELECT '' AS one, p.*
   FROM POLYGON_TBL p
   WHERE p.f1 ~= string '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

-- contains 
SELECT '' AS one, p.*
   FROM POLYGON_TBL p
   WHERE p.f1 ~ string '(3.0,1.0),(3.0,3.0),(1.0,0.0)';

--
-- string logic
--
-- 3	      o
--	      |
-- 2	    + |
--	   /  |
-- 1	  / o +
--       /    |
-- 0	+-----o-+
--
--	0 1 2 3 4
--
-- left of 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' << string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "false";

-- left overlap 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' << string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "true";

-- right overlap 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' &> string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "true";

-- right of 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' >> string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "false";

-- contained in 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' @ string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "false";

-- contains 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' ~ string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "false";

-- same 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' ~= string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "false";

-- overlap 
SELECT string '(2.0,0.0),(2.0,4.0),(0.0,0.0)' && string '(3.0,1.0),(3.0,3.0),(1.0,0.0)' AS "true";

