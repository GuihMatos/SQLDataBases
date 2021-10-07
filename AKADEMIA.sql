create database AKADEMIA;

use AKADEMIA;

show databases;

create table instrutor (
pk_instrutor int not null auto_increment,
nome varchar(45) not null,
CPF char(14),
primary key (pk_instrutor)
);

alter table instrutor modify column CPF char(14);

insert into instrutor (nome, CPF) values ('Van Dame', '111.111.111-11');
insert into instrutor (nome, CPF) values ('Arnol Chuasneguer', '222.222.222-22');
insert into instrutor (nome, CPF) values ('Silvestre Estalone', '333.333.333-33');
insert into instrutor (nome) values ('Riana Dance');

select * from instrutor;

create table atividade (
pk_atividade int not null auto_increment,
nome varchar(45) not null,
mensalidade decimal(3,2) not null,
primary key (pk_atividade)
);

alter table atividade modify column mensalidade decimal(5,2) not null;

insert into atividade (nome, mensalidade) values ('Natação', 150.00);
insert into atividade (nome, mensalidade) values ('Judô', 120.00);
insert into atividade (nome, mensalidade) values ('Malhação', 100.00);
insert into atividade (nome, mensalidade) values ('Dança', 120.00);

update atividade set mensalidade = 165.00 where pk_atividade = 1;

select * from atividade;

create table turma (
pk_turma int not null auto_increment,
fk_atividade int,
fk_instrutor int,
horario time not null,
primary key (pk_turma),
foreign key (fk_atividade) references atividade (pk_atividade),
foreign key (fk_instrutor) references instrutor (pk_instrutor)
);

alter table turma change hora_entrada hora_inicio time not null;
alter table turma add hora_termino time not null;
insert into turma (hora_termino) values ('10:00:00');

insert into turma (hora_inicio, hora_termino, fk_atividade, fk_instrutor) values ('08:00:00', '10:00:00', 2, 3);
insert into turma (hora_inicio, hora_termino, fk_atividade, fk_instrutor) values ('10:00:00', '12:00:00', 1, 1);
insert into turma (hora_inicio, hora_termino, fk_atividade, fk_instrutor) values ('16:00:00', '18:00:00', 3, 2);
insert into turma (hora_inicio, hora_termino, fk_atividade, fk_instrutor) values ('19:00:00', '21:00:00', 2, 3);
insert into turma (hora_inicio, hora_termino, fk_atividade, fk_instrutor) values ('08:00:00', '10:00:00', 4, 4);

select * from turma;

drop table turma;
delete from turma where pk_turma = 9;

update turma set fk_instrutor = 1 where pk_turma = 8;

create table aluno (
pk_aluno int not null auto_increment,
nome varchar(45) not null,
data_nasc date not null,
peso decimal(4,2) not null,
primary key (pk_aluno)
);

alter table aluno modify column peso decimal(4,2) not null;

insert into aluno (nome, data_nasc, peso) values ('João', '1990-02-15', 65.00);
insert into aluno (nome, data_nasc, peso) values ('Pedro', '1991-04-21', 77.00);
insert into aluno (nome, data_nasc, peso) values ('Maria', '1994-04-14', 66.00);
insert into aluno (nome, data_nasc, peso) values ('Mateus', '1988-02-04', 69.00);
insert into aluno (nome, data_nasc, peso) values ('Paulo', '1975-12-24', 80.00);
insert into aluno (nome, data_nasc, peso) values ('Joana', '2000-10-15', 54.00);
insert into aluno (nome, data_nasc, peso) values ('Marta', '1995-12-25', 62.00);
insert into aluno (nome, data_nasc, peso) values ('Maique Taisson', '1970-06-03', 90.00);

select * from aluno;

delete from aluno where pk_aluno = 3;

update aluno set nome = 'Maique Taisson' where pk_aluno = 8;

create table matricula (
pk_matricula int not null auto_increment,
fk_turma int,
fk_aluno int,
primary key (pk_matricula),
foreign key (fk_turma) references turma (pk_turma),
foreign key (fk_aluno) references aluno (pk_aluno)
);

insert into matricula (fk_turma, fk_aluno) values (5, 2);
insert into matricula (fk_turma, fk_aluno) values (6, 3);
insert into matricula (fk_turma, fk_aluno) values (5, 3);
insert into matricula (fk_turma, fk_aluno) values (7, 4);
insert into matricula (fk_turma, fk_aluno) values (6, 1);
insert into matricula (fk_turma, fk_aluno) values (7, 5);
insert into matricula (fk_turma, fk_aluno) values (10, 6);
insert into matricula (fk_turma, fk_aluno) values (10, 7);
insert into matricula (fk_turma, fk_aluno) values (7, 8);

select * from matricula;

update matricula set fk_turma = 7 where fk_aluno = 1;

delete from matricula where fk_aluno = 3;