create database Raghu_bank;

use Raghu_bank;

create table branch(
Branch_name varchar(30),
Branch_city varchar(25),
assets int,
PRIMARY KEY (Branch_name)
);

create table BankAccount(
Accno int,
Branch_name varchar(30),
Balance int,
PRIMARY KEY(Accno),
foreign key (Branch_name) references branch(Branch_name)
);

create table BankCustomer(
Customername varchar(20),
Customer_street varchar(30),
CustomerCity varchar (35),
PRIMARY KEY(Customername)
);

create table Depositer(
Customername varchar(20),
Accno int,
PRIMARY KEY(Customername,Accno),
foreign key (Accno) references BankAccount(Accno),
foreign key (Customername) references BankCustomer(Customername)
);

create table Loan(
Loan_number int,
Branch_name varchar(30),
Amount int,
PRIMARY KEY(Loan_number),
foreign key (Branch_name) references branch(Branch_name)
);

desc branch;
 desc BankAccount;
 desc BankCustomer;
 desc Depositer;
 desc Loan;
 
insert into branch values("SBI_Chamrajpet","Bangalore",50000);
insert into branch values("SBI_ResidencyRoad","Bangalore",10000);
insert into branch values("SBI_ShivajiRoad","Bombay",20000);
insert into branch values("SBI_ParlimentRoad","Delhi",10000);


select * from branch;
 
insert into BankAccount values(1,"SBI_Chamrajpet",2000);
insert into BankAccount values(2,"SBI_ResidencyRoad",5000);
insert into BankAccount values(3,"SBI_ShivajiRoad",6000);
insert into BankAccount values(4,"SBI_ParlimentRoad",9000);
insert into BankAccount values(5,"SBI_Jantarmantar",8000);

select * from BankAccount;

 
insert into BankCustomer values("Avinash","Bull_Temple_Road","Bangalore");
insert into BankCustomer values("Dinesh","Bannergatta_Road","Bangalore");
insert into BankCustomer values("Mohan","NationalCollege_Road","Bangalore");
insert into BankCustomer values("Nikil","Akbar_Road","Delhi");
insert into BankCustomer values("Ravi","Prithviraj_Road","Delhi");

select * from BankCustomer;
 
insert into Depositer values("Avinash",1);
insert into Depositer values("Dinesh",2);
insert into Depositer values("Nikil",4);
insert into Depositer values("Ravi",5);


select * from Depositer;
 
insert into Loan values(1,"SBI_Chamrajpet",1000);
insert into Loan values(2,"SBI_ResidencyRoad",2000);
insert into Loan values(3,"SBI_ShivajiRoad",3000);
insert into Loan values(4,"SBI_ParlimentRoad",4000);
insert into Loan values(5,"SBI_Jantarmantar",5000);

select * from Loan;

show tables;

create table Borrower(
Customername varchar(20),
Loan_number int,
foreign key(Customername) references BankCustomer(Customername),
foreign key(Loan_number) references Loan(Loan_number)
);

insert into Borrower values("Avinash",1);
insert into Borrower values("Dinesh",2);
insert into Borrower values("Mohan",3);
insert into Borrower values("Nikil",4);
insert into Borrower values("Ravi",5);

select * from Borrower ;

select d.Customername 
from branch b, Depositer d, BankAccount ba 
where b.Branch_city='Delhi' and d.Accno=ba.Accno and b.Branch_name=ba.Branch_name
group by d.Customername 
having count(distinct b.Branch_name)= (select count(distinct b.Branch_name) from branch b where b.Branch_city='Delhi');

select distinct b.Customername from Borrower b, Depositer d
where b.Customername NOT IN(
select d.Customername from Loan l,Depositer d, Borrower b
where l.Loan_number=b.Loan_number and
d.Customername=b.Customername
);

select distinct d.Customername from Depositer d
where d.Customername IN(
select d.Customername from branch br,Depositer d, BankAccount ba
where br.Branch_city='Bangalore' and br.Branch_name=ba.Branch_name and ba.accno=d.accno and Customername IN(
select Customername from Borrower)
);

select b.Branch_name from Branch b
where b.assets> ALL (
select SUM(b.assets) from Branch b
where b.Branch_City='Bangalore' );

UPDATE BankAccount set Balance=(Balance + (Balance*0.05));

select * from BankAccount;

delete ba.* from BankAccount ba, branch b where branch_city='Bombay' and ba.Branch_name=b.Branch_name;

select * from BankAccount;

delete b.* from branch b where Branch_city=’Bangalore’;

select * from branch;
 
 