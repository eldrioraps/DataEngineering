create table test_datatypes
(
id int identity primary key,
sample_value varchar(200),
sample_text nvarchar(200),
numbers_types float,--int
date_value datetime
)
declare @id int=10
select * from test_datatypes where id =@id

insert into test_datatypes(sample_value,sample_text,numbers_types,date_value) 
values ('2026-0203','akhilesh',2.4,'2026-02-03')


--here again R and D need to be done
declare @date date
set @date='2026-02-03'

declare @date2 datetime
set @date2='2026-02-03'--implicit conversion

select @date,@date2
print(@date)
print(@date2)

create table test_constraint
(id int primary key)

insert into test_constraint values(1)

select * from test_constraint