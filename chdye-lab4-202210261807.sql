-- Lab 4
-- chdye
-- Oct 26, 2022

USE `STUDENTS`;
-- STUDENTS-1
-- Find all students who study in classroom 111. For each student list first and last name. Sort the output by the last name of the student.
-- SHOW FULL TABLES;
-- SELECT * FROM list;

SELECT FirstName, LastName
FROM list
WHERE classroom = 111 ORDER BY LastName;


USE `STUDENTS`;
-- STUDENTS-2
-- For each classroom report the grade that is taught in it. Report just the classroom number and the grade number. Sort output by classroom in descending order.
SELECT DISTINCT classroom, grade
FROM list
ORDER BY classroom DESC;


USE `STUDENTS`;
-- STUDENTS-3
-- Find all teachers who teach fifth grade. Report first and last name of the teachers and the room number. Sort the output by room number.
SELECT DISTINCT teachers.First, teachers.Last, teachers.classroom
FROM list inner join teachers on list.classroom = teachers.classroom
WHERE list.grade = 5
ORDER BY classroom;


USE `STUDENTS`;
-- STUDENTS-4
-- Find all students taught by OTHA MOYER. Output first and last names of students sorted in alphabetical order by their last name.
SELECT DISTINCT list.FirstName, list.LastName
FROM list inner join teachers on list.classroom = teachers.classroom
WHERE teachers.First = "OTHA" and teachers.Last = "MOYER"
ORDER BY list.LastName;


USE `STUDENTS`;
-- STUDENTS-5
-- For each teacher teaching grades K through 3, report the grade (s)he teaches. Output teacher last name, first name, and grade. Each name has to be reported exactly once. Sort the output by grade and alphabetically by teacher’s last name for each grade.
SELECT DISTINCT teachers.Last, teachers.First, list.grade
FROM list inner join teachers on list.classroom = teachers.classroom
WHERE list.grade <= 3
ORDER BY list.grade, teachers.Last;


USE `BAKERY`;
-- BAKERY-1
-- Find all chocolate-flavored items on the menu whose price is under $5.00. For each item output the flavor, the name (food type) of the item, and the price. Sort your output in descending order by price.
SELECT Flavor, Food, Price FROM goods WHERE (Price < 5.00 and Flavor = 'Chocolate') ORDER BY Price DESC;


USE `BAKERY`;
-- BAKERY-2
-- Report the prices of the following items (a) any cookie priced above $1.10, (b) any lemon-flavored items, or (c) any apple-flavored item except for the pie. Output the flavor, the name (food type) and the price of each pastry. Sort the output in alphabetical order by the flavor and then pastry name.
SELECT Flavor, Food, Price FROM goods WHERE ( (Price > 1.10 and Food = 'Cookie') or Flavor = 'Lemon' or 
(Flavor = 'Apple' and Food != 'Pie') ) ORDER BY Flavor, Food;


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who made a purchase on October 3, 2007. Report the name of the customer (last, first). Sort the output in alphabetical order by the customer’s last name. Each customer name must appear at most once.
SELECT DISTINCT LastName, FirstName
FROM customers inner join receipts on Customer = customers.CId
WHERE SaleDate = DATE '2007-10-3' ORDER BY LastName;


USE `BAKERY`;
-- BAKERY-4
-- Find all different cakes purchased on October 4, 2007. Each cake (flavor, food) is to be listed once. Sort output in alphabetical order by the cake flavor.
SELECT DISTINCT Flavor, Food
FROM (goods inner join items on Item = goods.GId) inner join receipts on receipts.RNumber = items.Receipt
WHERE (SaleDate = DATE '2007-10-4' and Food = 'Cake') ORDER BY Flavor;


USE `BAKERY`;
-- BAKERY-5
-- List all pastries purchased by ARIANE CRUZEN on October 25, 2007. For each pastry, specify its flavor and type, as well as the price. Output the pastries in the order in which they appear on the receipt (each pastry needs to appear the number of times it was purchased).
SELECT Flavor, Food, Price
FROM (goods inner join items on Item = goods.GId) 
inner join receipts on receipts.RNumber = items.Receipt
inner join customers on customers.CId = receipts.Customer
WHERE (SaleDate = DATE '2007-10-25' and LastName = 'Cruzen' and FirstName = 'Ariane');


