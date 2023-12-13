-- Lab 6
-- chdye
-- Dec 1, 2022

USE `BAKERY`;
-- BAKERY-1
-- Find all customers who did not make a purchase between October 5 and October 11 (inclusive) of 2007. Output first and last name in alphabetical order by last name.
SELECT DISTINCT c.FirstName, c.LastName
FROM customers as c join receipts as r on c.CId = r.Customer
WHERE c.CId
    NOT IN (SELECT c2.CId
            FROM customers as c2 join receipts as r2 on c2.CId = r2.Customer
            WHERE r2.SaleDate >= '2007-10-05' and r2.SaleDate <= '2007-10-11');


USE `BAKERY`;
-- BAKERY-2
-- Find the customer(s) who spent the most money at the bakery during October of 2007. Report first, last name and total amount spent (rounded to two decimal places). Sort by last name.
with maxSpent as (
    select Customer,FirstName,LastName,SUM(PRICE) as Spent from receipts 
    join items on Receipt = RNumber
    join goods on GId = Item
    join customers on Customer = CId
    where SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    group by Customer
)
select FirstName,LastName,Round(Spent,2) from maxSpent
where Spent = (
    select MAX(Spent) from maxSpent
);


USE `BAKERY`;
-- BAKERY-3
-- Find all customers who never purchased a twist ('Twist') during October 2007. Report first and last name in alphabetical order by last name.

SELECT DISTINCT c2.FirstName, c2.LastName 
FROM 
    customers as c2 join receipts as r2 on c2.CId = r2.Customer 
                    join items as i2 on i2.Receipt = r2.RNumber
                    join goods as g2 on g2.GId = i2.Item
WHERE c2.CID
NOT IN(
    SELECT c.CID
    FROM 
        customers as c join receipts as r on c.CId = r.Customer 
                        join items as i on i.Receipt = r.RNumber
                        join goods as g on g.GId = i.Item
    WHERE g.Food = "Twist" AND SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    ORDER BY c.LastName );


USE `BAKERY`;
-- BAKERY-4
-- Find the baked good(s) (flavor and food type) responsible for the most total revenue.
with Revenues as (
    SELECT Food,Flavor,SUM(PRICE) as Revenue 
    FROM receipts join items on Receipt = RNumber
                  join goods on GId = Item
    GROUP BY Food,Flavor
)
SELECT Flavor, Food FROM Revenues
WHERE Revenue = (
    SELECT MAX(Revenue) FROM Revenues
);


USE `BAKERY`;
-- BAKERY-5
-- Find the most popular item, based on number of pastries sold. Report the item (flavor and food) and total quantity sold.
with GoodsSold as (
    -- GET the number of pastries sold
    SELECT Food, Flavor, Count(*) as Sold 
    FROM receipts 
        JOIN items on Receipt = RNumber
        JOIN goods on GId = Item
    GROUP BY Food, Flavor
)
-- Takethe max of this
SELECT Flavor, Food, Sold FROM GoodsSold
WHERE Sold = (
    SELECT MAX(Sold) FROM GoodsSold
);


USE `BAKERY`;
-- BAKERY-6
-- Find the date(s) of highest revenue during the month of October, 2007. In case of tie, sort chronologically.
with datesRevenue as (
    select SaleDate, SUM(PRICE) as Revenue from receipts 
    join items on Receipt = RNumber
    join goods on GId = Item
    where SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    group by SaleDate
)
select SaleDate from datesRevenue
where Revenue = (
    select MAX(Revenue) from datesRevenue
);


USE `BAKERY`;
-- BAKERY-7
-- Find the best-selling item(s) (by number of purchases) on the day(s) of highest revenue in October of 2007.  Report flavor, food, and quantity sold. Sort by flavor and food.
with datesRevenue AS (
    SELECT SaleDate, SUM(PRICE) as Revenue from receipts
    JOIN items on Receipt = RNumber
    JOIN goods on GId = Item
    WHERE SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    GROUP BY SaleDate
),
goodSold AS (
    select SaleDate,Food,Flavor,Count(*) as Sold from receipts 
    join items on Receipt = RNumber
    join goods on GId = Item
    group by Food,Flavor,SaleDate
),
bestSelling AS (
    SELECT Food, Flavor, Sold FROM goodSold
    where SaleDate = (
        select SaleDate from datesRevenue
            where Revenue = (
                select MAX(Revenue) from datesRevenue
            )
    )
)
SELECT Flavor, Food,  Sold FROM bestSelling
    where Sold = (
        select MAX(Sold) from bestSelling
    );


