create database ACME;

show databases;

use acme;

create table funcionario (
pk_funcionario int not null auto_increment,
nome varchar(45),
sobrenome varchar(45),
datanasc date,
cargo varchar(45),
salario decimal(7,2),
departamento varchar(45),
primary key (pk_funcionario)
);

update funcionario set cargo = 'Analista', salario = 5000.00 where pk_funcionario = 1011;

alter table funcionario auto_increment = 1001;

insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Alberto', 'Silva', '1970-01-05', 'Supervisor', 5000, 'Vendas');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Silvia', 'Pires', '1985-05-13', 'Vendedor', 2500, 'Vendas');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Mário', 'Oliveira', '1970-11-20', 'Diretor', 10000, 'Diretoria');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Roberto', 'Albuquerque', '1981-03-05', 'Supervisor', 5300, 'Administração');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Horácio', 'Almeida', '1973-10-18', 'Gerente', 8000, 'Recursos Humanos');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Fabiana', 'Rossi', '1980-08-07', 'Gerente', 8000, 'Administração');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Maria', 'Silva', '1979-03-07', 'Vendedor', 2700, 'Vendas');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Joana', 'Pereira', '1965-04-17', 'Supervisor', 8000, 'Recursos Humanos');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Márcia', 'Sousa', '1968-12-05', 'Gerente', 8500, 'CPD');
insert into funcionario (nome, sobrenome, datanasc, cargo, salario, departamento) values ('Antônio', 'Santos', '1988-02-07', 'Programador', 3500, 'CPD');

delete from funcionario where pk_funcionario = 1002;

select * from funcionario;

select funcionario.nome, funcionario.sobrenome from funcionario order by sobrenome;
select * from funcionario order by departamento;
select * from funcionario where salario > 5000.00 order by nome, sobrenome;
select funcionario.datanasc, funcionario.nome from funcionario order by datanasc desc;
select sum(salario) from funcionario;
select nome, departamento, cargo from funcionario;
select funcionario.nome, funcionario.sobrenome, funcionario.departamento from funcionario;

select funcionario.departamento, sum(funcionario.salario) from funcionario where funcionario.departamento = 'Vendas';
select funcionario.departamento, sum(funcionario.salario) from funcionario where funcionario.departamento = 'Diretoria';
select funcionario.departamento, sum(funcionario.salario) from funcionario where funcionario.departamento = 'Administração';
select funcionario.departamento, sum(funcionario.salario) from funcionario where funcionario.departamento = 'Recursos Humanos';
select funcionario.departamento, sum(funcionario.salario) from funcionario where funcionario.departamento = 'CPD';

select count(nome) from funcionario;
select avg(salario) from funcionario;
select funcionario.departamento, min(funcionario.salario) from funcionario where funcionario.departamento = 'Vendas';
select funcionario.departamento, min(funcionario.salario) from funcionario where funcionario.departamento = 'Diretoria';
select funcionario.departamento, min(funcionario.salario) from funcionario where funcionario.departamento = 'Administração';
select funcionario.departamento, min(funcionario.salario) from funcionario where funcionario.departamento = 'Recursos Humanos';
select funcionario.departamento, min(funcionario.salario) from funcionario where funcionario.departamento = 'CPD';

select funcionario.departamento, funcionario.nome, funcionario.sobrenome from funcionario order by departamento, funcionario.nome;
select funcionario.nome, funcionario.sobrenome from funcionario where funcionario.departamento = 'Recursos Humanos';

create table departamento (
pk_departamento int not null auto_increment,
nome varchar(45),
local_dep varchar(45),
fk_funcionario int,
primary key (pk_departamento),
foreign key (fk_funcionario) references funcionario (pk_funcionario)
);

select funcionario.departamento, funcionario.nome, funcionario.sobrenome, funcionario.salario, funcionario.salario*0.5 + salario from funcionario, departamento where funcionario.departamento = 'Vendas' and not departamento.nome;

alter table departamento auto_increment = 101;

insert into departamento (nome, local_dep, fk_funcionario) values ('Administração', 'Matriz', 1007);
insert into departamento (nome, local_dep, fk_funcionario) values ('Vendas', 'Filial', 1001);
insert into departamento (nome, local_dep, fk_funcionario) values ('Recursos Humanos', 'Matriz', 1009);
insert into departamento (nome, local_dep, fk_funcionario) values ('Diretoria', 'Matriz', 1004);
insert into departamento (nome, local_dep, fk_funcionario) values ('CPD', 'Matriz', 1010);

select * from departamento;

select departamento.nome, funcionario.nome, funcionario.sobrenome from departamento, funcionario where departamento.fk_funcionario = funcionario.pk_funcionario;
select departamento.nome from departamento;

delete from departamento;

create table projeto (
pk_projeto int not null auto_increment,
descricao varchar(45),
horas_prev decimal(5,2),
fk_funcionario int,
primary key (pk_projeto),
foreign key (fk_funcionario) references funcionario (pk_funcionario)
);

insert into projeto (descricao, fk_funcionario, horas_prev) values ('Ampliação do Setor de Vendas', 1001, 100.00);
insert into projeto (descricao, fk_funcionario, horas_prev) values ('Implantação do Sistema de RH', 1010, 80.00);
insert into projeto (descricao, fk_funcionario, horas_prev) values ('Auditoria Interna', 1005, 120.00);

select * from projeto;

select projeto.descricao, funcionario.nome, funcionario.sobrenome from projeto, funcionario where projeto.fk_funcionario = funcionario.pk_funcionario;

update projeto set horas_prev = 100.00 where pk_projeto = 2; -- resposta da 2.