USE `BAKERY`;
-- BAKERY-6
-- Find all types of cookies purchased by KIP ARNN during the month of October of 2007. Report each cookie type (flavor, food type) exactly once in alphabetical order by flavor.

SELECT DISTINCT Flavor, Food
FROM (goods inner join items on Item = goods.GId) 
inner join receipts on receipts.RNumber = items.Receipt
inner join customers on customers.CId = receipts.Customer
WHERE ( YEAR(SaleDate)= 2007 and MONTH(SaleDate) = 10 and LastName = 'Arnn' and FirstName = 'Kip' and Food = 'Cookie') ORDER BY Flavor;


USE `CSU`;
-- CSU-1
-- Report all campuses from Los Angeles county. Output the full name of campus in alphabetical order.
SELECT Campus
FROM campuses
WHERE County = 'Los Angeles' 
ORDER BY Campus;


USE `CSU`;
-- CSU-2
-- For each year between 1994 and 2000 (inclusive) report the number of students who graduated from California Maritime Academy Output the year and the number of degrees granted. Sort output by year.
SELECT degrees.Year, Degrees
FROM campuses inner join degrees on campuses.Id = degrees.CampusId
WHERE Campus = 'California Maritime Academy' and (degrees.Year <= 2000 and degrees.Year >= 1994);


USE `CSU`;
-- CSU-3
-- Report undergraduate and graduate enrollments (as two numbers) in ’Mathematics’, ’Engineering’ and ’Computer and Info. Sciences’ disciplines for both Polytechnic universities of the CSU system in 2004. Output the name of the campus, the discipline and the number of graduate and the number of undergraduate students enrolled. Sort output by campus name, and by discipline for each campus.
-- SHOW FULL TABLES;
-- SELECT * FROM disciplines


SELECT campuses.Campus, disciplines.name, discEnr.Gr, discEnr.Ug
FROM (campuses inner join discEnr on campuses.Id = discEnr.CampusId) 
        inner join disciplines on discEnr.Discipline = disciplines.Id
WHERE (disciplines.name = 'Computer and Info. Sciences' or disciplines.name = 'Mathematics' or disciplines.name = 'Engineering')
        and (campuses.Campus = 'California Polytechnic State University-San Luis Obispo' 
                or campuses.Campus = 'California State Polytechnic University-Pomona')
        and (discEnr.Year = 2004)
ORDER BY campuses.Campus, disciplines.name;


USE `CSU`;
-- CSU-4
-- Report graduate enrollments in 2004 in ’Agriculture’ and ’Biological Sciences’ for any university that offers graduate studies in both disciplines. Report one line per university (with the two grad. enrollment numbers in separate columns), sort universities in descending order by the number of ’Agriculture’ graduate students.
SELECT campuses.Campus, discEnr.Gr, dE2.Gr
FROM campuses, discEnr, disciplines, discEnr as dE2, disciplines as disc2
WHERE ( campuses.ID = discEnr.CampusId and campuses.ID = dE2.CampusId
        and disciplines.name = 'Agriculture' and discEnr.year = 2004 AND discEnr.Gr > 0
        and disc2.name = 'Biological Sciences' and dE2.year = 2004 AND dE2.Gr > 0 
        and discEnr.Discipline = disciplines.Id 
        and dE2.Discipline = disc2.Id )
ORDER BY discEnr.Gr DESC;


USE `CSU`;
-- CSU-5
-- Find all disciplines and campuses where graduate enrollment in 2004 was at least three times higher than undergraduate enrollment. Report campus names, discipline names, and both enrollment counts. Sort output by campus name, then by discipline name in alphabetical order.
-- 

SELECT campus, name, ug, gr
FROM (campuses inner join discEnr on campuses.Id = discEnr.CampusId) 
        inner join disciplines on discEnr.Discipline = disciplines.Id 
WHERE gr / 3 > ug AND discEnr.year = 2004
ORDER BY campus, name;


