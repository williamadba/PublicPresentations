

drop table if exists dbo.floatinghorror;
drop table if exists dbo.migrated_table;
go
create table dbo.floatinghorror
(invoiceid float not null 
constraint PK_floatinghorror primary key
, text1 varchar(10) not null);
go
--1 thru 8
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.001, char(79));
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.002, char(77));
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.003, char(71));
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.004, char(33));
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.005, char(87));
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.006, char(84));
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.007, char(70));
insert into dbo.floatinghorror (invoiceid, text1) values (2019000000100.008, char(33)); 

GO
--weird, shows duplicate values despite a group by?!
select invoiceid from dbo.floatinghorror group by invoiceid;

--to actually display the data, gotta convert
select invoice = cast(invoiceid as decimal(19,3))
from dbo.floatinghorror group by invoiceid;









--Say we have to copy the data to another system,
--like a data warehouse or a competitor's software, 
--to a database that uses grown-up data types
--and they have higher precision requirements!
create table dbo.migrated_table
(invoiceid decimal(19,4) not null constraint PK_migrated_table primary key
, text1 varchar(10) not null
);
--the data inserts fine
insert into dbo.migrated_table (invoiceid, text1)
select invoiceid, text1 from dbo.floatinghorror;
GO
--but oh no!
select * from dbo.migrated_table;
--cannot trust float/real data types!