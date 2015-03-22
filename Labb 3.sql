if DB_ID('Libary') is null
	create database Libary;		
go
use Libary;
go
if not exists(select * from sys.objects where object_id = OBJECT_ID(N'dbo.Authors') and type in (N'U'))
	create table Authors
	(
		ID int not null identity(1,1),
		FirstName varchar(50) not null,
		LastName varchar (50) not null,
		BirthDate datetime null,
		Deceased datetime null,
		Nationality varchar(50) null,
		[Language] varchar(50) null,
			constraint PK_Authors_ID primary key(ID)
	);	
go
if not exists(select * from sys.objects where object_id = OBJECT_ID(N'dbo.Litterature') and type in (N'U'))
	create table Litterature
	(
		ID int not null identity(1,1),
		AuthorID int not null,
		ISBN varchar(30) not null,
		Title varchar(50) not null,
		Genre varchar(50) null,
		[Language] varchar(50) null,
			constraint PK_Littrature_ID primary key(ID),
			constraint FK_Littrature_Authors_ID foreign key(AuthorID) references Authors(ID) 
	);
go
if not exists(select * from sys.objects where object_id = OBJECT_ID(N'dbo.LitteratureCopyStatus') and type in (N'U'))
	create table LitteratureCopyStatus
	(
		ID int not null identity(1,1),
		Name varchar(50) not null,
			constraint PK_LitteratureCopyStatus_ID primary key(ID)
	);
go	
if not exists(select * from sys.objects where object_id = OBJECT_ID(N'dbo.LitteratureCopy') and type in (N'U'))
	create table LitteratureCopy
	(
		ID int not null identity(1,1),
		StatusID int not null
			constraint DF_LitteratureCopy_StatusID default 1,
		LitteratureID int not null,
		PurchasePrice smallmoney null,
		PurchaseYear datetime null,
			constraint PK_LittratureCopy_ID primary key(ID),
			constraint FK_LittratureCopy_LitteratureCopyStatus_ID foreign key(StatusID) references LitteratureCopyStatus(ID),
			constraint FK_LittratureCopy_Litterature_ID foreign key(LitteratureID) references Litterature(ID),			
	);
go
if not exists(select * from sys.objects where object_id = OBJECT_ID(N'dbo.Customers') and type in (N'U'))
	create table Customers
	(
		ID int not null identity(1,1),
		FirstName varchar(50) not null,
		LastName varchar(50) not null,
		[Address] varchar(50) not null,
		PhoneNumber varchar(50) null,
		EmailAddress varchar(100) not null
			constraint AK_Customers_EmailAddress unique,
		Gender varchar(15) null,
		BirthDate datetime null,
		EntitledForLoan bit not null
			constraint DF_Customers_EntitledForLoan default 1,
			constraint PK_Customers_ID primary key(ID),
	);