USE `CSU`;
-- CSU-6
-- Report the amount of money collected from student fees (use the full-time equivalent enrollment for computations) at ’Fresno State University’ for each year between 2002 and 2004 inclusively, and the amount of money (rounded to the nearest penny) collected from student fees per each full-time equivalent faculty. Output the year, the two computed numbers sorted chronologically by year.
-- SHOW FULL TABLES;
-- SELECT * FROM campuses;
-- SELECT * FROM fees;
-- SELECT * FROM faculty;

SELECT fees.year, enrollments.FTE * fee AS collected, ROUND((enrollments.FTE * fee) / faculty.FTE, 2) AS 'faculty'
FROM fees JOIN campuses ON fees.CampusId = campuses.Id 
          JOIN faculty ON faculty.CampusId = campuses.Id AND faculty.year = fees.year
          JOIN enrollments ON enrollments.year = fees.year AND enrollments.CampusId = Id
WHERE fees.year <= 2004 AND fees.year >= 2002 AND campus = 'Fresno State University';


USE `CSU`;
-- CSU-7
-- Find all campuses where enrollment in 2003 (use the FTE numbers), was higher than the 2003 enrollment in ’San Jose State University’. Report the name of campus, the 2003 enrollment number, the number of faculty teaching that year, and the student-to-faculty ratio, rounded to one decimal place. Sort output in ascending order by student-to-faculty ratio.
SELECT DISTINCT other_campus.Campus, other_enroll.FTE, other_faculty.FTE, ROUND(other_enroll.FTE  / other_faculty.FTE, 1) AS 'faculty'
FROM enrollments JOIN campuses AS campuses_sjsu ON campuses_sjsu.Campus = 'San Jose State University' 
        join faculty as sjsu_faculty ON sjsu_faculty.year = 2003
        join enrollments as sjsu_enroll ON campuses_sjsu.Id = sjsu_enroll.CampusId and sjsu_enroll.year = 2003
        
        join campuses as other_campus ON other_campus.Campus <> 'San Jose State University' 
        join enrollments AS other_enroll ON other_enroll.year = 2003 AND other_enroll.CampusId = other_campus.Id
        join faculty as other_faculty ON  other_faculty.year = 2003 AND other_faculty.CampusId = other_campus.Id
WHERE other_enroll.FTE > sjsu_enroll.FTE
ORDER BY faculty;


USE `INN`;
-- INN-1
-- Find all modern rooms with a base price below $160 and two beds. Report room code and full room name, in alphabetical order by the code.
SELECT RoomCode, RoomName
FROM rooms
WHERE basePrice < 160 and decor = 'modern' and Beds = 2
ORDER BY RoomCode;


USE `INN`;
-- INN-2
-- Find all July 2010 reservations (a.k.a., all reservations that both start AND end during July 2010) for the ’Convoke and sanguine’ room. For each reservation report the last name of the person who reserved it, checkin and checkout dates, the total number of people staying and the daily rate. Output reservations in chronological order.
SELECT LastName, CheckIn, Checkout, Adults + Kids as total, Rate
FROM reservations inner join rooms on reservations.Room = rooms.RoomCode	
WHERE MONTH(CheckIn) = 7 and MONTH(Checkout) = 7 and YEAR(CheckIn) = 2010 and YEAR(Checkout) = 2010 and RoomName = 'Convoke and sanguine'
ORDER BY CheckIn;


USE `INN`;
-- INN-3
-- Find all rooms occupied on February 6, 2010. Report full name of the room, the check-in and checkout dates of the reservation. Sort output in alphabetical order by room name.
SELECT rooms.RoomName, reservations.CheckIn, reservations.Checkout
FROM reservations inner join rooms on reservations.Room = rooms.RoomCode	
WHERE CheckIn <= '2010-02-06' AND CheckOut > '2010-02-06'
ORDER BY RoomName;


USE `INN`;
-- INN-4
-- For each stay by GRANT KNERIEN in the hotel, calculate the total amount of money, he paid. Report reservation code, room name (full), checkin and checkout dates, and the total stay cost. Sort output in chronological order by the day of arrival.

