-- Lab 5
-- chdye
-- Nov 9, 2022

USE `AIRLINES`;
-- AIRLINES-1
-- Find all airports with exactly 17 outgoing flights. Report airport code and the full name of the airport sorted in alphabetical order by the code.
select Code, Name 
from airports join flights on Code = Source
group by Code, Name
having Count(FlightNo) = 17
order by Code;


USE `AIRLINES`;
-- AIRLINES-2
-- Find the number of airports from which airport ANP can be reached with exactly one transfer. Make sure to exclude ANP itself from the count. Report just the number.
Select count(DISTINCT f1.Source)
FROM flights as f1 join flights as f2
WHERE f1.Source != "ANP" and f2.Destination = "ANP" and f1.Destination = f2.Source;


USE `AIRLINES`;
-- AIRLINES-3
-- Find the number of airports from which airport ATE can be reached with at most one transfer. Make sure to exclude ATE itself from the count. Report just the number.
SELECT Count(Distinct f1.Source)
FROM 
    flights as f1 join airports as a1 on a1.Code = f1.Source
    join flights as f2 join airports as a2 on a2.Code = f2.Source
WHERE ( (f2.Source = f1.Destination and f2.Destination = "ATE") or (f1.Source = f2.Source and f1.Destination = "ATE") ) and f1.Source != "ATE";


USE `AIRLINES`;
-- AIRLINES-4
-- For each airline, report the total number of airports from which it has at least one outgoing flight. Report the full name of the airline and the number of airports computed. Report the results sorted by the number of airports in descending order. In case of tie, sort by airline name A-Z.
SELECT a.Name, COUNT(Distinct f.Source)
FROM
    airlines as a join flights as f on f.Airline = a.Id
GROUP BY (a.Name)
ORDER BY COUNT(Distinct f.Source) desc, a.Name ;


USE `BAKERY`;
-- BAKERY-1
-- For each flavor which is found in more than three types of items offered at the bakery, report the flavor, the average price (rounded to the nearest penny) of an item of this flavor, and the total number of different items of this flavor on the menu. Sort the output in ascending order by the average price.
select Flavor,ROUND(AVG(PRICE),2) as AveragePrice,
Count(Flavor) as DifferentPastries from goods
group by Flavor
having count(*) > 3
order by AveragePrice;


USE `BAKERY`;
-- BAKERY-2
-- Find the total amount of money the bakery earned in October 2007 from selling eclairs. Report just the amount.
SELECT Sum(g.Price) as total_money
FROM 
    goods as g join items as i on g.GId = i.Item
               join receipts as r on i.Receipt = r.RNumber
WHERE g.Food = "Eclair" and MONTH(r.SaleDate) = 10 and YEAR(r.SaleDate) = 2007;


USE `BAKERY`;
-- BAKERY-3
-- For each visit by NATACHA STENZ output the receipt number, sale date, total number of items purchased, and amount paid, rounded to the nearest penny. Sort by the amount paid, greatest to least.
SELECT r.RNumber, r.SaleDate, Count(SaleDate), ROUND(SUM(PRICE),2) as CheckAmount 
FROM 
    customers as c join receipts as r ON r.Customer = c.CId
    join items as i ON i.Receipt = r.RNumber
    join goods as g on i.Item = g.GId
WHERE FirstName = "NATACHA" and LastName = "STENZ"
Group by(r.RNumber)
order by SUM(Price) DESC;


USE `BAKERY`;
-- BAKERY-4
-- For the week starting October 8, report the day of the week (Monday through Sunday), the date, total number of purchases (receipts), the total number of pastries purchased, and the overall daily revenue rounded to the nearest penny. Report results in chronological order.
select DayName(SaleDate) as Day,
SaleDate,
COUNT(Distinct RNumber) as Receipts,
Count(Customer)as Items,
ROUND(Sum(PRICE),2) as Revenue
FROM
    goods as g join items as i on i.Item = g.GId
    join receipts as r ON i.Receipt = r.RNumber