USE `BAKERY`;
-- BAKERY-8
-- For every type of Cake report the customer(s) who purchased it the largest number of times during the month of October 2007. Report the name of the pastry (flavor, food type), the name of the customer (first, last), and the quantity purchased. Sort output in descending order on the number of purchases, then in alphabetical order by last name of the customer, then by flavor.
with Cakes as (
    select Customer, FirstName, LastName, Flavor, Food, Count(*) as quantity 
    from receipts join items on Receipt = RNumber
        join goods on GId = Item
        join customers on Customer = CId
    where SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31' and Food = 'Cake'
    group by Customer, Flavor
)
SELECT Flavor, Food, FirstName, LastName, quantity 
FROM Cakes as c1
WHERE quantity = 
    (   SELECT MAX(quantity) FROM Cakes as c2
        where c2.Flavor = c1.Flavor )
order by quantity DESC, LastName, Flavor;


USE `BAKERY`;
-- BAKERY-9
-- Output the names of all customers who made multiple purchases (more than one receipt) on the latest day in October on which they made a purchase. Report names (last, first) of the customers and the *earliest* day in October on which they made a purchase, sorted in chronological order, then by last name.

with latestDay as (
    select MAX(SaleDate) as LastSale, Customer as C1, FirstName, LastName
    from receipts join items on Receipt = RNumber
        join goods on GId = Item
        join customers on Customer = CId
    where SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    group by Customer
),
earliestDay as (
    select MIN(SaleDate) as FirstSale, Customer as C2
    from receipts join items on Receipt = RNumber
        join goods on GId = Item
        join customers on Customer = CId
    where SaleDate >= '2007-10-01' and SaleDate <= '2007-10-31'
    group by Customer
)
SELECT LastName, FirstName, FirstSale
FROM receipts join latestDay on Customer = C1 and SaleDate = LastSale 
               join earliestDay on Customer = C2
GROUP BY Customer
HAVING COUNT(RNumber) > 1
ORDER BY FirstSale, LastName;


USE `BAKERY`;
-- BAKERY-10
-- Find out if sales (in terms of revenue) of Chocolate-flavored items or sales of Croissants (of all flavors) were higher in October of 2007. Output the word 'Chocolate' if sales of Chocolate-flavored items had higher revenue, or the word 'Croissant' if sales of Croissants brought in more revenue.

with revenueCroissants as (
    select SUM(PRICE) as revenueCrois 
    from receipts 
        join items on Receipt = RNumber
        join goods on GId = Item
    where Food = 'Croissant'
),
revenueChocolate as (
    select SUM(PRICE) as revenueChoc, Flavor 
    from receipts 
        join items on Receipt = RNumber
        join goods on GId = Item
    where Flavor = 'Chocolate'
)
SELECT  
    Case WHEN revenueChoc > revenueCrois 
    Then
    'Chocolate'
    Else
    'Croissant'
    END as Revenue
from revenueChocolate 
join revenueCroissants;


USE `INN`;
-- INN-1
-- Find the most popular room(s) (based on the number of reservations) in the hotel  (Note: if there is a tie for the most popular room, report all such rooms). Report the full name of the room, the room code and the number of reservations.

with popularRoom as (
    SELECT RoomName, RoomCode, Count(CODE) as Reservations
    FROM reservations as rsv join rooms as rm on rsv.Room = rm.RoomCode
    GROUP BY (rsv.Room)
)
SELECT RoomName, RoomCode, Reservations FROM popularRoom
    where Reservations = (
        SELECT max(Reservations) FROM popularRoom
    );