go
if not exists(select * from sys.objects where object_id = OBJECT_ID(N'dbo.LitteratureLoan') and type in (N'U'))
	create table LitteratureLoan
	(
		ID int not null identity(1,1),
		CustomerID int not null,
		LitteratureCopyID int not null,
		BorrowDate datetime not null
			constraint DF_BorrowDate_CurrentDate default getdate(),
		Returndate datetime not null
			constraint DF_ReturnDate_ReturnDate default dateadd(day,14,getdate()),
			constraint PK_LitteratureLoan_ID primary key(ID),
			constraint FK_LitteratureLoan_Custumors_ID foreign key(CustomerID) references Customers(ID),
			constraint FK_LitteratureLoan_LitteratureCopy_ID foreign key(LitteratureCopyID) references LitteratureCopy(ID),
	);
	go
	if not exists(select ID from dbo.Authors) and @@ROWCOUNT = 0
	begin
	insert into Authors([FirstName],[LastName],[BirthDate],[Nationality]) values('Zachery','Foster','Sep 28, 1954','Nigeria'),('Oleg','Mays','Aug 29, 1924','Estonia'),('Lesley','Pena','Jan 10, 1943','Italy'),('Alfreda','Barton','Jul 13, 1939','Haiti'),('Garth','Montoya','Jul 8, 1954','Italy'),('Lane','Glenn','Sep 28, 1936','Greenland'),('Vance','Walton','May 5, 1969','Albania'),('Zephr','Stephens','Oct 11, 1970','Hungary'),('Hillary','Soto','May 3, 1944','Bhutan'),('Signe','Moore','Jan 20, 1921','Guyana');
	insert into Authors([FirstName],[LastName],[BirthDate],[Nationality]) values('Nayda','Miller','Jan 29, 1970','Faroe Islands'),('Paki','Webb','Jun 15, 1979','Palau'),('Violet','Reese','Mar 9, 1940','Palestine, State of'),('Signe','Tanner','Feb 7, 1956','Saint Helena, Ascension and Tristan da Cunha'),('Barclay','Mcdonald','Nov 10, 1970','Portugal'),('Scott','Shaw','Oct 4, 1922','Fiji'),('Deirdre','Crosby','Jul 14, 1965','Equatorial Guinea'),('Berk','Sandoval','Apr 14, 1971','Saint Pierre and Miquelon'),('Harlan','Baxter','Mar 28, 1924','Uruguay'),('Ulric','Rowe','Dec 12, 1941','Christmas Island');
	insert into Authors([FirstName],[LastName],[BirthDate],[Nationality]) values('Justin','Vang','Jan 27, 1968','Timor-Leste'),('Brynne','Head','Sep 8, 1972','Canada'),('Jonas','Russell','May 5, 1951','Zambia'),('Rylee','Hughes','Jun 1, 1954','Guinea-Bissau'),('Orla','Mcclure','May 13, 1945','Saint Pierre and Miquelon'),('Sonya','Langley','Jan 8, 1973','Benin'),('Cara','Chaney','May 20, 1943','Honduras'),('Deborah','Suarez','Jun 22, 1968','Tuvalu'),('Yen','Ford','Nov 16, 1937','Myanmar'),('Ashton','Rivers','Sep 11, 1969','Sao Tome and Principe');
	insert into Authors([FirstName],[LastName],[BirthDate],[Nationality]) values('Kai','Parker','Feb 6, 1944','Colombia'),('Tate','Steele','May 2, 1947','Curaçao'),('Omar','Mejia','Oct 2, 1956','Libya'),('Moana','Richardson','May 31, 1922','Anguilla'),('Shelly','Wood','Jun 7, 1936','Northern Mariana Islands'),('Todd','Curtis','Jun 30, 1956','Syria'),('Neville','Macdonald','Feb 28, 1960','Belarus'),('Justin','Welch','Oct 18, 1969','Guinea'),('Iris','Parker','Jan 4, 1968','Czech Republic'),('Veda','Larsen','Jun 26, 1947','Niger');
	insert into Authors([FirstName],[LastName],[BirthDate],[Nationality]) values('Amity','Simmons','Jan 3, 1929','Bangladesh'),('Petra','Richards','Jan 3, 1956','Serbia'),('Dale','Jensen','Nov 4, 1941','Bolivia'),('Garth','Edwards','Mar 1, 1940','Guinea'),('Alec','Dodson','Apr 18, 1921','Afghanistan'),('Odysseus','Albert','Mar 25, 1928','Equatorial Guinea'),('Robin','Estrada','Apr 23, 1974','Tonga'),('Thomas','Flowers','Jan 29, 1968','Cape Verde'),('Pearl','Calderon','Jan 25, 1965','Portugal'),('Kasimir','Norman','Apr 25, 1931','Mozambique');
	end
	go
	if not exists(select ID from dbo.Litterature) and @@ROWCOUNT = 0
	begin
	insert into Litterature([Title],[AuthorID],[ISBN],[Language]) values('Phasellus at',1,'4415764838800','Grenada'),('Augue ut',2,'8976796923049','Albania'),('Nunc sollicitudin',3,'2310018645312','Argentina'),('Vitae velit',4,'4281249427891','Western Sahara'),('Sed, est.',5,'1851170730096','Croatia'),('orci lobortis',6,'2415093281647','Haiti'),('Magna. Sed',7,'6926263377768','Saint Pierre and Miquelon'),('Amet ornare',8,'5711584348084','Antigua and Barbuda'),('convallis, ante',9,'1538918328441','Anguilla'),('Donec at',10,'1435356529254','Poland');
	insert into Litterature([Title],[AuthorID],[ISBN],[Language]) values('Proin sed',11,'9995851451443','Iran'),('A, arcu.',12,'8903393553137','Paraguay'),('Tellus sem',13,'0525438988945','Montenegro'),('Vitae, erat.',14,'7915420645606','Papua New Guinea'),('Id magna',15,'9508718108790','Switzerland'),('ut, molestie',16,'4874960681551','Myanmar'),('Vel lectus.',17,'7179453404848','Jamaica'),('Id, mollis',18,'6908977803057','Angola'),('Praesent interdum',19,'9091235529688','Sudan'),('Aliquam rutrum',20,'9089427586063','Brazil');
	insert into Litterature([Title],[AuthorID],[ISBN],[Language]) values('Et magnis',21,'0118636031229','Nauru'),('Aliquet libero.',22,'6930645847362','Costa Rica'),('Vitae mauris',23,'5908795531943','Greenland'),('Maecenas malesuada',24,'3714320899799','Wallis and Futuna'),('Quisque tincidunt',25,'3577503951588','Norfolk Island'),('Vehicula. Pellentesque',26,'0904279832718','Ghana'),('Curae; Donec',27,'1487562561360','Greece'),('Aliquet, metus',28,'4932980692459','San Marino'),('Integer mollis.',29,'6060441094806','Estonia'),('Nunc lectus',30,'5275031494102','Costa Rica');
	insert into Litterature([Title],[AuthorID],[ISBN],[Language]) values('Mauris sapien,',31,'5374184872435','Thailand'),('accumsan laoreet',32,'4100004398440','Pitcairn Islands'),('lorem semper',33,'3851042473353','Mauritania'),('tempor erat',34,'8606383189370','United Arab Emirates'),('ligula. Nullam',35,'7012923017984','Cyprus'),('Urna, nec',36,'4879563400217','Mayotte'),('Semper et,',37,'5474281604428','French Southern Territories'),('Ipsum ac',38,'8442319315900','Mali'),('erat semper',39,'0253448637064','Equatorial Guinea'),('ultricies adipiscing,',40,'7378339152079','Guernsey');
	insert into Litterature([Title],[AuthorID],[ISBN],[Language]) values('Sagittis. Duis',41,'0154722731664','Oman'),('Sed, facilisis',42,'3823494573844','Switzerland'),('Lorem vitae',43,'5196047890092','Peru'),('Pretium et,',44,'3706323356428','Saint Vincent and The Grenadines'),('A, auctor',45,'0628284253617','Jordan'),('Turpis nec',46,'8277027675042','Luxembourg'),('Sodales elit',47,'0302376579970','Cyprus'),('Adipiscing elit.',48,'4977328199918','Costa Rica'),('Aliquam adipiscing',49,'8146027897662','Guernsey'),('Gravida non,',50,'9288441523419','Colombia');
	end
	go
	if not exists(select ID from dbo.LitteratureCopyStatus) and @@ROWCOUNT = 0
	begin
	insert into LitteratureCopyStatus([Name]) values('Available'),('Unavailable'),('Overdue');
	end
	go
	if not exists(select ID from dbo.LitteratureCopy) and @@ROWCOUNT = 0
	begin
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(1,'88','2001'),(2,'69','2009'),(3,'15','1998'),(4,'79','1989'),(5,'100','1998'),(6,'77','1996'),(7,'109','1998'),(8,'66','2012'),(9,'31','2003'),(10,'83','1983');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(11,'20','1984'),(12,'79','1993'),(13,'34','2007'),(14,'17','2000'),(15,'62','2013'),(16,'39','2014'),(17,'27','1996'),(18,'33','2002'),(19,'108','2014'),(20,'87','1990');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(21,'74','1993'),(22,'18','1992'),(23,'4','1992'),(24,'62','1989'),(25,'204','2003'),(26,'89','1995'),(27,'78','1981'),(28,'25','1994'),(29,'14','2013'),(30,'55','2005');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(31,'19','2014'),(32,'96','1987'),(33,'36','2012'),(34,'49','2009'),(35,'106','2011'),(36,'93','1981'),(37,'40','2006'),(38,'64','1996'),(39,'94','2013'),(40,'72','2007');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(41,'57','1982'),(42,'92','2014'),(43,'94','1987'),(44,'71','1982'),(45,'44','2004'),(46,'73','1980'),(47,'77','2000'),(48,'71','1996'),(49,'44','1984'),(50,'44','1982');
	-- Dubletter för att trycka in en extra kopia
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(32,'88','2001'),(35,'69','2009'),(42,'15','1998'),(49,'79','1989'),(46,'100','1998'),(24,'77','1996'),(28,'109','1998'),(26,'66','2012'),(47,'31','2003'),(47,'83','1983');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(15,'20','1984'),(21,'79','1993'),(25,'34','2007'),(35,'17','2000'),(10,'62','2013'),(20,'39','2014'),(45,'27','1996'),(37,'33','2002'),(31,'108','2014'),(43,'87','1990');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(35,'74','1993'),(11,'18','1992'),(26,'4','1992'),(43,'62','1989'),(12,'204','2003'),(42,'89','1995'),(14,'78','1981'),(2,'25','1994'),(2,'14','2013'),(37,'55','2005');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(35,'19','2014'),(48,'96','1987'),(44,'36','2012'),(44,'49','2009'),(31,'106','2011'),(47,'93','1981'),(28,'40','2006'),(13,'64','1996'),(37,'94','2013'),(41,'72','2007');
	insert into LitteratureCopy([LitteratureID],[PurchasePrice],[PurchaseYear]) values(40,'57','1982'),(43,'92','2014'),(37,'94','1987'),(27,'71','1982'),(33,'44','2004'),(9,'73','1980'),(41,'77','2000'),(29,'71','1996'),(39,'44','1984'),(37,'44','1982');
	end
	go
	if not exists(select ID from dbo.Customers) and @@ROWCOUNT = 0
	begin
	insert into Customers([FirstName],[LastName],[Address],[EmailAddress]) values('Stewart','Carr','177-452 Amet St.','nibh.dolor@ac.edu'),('Rebekah','Sandoval','1281 Lobortis. Road','consequat@enimSed.ca'),('George','May','9894 Pretium St.','ultrices.mauris@malesuada.ca'),('Dennis','Carroll','855-1155 Tortor, Ave','amet@diameudolor.net'),('Shaeleigh','Gutierrez','2247 Nam Road','lacus.Etiam.bibendum@enimSuspendisse.edu'),('Daryl','Gallagher','Ap #674-1300 Libero Av.','facilisis@sedlibero.com'),('Chaim','Morales','Ap #246-4744 Gravida. Ave','tempus@nonlorem.net'),('Holmes','Saunders','1876 Quis, Ave','pede.Cum.sociis@amet.co.uk'),('Shaine','Gutierrez','P.O. Box 809, 5824 Dui. Rd.','Donec@rutrumjustoPraesent.ca'),('Colby','Bates','P.O. Box 199, 2426 Est, Street','Donec.non@seddolor.co.uk');
	insert into Customers([FirstName],[LastName],[Address],[EmailAddress]) values('Hunter','Tate','P.O. Box 510, 2232 Nisi Av.','sapien.Cras.dolor@blanditviverra.co.uk'),('Dylan','Myers','1026 Ullamcorper, St.','diam@nunc.org'),('Keane','Neal','P.O. Box 369, 918 In Avenue','vitae.orci@tincidunt.ca'),('Shay','Rich','200-9557 Dui Av.','ullamcorper@vitae.edu'),('Cailin','Mercer','Ap #387-1790 Aliquet St.','neque@euismodet.net'),('McKenzie','Lindsey','Ap #374-217 Feugiat Road','egestas.Sed.pharetra@scelerisque.com'),('Raymond','Pratt','3938 Ac St.','Donec.nibh@Vivamus.org'),('Nissim','Velazquez','Ap #343-2182 Magna Rd.','Donec@dolordapibus.net'),('Iliana','Bryan','917-9217 Libero Av.','laoreet.lectus.quis@velit.org'),('Howard','Rosales','Ap #887-2112 Egestas Ave','tincidunt.dui@Vivamus.net');
	insert into Customers([FirstName],[LastName],[Address],[EmailAddress]) values('Chancellor','Leonard','995-8754 Nam Rd.','risus.Donec.nibh@elementumloremut.net'),('Guy','Carrillo','2073 Consequat Street','cursus@eratEtiam.org'),('Mikayla','Chambers','590-6250 Suspendisse Road','rutrum@indolor.edu'),('Armando','Rios','595-2910 Eu Rd.','congue@idsapien.com'),('Cara','Boyd','937 Quis Avenue','orci.lobortis.augue@metusIn.ca'),('Caldwell','Harding','Ap #185-5581 Parturient Avenue','justo@dapibusid.ca'),('Lois','Cabrera','P.O. Box 239, 3576 Orci. Rd.','justo.Praesent.luctus@Nunc.edu'),('Amber','Huber','5615 A St.','massa.non@quam.com'),('Ginger','Potts','668-4083 Duis St.','egestas.blandit.Nam@antelectusconvallis.org'),('Tanya','Wheeler','P.O. Box 988, 2613 Ligula St.','mi@egestasDuisac.ca');
	insert into Customers([FirstName],[LastName],[Address],[EmailAddress]) values('Neville','Cleveland','P.O. Box 996, 4924 Morbi Road','neque.non@adipiscing.com'),('Kirsten','Perez','446-6567 Dui Av.','tincidunt@tinciduntdui.ca'),('Honorato','Mcintyre','P.O. Box 824, 9522 Sed Rd.','purus.ac.tellus@arcuAliquam.com'),('Rashad','Rocha','Ap #410-8749 A, Av.','a.arcu@viverra.org'),('Wing','Hopkins','9435 A, Av.','magna.Suspendisse.tristique@vel.co.uk'),('Roanna','Roberson','P.O. Box 909, 432 Nec Av.','eros.nec.tellus@auctor.com'),('Zena','Payne','177-8449 Amet, Avenue','tincidunt.congue.turpis@Namacnulla.com'),('Shelley','Warner','4467 Nunc Street','Integer@odio.com'),('Aurelia','Santos','P.O. Box 536, 3962 Augue Street','in.lobortis@aliquetProinvelit.com'),('Macy','Stewart','Ap #379-2692 Sodales Av.','dolor.sit@veliteu.ca');
	insert into Customers([FirstName],[LastName],[Address],[EmailAddress]) values('Demetrius','Avery','8597 Purus. Ave','egestas.Aliquam@incursuset.edu'),('Iola','Peterson','500-8818 In Rd.','ornare.sagittis.felis@acarcu.ca'),('Alika','Rivers','515-4544 Senectus Rd.','at.libero.Morbi@egestas.edu'),('Abdul','Ferrell','7353 Tempus Rd.','consectetuer.adipiscing.elit@Craslorem.org'),('TaShya','Gallagher','596-7719 Nulla Street','netus.et.malesuada@neque.co.uk'),('Kennan','Donovan','4267 Sed, Street','lobortis.augue@conguea.edu'),('Helen','Spencer','4090 Ut St.','velit.Cras.lorem@euturpis.co.uk'),('Basil','Figueroa','P.O. Box 292, 9861 Erat Street','consectetuer.cursus.et@nulla.org'),('Martha','Gordon','537-5221 Etiam St.','faucibus@Nam.org'),('Jackson','Thornton','570-9314 Sed Rd.','malesuada@a.ca');
	end
	go
	if not exists(select ID from dbo.LitteratureLoan) and @@ROWCOUNT = 0
	begin
	insert into LitteratureLoan([CustomerID],[LitteratureCopyID]) values(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10);
	insert into LitteratureLoan([CustomerID],[LitteratureCopyID]) values(1,11),(2,21),(3,32),(4,43),(5,26),(6,25),(7,38),(8,36),(9,45),(10,16);
	-- Transaction för att sätta alla med lånade böcker till status 2
	update dbo.LitteratureCopy
		set StatusID = 2
		from dbo.LitteratureCopy as LC
			 inner join dbo.LitteratureLoan as LL
			 on LL.LitteratureCopyID = LC.ID
		where LL.BorrowDate is not null
	end