where SaleDate >= DATE'2007-10-08' and SaleDate <= DATE'2007-10-14'
GROUP BY(SaleDate)
ORDER BY(SaleDate);


USE `BAKERY`;
-- BAKERY-5
-- Report all dates on which more than ten tarts were purchased, sorted in chronological order.
SELECT SaleDate
FROM
    goods as g join items as i on i.Item = g.GId
    join receipts as r ON i.Receipt = r.RNumber
where g.Food = "Tart"
GROUP BY(SaleDate)
HAVING Count(*) > 10;


USE `CSU`;
-- CSU-1
-- For each campus that averaged more than $2,500 in fees between the years 2000 and 2005 (inclusive), report the campus name and total of fees for this six year period. Sort in ascending order by fee.
SELECT c.Campus, ROUND(SUM(fee),2) as Fee 
FROM
    campuses as c join fees as f on f.CampusId = c.Id
WHERE f.Year >= 2000 and f.Year <= 2005
group by c.Campus
having SUM(fee) / COUNT(*) > 2500.0
order by Fee;


USE `CSU`;
-- CSU-2
-- For each campus for which data exists for more than 60 years, report the campus name along with the average, minimum and maximum enrollment (over all years). Sort your output by average enrollment.
select Campus, AVG(Enrolled), MIN(Enrolled), MAX(Enrolled)
from campuses as c join enrollments as e
on e.CampusId = c.Id
group by Campus
having COUNT(e.Year) > 60
order by AVG(e.Enrolled);


USE `CSU`;
-- CSU-3
-- For each campus in LA and Orange counties report the campus name and total number of degrees granted between 1998 and 2002 (inclusive). Sort the output in descending order by the number of degrees.

select c.Campus, SUM(d.degrees) as total_degrees 
from campuses as c join degrees as d
on d.CampusId = c.Id
WHERE (d.year >= 1998 and d.year <= 2002) and (c.County = "Los Angeles" or c.County = "Orange")
group by c.Campus
ORDER BY SUM(degrees) desc;


USE `CSU`;
-- CSU-4
-- For each campus that had more than 20,000 enrolled students in 2004, report the campus name and the number of disciplines for which the campus had non-zero graduate enrollment. Sort the output in alphabetical order by the name of the campus. (Exclude campuses that had no graduate enrollment at all.)
select c.Campus, COUNT(d.Discipline) as disciplines
from campuses as c join enrollments as e on e.CampusId = c.Id
              join discEnr as d on d.CampusId = c.Id
where e.year = 2004 and e.Enrolled > 20000
and d.Gr > 0
group by Campus
order by Campus;


USE `INN`;
-- INN-1
-- For each room, report the full room name, total revenue (number of nights times per-night rate), and the average revenue per stay. In this summary, include only those stays that began in the months of September, October and November of calendar year 2010. Sort output in descending order by total revenue. Output full room names.
select rooms.RoomName, Round(SUM(Rate * DateDiff(CheckOut,CheckIn)),2) as TotalRevenue, Round(AVG(Rate * DateDiff(CheckOut,CheckIn)),2) as AveragePerStay
from reservations join rooms on RoomCode = Room
where Month(CheckIn) >= 9 and Month(CheckIn) <= 11 and YEAR(CheckIn) = 2010
group by RoomName
order by SUM(Rate * DateDiff(CheckOut,CheckIn)) desc;


USE `INN`;
-- INN-2
-- Report the total number of reservations that began on Fridays, and the total revenue they brought in.
SELECT COUNT(*) as num_fridays, Round(SUM(Rate * DateDiff(CheckOut,CheckIn)),2) as TotalRevenue
FROM reservations
where DAYNAME(CheckIn) = "Friday";


USE `INN`;
-- INN-3
-- List each day of the week. For each day, compute the total number of reservations that began on that day, and the total revenue for these reservations. Report days of week as Monday, Tuesday, etc. Order days from Sunday to Saturday.
select DayName(CheckIn), COUNT(*) as Stays, SUM(Rate * DateDiff(CheckOut,CheckIn)) as REVENUE
from reservations
group by DayOfWeek(CheckIn), DayName(CheckIn)
order by DayOfWeek(CheckIn);