SELECT reservations.code, rooms.RoomName, reservations.CheckIn, reservations.Checkout , DATEDIFF(CheckOut, CheckIn) * Rate AS Paid FROM reservations
JOIN rooms ON reservations.Room = rooms.RoomCode
WHERE FirstName = 'GRANT' AND LastName = 'KNERIEN'
ORDER BY CheckIn;


USE `INN`;
-- INN-5
-- For each reservation that starts on December 31, 2010 report the room name, nightly rate, number of nights spent and the total amount of money paid. Sort output in descending order by the number of nights stayed.
SELECT rooms.RoomName, Rate, DATEDIFF(CheckOut, CheckIn) AS NightsStayed, DATEDIFF(CheckOut, CheckIn) * Rate AS total 
FROM reservations JOIN rooms ON reservations.Room = rooms.RoomCode
WHERE CheckIn = '2010-12-31'
ORDER BY NightsStayed DESC;


USE `INN`;
-- INN-6
-- Report all reservations in rooms with double beds that contained four adults. For each reservation report its code, the room abbreviation, full name of the room, check-in and check out dates. Report reservations in chronological order, then sorted by the three-letter room code (in alphabetical order) for any reservations that began on the same day.
SELECT reservations.code, reservations.Room, rooms.RoomName, reservations.CheckIn, reservations.Checkout 
FROM reservations JOIN rooms ON reservations.Room = rooms.RoomCode
WHERE bedType = 'Double' AND Adults = 4
ORDER BY CheckIn, RoomCode;


USE `MARATHON`;
-- MARATHON-1
-- Report the overall place, running time, and pace of TEDDY BRASEL.
SELECT Place, RunTime, Pace
FROM marathon
WHERE FirstName = 'TEDDY' AND LastName = 'BRASEL';


USE `MARATHON`;
-- MARATHON-2
-- Report names (first, last), overall place, running time, as well as place within gender-age group for all female runners from QUNICY, MA. Sort output by overall place in the race.
-- SHOW FULL TABLES;
-- SELECT * FROM marathon;

SELECT FirstName, LastName, Place, RunTime, GroupPlace
FROM marathon
WHERE Sex = 'F' AND State = 'MA' AND Town = 'QUNICY'
ORDER BY Place;


USE `MARATHON`;
-- MARATHON-3
-- Find the results for all 34-year old female runners from Connecticut (CT). For each runner, output name (first, last), town and the running time. Sort by time.
SELECT FirstName, LastName, Town, RunTime
FROM marathon
WHERE Sex = 'F' AND Age = 34 AND STATE = 'CT'
ORDER BY RunTime;


USE `MARATHON`;
-- MARATHON-4
-- Find all duplicate bibs in the race. Report just the bib numbers. Sort in ascending order of the bib number. Each duplicate bib number must be reported exactly once.
SELECT DISTINCT marathon.BibNumber
FROM marathon, marathon as m2
WHERE marathon.BibNumber = m2.BibNumber and marathon.FirstName != m2.FirstName and marathon.LastName != m2.LastName
ORDER BY BibNumber;


USE `MARATHON`;
-- MARATHON-5
-- List all runners who took first place and second place in their respective age/gender groups. List gender, age group, name (first, last) and age for both the winner and the runner up (in a single row). Include only age/gender groups with both a first and second place runner. Order the output by gender, then by age group.
SELECT m1.Sex, m1.AgeGroup, m1.FirstName, m1.LastName, m1.Age, m2.FirstName, m2.LastName, m2.Age
FROM marathon as m1 JOIN marathon as m2 
WHERE m1.GroupPlace = 1 AND m2.GroupPlace = 2 AND m1.AgeGroup = m2.AgeGroup and m1.Sex = m2.Sex
ORDER BY m1.Sex, m1.AgeGroup;


USE `AIRLINES`;
-- AIRLINES-1
-- Find all airlines that have at least one flight out of AXX airport. Report the full name and the abbreviation of each airline. Report each name only once. Sort the airlines in alphabetical order.
SELECT DISTINCT airlines.Name, airlines.Abbr
FROM airlines inner join flights on airlines.Id = flights.Airline
WHERE Source = 'AXX'
ORDER BY airlines.Name;


