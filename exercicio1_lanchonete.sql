create database Lanchonete;

show databases;

use Lanchonete;

create table Cliente (
pk_cliente int auto_increment,
nome varchar(50) not null,
telefone char(10) not null,
primary key (pk_cliente)
);

create table Pedido (
pk_pedido int not null auto_increment,
fk_cliente int not null,
datapedido date not null,
primary key (pk_pedido),
foreign key (fk_cliente) references Cliente (pk_cliente)
);

create table TipoProduto (
pk_tipo_produto int not null auto_increment,
tipo varchar(20) not null,
primary key (pk_tipo_produto)
);

create table Produto (
pk_produto int not null auto_increment,
fk_tipo_produto int not null,
descricao varchar(50) not null,
valor decimal(10,2) not null,
primary key (pk_produto),
foreign key (fk_tipo_produto) references TipoProduto (pk_tipo_produto)
);

create table ItemPedido (
pk_item_pedido int not null auto_increment,
fk_pedido int not null,
fk_produto int not null,
quantidade int not null,
valor decimal (10,2),
primary key (pk_item_pedido),
foreign key (fk_pedido) references Pedido (pk_pedido),
foreign key (fk_produto) references Produto (pk_produto)
);

show tables;

describe Cliente;
describe Pedido;
describe TipoProduto;
describe Produto;
describe ItemPedido;

select * from Cliente;
select * from Pedido;
select * from TipoProduto;
select * from Produto;
select * from ItemPedido;

insert into Cliente (nome, telefone) values 
('José', '9911-1111'),
('Pedro', '9922-2222'),
('Maria', '9933-3333'),
('João', '9944-4444'), 
('Joana', '9955-5555'), 
('Luis', '9966-6666');

insert into TipoProduto (tipo) values 
('Bebida'),
('Massa'), 
('Sanduiche');

insert into Produto (descricao, valor, fk_tipo_produto) values 
('Refrigerante 1L', 6.5, 1),
('Refrigerante 2L', 8, 1),
('Pizza Calabreza M', 15, 2),
('Pizza Calabreza G', 20, 2),
('Pizza Mussarela M', 15, 2),
('Pizza Mussarela G', 20, 2),
('Hamburger', 8, 3),
('Eggsburger', 10, 3),
('X Tudo', 12, 3);

insert into Pedido (datapedido, fk_cliente) values
('2018-11-01', 3), 
('2018-11-01', 1),
('2018-11-03', 6),
('2018-11-05', 5), 
('2018-11-10', 4), 
('2018-11-12', 4), 
('2018-11-14', 1), 
('2018-11-14', 2);

insert into ItemPedido (fk_pedido, fk_produto, quantidade, valor) values 
(1, 3, 2, 15), (1, 2, 1, 8),
(1, 8, 1, 10), (2, 9, 1, 12), (2, 1, 1, 6.5),
(3, 6, 1, 20), (3, 1, 1, 8),
(4, 8, 1, 10), (4, 9, 1, 12), (4, 1, 1, 6.5),
(5, 5, 1, 15), (5, 2, 1, 8),
(6, 4, 1, 20),
(7, 7, 1, 8), (7, 1, 1, 8),
(8, 2, 1, 8), (7, 1, 1, 20), (8, 6, 1, 20);