USE `INN`;
-- INN-2
-- Find the room(s) that have been occupied the largest number of days based on all reservations in the database. Report the room name(s), room code(s) and the number of days occupied. Sort by room name.
with RoomReservations as (
    SELECT Room, RoomName, DateDiff(Checkout,CheckIn) AS rsvCount FROM reservations
    join rooms on Room = RoomCode
    group by Room, CheckIn, CheckOut
),
DaysOccupied as (
    select Room, RoomName, SUM(rsvCount) as Total from RoomReservations
    group by Room
)
select RoomName,Room,Total from DaysOccupied
where Total = (
    select MAX(Total) from DaysOccupied
);


USE `INN`;
-- INN-3
-- For each room, report the most expensive reservation. Report the full room name, dates of stay, last name of the person who made the reservation, daily rate and the total amount paid (rounded to the nearest penny.) Sort the output in descending order by total amount paid.
with RoomReservations as (
    SELECT CODE, CheckIn, Checkout, LastName, Room, RoomName, Rate, DateDiff(Checkout,CheckIn) * Rate AS Expenses FROM reservations
    join rooms on Room = RoomCode
    group by CODE
)
SELECT RoomName, CheckIn, Checkout, LastName, Rate, Expenses from RoomReservations r1
-- This will loop through for all rooms
where Expenses = (
    select MAX(Expenses) from RoomReservations r2
    where r1.Room = r2.Room
)
ORDER BY Expenses DESC;


USE `INN`;
-- INN-4
-- For each room, report whether it is occupied or unoccupied on July 4, 2010. Report the full name of the room, the room code, and either 'Occupied' or 'Empty' depending on whether the room is occupied on that day. (the room is occupied if there is someone staying the night of July 4, 2010. It is NOT occupied if there is a checkout on this day, but no checkin). Output in alphabetical order by room code. 
with checkOccupied as (
    SELECT RoomName, RoomCode, CASE
        WHEN (CheckIn <= '2010-07-04' and Checkout > '2010-07-04')
        Then
            'Occupied'
        Else
            'Empty'
        END as isOccupied
    FROM reservations
        join rooms on Room = RoomCode
),
OccupiedTrue as (
    SELECT RoomName, RoomCode, isOccupied
    FROM checkOccupied
    WHERE isOccupied = "Occupied" 
    GROUP BY RoomName, RoomCode, isOccupied
)
SELECT rooms.RoomName, rooms.RoomCode, IFNULL(isOccupied, "Empty") as Occupancy
FROM rooms 
    left join OccupiedTrue
    on rooms.RoomName = OccupiedTrue.RoomName;


USE `INN`;
-- INN-5
-- Find the highest-grossing month (or months, in case of a tie). Report the month name, the total number of reservations and the revenue. For the purposes of the query, count the entire revenue of a stay that commenced in one month and ended in another towards the earlier month. (e.g., a September 29 - October 3 stay is counted as September stay for the purpose of revenue computation). In case of a tie, months should be sorted in chronological order.
with individualResvCost as (
    SELECT CheckIn, CheckOut, DateDiff(CheckOut,Checkin) * Rate as Price 
    FROM reservations
),
aggregatedMonthCost as (
    SELECT Month(CheckIn) as Month, SUM(Price) as MonthlyCost, Count(*) as totalReservationsInMon 
    FROM individualResvCost
    GROUP BY Month(CheckIn)
)
SELECT MONTHNAME(STR_TO_DATE(Month, '%m')), totalReservationsInMon, MonthlyCost 
FROM aggregatedMonthCost
WHERE MonthlyCost = (
    SELECT MAX(MonthlyCost) 
    FROM aggregatedMonthCost
)
ORDER BY Month;


USE `STUDENTS`;
-- STUDENTS-1
-- Find the teacher(s) with the largest number of students. Report the name of the teacher(s) (last, first) and the number of students in their class.

with withNumStudents as (
    SELECT t.Last, t.First, Count(*) as totalStudents
    FROM teachers as t join list as l
    WHERE t.classroom = l.classroom
    GROUP BY t.First, t.Last
)
select * from withNumStudents
where totalStudents = (
    select MAX(totalStudents) from withNumStudents
);


