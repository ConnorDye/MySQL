-- Lab 3
-- chdye
-- Oct 17, 2022

USE `chdye`;
-- BAKERY-1
-- Using a single SQL statement, reduce the prices of Lemon Cake and Napoleon Cake by $2.
-- Here we use WHERE to make a selection when the food is cake or the flavor is lemon and adjst the price accordingly
-- We apply the same logic for the second statement.
UPDATE goods SET Price = 6.95 WHERE Food = 'Cake' and Flavor = 'Lemon';
UPDATE goods SET Price = 11.49 WHERE Food = 'Cake' and Flavor = 'Napoleon';


-- SELECT * FROM receipts;


USE `chdye`;
-- BAKERY-2
-- Using a single SQL statement, increase by 15% the price of all Apricot or Chocolate flavored items with a current price below $5.95.
-- HERE WE USE A SELECTION ON FLAVOR = 'APRICOT' OR when the flavor is chocalate and the price is above our threshold to update the price accordingly in the table
UPDATE goods SET Price = (Price * 1.15) WHERE (Flavor = 'Apricot' or Flavor = 'Chocolate') and (Price < 5.95);


USE `chdye`;
-- BAKERY-3
-- Add the capability for the database to record payment information for each receipt in a new table named payments (see assignment PDF for task details)
-- This statement was added since lab2 is synced with lab3, we must drop this before we can drop the other tables
DROP TABLE IF EXISTS payments;


-- Here we create our new payments table
-- Our primary key has all 3 attributes below because we could make multiple payments on a receipt, they could be settled at the same time or the amount could be the same so we use all 3 so that they're unique
-- We add our foreign key Receipt so that it references a valid receipt number
CREATE TABLE payments(
    Receipt INTEGER,
    Amount DECIMAL(19, 2),
    PaymentSettled DATETIME,
    PaymentType VARCHAR(50),
    PRIMARY KEY(Receipt, PaymentSettled, Amount),
    FOREIGN KEY(Receipt) References receipts(RNumber)
);


USE `chdye`;
-- BAKERY-4
-- Create a database trigger to prevent the sale of Meringues (any flavor) and all Almond-flavored items on Saturdays and Sundays.
CREATE TRIGGER prevent_sale BEFORE INSERT on items 
for each row
    begin
        -- Since items does not countain the seperate attributes about the flavor, food, and saletime we need to select these
        -- from goods so we have access in our trigger
        DECLARE flav VARCHAR(100);
        DECLARE foodtype VARCHAR(100);
        DECLARE saletime DATE;
        SELECT Flavor INTO flav FROM goods WHERE NEW.item = goods.GId;
        SELECT Food INTO foodtype FROM goods WHERE NEW.item = goods.GId;
        SELECT SaleDate INTO saletime FROM receipts WHERE NEW.Receipt = receipts.RNumber;
       
        -- here our dayname() function will give us the day of our sale so we check if it is saturday or sunday and whether the flavor and food is the value of our constraint
        if ( ( DAYNAME(saletime)= 'Saturday' or DAYNAME(saletime) = 'Sunday') and (flav = "Almond" or foodtype = "Meringue") ) then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Prevent the sale of Meringues and Almond flavored items';
        end if;
    end;


USE `chdye`;
-- AIRLINES-1
-- Enforce the constraint that flights should never have the same airport as both source and destination (see assignment PDF)
-- To make sure that flights never have the same airport as both source and destination, we can use a trigger to check
-- if these attributes are equal and prevent the input if so.
CREATE TRIGGER prevent_insert BEFORE INSERT on flights 
for each row
    begin
        if (NEW.SourceAirport  = NEW.DestAirport) then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Prevent the insert of an invalid flight';
        end if;
    end;


USE `chdye`;
-- AIRLINES-2
-- Add a "Partner" column to the airlines table to indicate optional corporate partnerships between airline companies (see assignment PDF)
-- We create a trigger before we insert to make sure the partners aren't the same as the abbreviation
-- Here we can alter the table to add a column partner and introduce our constraint on existing data that airlines.Partner != airlines.Abbreviation
ALTER TABLE airlines 
ADD COLUMN Partner VARCHAR(50),
ADD CONSTRAINT no_self_partners CHECK(airlines.Partner != airlines.Abbreviation);

-- Here we make Partner unique because there can't be dual partners
ALTER TABLE airlines ADD UNIQUE(Partner);

-- Here we add a foreign key to make sure our partners are a valid airline
ALTER TABLE airlines ADD FOREIGN KEY valid_airlines(Partner) References airlines(Abbreviation);

-- Here we update our partners
UPDATE airlines SET Partner = "JetBlue" WHERE Abbreviation="Southwest";
UPDATE airlines SET Partner = "Southwest" WHERE Abbreviation="JetBlue";

-- We create a trigger before we insert to make sure the partners aren't the same as the abbreviation
CREATE TRIGGER prevent_insert BEFORE INSERT on airlines 
for each row
    begin
        if (NEW.Partner  = NEW.Abbreviation) then
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Prevent the insert of an invalid flight';
        end if;
    end;


USE `chdye`;
-- KATZENJAMMER-1
-- Change the name of two instruments: 'bass balalaika' should become 'awesome bass balalaika', and 'guitar' should become 'acoustic guitar'. This will require several steps. You may need to change the length of the instrument name field to avoid data truncation. Make this change using a schema modification command, rather than a full DROP/CREATE of the table.
-- We first alter our table to expand the instrument field, and then we have two update statements to modify the name of our two instruments "bass balalaika" and "guitar"

ALTER TABLE Instruments CHANGE COLUMN Instrument Instrument VARCHAR(100);

UPDATE Instruments SET Instrument="awesome bass balalaika" WHERE Instrument="bass balalaika";

UPDATE Instruments SET Instrument="acoustic guitar" WHERE Instrument="guitar";


USE `chdye`;
-- KATZENJAMMER-2
-- Keep in the Vocals table only those rows where Solveig (id 1 -- you may use this numeric value directly) sang, but did not sing lead.
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 2, 1 , "lead" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 2, 3 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 2, 4 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 3, 2 , "lead" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 1 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 2 , "lead" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 3 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 4 , "chorus" );

-- We first delete Vocals when id 1 is lead and any where the id isn't 1
DELETE FROM Vocals WHERE Bandmate = 1 and TypeVocal = "lead";
DELETE FROM Vocals WHERE Bandmate != 1;

-- We have to modify the name of the TypeVocal column to pass the test. Note since Type is a reserved keyword we have to use backticks
ALTER TABLE Vocals CHANGE COLUMN TypeVocal `Type` VARCHAR(100);
-- DELETE FROM Vocals;
-- SELECT * FROM Vocals;
select SongId, Bandmate, `Type` from Vocals;