USE `AIRLINES`;
-- AIRLINES-2
-- Find all destinations served from the AXX airport by Northwest. Re- port flight number, airport code and the full name of the airport. Sort in ascending order by flight number.

SELECT DISTINCT flights.FlightNo, flights.Destination, airports.Name
FROM airlines join flights on airlines.Id = flights.Airline join airports on airports.Code = Destination
WHERE Source = 'AXX' and Abbr = "Northwest"
ORDER BY flightno;


USE `AIRLINES`;
-- AIRLINES-3
-- Find all *other* destinations that are accessible from AXX on only Northwest flights with exactly one change-over. Report pairs of flight numbers, airport codes for the final destinations, and full names of the airports sorted in alphabetical order by the airport code.
-- SHOW FULL TABLES;
-- SELECT * FROM airlines;
-- SELECT * FROM flights;
-- SELECT * FROM airports;


SELECT  flights.FlightNo, flights2.FlightNo, flights2.Destination, airports2.Name
FROM airlines join flights on airlines.Id = flights.Airline join airports on airports.Code = Destination join flights as flights2 on airlines.Id = flights2.Airline join airports as airports2 on airports2.Code = flights2.Destination
WHERE flights2.Source = flights.Destination and flights.Source = 'AXX' and airlines.Name = 'Northwest Airlines'  and flights2.Destination != flights.Source
ORDER BY flights.flightno;


USE `AIRLINES`;
-- AIRLINES-4
-- Report all pairs of airports served by both Frontier and JetBlue. Each airport pair must be reported exactly once (if a pair X,Y is reported, then a pair Y,X is redundant and should not be reported).
SELECT DISTINCT flights.Source, flights.Destination  
FROM airlines join flights on airlines.Id = flights.Airline AND airlines.Abbr = "JetBlue"
                join airports on (airports.Code = Destination OR airports.Code = Destination)
                join airlines as airlines2 on airlines2.Abbr = "Frontier"
                join flights as flights2 on airlines2.Id = flights2.Airline 
                join airports as airports2 on (airports2.Code = flights2.Destination or airports2.Code = flights2.Source)
WHERE flights.Source = flights2.Source and flights.Destination = flights2.Destination
LIMIT 1;


USE `AIRLINES`;
-- AIRLINES-5
-- Find all airports served by ALL five of the airlines listed below: Delta, Frontier, USAir, UAL and Southwest. Report just the airport codes, sorted in alphabetical order.
SELECT DISTINCT f1.Source
FROM (flights as f1 join airlines as a1 ON f1.Airline = a1.ID AND a1.Name = 'Delta Airlines')
    join (flights as f2 join airlines as a2 on f2.Airline = a2.ID AND a2.Name = 'Frontier Airlines')
    join (flights as f3 join airlines as a3 on f3.Airline = a3.ID AND a3.Name = 'US Airways')
    join (flights as f4 join airlines as a4 on f4.Airline = a4.ID AND a4.Name = 'United Airlines')
    join (flights as f5 join airlines as a5 on f5.Airline = a5.ID AND a5.Name = 'Southwest Airlines')
WHERE (f1.Source = f2.Source AND f2.Source = f3.Source AND f3.Source = f4.Source AND f4.Source = f5.Source)
ORDER BY f1.Source;


USE `AIRLINES`;
-- AIRLINES-6
-- Find all airports that are served by at least three Southwest flights. Report just the three-letter codes of the airports — each code exactly once, in alphabetical order.
SELECT DISTINCT f1.Source
FROM 
    flights as f1 JOIN airlines as a1 ON a1.Abbr = "Southwest" AND f1.Airline = a1.Id
    JOIN flights as f2 ON f2.Airline = a1.Id
    JOIN flights as f3 ON f3.Airline = a1.Id