USE `STUDENTS`;
-- STUDENTS-2
-- Find the grade(s) with the largest number of students whose last names start with letters 'A', 'B' or 'C' Report the grade and the number of students. In case of tie, sort by grade number.
with withNumStudents as (
    SELECT grade, Count(*) as totalStudents
    FROM teachers as t join list as l on t.classroom = l.classroom
    where LastName like "A%" or LastName like "B%" or LastName like "C%"
    GROUP BY grade
)
select * from withNumStudents
where totalStudents = (
    select MAX(totalStudents) from withNumStudents
);


USE `STUDENTS`;
-- STUDENTS-3
-- Find all classrooms which have fewer students in them than the average number of students in a classroom in the school. Report the classroom numbers and the number of student in each classroom. Sort in ascending order by classroom.
with StudentsInClass as (
    select teachers.classroom, Count(*) as Students 
    from teachers join list on teachers.classroom = list.classroom
    group by teachers.classroom
)
select * from StudentsInClass 
where Students < (
    select Avg(Students) from StudentsInClass
);


USE `STUDENTS`;
-- STUDENTS-4
-- Find all pairs of classrooms with the same number of students in them. Report each pair only once. Report both classrooms and the number of students. Sort output in ascending order by the number of students in the classroom.
with StudentsInClass as (
    select teachers.classroom, Count(*) as Students 
    from teachers join list on teachers.classroom = list.classroom
    group by teachers.classroom
),
SameClassrooms as (
    select s1.classroom as c1,s2.classroom as c2, s1.Students 
    from StudentsInClass s1 join StudentsInClass s2
    on s1.classroom < s2.classroom
    and s1.Students = s2.Students
    order by s1.Students
)
select * from SameClassrooms;


USE `STUDENTS`;
-- STUDENTS-5
-- For each grade with more than one classroom, report the grade and the last name of the teacher who teaches the classroom with the largest number of students in the grade. Output results in ascending order by grade.
with diffClasses as (
    select grade, Count(Distinct list.classroom) as NumClasses
    from teachers join list on teachers.classroom = list.classroom
    group by list.grade
    
),
numStudentsTaught as (
    SELECT grade, teachers.Last, teachers.First, Count(*) as Students
    from teachers join list on teachers.classroom = list.classroom
    group by list.grade, teachers.Last, teachers.First
),
moreThanOne as (
    SELECT diffClasses.grade, Last, First, Students 
    FROM numStudentsTaught join diffClasses on diffClasses.grade = numStudentsTaught.grade
    WHERE diffClasses.NumClasses > 1 
)
SELECT grade, Last
FROM moreThanOne as m1
WHERE Students = (SELECT MAX(Students) FROM numStudentsTaught as m2 
                    WHERE m1.grade = m2.grade)
ORDER BY grade

AND Students = (SELECT MAX(Students) FROM numStudentsTaught as t2);


USE `CSU`;
-- CSU-1
-- Find the campus(es) with the largest enrollment in 2000. Output the name of the campus and the enrollment. Sort by campus name.

SELECT Campus, Enrolled
FROM campuses as c join enrollments as e on c.Id = e.CampusId
WHERE e.Year = 2000
and Enrolled = (
    select MAX(Enrolled) from enrollments
    WHERE Year = 2000
);


USE `CSU`;
-- CSU-2
-- Find the university (or universities) that granted the highest average number of degrees per year over its entire recorded history. Report the name of the university, sorted alphabetically.

with numdegrees as 
    (SELECT c.Campus, SUM(degrees) as totalDegrees
    FROM campuses as c join degrees as d on c.Id = d.CampusId
    GROUP BY c.Campus)
SELECT Campus FROM numdegrees
WHERE totalDegrees = 
(SELECT MAX(totalDegrees) FROM numdegrees);


