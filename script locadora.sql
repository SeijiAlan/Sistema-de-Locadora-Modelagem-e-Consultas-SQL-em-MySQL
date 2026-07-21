create database locadora;
use locadora;


create table clientes (
id_cliente int primary key auto_increment,
nome varchar (50) not null,
CPF varchar(14) not null,
telefone varchar(15) not null,
cidade varchar(50) not null
);

create table veiculos (
id_veiculos int primary key auto_increment,
modelo varchar(50) not null,
marca varchar(50) not null,
ano varchar(4) not null,
cor varchar(10) not null,
valor_diaria decimal(10,2) not null
);





create table locacoes (
id_locacao int primary key auto_increment,
id_cliente int,
constraint fk_cliente
foreign key(id_cliente) references clientes(id_clientes),
id_veiculo int,
constraint fk_veiculo
foreign key(id_veiculo) references veiculos(id_veiculo),
data_retirada date not null,
data_devolucao date not null,
quantidade_dias int not null
);


insert into clientes (nome,CPF,telefone,cidade) values
('Andre Sanches','00000000000','88889909','recife'),
('Sergio santos','11111111111','06097890','campos do jordao'),
('fabio junior','22222222222','34569988','campinas'),
('antonio nunes','33333333333','45655534','sao paulo'),
('Nayla silva','44444444444','45443322','hortolandia'),
('saori silva','55555555555','22111122','curitiba'),
('ytalo ferreira','66666666666','77778878','manaus'),
('maikon jordan','77777777777','22223344','osasco');


insert into veiculos (modelo,marca,ano,cor,valor_diaria) values
('onix','chevrolet','2018','preto',130.00),
('onix','chevrolet','2019','branco',150.00),
('onix','chevrolet','2019','prata',150.00),
('ka','ford','2018','prata',120),
('ka','ford','2019','branco',120),
('fit','honda','2020','prata',170),
('fit','honda','2019','branco',170),
('fit','honda','2020','preto',170),
('gol','volkswagem','2017','branco',120),
('gol','volkswagen','2020','preto',120),
('gol','volkswagen','2019','prata',120);



INSERT INTO locacoes (id_cliente, id_veiculo, data_retirada, data_devolucao, quantidade_dias) VALUES
(1, 2, '2026-03-02', '2026-03-15', 13),
(5, 3, '2025-05-03', '2025-06-10', 38),
(6, 2, '2026-04-10', '2026-04-20', 10),
(6, 4, '2026-02-01', '2026-03-20', 47),
(1, 10, '2025-10-03', '2025-10-21', 18),
(1, 11, '2025-07-10', '2025-07-26', 16),
(5, 11, '2025-06-02', '2025-06-19', 17),
(3, 6, '2025-08-04', '2025-08-16', 12),
(2, 7, '2026-08-11', '2026-09-19', 39),
(2, 5, '2026-11-12', '2026-12-03', 21),
(3, 1, '2025-03-12', '2025-04-11', 30),
(7, 7, '2025-01-05', '2025-01-25', 20),
(2, 9, '2025-06-12', '2025-06-29', 17),
(3, 11, '2025-09-11', '2025-09-21', 10),
(8, 8, '2026-03-21', '2026-03-30', 9);



update locacoes set quantidade_dias='13' where id_locacao=16;
update locacoes set quantidade_dias='39' where id_locacao=17;
update veiculos set cor='vermelho' where id_veiculo=1;
update veiculos set valor_diaria='130.00' where id_veiculo=1;


delete from locacoes where id_locacao=16;





select c.nome as cliente,c.cidade,count(l.id_locacao) as qntd_locacao,sum(l.quantidade_dias) as total_dias_alugados,
min(l.quantidade_dias*v.valor_diaria) as menor_valor,max(quantidade_dias*valor_diaria) as maior_valor,round(avg(quantidade_dias*valor_diaria),2) as media,
sum(l.quantidade_dias*v.valor_diaria) as receita
from clientes c left join locacoes l
on c.id_cliente=l.id_cliente
AND l.data_retirada >= '2026-01-01'
AND l.data_devolucao <= '2026-12-31'
AND l.quantidade_dias BETWEEN 10 AND 30
left join veiculos v on v.id_veiculo=l.id_veiculo
AND v.valor_diaria BETWEEN 100 AND 300
group by c.id_cliente
order by receita desc;




select c.nome as cliente,count(l.id_locacao) as quantidade_locacao,min(l.quantidade_dias*v.valor_diaria) as menor_valor_locacao,
max(l.quantidade_dias*v.valor_diaria) as maior_valor_locacao,round(avg(l.quantidade_dias*v.valor_diaria),2) as media_diaria,
sum(l.quantidade_dias*v.valor_diaria) as receita
from locacoes l inner join clientes c 
on c.id_cliente=l.id_cliente
inner join veiculos v on v.id_veiculo=l.id_veiculo
where valor_diaria between 100 and 250
group by c.id_cliente,c.nome
having sum(l.quantidade_dias*v.valor_diaria)>2500;



select v.marca,count(distinct v.id_veiculo) as quantidade_veiculos,count(l.id_locacao) as quantidade_locacoes,
round(avg(valor_diaria),2) as media_diaria 
from locacoes l inner join veiculos v 
on l.id_veiculo=v.id_veiculo
where marca in ('chevrolet','ford','honda')
group by v.marca
having count(l.id_locacao)>=3
order by quantidade_locacoes;

select modelo,marca,valor_diaria,count(id_veiculo) over(partition by marca),round(avg(valor_diaria) over(partition by marca),2) as media_marca,
sum(valor_diaria) over(partition by marca) as total_diaria_marca,
min(valor_diaria) over(partition by marca) as menor_diaria_marca,
max(valor_diaria) over(partition by marca) as maior_diaria_marca
from veiculos;



select modelo,marca,valor_diaria,count(id_veiculo) over(partition by marca) as qntd_veiculo,sum(valor_diaria) over(partition by marca),
round((valor_diaria/sum(valor_diaria) over(partition by marca)),2)*100 as porcentagem_diaria_do_total from veiculos;



select modelo,marca,valor_diaria,min(valor_diaria) over(partition by marca) as menor_diaria,max(valor_diaria) over(partition by marca) as maior_diaria,
max(valor_diaria) over(partition by marca)-min(valor_diaria) over(partition by marca) as amplitude from veiculos;










































