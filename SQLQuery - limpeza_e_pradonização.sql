USE db_livros

/* 
--- ETAPA 1 - CRIAÇÃO DE COLUNAS AUXILIARES ---
Criação das colunas que irão armazenar o título tratado e o nome da saga extraídos da coluna original.
*/
ALTER TABLE books_new
ADD title_new NVARCHAR(255),
    series NVARCHAR(255);

/* 
--- ETAPA 2 - SEPARAÇÃO DE TÍTULO E SAGA ---
Extração do nome do livro e da saga a partir da coluna original 'title'.
*/
UPDATE books_new 
SET 
    title_book = CASE 
        WHEN CHARINDEX('(', title) > 0 
            THEN RTRIM(LEFT(title, CHARINDEX('(', title) - 1)) 
        ELSE title 
    END,
    
    series = CASE 
        WHEN CHARINDEX('(', title) > 0 AND CHARINDEX(')', title) > 0 
            THEN SUBSTRING(
                title, 
                CHARINDEX('(', title) + 1, 
                CHARINDEX(')', title) - CHARINDEX('(', title) - 1
            ) 
        ELSE NULL 
    END;

/*
--- ETAPA 3 - PADRONIZAÇÃO DOS NOMES DAS SAGAS ---
Remoção da numeração dos volumes para manter apenas o nome principal da saga.
*/
UPDATE books_new 
SET 
    series = CASE 
        WHEN CHARINDEX('#', series) > 0 
            THEN LEFT(series, CHARINDEX('#', series) - 1) 
        ELSE series 
    END;

/*
--- ETAPA 4 - PADRONIZAÇÃO DOS AUTORES ---
Quando existem múltiplos autores separados por '/', mantém apenas o autor principal.
*/
UPDATE books_new 
SET 
    authors = CASE 
        WHEN CHARINDEX('/', authors) > 0 
            THEN LEFT(authors, CHARINDEX('/', authors) - 1) 
        ELSE authors 
    END;

/*
--- ETAPA 5 - REMOÇÃO DE COLEÇÕES E BOX SETS ---
Exclusão de registros que representam conjuntos de livros e poderiam distorcer as análises individuais.
*/
DELETE FROM books_new
WHERE title LIKE '%Box Set%'
   OR title LIKE '%Boxed Set%'
   OR title LIKE '%Collection%'
   OR title LIKE '%Omnibus%'
   OR title LIKE '%Complete Works%'
   OR title LIKE '%Set Books%';

/*
--- ETAPA 6 - REMOÇÃO DE SÉRIES AGRUPADAS ---
Exclusão de registros que representam intervalos de volumes em vez de uma obra específica.
*/
DELETE FROM books_new
WHERE SerieChave LIKE '%-%' 
   OR SerieChave LIKE '%&%'
   OR SerieChave LIKE '%,%';