drop database CLINICAS;
		-- COLOCAR OS APELIDOS COM AS ALIAS (PRA ELE -NÃO- TIRAR PONTOS)

show databases;

create database CLINICAS;
use CLINICAS;

show databases;

create table clinica (
pk_clinica int not null auto_increment,
nome varchar(50),
CNPJ char(20),
primary key (pk_clinica)
);

insert into clinica (nome, CNPJ) values ('Saúde', '00.000.000/0000-00');
insert into clinica (nome, CNPJ) values ('Saúde Total', '99.999.999/9999-99');

select * from clinica;

create table medico (
pk_medico int not null auto_increment,
nome varchar(50),
CPF char(14),
especialidade varchar(20),
primary key (pk_medico)
);

insert into medico (nome, CPF, especialidade) values ('Flávio', '111.111.111-11', 'Cardiologista');
insert into medico (nome, CPF, especialidade) values ('Márcio', '444.444.444-44', 'Ortopedista');
insert into medico (nome, CPF, especialidade) values ('Camila', '888.888.888-88', 'Pediatra');

select * from medico;

create table paciente (
pk_paciente int not null auto_increment,
nome varchar(50),
datanasc date,
primary key (pk_paciente)
);

insert into paciente (nome, datanasc) values ('José', '1990-06-07');
insert into paciente (nome, datanasc) values ('Thiago', '1964-04-23');
insert into paciente (nome, datanasc) values ('Francisco', '1983-05-05');
insert into paciente (nome, datanasc) values ('Maria', '1972-09-29');
insert into paciente (nome, datanasc) values ('Ana', '2014-08-21');
insert into paciente (nome, datanasc) values ('Pedro', '2015-12-01');

select * from paciente;

create table consulta (
pk_consulta int not null auto_increment,
fk_paciente int,
fk_medico int,
fk_clinica int,
data_consulta date,
hora time,
valor decimal(10,2),
primary key (pk_consulta),
foreign key (fk_paciente) references paciente (pk_paciente),
foreign key (fk_medico) references medico (pk_medico),
foreign key (fk_clinica) references clinica (pk_clinica)
);

insert into consulta (fk_paciente, fk_medico, fk_clinica, data_consulta, hora, valor) values (1, 1, 1, '2018-11-14', '11:10:00', 200.00);
insert into consulta (fk_paciente, fk_medico, fk_clinica, data_consulta, hora, valor) values (2, 1, 1, '2018-11-16', '12:50:00', 200.00);
insert into consulta (fk_paciente, fk_medico, fk_clinica, data_consulta, hora, valor) values (3, 1, 1, '2018-11-19', '07:30:00', 200.00);
insert into consulta (fk_paciente, fk_medico, fk_clinica, data_consulta, hora, valor) values (4, 2, 1, '2018-12-03', '09:20:00', 160.00);
insert into consulta (fk_paciente, fk_medico, fk_clinica, data_consulta, hora, valor) values (5, 3, 1, '2018-12-23', '08:45:00', 185.00);
insert into consulta (fk_paciente, fk_medico, fk_clinica, data_consulta, hora, valor) values (6, 2, 2, '2018-12-25', '16:00:00', 200.00);

select * from consulta;

select paciente.nome as 'Paciente', medico.nome as 'Médico(a)' from consulta
inner join paciente on paciente.pk_paciente = consulta.fk_paciente
inner join medico on medico.pk_medico = consulta.fk_medico
where consulta.valor > avg(consulta.valor); 

select paciente.nome as 'Paciente', medico.nome as 'Médico(a)' from paciente, medico
where paciente.pk_paciente and medico.pk_medico = (select consulta.fk_paciente, consulta.fk_medico from consulta);
-- where consulta.valor > avg(consulta.valor); 
-- in (select consulta.fk_paciente, consulta.fk_medico, consulta.data_consulta, consulta.hora from consulta) 
-- having consulta.valor > avg(consulta.valor);
-- , consulta.data_consulta, consulta.hora