USE `CSU`;
-- CSU-3
-- Find the university with the lowest student-to-faculty ratio in 2003. Report the name of the campus and the student-to-faculty ratio, rounded to one decimal place. Use FTE numbers for enrollment. In case of tie, sort by campus name.
with student_fac_ratio AS (
    SELECT Campus, enrollments.FTE / faculty.FTE AS Ratio 
    FROM campuses JOIN faculty ON faculty.CampusId = Id
    JOIN enrollments ON enrollments.CampusId = Id
    AND faculty.Year = enrollments.Year
    WHERE enrollments.Year = 2003
)
SELECT Campus, Round(Ratio,1) FROM student_fac_ratio
WHERE Ratio = (
    SELECT MIN(Ratio) FROM student_fac_ratio
);


USE `CSU`;
-- CSU-4
-- Among undergraduates studying 'Computer and Info. Sciences' in the year 2004, find the university with the highest percentage of these students (base percentages on the total from the enrollments table). Output the name of the campus and the percent of these undergraduate students on campus. In case of tie, sort by campus name.
with perecent_enrolled as (
    select Campus,
    discEnr.Ug / enrollments.Enrolled as Ratio 
    FROM campuses 
        join discEnr on campuses.Id = discEnr.CampusId
        join enrollments on campuses.Id = enrollments.CampusId
        join disciplines on disciplines.Id = discEnr.Discipline
    where discEnr.Year = 2004 and enrollments.Year = 2004 and disciplines.Name = 'Computer and Info. Sciences'
)
select Campus, ROUND(Ratio*100,1) as PercentEnrolled 
FROM perecent_enrolled
where Ratio = (
    select MAX(Ratio) from perecent_enrolled
);


USE `CSU`;
-- CSU-5
-- For each year between 1997 and 2003 (inclusive) find the university with the highest ratio of total degrees granted to total enrollment (use enrollment numbers). Report the year, the name of the campuses, and the ratio. List in chronological order.
with degreeRatio as (
    select enrollments.Year, Campus, degrees / enrollments.Enrolled as numDegrees 
    FROM campuses 
        join degrees on degrees.CampusId = campuses.Id
        join enrollments on (enrollments.CampusId = campuses.Id and degrees.year = enrollments.Year)
    WHERE degrees.year >= 1997 and degrees.year <= 2003
    and enrollments.Year >= 1997 and enrollments.Year <= 2003
)
SELECT * 
FROM degreeRatio d1
WHERE numDegrees = (
    SELECT MAX(numDegrees) FROM degreeRatio d2
    WHERE d1.Year = d2.Year
)
ORDER BY Year;


USE `CSU`;
-- CSU-6
-- For each campus report the year of the highest student-to-faculty ratio, together with the ratio itself. Sort output in alphabetical order by campus name. Use FTE numbers to compute ratios and round to two decimal places.
with ratios as (
    SELECT Campus, f.Year, ROUND (e.FTE/ f.FTE, 2) as ratio
    FROM campuses as c
        join faculty as f on f.CampusId = c.Id
        join enrollments as e on e.CampusId = c.Id and e.Year = f.Year
)
SELECT * FROM ratios r1
WHERE ratio = 
(
    SELECT MAX(ratio) FROM ratios r2
    WHERE r1.Campus = r2.Campus
)
ORDER BY Campus;


USE `CSU`;
-- CSU-7
-- For each year for which the data is available, report the total number of campuses in which student-to-faculty ratio became worse (i.e. more students per faculty) as compared to the previous year. Report in chronological order.

with ratios as (
    SELECT Campus, f.Year, ROUND (e.FTE/ f.FTE, 2) as ratio
    FROM campuses as c
        join faculty as f on f.CampusId = c.Id
        join enrollments as e on e.CampusId = c.Id and e.Year = f.Year
)
-- Year + 1 because we're saying r2 year is r1.Year + 1
SELECT Year + 1, Count(*)
    FROM ratios r1
    WHERE ratio < 
    (
        SELECT MAX(Ratio) from ratios r2
        WHERE r1.Campus = r2.Campus
        and r2.Year = r1.Year + 1
    )
    GROUP BY Year
    ORDER BY Year;


USE `MARATHON`;
-- MARATHON-1
-- Find the state(s) with the largest number of participants. List state code(s) sorted alphabetically.

