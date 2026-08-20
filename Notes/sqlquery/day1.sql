create table dbo.testing_01
(
id int,
name varchar(20)
)
select * from  dbo.testing_01
 delete from  dbo.testing_01
alter table dbo.testing_01 alter column name nvarchar(250)

insert into dbo.testing_01(id,name) values (1,'kim')
insert into dbo.testing_01(id,name) values (1,'a')
insert into dbo.testing_01(id,name) values (2,'b')
insert into dbo.testing_01(id,name) values (3,'c')
insert into dbo.testing_01(id,name) values (4,'d')
insert into dbo.testing_01(id,name) values (5,'e')
insert into dbo.testing_01(id,name) values (6,'f')
insert into dbo.testing_01(id,name) values (7,'g')
insert into dbo.testing_01(id,name) values (8,'h')
insert into dbo.testing_01(id,name) values (9,'i')
insert into dbo.testing_01(id,name) values (10,'j')
insert into dbo.testing_01(id,name) values (11,'k')
insert into dbo.testing_01(id,name) values (12,'l')
insert into dbo.testing_01(id,name) values (13,'m')
insert into dbo.testing_01(id,name) values (14,'n')
insert into dbo.testing_01(id,name) values (15,'o')
insert into dbo.testing_01(id,name) values (16,'p')
insert into dbo.testing_01(id,name) values (17,'q')
insert into dbo.testing_01(id,name) values (18,'r')
insert into dbo.testing_01(id,name) values (19,'s')


Select 
--1,2,3,'kim','greg'
id,name
from dbo.testing_01--naming convention ( by default we use two part naming convention --schema+object_name)
where name='f'


insert into dbo.testing_01(id,name) values (21,'aaa$')
insert into dbo.testing_01(id,name) values (22,'$aba')
insert into dbo.testing_01(id,name) values (31,'.1ab')
insert into dbo.testing_01(id,name) values (33,'>a1b')

Select 
id,name
from dbo.testing_01
where id>20
order by name asc

Select 
id,name
from dbo.testing_01
where id>20
order by name desc