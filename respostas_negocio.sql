use mercadolivre

/**************************
Tabela retornando os vendedores com aniversario hoje e 
com vendas em 2020 maior que 1500
***************************/
select
c.[nome cliente]
,c.[data de nascimento] 
,sum(o.nPedido) as TotalVendas
from customer c
inner join [order] o
on
c.idcliente = o.idcliente
where
c.[data de nascimento] = CONVERT(DATE, GETDATE())
and
o.dataPedido ='01-01-2020'
c.tipoCustomer = 'vendedor'
having 
sum(v.nPedido)>1500
group by 
c.[nome cliente]
,c.[data de nascimento] 




/**************************
Ranking dos 5 maiorer vendedores no ano de 2020
na categoria celular
(fazer o join com categoria para filtrar celular)
***************************/


WITH RankingVendedores AS (
    SELECT
        o.idcliente,
        ,MONTH(o.DataPedido) AS Mes
        ,YEAR(o.DataPedido) AS Ano
        ,SUM(o.ValorPedido) AS [valor total da transacao]
		,sum(o.qtdVendas) as TotalVendas
		,sum(o.qtdProduto) as TotalProdutos
        ROW_NUMBER() OVER (PARTITION BY YEAR(o.DataPedido), MONTH(o.DataPedido) ORDER BY SUM(o.ValorPedido) DESC) AS Ranking
    FROM [Order] o

	inner join category g on
	r.iditem = g.iditem

    WHERE 
	g.categoria='celular'
	and
	YEAR(o.DataVenda) >='01-01-2020'
    
	GROUP BY o.idcliente,
	MONTH(DataPedido),
	YEAR(DataPedido),
	g.categoria
)

SELECT 
c.[nome do cliente]
,c.[sobrenome]
,
r.IdCliente
,r.Mes
,r.Ano
,r.TotalVendas
,r.TotalProdutos
,r.[valor total da transacao]
FROM RankingVendedores r
inner join customer c on
r.idcliente = c.idcliente



WHERE 
c.tipoCustomer ='vendedor'
and

and
r.Ranking <= 5


ORDER BY r.Mes, r.Ranking;


/******************************
Procedure para atualizar a tabela 2 com os
pedido e os status do dia
******************************/

create procedure atualizaOrder as


drop table if exists [orderDiario]

select 
o.* 
into OrderDiario
from
[order] o
inner join item i on

o.iditem = i.iditem

where i.statusItem='Ativo'


DELETE FROM OrderDiario WHERE DataPedido = CONVERT(DATE, GETDATE());


MERGE INTO OrderDiario AS d
USING [Order] AS o
ON d.IDItem = o.IdItem AND d.DataPedido = CONVERT(DATE, GETDATE())
WHEN MATCHED THEN
    UPDATE SET d.ValorPedido = o.ValorPedido, d.[StatusPedido] = o.[StatusPedido]
WHEN NOT MATCHED THEN
    INSERT (IdItem, ValorPedido, [StatusPedido], DataPedido)
    VALUES (o.IdItem, o.ValorPedido, o.[StatusPedido], CONVERT(DATE, GETDATE()));

/*******************
Agendar execução da proc no sql Agent 
ou no airflow
******************/

	
	select * from OrderDiario
