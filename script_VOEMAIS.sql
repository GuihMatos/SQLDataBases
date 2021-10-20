show databases;

create database VOEMAIS;
show databases;

use VOEMAIS;

create table aeronave (
pk_aeronave integer not null auto_increment,
modelo varchar(45) not null,
fabricante varchar(45) not null,
primary key (pk_aeronave)
);

-- 3)
insert into aeronave (modelo, fabricante) values ('737-300', 'Boeing');
insert into aeronave (modelo, fabricante) values ('767-100', 'Boeing');
insert into aeronave (modelo, fabricante) values ('Focker 100', 'Focker');

select * from aeronave;

create table trecho (
pk_trecho integer not null auto_increment,
cidade_origem varchar(45) not null,
cidade_destino varchar(45) not null,
primary key (pk_trecho)
);

-- 3)
insert into trecho (cidade_origem, cidade_destino) values ('São Luís', 'Teresina');
insert into trecho (cidade_origem, cidade_destino) values ('Fortaleza', 'São Luís');
insert into trecho (cidade_origem, cidade_destino) values ('São Luís', 'Fortaleza');

select * from trecho;

create table voo (
pk_voo integer not null auto_increment,
fk_trecho integer,
fk_aeronave integer,
dataVoo date not null,
horaVoo time not null,
primary key (pk_voo),
foreign key (fk_trecho) references trecho (pk_trecho),
foreign key (fk_aeronave) references aeronave (pk_aeronave)
);

-- 3)
insert into voo (fk_trecho, fk_aeronave, dataVoo, horaVoo) values (2, 3,'2007-07-15', '05:00:00');
insert into voo (fk_trecho, fk_aeronave, dataVoo, horaVoo) values (1, 1,'2007-07-16', '12:30:00');
insert into voo (fk_trecho, fk_aeronave, dataVoo, horaVoo) values (3, 2,'2007-07-20', '16:00:00');
insert into voo (fk_trecho, fk_aeronave, dataVoo, horaVoo) values (3, 1,'2007-07-21', '12:00:00');
insert into voo (fk_trecho, fk_aeronave, dataVoo, horaVoo) values (3, 2,'2007-07-23', '15:00:00');

select * from voo;

-- 4) a)
select voo.pk_voo as 'Código do Voo', trecho.cidade_origem as 'Cidade Origem', trecho.cidade_destino as 'Cidade Destino', aeronave.modelo as 'Modelo Aeronave', voo.dataVoo as 'Data do Voo', voo.horaVoo as 'Hora' from voo 
inner join trecho on voo.fk_trecho = trecho.pk_trecho 
inner join aeronave on voo.fk_aeronave = aeronave.pk_aeronave;

-- 5) a)
update voo set horaVoo = '17:00' where pk_voo = 3;
update voo set fk_aeronave = 3 where pk_voo = 3;

create table passageiro (
pk_passageiro integer not null auto_increment,
nome varchar(45) not null,
CPF char(14) not null,
primary key (pk_passageiro)
);

-- 3)
insert into passageiro (nome, CPF) values ('Roberto Carlos', '111.111.111-11');
insert into passageiro (nome, CPF) values ('Marisa Monte', '222.222.222-22');
insert into passageiro (nome, CPF) values ('Gilberto Gil', '333.333.333-33');
insert into passageiro (nome, CPF) values ('Adriana Calcanhoto', '444.444.444-44');
insert into passageiro (nome, CPF) values ('Erasmo Carlos', '555.555.555-55');

-- 5) b)
insert into passageiro (nome, CPF) values ('Wesley Safadão', '666.666.666-66');

select * from passageiro;

create table reserva (
pk_reserva integer not null auto_increment,
fk_voo integer,
fk_passageiro integer,
primary key (pk_reserva),
foreign key (fk_voo) references voo (pk_voo),
foreign key (fk_passageiro) references passageiro (pk_passageiro)
);

-- 3)
insert into reserva (fk_voo, fk_passageiro) values (1, 1);
insert into reserva (fk_voo, fk_passageiro) values (1, 3);
insert into reserva (fk_voo, fk_passageiro) values (2, 4);
insert into reserva (fk_voo, fk_passageiro) values (2, 5);
insert into reserva (fk_voo, fk_passageiro) values (1, 2);
insert into reserva (fk_voo, fk_passageiro) values (3, 1);

select * from reserva;

-- 4) b)
select reserva.pk_reserva as 'Código de Reserva', passageiro.nome as 'Passageiro', voo.dataVoo as 'Data do Voo', voo.horaVoo as 'Hora' from reserva 
inner join passageiro on reserva.fk_passageiro = passageiro.pk_passageiro 
inner join voo on reserva.fk_voo = voo.pk_voo;

update reserva set fk_passageiro = 6 where pk_reserva = 6;