select paciente.nome, (select consulta.valor from consulta having consulta.valor > avg(consulta.valor)), 
(select medico.nome from medico where medico.pk_medico = consulta.fk_medico), (select consulta.data_consulta from consulta), (select consulta.hora from consulta)
from paciente;
(select consulta.data_consulta, consulta.hora from consulta); 
-- SELECT CERTO (8) (select medico.nome from consulta inner join medico on consulta.fk_medico = medico.pk_medico group by medico.nome);
-- SELECT CERTO (8) (select consulta.valor from consulta having consulta.valor > avg(consulta.valor));

-- SELECT ABAIXO MAIS OU MENOS CERTO
select paciente.nome, 
(select medico.nome from consulta inner join medico on consulta.fk_medico = medico.pk_medico group by medico.nome), 
(select consulta.valor from consulta having consulta.valor > avg(consulta.valor)) as Valor_da_Consulta
from paciente;

select paciente.nome,
(select medico.nome from consulta inner join medico on consulta.fk_medico = medico.pk_medico group by medico.nome), 
(select consulta.valor from consulta having consulta.valor > avg(consulta.valor)) as Valor_da_Consulta 
from consulta inner join paciente on consulta.fk_paciente = paciente.pk_paciente;

-- 1)
select paciente.nome as 'Paciente', consulta.data_consulta as 'Data da Consulta', consulta.hora as 'Hora', medico.nome as 'Médico(a)', medico.especialidade as 'Especialidade do(a) Médico(a)' from consulta
inner join paciente on consulta.fk_paciente = paciente.pk_paciente 
inner join medico on consulta.fk_medico = medico.pk_medico where consulta.data_consulta like '2018-12%';

-- 2)
select medico.nome as 'Médico(a)', medico.CPF as 'CPF do(a) Médico(a)', medico.especialidade as 'Especialidade do(a) Médico(a)', consulta.data_consulta as 'Data da Consulta', consulta.hora as 'Hora', consulta.valor as 'Valor da Consulta', clinica.nome as 'Nome da Clínica' from consulta
inner join paciente on consulta.fk_paciente = paciente.pk_paciente 
inner join medico on consulta.fk_medico = medico.pk_medico 
inner join clinica on consulta.fk_clinica = clinica.pk_clinica 
where consulta.data_consulta like '2018-12%';

-- 3)
select medico.especialidade as 'Especialidade do(a) Médico(a)', count(consulta.pk_consulta) as 'Quantidade de Consultas', sum(consulta.valor) as 'Total Faturado' from consulta
inner join medico on consulta.fk_medico = medico.pk_medico 
where consulta.data_consulta like '2018-11%' group by medico.especialidade;

-- 4)
select clinica.nome as 'Clínica', count(consulta.pk_consulta) as 'Quantidade de Consultas', sum(consulta.valor) as 'Total Faturado' from consulta
inner join clinica on consulta.fk_clinica = clinica.pk_clinica 
where consulta.data_consulta like '2018-11%' group by clinica.nome;

-- 5)
select medico.nome as 'Médico(a)', count(consulta.pk_consulta) as 'Quantidade de Consultas', sum(consulta.valor) as 'Total Faturado(Médico(a))' from consulta
inner join medico on consulta.fk_medico = medico.pk_medico
where consulta.data_consulta like '2018-12%' group by medico.nome;

-- 6)
select paciente.nome as 'Paciente' from paciente 
where paciente.pk_paciente in (select consulta.fk_paciente from consulta where consulta.fk_clinica <> 2);

-- 7)
select medico.especialidade as 'Especialidade' from medico 
where medico.pk_medico not in (select consulta.fk_medico from consulta 
								where consulta.data_consulta like '2018-12%');

-- 8) NÃO TERMINADA AINDA
select paciente.nome from paciente 
where pk_paciente not in (select paciente.nome from clinica where clinica.nome = 'Saúde Total');