WHERE (f1.Source = f2.Source AND f2.Source = f3.Source AND f1.Source = f3.Source) and (f1.FlightNo != f2.FlightNo AND f2.FlightNo != f3.FlightNo AND f1.FlightNo != f3.FlightNo)
ORDER BY f1.Source;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report, in order, the tracklist for ’Le Pop’. Output just the names of the songs in the order in which they occur on the album.
SELECT Songs.Title
FROM (Tracklists inner join  Albums ON Albums.AId = Tracklists.Album) inner join Songs on Tracklists.Song = Songs.SongId
WHERE Albums.Title = "Le Pop"
ORDER BY Tracklists.Position;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- List the instruments each performer plays on ’Mother Superior’. Output the first name of each performer and the instrument, sort alphabetically by the first name.
SELECT Band.Firstname, Instruments.Instrument
FROM (Songs inner join Instruments ON Instruments.Song = Songs.SongId) inner join Band on Instruments.Bandmate = Band.Id
WHERE Songs.Title = "Mother Superior"
ORDER BY Band.Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List all instruments played by Anne-Marit at least once during the performances. Report the instruments in alphabetical order (each instrument needs to be reported exactly once).
SELECT DISTINCT Instruments.Instrument
FROM (Band inner join Performance ON Band.Id = Performance.Bandmate) inner join Instruments on Band.Id = Instruments.Bandmate
WHERE Band.Firstname = "Anne-Marit"
ORDER BY Instruments.Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find all songs that featured ukalele playing (by any of the performers). Report song titles in alphabetical order.
SELECT Songs.Title 
FROM Songs inner join Instruments ON Song = SongId
WHERE Instrument = 'ukalele'
ORDER BY Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments Turid ever played on the songs where she sang lead vocals. Report the names of instruments in alphabetical order (each instrument needs to be reported exactly once).
select Distinct Instrument from Songs 
JOIN Instruments ON Instruments.Song = SongId
JOIN Band On Id = Instruments.Bandmate
JOIN Vocals ON Id = Vocals.Bandmate AND Vocals.Song = SongId
WHERE Firstname = 'Turid' AND VocalType = 'lead'
ORDER BY Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Find all songs where the lead vocalist is not positioned center stage. For each song, report the name, the name of the lead vocalist (first name) and her position on the stage. Output results in alphabetical order by the song, then name of band member. (Note: if a song had more than one lead vocalist, you may see multiple rows returned for that song. This is the expected behavior).
SELECT Songs.Title, Band.Firstname, Performance.StagePosition
FROM Songs 
    JOIN Performance ON Songs.SongId = Performance.Song
    JOIN Band ON Band.Id = Performance.Bandmate
    JOIN Vocals ON Vocals.Song = Songs.SongId AND Vocals.Bandmate = Band.Id
WHERE Performance.StagePosition <> 'Center' AND Vocals.VocalType = 'lead'
ORDER BY Songs.Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Find a song on which Anne-Marit played three different instruments. Report the name of the song. (The name of the song shall be reported exactly once)
select DISTINCT Songs.Title 
FROM Songs JOIN Instruments AS instr1 ON instr1.Song = SongId
        JOIN Instruments AS instr2 ON instr2.Song = SongId
        JOIN Instruments AS instr3 ON instr3.Song = SongId
JOIN Band On Id = instr1.Bandmate AND Id = instr2.Bandmate AND Id = instr3.Bandmate
WHERE Firstname = 'Anne-Marit' AND instr1.Instrument != instr2.Instrument != instr3.Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Report the positioning of the band during ’A Bar In Amsterdam’. (just one record needs to be returned with four columns (right, center, back, left) containing the first names of the performers who were staged at the specific positions during the song).
select DISTINCT band1.FirstName AS `Right`, band2.FirstName as Center,band3.FirstName as Back, band4.FirstName as `left`  
FROM Songs 
    JOIN Band as band1 
    JOIN Band as band2 
    JOIN Band as band3 
    JOIN Band as band4 
    JOIN Performance as P1 ON band1.Id = P1.Bandmate and P1.Song = Songs.SongId
    JOIN Performance as P2 ON band2.Id = P2.Bandmate and P2.Song = Songs.SongId
    JOIN Performance as P3 ON band3.Id = P3.Bandmate and P3.Song = Songs.SongId
    JOIN Performance as P4 ON band4.Id = P4.Bandmate and P4.Song = Songs.SongId
WHERE Songs.Title = "A Bar In Amsterdam" and (P1.StagePosition = "right" and P2.StagePosition = "center" and P3.StagePosition = "back" and P4.StagePosition = "left");