with stateNums as (
SELECT State, Count(LastName) as participants
FROM marathon
GROUP BY State
)
SELECT State FROM stateNums
WHERE participants = (
    SELECT MAX(participants) from stateNums
);


USE `MARATHON`;
-- MARATHON-2
-- Find all towns in Rhode Island (RI) which fielded more female runners than male runners for the race. Include only those towns that fielded at least 1 male runner and at least 1 female runner. Report the names of towns, sorted alphabetically.

with numFemales as (
    select Town, Count(*) as Females 
    from marathon
    where State = 'RI' and Sex = 'F'
    group by Town
),
numMales as (
    select Town,Count(*) as Males 
    from marathon
    where State = 'RI' and Sex = 'M'
    group by Town
)
select numFemales.Town from
numFemales join numMales
on numFemales.Town = numMales.Town
where Females > Males
order by numFemales.Town;


USE `MARATHON`;
-- MARATHON-3
-- For each state, report the gender-age group with the largest number of participants. Output state, age group, gender, and the number of runners in the group. Report only information for the states where the largest number of participants in a gender-age group is greater than one. Sort in ascending order by state code, age group, then gender.
with participants as (
SELECT State, Sex, AgeGroup, Count(AgeGroup) as numParticipants
FROM marathon
GROUP BY State, Sex, AgeGroup
)
SELECT State,AgeGroup,Sex, numParticipants from participants p1
where numParticipants = (
    select MAX(numParticipants) from participants p2
    where p1.State = p2.State
)
and numParticipants > 1
order by State, AgeGroup, Sex;

with ParticipantsPerGroup as (
    select State,Sex,AgeGroup,Count(*) as Participants from marathon
    group by State,Sex,AgeGroup
)
select State,AgeGroup,Sex,Participants from ParticipantsPerGroup p1
where Participants = (
    select MAX(Participants) from ParticipantsPerGroup p2
    where p1.State = p2.State
)
and Participants > 1
order by State,AgeGroup,Sex
;


USE `MARATHON`;
-- MARATHON-4
-- Find the 30th fastest female runner. Report her overall place in the race, first name, and last name. This must be done using a single SQL query (which may be nested) that DOES NOT use the LIMIT clause. Think carefully about what it means for a row to represent the 30th fastest (female) runner.
SELECT Place,FirstName,LastName 
FROM marathon m1
WHERE sex = 'F'
AND (
    -- Select the person where theres 29 people who are faster than them
    SELECT Count(*) FROM marathon m2
    WHERE sex = 'F' AND m2.Place < m1.Place
) = 29
GROUP BY Place;


USE `MARATHON`;
-- MARATHON-5
-- For each town in Connecticut report the total number of male and the total number of female runners. Both numbers shall be reported on the same line. If no runners of a given gender from the town participated in the marathon, report 0. Sort by number of total runners from each town (in descending order) then by town.

with totalCount as (
    select Town, Count(*) as totalParticipants from marathon
    where State = 'CT'
    group by Town
),
numMales as (
    select Town, Count(*) as maleParticipants from marathon
    where State = 'CT' and Sex = "M"
    group by Town
),
numFemales as (
    select Town, Count(*) as femaleParticipants from marathon
    where State = 'CT' and Sex = "F"
    group by Town
)
SELECT totalCount.Town, IFNULL(maleParticipants, 0) as men, IFNULL(femaleParticipants, 0) as women
FROM totalCount 
    left  join numMales 
    on numMales.Town = totalCount.Town
    left outer join numFemales 
    on totalCount.Town = numFemales.Town
ORDER BY totalCount.totalParticipants DESC, totalCount.Town;


USE `KATZENJAMMER`;
-- KATZENJAMMER-1
-- Report the first name of the performer who never played accordion.

SELECT DISTINCT Firstname
FROM Band 
  JOIN Instruments i1 ON Bandmate > Id AND i1.Instrument = 'accordion'
  JOIN Instruments i2 ON i2.Bandmate > i1.Bandmate AND i2.Instrument <> 'accordion'
  JOIN Instruments i3 ON i3.Bandmate > i2.Bandmate AND i3.Instrument <> 'accordion';


