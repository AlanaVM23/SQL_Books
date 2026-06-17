USE db_livros;

/*
--- ETAPA 1 - CRIAÇÃO DA COLUNA---
Cria coluna auxiliar utilizada para identificar diferentes edições da mesma obra.
*/
ALTER TABLE books_new ADD SerieChave NVARCHAR(255);
GO

/*
--- ETAPA 2 - PREENCHIMENTO DA CHAVE DA SÉRIE ---
Extração da identificação da série presente no título.
*/
UPDATE books_new 
SET 
    SerieChave = CASE 
        WHEN title LIKE '%(%#%)%' 
            THEN SUBSTRING(
                title, 
                CHARINDEX('(', title) + 1, 
                CHARINDEX(')', title) - CHARINDEX('(', title) - 1
            ) 
        ELSE NULL 
    END;
GO

/*
--- ETAPA 3 - REMOÇÃO DE EDIÇÕES DUPLICADAS ---
Mantém apenas a edição mais popular de cada obra utilizando o número de avaliações como critério.
*/
WITH CTE_Final AS (
    SELECT 
        bookID, 
        title, 
        ratings_count, 
        SerieChave, 
        ROW_NUMBER() OVER (
            PARTITION BY ISNULL(SerieChave, CAST(authors AS NVARCHAR(MAX)) + LEFT(title, 25)) 
            ORDER BY ratings_count DESC
        ) AS Ordem 
    FROM books_new
)
DELETE FROM CTE_Final 
WHERE Ordem > 1;
GO
