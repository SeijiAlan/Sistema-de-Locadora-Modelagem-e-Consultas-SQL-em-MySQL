## Explicação geral

-O banco de dados contém 3 tabelas, sendo a tabela locacoes (tabela fato) e as demais as dimensões (clientes e veiculos).Os dados foram pensados de forma aleatória, portanto são dados ficticios.

-Com base nos dados inseridos, foi possível desenvolver várias queries usando ferramentas estruturais como select,where,groupy by,inner join,left join,having(acompanhado de função agregada),order by, over e partition by (funções de janela).

-O banco de dados foi desenvolvido por meio do MySQL

---

## Desenvolvimento (Criação e modelagem das tabelas)

-Nesta etapa foi desenvolvido um banco de dados relacional para uma locadora de veículos utilizando MySQL. Foram criadas as tabelas **clientes**, **veículos** e **locações**, definindo chaves primárias, chaves estrangeiras e restrições de integridade referencial para representar o relacionamento entre as entidades e garantir a consistência dos dados armazenados.

-Atribui o formato "varchar" não apenas para o CPF como também para a coluna "telefone" com a finalidade de evitar erros de modelagem após a gravação dados,além disso me preocupei em assegurar que todos os dados de todas as colunas fossem obrigatórios (not null) com a finalidade de manter um banco de dados mais organizado com dados rastreáveis. Dessa forma, os seguintes comandos SQL foram executados:

