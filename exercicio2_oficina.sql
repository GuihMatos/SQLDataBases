create database OFICINA;

show databases;

use OFICINA;

show tables;

drop table Cliente;
drop table Veiculo;
drop table OrdemServico;
drop table Servico;

create table Cliente (
pk_cliente int auto_increment,
nome varchar(50) not null,
telefone char(14),
primary key (pk_cliente)
);

describe Cliente;

create table Veiculo (
pk_veiculo int auto_increment,
fk_cliente int,
placa char(8) not null,
marca varchar(45) not null,
modelo varchar(45) not null,
primary key (pk_veiculo),
foreign key (fk_cliente) references Cliente (pk_cliente)
);

create table OrdemServico (
pk_ordem int auto_increment,
fk_veiculo int,
data_entrada date not null,
data_conlusao date,
primary key (pk_ordem),
foreign key (fk_veiculo) references Veiculo (pk_veiculo)
);

create table Servico (
pk_servico int auto_increment,
fk_ordem int,
descricao varchar(60) not null,
valor decimal(10,2) not null,
primary key (pk_servico),
foreign key (fk_ordem) references OrdemServico (pk_ordem)
);

insert into Cliente (nome) values ('João');

select * from Cliente;

delete from Cliente;

insert into Veiculo (fk_cliente, placa, marca, modelo) values (3, 'HPP-1234', 'FIAT', 'UNO');

select * from Veiculo;

insert into OrdemServico (fk_veiculo, data_entrada) values (1, '2020-11-19');

select * from OrdemServico;

insert into Servico (fk_ordem, descricao, valor) values 
(3, 'Troca de óleo', 250.00), (3, 'Alinhamento e balanceamento', 120.00), (3, 'Lavagem geral', 20.00);

select * from Servico;