USE `INN`;
-- INN-4
-- For each room list full room name and report the highest markup against the base price and the largest markdown (discount). Report markups and markdowns as the signed difference between the base price and the rate. Sort output in descending order beginning with the largest markup. In case of identical markup/down sort by room name A-Z. Report full room names.
select roomname, MAX(Rate - BasePrice) as Markup, MIN(Rate - BasePrice) as Discount
from reservations join rooms on Room = RoomCode
group by roomname
order by MAX(Rate - BasePrice) desc, roomname;


USE `INN`;
-- INN-5
-- For each room report how many nights in calendar year 2010 the room was occupied. Report the room code, the full name of the room, and the number of occupied nights. Sort in descending order by occupied nights. (Note: this should be number of nights during 2010. Some reservations extend beyond December 31, 2010. The ”extra” nights in 2011 must be deducted).
SELECT r.RoomCode, r.RoomName, sum(DateDiff( CASE WHEN rsv.CheckOut >'2010-12-31' THEN DATE '2011-01-01' ELSE rsv.CheckOut END, CASE WHEN rsv.CheckIn < '2009-12-31' THEN DATE '2010-01-01' ELSE rsv.CheckIn END)) as DaysOccupied
FROM rooms as r join reservations as rsv on r.RoomCode = rsv.Room
WHERE YEAR(rsv.CheckIn) <= 2010 and YEAR(rsv.CheckOut) >= 2010
group by r.RoomName, r.RoomCode
ORDER BY DaysOccupied desc;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- For each performer, report first name and how many times she sang lead vocals on a song. Sort output in descending order by the number of leads. In case of tie, sort by performer first name (A-Z.)
SELECT b.Firstname, Count(*)
FROM
    Band as b join Vocals as v on b.Id = v.Bandmate
WHERE v.VocalType = "lead"
GROUP BY v.Bandmate, v.VocalType
ORDER BY Count(*) desc, b.Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- Report how many different instruments each performer plays on songs from the album 'Le Pop'. Include performer's first name and the count of different instruments. Sort the output by the first name of the performers.
SELECT b.Firstname, COUNT(distinct i.Instrument) as num_instruments
FROM Band as b join Instruments as i on b.Id = i.Bandmate 
        join Tracklists as t on t.Song = i.Song
        join Albums as a on a.AId = t.Album
WHERE a.Title = "Le Pop"
group by b.Firstname
ORDER BY b.Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- List each stage position along with the number of times Turid stood at each stage position when performing live. Sort output in ascending order of the number of times she performed in each position.

SELECT p.StagePosition, Count(*) as num_times
FROM Band as b join Performance as p on b.Id = p.Bandmate
WHERE b.Firstname = "Turid"
group by (p.StagePosition)
ORDER BY num_times;


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Report how many times each performer (other than Anne-Marit) played bass balalaika on the songs where Anne-Marit was positioned on the left side of the stage. List performer first name and a number for each performer. Sort output alphabetically by the name of the performer.

SELECT b.Firstname, Count(distinct i.Song)
FROM 
    Band as b join Instruments as i on b.Id = i.Bandmate
              join Performance as p on b.Id = p.Bandmate
              join Band as b2 on b2.Firstname = "Anne-Marit"
              join Performance as p2 on b2.Id = p2.Bandmate and p2.Song = p.Song and p2.Song = i.Song
              
WHERE (b.Firstname <> "Anne-Marit" and i.Instrument = "bass balalaika")
and (b2.Firstname = "Anne-Marit" and p2.StagePosition = "left")
group by (b.Firstname);


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Report all instruments (in alphabetical order) that were played by three or more people.
select distinct Instrument from Instruments
group by Instrument
having Count(distinct Bandmate) > 2
order by Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- For each performer, list first name and report the number of songs on which they played more than one instrument. Sort output in alphabetical order by first name of the performer
-- instruments 2
SELECT b.Firstname, Count(Distinct i1.Song) 
FROM 
    Instruments as i1 join Instruments as i2 on i1.Song = i2.Song and i1.Bandmate = i2.Bandmate and i1.Instrument <> i2.Instrument
    join Band as b on b.Id = i1.Bandmate