```sql
create table clientes (
id_cliente int primary key auto_increment,
nome varchar (50) not null, 
CPF varchar(14) not null,
telefone varchar(15) not null,
cidade varchar(50) not null
);
````

```sql
create table veiculos (
id_veiculos int primary key auto_increment,
modelo varchar(50) not null,
marca varchar(50) not null,
ano int(4) not null,
cor varchar(10) not null,
valor_diaria decimal(10,2) not null
);
```

```sql
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
```
---

Após a modelagem do banco, foram inseridos registros de clientes, veículos e locações para simular um cenário real de operação. Essa base de dados foi utilizada para validar relacionamentos entre tabelas e servir como fonte para consultas analíticas e testes de diferentes recursos da linguagem SQL.
Utilizou-se os seguintes comandos:

```sql
insert into clientes (nome,CPF,telefone,cidade) values
('Andre Sanches','00000000000','88889909','recife'),
('Sergio santos','11111111111','06097890','campos do jordao'),
('fabio junior','22222222222','34569988','campinas'),
('antonio nunes','33333333333','45655534','sao paulo'),
('Nayla silva','44444444444','45443322','hortolandia'),
('saori silva','55555555555','22111122','curitiba'),
('ytalo ferreira','66666666666','77778878','manaus'),
('maikon jordan','77777777777','22223344','osasco');
```


```sql
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
```

```sql
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
```

---


Foram realizadas operações de manutenção utilizando os comandos **UPDATE**, **DELETE** e novos **INSERTs**, simulando situações comuns do dia a dia, como correção de informações, atualização de valores e remoção de registros. Essas operações demonstram o domínio das principais instruções de manipulação de dados (DML) utilizadas em bancos relacionais conforme os comandos a seguir:

```sql
update locacoes set quantidade_dias='13' where id_locacao=16;
```

```sql
update locacoes set quantidade_dias='39' where id_locacao=17;
```

```sql
update veiculos set cor='vermelho' where id_veiculo=1;
```

```sql
update veiculos set valor_diaria='130.00' where id_veiculo=1;
```

```sql
delete from locacoes where id_locacao=16;
```
---

Como determinei o auto_increment na criação da coluna id_locacao da tabela locacoes, o workbench acabou atribuindo os números de cada id partindo do número 17,
foram adicionados inicialmente 15 registros porém, deletou-se 1 registro (id_locacao=16), restando apenas 14 registros na tabela fato em questão.

---


## DESENVOLVIMENTO DAS QUERIES

# (Consulta utilizando LEFT JOIN)
Esta consulta utiliza **LEFT JOIN** para relacionar clientes, locações e veículos, preservando todos os clientes cadastrados, mesmo aqueles sem locações no período analisado. Além dos relacionamentos entre tabelas, são aplicados filtros, funções de agregação, agrupamentos e ordenação para gerar indicadores como quantidade de locações, dias alugados e valores pagos por cliente:

<img width="1600" height="419" alt="1" src="https://github.com/user-attachments/assets/10e8e544-1320-4485-8343-edaaefed10b6" />


# (Consulta com INNER JOIN, GROUP BY e HAVING)
Nesta consulta foram utilizados **INNER JOIN**, **GROUP BY** e **HAVING** para identificar clientes cuja soma dos valores das locações ultrapassa um determinado limite. Também são calculados indicadores como menor, maior, média e valor total das locações, demonstrando o uso conjunto de funções de agregação para análises financeiras:

<img width="1600" height="426" alt="2" src="https://github.com/user-attachments/assets/d1331628-421d-4243-968d-6ac19404d33b" />


# (Agrupamento por marca de veículo)
Esta consulta apresenta uma visão consolidada das locações por marca de veículo, utilizando **GROUP BY**, **HAVING** e funções de agregação. O resultado permite identificar a quantidade de veículos disponíveis, o número de locações realizadas e o valor médio das diárias para cada fabricante selecionado:

<img width="1600" height="461" alt="3" src="https://github.com/user-attachments/assets/e2c145e6-9cd9-4ab2-bca2-011b46ab96a7" />


# (Window Functions - Indicadores por marca)
Esta consulta aplica **Window Functions** utilizando `OVER(PARTITION BY)` para calcular indicadores por marca sem perder o detalhamento de cada veículo. São apresentados a quantidade de veículos, média, soma, menor e maior valor das diárias, mantendo todas as linhas da consulta e evidenciando a principal vantagem das funções de janela em relação ao `GROUP BY`:

<img width="1600" height="368" alt="4" src="https://github.com/user-attachments/assets/4a2c855f-d2c9-4639-8440-4c520c7cfd85" />



# (Window Functions - Participação percentual)
Nesta consulta são utilizadas funções de janela para calcular a participação percentual da diária de cada veículo em relação ao valor total das diárias da sua marca. Essa abordagem demonstra como as Window Functions permitem combinar informações individuais e agregadas na mesma consulta, preservando o detalhamento de cada registro:

<img width="1600" height="393" alt="5" src="https://github.com/user-attachments/assets/1735fab8-ccde-464e-acda-22a8c5be97f9" />



# (Window Functions - Amplitude das diárias)
Esta consulta utiliza `MIN()`, `MAX()` e `OVER(PARTITION BY)` para identificar a menor e a maior diária de cada marca, além de calcular a amplitude de preços entre esses valores. O resultado facilita a análise da variação das diárias dentro de cada fabricante sem a necessidade de agrupar os registros:

<img width="1600" height="365" alt="6" src="https://github.com/user-attachments/assets/624cfee8-5504-4ba0-9c3e-a02c5e7802f5" />


---

## CONCLUSÃO 

Este projeto permitiu consolidar os principais conceitos de SQL e modelagem de bancos de dados relacionais utilizando MySQL. Ao longo do desenvolvimento foram aplicados comandos de definição e manipulação de dados (DDL e DML), criação de relacionamentos por meio de chaves primárias e estrangeiras, consultas utilizando `INNER JOIN` e `LEFT JOIN`, filtros, funções de agregação, `GROUP BY`, `HAVING`, subconsultas e Window Functions (`OVER()` e `PARTITION BY`). Além da implementação do banco de dados, foram desenvolvidas consultas voltadas à geração de indicadores e análises, simulando cenários encontrados em aplicações e projetos de Business Intelligence. Este projeto representa a evolução prática dos meus estudos em SQL e demonstra minha capacidade de estruturar, manipular e analisar dados em um banco de dados relacional.

























