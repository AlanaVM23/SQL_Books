USE db_livros

/*
ETAPA 1 - CORREÇÃO DA ESCALA DE AVALIAÇÕES
Ajusta registros cuja nota foi armazenada sem separação decimal adequada.
*/
UPDATE books_new
SET average_rating = 
    CASE 
        WHEN average_rating >= 100 THEN average_rating / 100.0
        WHEN average_rating >= 10 THEN average_rating / 10.0
        ELSE average_rating 
    END
WHERE average_rating > 5;
