-- Lab 2
-- chdye
-- Oct 9, 2022

USE `chdye`;
-- AIRLINES
-- Create and populate relational tables corresponding to the AIRLINES dataset (schema and data provided on Canvas)
DROP TABLE IF EXISTS flights;
DROP TABLE IF EXISTS airlines;
DROP TABLE IF EXISTS airports;


CREATE TABLE airlines(
    ID INTEGER,
    Airline VARCHAR(100), --
    Abbreviation VARCHAR(50),
    Country VARCHAR(10),
    PRIMARY KEY(ID),  -- unique as well --
    UNIQUE(Airline),
    UNIQUE(Abbreviation)
);

INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 1 , "United Airlines", "UAL", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 2 , "US Airways", "USAir", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 3 , "Delta Airlines", "Delta", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 4 , "Southwest Airlines", "Southwest", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 5 , "American Airlines", "American", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 6 , "Northwest Airlines", "Northwest", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 7 , "Continental Airlines", "Continental", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 8 , "JetBlue Airways", "JetBlue", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 9 , "Frontier Airlines", "Frontier", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 10 , "AirTran Airways", "AirTran", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 11 , "Allegiant Air", "Allegiant", "USA" );
INSERT INTO airlines(ID, Airline, Abbreviation, Country) values( 12 , "Virgin America", "Virgin", "USA" );

CREATE TABLE airports(
    City VARCHAR(50),
    AirportCode VARCHAR(3),
    AirportName VARCHAR(50),
    Country VARCHAR(50),
    CountryAbbrev VARCHAR(10),
    PRIMARY KEY(AirportCode)
);

INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Aberdeen", "APG", "Phillips AAF", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Aberdeen", "ABR", "Municipal", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Abilene", "DYS", "Dyess AFB", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Abilene", "ABI", "Municipal", "United States", "US " );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Abingdon", "VJI", "Virginia Highlands", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Ada", "ADT", "Ada", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Adak Island", "ADK", "Adak Island Ns", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Adrian", "ADG", "Lenawee County", "United States", "US " );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Afton", "AFO", "Municipal", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Aiken", "AIK", "Municipal", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Ainsworth", "ANW", "Ainsworth", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Akhiok", "AKK", "Akhiok SPB", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Akiachak", "KKI", "Spb", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Akiak", "AKI", "Akiak", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Akron CO", "AKO", "Colorado Plains Regional Airport", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Akron/Canton OH", "CAK", "Akron/canton Regional", "United States", "US" );
INSERT INTO airports(City, AirportCode, AirportName, Country, CountryAbbrev) values( "Akron/Canton", "AKC", "Fulton International", "United States", "US" );

CREATE TABLE flights(
    Airline INTEGER,
    FlightNo INTEGER,
    SourceAirport VARCHAR(3) NOT NULL,
    DestAirport VARCHAR(3) NOT NULL,
    FOREIGN KEY airline_id(Airline) 
    References airlines(ID),
    PRIMARY KEY (Airline, FlightNo),
    FOREIGN KEY (SourceAirport) References airports(AirportCode),
    FOREIGN KEY (DestAirport) References airports(AirportCode)
);

INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(1 ,  28, "APG", "ABR" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(1 ,  29, "AIK", "ADT" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(1 ,  44, "AKO", "AKI" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(1 ,  45, "CAK", "APG" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(1 ,  54, "AFO", "AKO" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(3 ,  2, "AIK", "ADT" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(3 ,  3, "DYS", "ABI" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(3 ,  26, "AKK", "VJI" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(9 ,  1260, "AKO", "AKC" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(9 ,  1261, "APG", "ABR" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(9 ,  1286, "ABR", "APG" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(9 ,  1287, "DYS", "ANW" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(10 ,  6, "KKI", "AKC" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(10 ,  7, "VJI", "APG" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(10 ,  54, "ADT", "APG" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(6 ,  4, "AIK", "AKO" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(6 ,  5, "CAK", "APG" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(6 ,  28, "AKO", "ABI" );
INSERT INTO flights(Airline, FlightNo, SourceAirport, DestAirport) values(6 ,  29, "ABR", "ABI" );

SELECT * FROM airlines;
SELECT * FROM airports;
SELECT * FROM flights;


USE `chdye`;
-- KATZENJAMMER
-- Create and populate the KATZENJAMMER database
DROP TABLE IF EXISTS Vocals;
DROP TABLE IF EXISTS Tracklists;
-- DROP TABLE IF EXISTS Songs;
DROP TABLE IF EXISTS Performance;
DROP TABLE IF EXISTS Instruments;
DROP TABLE IF EXISTS Band;
DROP TABLE IF EXISTS Albums;
DROP TABLE IF EXISTS Songs;

CREATE TABLE Songs(
    SongId INTEGER,
    Title VARCHAR(50),
    PRIMARY KEY(SongId)
    -- FOREIGN KEY(SongId) References Instruments(SongId) songs should be at the top and everything should reference songs --
);

INSERT INTO Songs(SongId, Title) values( 1, "Overture" );
INSERT INTO Songs(SongId, Title) values( 2, "A Bar In Amsterdam" );
INSERT INTO Songs(SongId, Title) values( 3, "Demon Kitty Rag" );
INSERT INTO Songs(SongId, Title) values( 4, "Tea With Cinnamon" );
INSERT INTO Songs(SongId, Title) values( 5, "Hey Ho on the Devil's Back" );
INSERT INTO Songs(SongId, Title) values( 6, "Wading in Deeper" );
INSERT INTO Songs(SongId, Title) values( 7, "Le Pop" );
INSERT INTO Songs(SongId, Title) values( 8, "Der Kapitan" );
INSERT INTO Songs(SongId, Title) values( 9, "Virginia Clemm" );
INSERT INTO Songs(SongId, Title) values( 10, "Play My Darling" );
INSERT INTO Songs(SongId, Title) values( 11, "To the Sea" );
INSERT INTO Songs(SongId, Title) values( 12, "Mother Superior" );
INSERT INTO Songs(SongId, Title) values( 13, "Aint no Thang" );
INSERT INTO Songs(SongId, Title) values( 14, "A Kiss Before You Go" );
INSERT INTO Songs(SongId, Title) values( 15, "I Will Dance (When I Walk Away)" );
INSERT INTO Songs(SongId, Title) values( 16, "Cherry Pie" );
INSERT INTO Songs(SongId, Title) values( 17, "Land of Confusion" );
INSERT INTO Songs(SongId, Title) values( 18, "Lady Marlene" );
INSERT INTO Songs(SongId, Title) values( 19, "Rock-Paper-Scissors" );
INSERT INTO Songs(SongId, Title) values( 20, "Cocktails and Ruby Slippers" );
INSERT INTO Songs(SongId, Title) values( 21, "Soviet Trumpeter" );
INSERT INTO Songs(SongId, Title) values( 22, "Loathsome M" );
INSERT INTO Songs(SongId, Title) values( 23, "Shepherds Song" );
INSERT INTO Songs(SongId, Title) values( 24, "Gypsy Flee" );
INSERT INTO Songs(SongId, Title) values( 25, "Gods Great Dust Storm" );
INSERT INTO Songs(SongId, Title) values( 26, "Ouch" );
INSERT INTO Songs(SongId, Title) values( 27, "Listening to the World" );
INSERT INTO Songs(SongId, Title) values( 28, "Johnny Blowtorch" );
INSERT INTO Songs(SongId, Title) values( 29, "Flash" );
INSERT INTO Songs(SongId, Title) values( 30, "Driving After You" );
INSERT INTO Songs(SongId, Title) values( 31, "My Own Tune" );
INSERT INTO Songs(SongId, Title) values( 32, "Badlands" );
INSERT INTO Songs(SongId, Title) values( 33, "Old De Spain" );
INSERT INTO Songs(SongId, Title) values( 34, "Oh My God" );
INSERT INTO Songs(SongId, Title) values( 35, "Lady Gray" );
INSERT INTO Songs(SongId, Title) values( 36, "Shine Like Neon Rays" );
INSERT INTO Songs(SongId, Title) values( 37, "Flash in the Dark" );
INSERT INTO Songs(SongId, Title) values( 38, "My Dear" );
INSERT INTO Songs(SongId, Title) values( 39, "Bad Girl" );
INSERT INTO Songs(SongId, Title) values( 40, "Rockland" );
INSERT INTO Songs(SongId, Title) values( 41, "Curvaceous Needs" );
INSERT INTO Songs(SongId, Title) values( 42, "Borka" );
INSERT INTO Songs(SongId, Title) values( 43, "Let it Snow" );


CREATE TABLE Albums(
    AId INTEGER,
    Title VARCHAR(100),
    Year INTEGER,
    Label VARCHAR(50),
    TypeRec VARCHAR(50),
    PRIMARY KEY(AId)
);

INSERT INTO Albums(AId, Title, Year, Label, TypeRec) values( 1, "Le Pop" , "2008" , "Propeller Recordings", "Studio" );
INSERT INTO Albums(AId, Title, Year, Label, TypeRec) values( 2, "A Kiss Before You Go" , "2011" , "Propeller Recordings", "Studio" );
INSERT INTO Albums(AId, Title, Year, Label, TypeRec) values( 3, "A Kiss Before You Go: Live in Hamburg" , "2012" , "Universal Music Group", "Live" );
INSERT INTO Albums(AId, Title, Year, Label, TypeRec) values( 4, "Rockland" , "2015" , "Propeller Recordings", "Studio" );

-- holds the unique band members --
CREATE TABLE Band(
    Id Integer,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    PRIMARY KEY(Id)
);

INSERT INTO Band(Id, FirstName, LastName) values( Id, "Firstname" , "Lastname" );
INSERT INTO Band(Id, FirstName, LastName) values( 1, "Solveig" , "Heilo" );
INSERT INTO Band(Id, FirstName, LastName) values( 2, "Marianne" , "Sveen" );
INSERT INTO Band(Id, FirstName, LastName) values( 3, "Anne-Marit" , "Bergheim" );
INSERT INTO Band(Id, FirstName, LastName) values( 4, "Turid" , "Jorgensen" );

CREATE TABLE Instruments(
    SongId INTEGER,
    BandmateId INTEGER,
    Instrument VARCHAR(50),
    PRIMARY KEY(SongId, Instrument), -- each bandmate can be in multiple songs, and there will be multiple of the same SongId listed to list all band members, and each bandmate can pay multiple instruments
    FOREIGN KEY (BandmateId) References Band(Id),
    FOREIGN KEY (SongId) References Songs(SongId)
);

INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 1, 1 , "trumpet" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 1, 2 , "keyboard" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 1, 3 , "accordion" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 1, 4 , "bass balalaika" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 2, 1 , "trumpet" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 2, 2 , "drums" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 2, 3 , "guitar" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 2, 4 , "bass balalaika" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 3, 1 , "drums" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 3, 1 , "ukalele" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 3, 2 , "banjo" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 3, 3 , "bass balalaika" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 3, 4 , "keyboards" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 4, 1 , "drums" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 4, 2 , "ukalele" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 4, 3 , "accordion" );
INSERT INTO Instruments(SongId, BandmateId, Instrument) values( 4, 4 , "bass balalaika" );

CREATE TABLE Performance(
    SongId INTEGER,
    Bandmate INTEGER,
    StagePosition VARCHAR(10),
    FOREIGN KEY (SongId) References Songs(SongId),
    FOREIGN KEY (Bandmate) References Band(Id),
    PRIMARY KEY(SongId, Bandmate) -- you can't have the same bandmate in the same song twice --
);

INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 1, 1 , "back" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 1, 2 , "left" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 1, 3 , "center" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 1, 4 , "right" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 2, 1 , "center" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 2, 2 , "back" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 2, 3 , "left" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 2, 4 , "right" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 3, 1 , "back" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 3, 2 , "right" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 3, 3 , "center" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 3, 4 , "left" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 4, 1 , "back" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 4, 2 , "center" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 4, 3 , "left" );
INSERT INTO Performance(SongId, Bandmate, StagePosition) values( 4, 4 , "right" );


CREATE TABLE Tracklists(
    AlbumId INTEGER,
    Position INTEGER,
    SongId INTEGER,
    PRIMARY KEY(AlbumId, SongId),
    FOREIGN KEY(SongId) References Songs(SongId),
    FOREIGN KEY(AlbumId) References Albums(AId)


);

CREATE TABLE Vocals(
    SongId INTEGER,
    Bandmate INTEGER,
    TypeVocal VARCHAR(10),
    PRIMARY KEY(SongId, Bandmate),
    FOREIGN KEY(SongId) References Songs(SongId),
    FOREIGN KEY(Bandmate) References Band(Id)
    
);
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 2, 1 , "lead" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 2, 3 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 2, 4 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 3, 2 , "lead" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 1 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 2 , "lead" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 3 , "chorus" );
INSERT INTO Vocals(SongId, Bandmate, TypeVocal) values( 4, 4 , "chorus" );


USE `chdye`;
-- BAKERY
-- Create and populate the BAKERY database
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS receipts;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS goods;


CREATE TABLE customers(
    CId INTEGER,
    LastName VARCHAR(100) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    PRIMARY KEY(CId)
);

INSERT INTO customers(CId, Lastname, Firstname) values( 1, "LOGAN", "JULIET" );
INSERT INTO customers(CId, Lastname, Firstname) values( 2, "ARZT", "TERRELL" );
INSERT INTO customers(CId, Lastname, Firstname) values( 3, "ESPOSITA", "TRAVIS" );
INSERT INTO customers(CId, Lastname, Firstname) values( 4, "ENGLEY", "SIXTA" );
INSERT INTO customers(CId, Lastname, Firstname) values( 5, "DUNLOW", "OSVALDO" );
INSERT INTO customers(CId, Lastname, Firstname) values( 6, "SLINGLAND", "JOSETTE" );
INSERT INTO customers(CId, Lastname, Firstname) values( 7, "TOUSSAND", "SHARRON" );
INSERT INTO customers(CId, Lastname, Firstname) values( 8, "HELING", "RUPERT" );
INSERT INTO customers(CId, Lastname, Firstname) values( 9, "HAFFERKAMP", "CUC" );
INSERT INTO customers(CId, Lastname, Firstname) values( 10, "DUKELOW", "CORETTA" );
INSERT INTO customers(CId, Lastname, Firstname) values( 11, "STADICK", "MIGDALIA" );
INSERT INTO customers(CId, Lastname, Firstname) values( 12, "MCMAHAN", "MELLIE" );
INSERT INTO customers(CId, Lastname, Firstname) values( 13, "ARNN", "KIP" );
INSERT INTO customers(CId, Lastname, Firstname) values( 14, "S'OPKO", "RAYFORD" );
INSERT INTO customers(CId, Lastname, Firstname) values( 15, "CALLENDAR", "DAVID" );
INSERT INTO customers(CId, Lastname, Firstname) values( 16, "CRUZEN", "ARIANE" );
INSERT INTO customers(CId, Lastname, Firstname) values( 17, "MESDAQ", "CHARLENE" );
INSERT INTO customers(CId, Lastname, Firstname) values( 18, "DOMKOWSKI", "ALMETA" );
INSERT INTO customers(CId, Lastname, Firstname) values( 19, "STENZ", "NATACHA" );
INSERT INTO customers(CId, Lastname, Firstname) values( 20, "ZEME", "STEPHEN" );

CREATE TABLE goods(
    GId VARCHAR(100) NOT NULL,
    Flavor VARCHAR(50),
    Food VARCHAR(50),
    Price DOUBLE NOT NULL,
    PRIMARY KEY(GId),
    UNIQUE(FOOD, FLAVOR)
);

INSERT INTO goods(GId, Flavor, Food, Price) values("20-BC-C-10", "Chocolate", "Cake", 8.95 );
INSERT INTO goods(GId, Flavor, Food, Price) values("20-BC-L-10", "Lemon", "Cake", 8.95 );
INSERT INTO goods(GId, Flavor, Food, Price) values("20-CA-7.5", "Casino", "Cake", 15.95 );
INSERT INTO goods(GId, Flavor, Food, Price) values("24-8x10", "Opera", "Cake", 15.95 );
INSERT INTO goods(GId, Flavor, Food, Price) values("25-STR-9", "Strawberry", "Cake", 11.95 );
INSERT INTO goods(GId, Flavor, Food, Price) values("26-8x10", "Truffle", "Cake", 15.95 );
INSERT INTO goods(GId, Flavor, Food, Price) values("45-CH", "Chocolate", "Eclair", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("45-CO", "Coffee", "Eclair", 3.5 );
INSERT INTO goods(GId, Flavor, Food, Price) values("45-VA", "Vanilla", "Eclair", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("46-11", "Napoleon", "Cake", 13.49 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-ALM-I", "Almond", "Tart", 3.75 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-APIE-10", "Apple", "Pie", 5.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-APP-11", "Apple", "Tart", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-APR-PF", "Apricot", "Tart", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-BER-11", "Berry", "Tart", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-BLK-PF", "Blackberry", "Tart", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-BLU-11", "Blueberry", "Tart", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-CH-PF", "Chocolate", "Tart", 3.75 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-CHR-11", "Cherry", "Tart", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-LEM-11", "Lemon", "Tart", 3.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("90-PEC-11", "Pecan", "Tart", 3.75 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-GA", "Ganache", "Cookie", 1.15 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-GON", "Gongolais", "Cookie", 1.15 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-R", "Raspberry", "Cookie", 1.09 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-LEM", "Lemon", "Cookie", 0.79 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-M-CH-DZ", "Chocolate", "Meringue", 1.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-M-VA-SM-DZ", "Vanilla", "Meringue", 1.15 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-MAR", "Marzipan", "Cookie", 1.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-TU", "Tuile", "Cookie", 1.25 );
INSERT INTO goods(GId, Flavor, Food, Price) values("70-W", "Walnut", "Cookie", 0.79 );
INSERT INTO goods(GId, Flavor, Food, Price) values("50-ALM", "Almond", "Croissant", 1.45 );
INSERT INTO goods(GId, Flavor, Food, Price) values("50-APP", "Apple", "Croissant", 1.45 );
INSERT INTO goods(GId, Flavor, Food, Price) values("50-APR", "Apricot", "Croissant", 1.45 );
INSERT INTO goods(GId, Flavor, Food, Price) values("50-CHS", "Cheese", "Croissant", 1.75 );
INSERT INTO goods(GId, Flavor, Food, Price) values("50-CH", "Chocolate", "Croissant", 1.75 );
INSERT INTO goods(GId, Flavor, Food, Price) values("51-APR", "Apricot", "Danish", 1.15 );
INSERT INTO goods(GId, Flavor, Food, Price) values("51-APP", "Apple", "Danish", 1.15 );
INSERT INTO goods(GId, Flavor, Food, Price) values("51-ATW", "Almond", "Twist", 1.15 );
INSERT INTO goods(GId, Flavor, Food, Price) values("51-BC", "Almond", "Bear Claw", 1.95 );
INSERT INTO goods(GId, Flavor, Food, Price) values("51-BLU", "Blueberry", "Danish", 1.15 );


CREATE TABLE receipts(
    RNumber INTEGER,
    SaleDate DATE,
    Customer INTEGER,
    FOREIGN KEY (Customer) References customers(CId),
    PRIMARY KEY (RNumber)
    -- FOREIGN KEY (RNumber) References items(Receipt) --
);

-- TO_DATE('17/12/2015', 'DD/MM/YYYY') --
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 18129, DATE '2007-10-28', 15 ); 
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 51991, DATE '2007-10-17', 14 );
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 83085, DATE '2007-10-12', 7 );
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 70723, DATE '2007-10-28', 20 ); 
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 13355, DATE '2007-10-12', 7 );
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 52761, DATE '2007-10-27', 8 );
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 99002, DATE '2007-10-13', 20 );
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 58770, DATE '2007-10-22', 18 );
INSERT INTO receipts(RNumber, SaleDate, Customer) values( 84665, DATE '2007-10-10', 6 );

-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 51991, "17-Oct-2007", 14 );
-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 83085, "12-Oct-2007", 7 );
-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 70723, "28-Oct-2007", 20 );
-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 13355, "12-Oct-2007", 7 );
-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 52761, "27-Oct-2007", 8 );
-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 99002, "13-Oct-2007", 20 );
-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 58770, "22-Oct-2007", 18 );
-- INSERT INTO receipts(RNumber, SaleDate, Customer) values( 84665, "10-Oct-2007", 6 );


CREATE TABLE items(
    Receipt INTEGER,
    Ordinal INTEGER,
    Item VARCHAR(50) NOT NULL,
    FOREIGN KEY (Item) References goods(GId),
    PRIMARY KEY(RECEIPT, ORDINAL), -- there can be duplicate receipt numbers because there are many items on a receipt, but we can't have two different items at the same position on the receipt so this is unique -- 
    FOREIGN KEY (Receipt) References receipts(RNumber)
);

INSERT INTO items(Receipt, Ordinal, Item) values( 18129, 1, "70-TU" );
INSERT INTO items(Receipt, Ordinal, Item) values( 51991, 1, "90-APIE-10" );
INSERT INTO items(Receipt, Ordinal, Item) values( 51991, 2, "90-CH-PF" );
INSERT INTO items(Receipt, Ordinal, Item) values( 51991, 3, "90-APP-11" );
INSERT INTO items(Receipt, Ordinal, Item) values( 51991, 4, "26-8x10" );
INSERT INTO items(Receipt, Ordinal, Item) values( 83085, 1, "25-STR-9" );
INSERT INTO items(Receipt, Ordinal, Item) values( 83085, 2, "24-8x10" );
INSERT INTO items(Receipt, Ordinal, Item) values( 83085, 3, "90-APR-PF" );
INSERT INTO items(Receipt, Ordinal, Item) values( 83085, 4, "51-ATW" );
INSERT INTO items(Receipt, Ordinal, Item) values( 83085, 5, "26-8x10" );
INSERT INTO items(Receipt, Ordinal, Item) values( 70723, 1, "45-CO" );
INSERT INTO items(Receipt, Ordinal, Item) values( 13355, 1, "24-8x10" );
INSERT INTO items(Receipt, Ordinal, Item) values( 13355, 2, "70-LEM" );
INSERT INTO items(Receipt, Ordinal, Item) values( 13355, 3, "46-11" );
INSERT INTO items(Receipt, Ordinal, Item) values( 52761, 1, "90-ALM-I" );
INSERT INTO items(Receipt, Ordinal, Item) values( 52761, 2, "26-8x10" );
INSERT INTO items(Receipt, Ordinal, Item) values( 52761, 3, "50-CHS" );
INSERT INTO items(Receipt, Ordinal, Item) values( 52761, 4, "90-BLK-PF" );
INSERT INTO items(Receipt, Ordinal, Item) values( 52761, 5, "90-ALM-I" );
INSERT INTO items(Receipt, Ordinal, Item) values( 99002, 1, "50-CHS" );
INSERT INTO items(Receipt, Ordinal, Item) values( 99002, 2, "45-VA" );
INSERT INTO items(Receipt, Ordinal, Item) values( 58770, 1, "50-CHS" );
INSERT INTO items(Receipt, Ordinal, Item) values( 58770, 2, "46-11" );
INSERT INTO items(Receipt, Ordinal, Item) values( 58770, 3, "45-CH" );
INSERT INTO items(Receipt, Ordinal, Item) values( 58770, 4, "20-CA-7.5" );
INSERT INTO items(Receipt, Ordinal, Item) values( 84665, 1, "90-BER-11" );




SELECT * FROM receipts;


USE `chdye`;
-- CUSTOM
-- Create and populate your custom database
-- sp500_companies.csv --
DROP TABLE IF EXISTS financials;
DROP TABLE IF EXISTS company;
DROP TABLE IF EXISTS locations;



-- Locations holds our possible valid locations for companies, and our primary key is City and State incase two States have duplicate city names or a symbol is in multiple locations --
CREATE TABLE locations(
    City VARCHAR(100) NOT NULL,
    State VARCHAR(10) NOT NULL,
    Symbol VARCHAR(10) NOT NULL,
    PRIMARY KEY(City, State),
    UNIQUE(State)
);


CREATE TABLE company(
    Exchange VARCHAR(3) NOT NULL,
    Symbol VARCHAR(10) NOT NULL,
    Shortname VARCHAR(100),
    Longname VARCHAR(100),
    Sector VARCHAR(100),
    Industry VARCHAR(100),
    Currentprice DOUBLE,
    Marketcap INTEGER,
    Ebitda INTEGER,
    Revenue DOUBLE,
    City VARCHAR(100),
    State VARCHAR(10),
    NumEmployees INTEGER,
    PRIMARY KEY(Symbol), -- Stock Ticker is always unique --
    FOREIGN KEY(State) References locations(State),
    FOREIGN KEY(City) References locations(City),
    UNIQUE(City, State)
);

-- We can create a financials tables to access the aggregate financial information for the s&p500 or individual companies--
CREATE TABLE financials(
    Exchange VARCHAR(3) NOT NULL,
    Symbol VARCHAR(10) NOT NULL,
    Sector VARCHAR(100),
    Industry VARCHAR(100),
    City VARCHAR(100),
    State VARCHAR(10),
    Currentprice DOUBLE,
    Marketcap INTEGER,
    Ebitda INTEGER,
    Revenue DOUBLE,
    PRIMARY KEY(Symbol),
    FOREIGN KEY(Symbol) References company(Symbol),
    UNIQUE(City, State)
);