USE `KATZENJAMMER`;
-- KATZENJAMMER-2
-- Report, in alphabetical order, the titles of all instrumental compositions performed by Katzenjammer ("instrumental composition" means no vocals).

SELECT Title FROM Songs
WHERE SongId NOT in (
    SELECT Song
    FROM Vocals
)
ORDER BY Title;


USE `KATZENJAMMER`;
-- KATZENJAMMER-3
-- Report the title(s) of the song(s) that involved the largest number of different instruments played (if multiple songs, report the titles in alphabetical order).
with numInstruments as
(SELECT Title, Count(*) as InstCount
FROM Songs as s join Instruments as i on s.SongId = i.Song
GROUP BY Title)
SELECT Title 
FROM numInstruments
where InstCount = (
    SELECT MAX(InstCount) FROM numInstruments
);


USE `KATZENJAMMER`;
-- KATZENJAMMER-4
-- Find the favorite instrument of each performer. Report the first name of the performer, the name of the instrument, and the number of songs on which the performer played that instrument. Sort in alphabetical order by the first name, then instrument.

with performerInstr as (
    select Firstname, Id, Instrument, Count(*) as TimesPlayed 
    FROM Band join Instruments on Id = Bandmate
    group by Id,Instrument
)
SELECT Firstname, Instrument,TimesPlayed from performerInstr p1
where TimesPlayed = (
    select MAX(TimesPlayed) from performerInstr p2
    where p1.Id = p2.id
)
order by Firstname, Instrument;


USE `KATZENJAMMER`;
-- KATZENJAMMER-5
-- Find all instruments played ONLY by Anne-Marit. Report instrument names in alphabetical order.
with otherPerformers as (
    select Distinct Instrument
    FROM Band join Instruments on Id = Bandmate
    WHERE Firstname != "Anne-Marit"
    group by Id, Instrument
)
SELECT DISTINCT Instrument 
FROM Instruments
WHERE Instrument NOT in
(
    SELECT Distinct Instrument
    FROM otherPerformers
);


USE `KATZENJAMMER`;
-- KATZENJAMMER-6
-- Report, in alphabetical order, the first name(s) of the performer(s) who played the largest number of different instruments.

with diffInstrs as (
    SELECT Firstname, Lastname, Count(Distinct i.Instrument) as instrPlayed
    FROM Band as b 
        join Instruments as i 
        on i.Bandmate = b.Id
    GROUP BY b.Id
)
SELECT Firstname
FROM diffInstrs
WHERE instrPlayed = (
    SELECT MAX(instrPlayed) FROM diffInstrs
)
ORDER BY Firstname;


USE `KATZENJAMMER`;
-- KATZENJAMMER-7
-- Which instrument(s) was/were played on the largest number of songs? Report just the names of the instruments, sorted alphabetically (note, you are counting number of songs on which an instrument was played, make sure to not count two different performers playing same instrument on the same song twice).
with diffInstrs as (
    SELECT i.Instrument, Count(Distinct Song) as instrPlayed
    FROM Band as b 
        join Instruments as i 
        on i.Bandmate = b.Id
        join Songs as s
        on s.SongId = i.Song
    GROUP BY i.Instrument
)
SELECT Instrument 
FROM diffInstrs
WHERE instrPlayed = (SELECT MAX(instrPlayed) FROM diffInstrs);


USE `KATZENJAMMER`;
-- KATZENJAMMER-8
-- Who spent the most time performing in the center of the stage (in terms of number of songs on which she was positioned there)? Return just the first name of the performer(s), sorted in alphabetical order.

with centerPos as (
    SELECT Firstname, Lastname, Count(p.StagePosition) as numCenter
    FROM Band as b 
        join Performance as p 
        on p.Bandmate = b.Id
    WHERE p.StagePosition = "center"
    GROUP BY b.Id
)
SELECT Firstname 
FROM centerPos
WHERE numCenter = (SELECT MAX(numCenter) FROM centerPos)
ORDER BY Firstname;