go
if object_id(N'dbo.vCustomersWithBooks', 'V') is not null
drop view dbo.vCustomersWithBooks
go
-- View med vilka kunder som har lånade böcker
create view dbo.vCustomersWithBooks 
	as
	select C.FirstName + ' ' + C.LastName as CustomerName
		, L.Title
		, cast(LL.Returndate as date) as 'ReturnDate'
	from dbo.Customers as C
		inner join dbo.LitteratureLoan as LL
		on LL.CustomerID = C.ID
		inner join dbo.Litterature as L
		on L.ID = LL.LitteratureCopyID 
		where LL.Returndate > GETDATE();
go
if object_id(N'dbo.vNumberOfCopiesAvailable', 'V') is not null
drop view dbo.vNumberOfCopiesAvailable;
go
--View med antalet kopior av varje titel
create view dbo.vNumberOfCopiesAvailable
	as
	select L.Title as BookTitle
		, L.ISBN
		, LC.ID as CopyID
		, LCS.Name as [Availability]
	from Litterature as L
		inner join LitteratureCopy as LC
		on LC.LitteratureID = L.ID
			inner join LitteratureCopyStatus as LCS
			on LCS.ID = LC.StatusID
	where LC.StatusID = 1;
go
if object_id(N'dbo.uspBorrowBook', 'P') is not null
drop procedure dbo.uspBorrowBook;
go
create procedure dbo.uspBorrowBook
(
	@CustomerID int,
	@BookID int
)
as
begin try
	begin transaction
		update dbo.LitteratureCopy
		set StatusID = 2
		from dbo.LitteratureCopy as LC
			 inner join dbo.LitteratureLoan as LL
			 on LL.LitteratureCopyID = LC.ID
		where LL.LitteratureCopyID = @BookID

		insert into dbo.LitteratureLoan(CustomerID, LitteratureCopyID)
		values(@CustomerID,@BookID)
	commit transaction
end try
begin catch
	rollback transaction
	select 'Loan transaction failed!'
end catch
go
if object_id(N'dbo.uspReturnBook', 'P') is not null
drop procedure dbo.uspReturnBook;
go
create procedure dbo.uspReturnBook
(
	@BookID int
)
as 
begin try
	begin transaction
		update dbo.LitteratureLoan
		set Returndate = getdate()
		from dbo.LitteratureLoan as LL
		where GETDATE() between BorrowDate and Returndate and LL.LitteratureCopyID = @BookID;

		update dbo.LitteratureCopy
		set StatusID = 1
		from dbo.LitteratureCopy as LC
			 inner join dbo.LitteratureLoan as LL
			 on LL.LitteratureCopyID = LC.ID
		where LC.ID = @BookID;
		commit transaction
end try
begin catch
rollback transaction
select 'Transaction Failed - Book not returned'
end catch

--execute dbo.uspBorrowBook @CustomerID=2,@BookID=40;

--execute dbo.uspReturnBook @BookID=40;

--select * from dbo.vCustomersWithBooks;

--select * from dbo.vNumberOfCopiesAvailable;

--use master;
--drop database Libary;
