create database biblioteca;

use biblioteca;

show databases;

create table aluno (
pk_aluno int not null auto_increment,
nome varchar(45) not null,
data_nasc date,
primary key (pk_aluno)
);

create table autor (
pk_autor int not null auto_increment,
nome varchar(25) not null,
sobrenome varchar(45),
primary key (pk_autor)
);

create table livro (
pk_livro int not null auto_increment,
titulo varchar(45) not null,
primary key (pk_livro)
);

create table livro_autor (
fk_livro int,
fk_autor int,
foreign key (fk_livro) references livro (pk_livro),
foreign key (fk_autor) references autor (pk_autor)
);

create table exemplar (
pk_exemplar int not null auto_increment,
fk_livro int,
disponível bit not null,
primary key (pk_exemplar),
foreign key (fk_livro) references livro (pk_livro)
);

create table emprestimo (
pk_emprestimo int not null auto_increment,
fk_aluno int,
fk_exemplar int,
data_emprestimo date not null,
data_evolucao date not null,
multa decimal(10,2),
primary key (pk_emprestimo),
foreign key (fk_aluno) references aluno (pk_aluno),
foreign key (fk_exemplar) references exemplar (pk_exemplar)
);

show tables;