group by b.Firstname
ORDER BY b.Firstname;


USE `MARATHON`;
-- MARATHON-1
-- List each age group and gender. For each combination, report total number of runners, the overall place of the best runner and the overall place of the slowest runner. Output result sorted by age group and sorted by gender (F followed by M) within each age group.
SELECT AgeGroup, Sex, COUNT(*), MIN(Place), MAX(Place) 
FROM marathon
GROUP BY AgeGroup, Sex
ORDER BY AgeGroup, Sex;


USE `MARATHON`;
-- MARATHON-2
-- Report the total number of gender/age groups for which both the first and the second place runners (within the group) are from the same state.
SELECT count(*)
FROM marathon as m1 join marathon as m2
WHERE m1.GroupPlace = 1 and m2.GroupPlace = 2 and m1.Sex = m2.Sex and m1.AgeGroup = m2.AgeGroup and m1.State = m2.State;


USE `MARATHON`;
-- MARATHON-3
-- For each full minute, report the total number of runners whose pace was between that number of minutes and the next. In other words: how many runners ran the marathon at a pace between 5 and 6 mins, how many at a pace between 6 and 7 mins, and so on.
select Minute(Pace),Count(*) from marathon
group by Minute(Pace);


USE `MARATHON`;
-- MARATHON-4
-- For each state with runners in the marathon, report the number of runners from the state who finished in top 10 in their gender-age group. If a state did not have runners in top 10, do not output information for that state. Report state code and the number of top 10 runners. Sort in descending order by the number of top 10 runners, then by state A-Z.
SELECT State, Count(*) 
FROM marathon
WHERE GroupPlace < 11
GROUP BY(State)
HAVING Count(*) > 0
ORDER BY Count(*) DESC;


USE `MARATHON`;
-- MARATHON-5
-- For each Connecticut town with 3 or more participants in the race, report the town name and average time of its runners in the race computed in seconds. Output the results sorted by the average time (lowest average time first).
SELECT Town, Round(AVG(TIME_TO_SEC(RunTime)),1) 
FROM marathon
WHERE State = 'CT'
group by Town
having count(*) >= 3
order by Round(AVG(TIME_TO_SEC(RunTime)),1);


USE `STUDENTS`;
-- STUDENTS-1
-- Report the last and first names of teachers who have between seven and eight (inclusive) students in their classrooms. Sort output in alphabetical order by the teacher's last name.
SELECT distinct t.Last, t.First
FROM teachers as t join list as l on l.classroom = t.classroom
group by t.Last, t.First
having (count(*) = 7 or count(*) = 8)
ORDER BY t.Last;


USE `STUDENTS`;
-- STUDENTS-2
-- For each grade, report the grade, the number of classrooms in which it is taught, and the total number of students in the grade. Sort the output by the number of classrooms in descending order, then by grade in ascending order.

SELECT l.grade, Count(distinct l.classroom), Count(distinct l.Lastname)
FROM list as l join teachers as t
GROUP BY l.grade
ORDER BY Count(distinct l.classroom) desc , l.grade asc;


USE `STUDENTS`;
-- STUDENTS-3
-- For each Kindergarten (grade 0) classroom, report classroom number along with the total number of students in the classroom. Sort output in the descending order by the number of students.
SELECT l.classroom, Count(distinct l.LastName)
FROM list as l join teachers as t
WHERE l.grade = 0
GROUP BY l.classroom
ORDER BY Count(distinct l.LastName) desc;


USE `STUDENTS`;
-- STUDENTS-4
-- For each fourth grade classroom, report the classroom number and the last name of the student who appears last (alphabetically) on the class roster. Sort output by classroom.
SELECT l.classroom, MAX(lastname)
FROM list as l 
WHERE l.grade = 4
GROUP BY l.classroom
ORDER BY l.classroom;


