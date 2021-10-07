create database banco;

show databases;

use banco;

show tables;

create table cliente (
pk_cliente int not null auto_increment,
nome varchar(45) not null,
data_nascimento date,
primary key (pk_cliente)
);

create table tipoconta (
pk_tipoconta int not null auto_increment,
descricao varchar(45) not null,
primary key (pk_tipoconta)
);

create table conta (
pk_conta int not null auto_increment,
fk_tipoconta int,
fk_cliente int,
data_abertura date not null,
saldo decimal(10,2) not null,
primary key (pk_conta),
foreign key (fk_tipoconta) references tipoconta (pk_tipoconta),
foreign key (fk_cliente) references cliente (pk_cliente)
);

create table movimento (
pk_movimento int not null auto_increment,
fk_conta int,
data_hora datetime not null,
credito_debito char(1) not null,
numero_documento varchar(20) not null,
valor decimal(10,2) not null,
primary key (pk_movimento),
foreign key (fk_conta) references conta (pk_conta)
);

create table tipomovimento (
pk_tipomovimento int not null auto_increment,
fk_movimento int,
descricao varchar(20),
primary key (pk_tipomovimento),
foreign key (fk_movimento) references movimento (pk_movimento)
);

select * from tipomovimento;

alter table cliente add CPF varchar(14) not null;
select * from cliente;

alter table movimento change numero_documento nr_doc varchar(20) not null;
select * from movimento;

alter table movimento drop credito_debito;
