drop database RichardLarsson;
create database RichardLarsson;
use RichardLarsson;

create table Player(
Pnr char(12) NOT NULL,
PlayerName varchar(25) NOT NULL,
PlayerAge int NOT NULL,
primary key (Pnr)
)engine=innodb;

create table Jacket(
Size varchar(5),
Material varchar(20),
Pnr char(12),
Embroderies varchar(24),
primary key(Pnr, Embroderies),
foreign key(Pnr) references Player(Pnr) ON DELETE cascade
)engine=Innodb;

create table ClubConstruction(
SerialNumber char(10),
Hardness char(3),
primary key(SerialNumber)
)engine=Innodb;

create table Club(
ClubNumber char(2),
ClubMaterial varchar(20),
SerialNumber char(10),
Pnr char(12),
primary key(Pnr, ClubNumber),
foreign key(SerialNumber) references ClubConstruction(SerialNumber) ON DELETE CASCADE,
foreign key(Pnr) references Player(Pnr) ON DELETE CASCADE
)engine=Innodb;

create table Competition(
CompetitionName varchar(35),
CompetitionDate date,
primary key(CompetitionName)
)engine=Innodb;

create table Participants(
Pnr char(12),
CompetitionName varchar(35),
primary key(CompetitionName, Pnr),
foreign key(CompetitionName) references Competition(CompetitionName) ON DELETE CASCADE,
foreign key(Pnr) references Player(Pnr) ON DELETE cascade
)engine=Innodb;

create table Weather(
Windspeed char(2),
WeatherChart varchar(15),
primary key(WeatherChart)
)engine=Innodb;

#Changed to weatherchart to make a more realistic unique key
create table CompetitionWeather(
TimeOfDay TIME NOT NULL,
WeatherChart varchar(15),
CompetitionName varchar(35),
primary key(TimeOfDay),
foreign key(CompetitionName) references Competition(CompetitionName) ON DELETE CASCADE,
foreign key(WeatherChart) references Weather(WeatherChart) ON DELETE cascade
)engine=Innodb;


#Added data

INSERT INTO Player (Pnr, PlayerName, PlayerAge) VALUES ("199702104546","Johan Andersson",25);
INSERT INTO Player (Pnr, PlayerName, PlayerAge) VALUES ("194201222451","Rune 'Proffs-Rune' Landén",80);
INSERT INTO Player (Pnr, PlayerName, PlayerAge) VALUES ("200604083281","Annika Persson",15);
INSERT INTO Player (Pnr, PlayerName, PlayerAge) VALUES ("201504125656","Nicklas Jansson",7);

#Added Embroderies of won competitions as a weak key
INSERT INTO Jacket (Size, Material, Pnr, Embroderies) VALUES ("XL", "fleece", "199702104546", "Winner of Skövde Cup");
INSERT INTO Jacket (Size, Material, Pnr, Embroderies) VALUES ("XL", "goretex", "199702104546", "Best Achiever");
INSERT INTO Jacket (Size, Material, Pnr, Embroderies) VALUES ("S", "goretex", "201504125656", "Best Blind Golfer 2021");
INSERT INTO Jacket (Size, Material, Pnr, Embroderies) VALUES ("XXL", "silk", "194201222451", "Winner of Skövde Cup");
INSERT INTO Jacket (Size, Material, Pnr, Embroderies) VALUES ("M", "polyester", "200604083281", "Best Achiever");

INSERT INTO ClubConstruction (SerialNumber, Hardness) VALUES (1235646313, 10);
INSERT INTO ClubConstruction (SerialNumber, Hardness) VALUES (4231132342, 5);
INSERT INTO ClubConstruction (SerialNumber, Hardness) VALUES (3453453456, 1);

INSERT INTO Club (ClubNumber, ClubMaterial, SerialNumber, Pnr) VALUES (4, "Wood", 1235646313,"201504125656");
INSERT INTO Club (ClubNumber, ClubMaterial, SerialNumber, Pnr) VALUES (1, "Wood", 4231132342,"200604083281");
INSERT INTO Club (ClubNumber, ClubMaterial, SerialNumber, Pnr) VALUES (1, "Plastic", 3453453456,"199702104546");

INSERT INTO Competition (CompetitionName, CompetitionDate) VALUES ("Big Golf Cup Skövde","2021-10-06");
INSERT INTO Competition (CompetitionName, CompetitionDate) VALUES ("Lätt & Lagom Cup","2022-11-16");
INSERT INTO Competition (CompetitionName, CompetitionDate) VALUES ("Prova-På-Golf för blinda","2020-08-12");

INSERT INTO Participants (Pnr, CompetitionName) VALUES ("199702104546", "Big Golf Cup Skövde");
INSERT INTO Participants (Pnr, CompetitionName) VALUES ("201504125656", "Big Golf Cup Skövde");
INSERT INTO Participants (Pnr, CompetitionName) VALUES ("200604083281", "Big Golf Cup Skövde");
INSERT INTO Participants (Pnr, CompetitionName) VALUES ("201504125656", "Prova-På-Golf för blinda");
INSERT INTO Participants (Pnr, CompetitionName) VALUES ("200604083281", "Prova-På-Golf för blinda");

INSERT INTO Weather (WindSpeed, WeatherChart) VALUES(10, "SMHI34346");
INSERT INTO Weather (WindSpeed, WeatherChart) VALUES(2, "SMHI54873");
INSERT INTO Weather (WindSpeed, WeatherChart) VALUES(32, "SMHI15496");

INSERT INTO CompetitionWeather (TimeOfDay, WeatherChart, CompetitionName) VALUES("12:00:00", "SMHI34346", "Big Golf Cup Skövde");
INSERT INTO CompetitionWeather (TimeOfDay, WeatherChart, CompetitionName) VALUES("12:15:00", "SMHI15496", "Prova-På-Golf för blinda");
INSERT INTO CompetitionWeather (TimeOfDay, WeatherChart, CompetitionName) VALUES("04:30:00", "SMHI54873", "Lätt & Lagom Cup");


#Operation 1
SELECT PlayerAge FROM Player WHERE PlayerName = "Johan Andersson";

#Operation 2
SELECT CompetitionDate FROM Competition WHERE CompetitionName = "Big Golf Cup Skövde";

#Operation 3
SELECT ClubMaterial FROM Club WHERE Pnr = "199702104546";

#Operation 4
SELECT * FROM Jacket WHERE Pnr = "199702104546";

#Operation 5
SELECT * FROM Participants WHERE CompetitionName = "Big Golf Cup Skövde";

#Operation 6
SELECT Weather.WindSpeed FROM Weather INNER JOIN CompetitionWeather ON Weather.WeatherChart = CompetitionWeather.WeatherChart WHERE CompetitionName = "Big Golf Cup Skövde";

#Operation 7
SELECT * FROM Player WHERE PlayerAge < 30;

#Operation 8
DELETE FROM Jacket WHERE Pnr = "199702104546";

#Operation 9
DELETE FROM Player WHERE Pnr = "201504125656";

#Operation 10
SELECT AVG(PlayerAge) FROM Player;