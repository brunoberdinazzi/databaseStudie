-- Procedure para calcular o total de vendas por cliente e produto
CREATE PROCEDURE CalcularTotalVendasPorClienteProduto
AS
BEGIN
    -- Crie uma tabela temporária para armazenar os resultados
    CREATE TABLE #Resultados (
        ClienteID INT,
        ProdutoID INT,
        TotalVendas DECIMAL(10, 2)
    )

    -- Preencha a tabela temporária com os dados das vendas
    INSERT INTO #Resultados (ClienteID, ProdutoID, TotalVendas)
    SELECT
        V.ClienteID,
        P.ProdutoID,
        SUM(V.Valor) AS TotalVendas
    FROM Vendas V
    JOIN Produtos P ON V.ProdutoID = P.ProdutoID
    GROUP BY V.ClienteID, P.ProdutoID

    -- Exiba os resultados
    SELECT
        C.Nome AS NomeCliente,
        P.Nome AS NomeProduto,
        R.TotalVendas
    FROM #Resultados R
    JOIN Clientes C ON R.ClienteID = C.ClienteID
    JOIN Produtos P ON R.ProdutoID = P.ProdutoID

    -- Limpe a tabela temporária
    DROP TABLE #Resultados
END
