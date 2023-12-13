create database Assignment5Db
use Assignment5Db

create schema bank
go

create table bank.Customer
(
    CId nvarchar(50) primary key,
    CName nvarchar(50) not null,
    CEmail nvarchar(50) unique not null,
    Contact nvarchar(50) unique not null,
    CPwd as (right(CName, 2)) + CId + (left(Contact, 2)) persisted
)


create table bank.MailInfo
(
    CId nvarchar(50) primary key,
    CName nvarchar(50) not null,
    CEmail nvarchar(50) unique not null,
    Contact nvarchar(50) unique not null,
    CPwd as (right(CName, 2)) + CId + (left(Contact, 2)) persisted,
    MailTo as CEmail persisted,
    MailDate date,
    MaiMessage nvarchar(100)
)


create trigger afterInsTrg
on bank.Customer
after insert 
as
begin
    declare @id nvarchar(50)
    declare @name nvarchar(50)
    declare @mail nvarchar(50)
    declare @contact nvarchar(50)
    declare @pwd nvarchar(50)
    declare @mailto nvarchar(50)
    declare @maildate date
    declare @message nvarchar(100)

    select @id = CId, @name = CName, @mail = CEmail, @contact = Contact from inserted

    insert into bank.MailInfo (CId, CName, CEmail, Contact, MailDate, MaiMessage)
    values (@id, @name, @mail, @contact, GETDATE(), 'Your net banking password is CPwd is valid up to 2 days only. Update it.')

    print 'Record inserted & values captured'
end
insert into bank.Customer (CId, CName, CEmail, Contact) values ('1', 'Sahu', 'sahu@yahoo.com', '987654321')
insert into bank.Customer (CId, CName, CEmail, Contact) values ('2', 'Bhavani', 'bhavani@yahoo.com', '9867534210')
insert into bank.Customer (CId, CName, CEmail, Contact) values ('5', 'Boyapati', 'boyapati@yahoo.com', '8985912031')
select * from bank.Customer
select * from bank.MailInfo