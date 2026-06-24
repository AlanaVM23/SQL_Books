USE db_livros
-- 1. Listar todos os livros
--SELECT * FROM books_new;

-- 2. Livros com avaliação acima de 4,5
-- SELECT title_book, average_rating FROM books_new
-- WHERE average_rating > 4.5;

-- 3. Contar o número total de livros
--SELECT COUNT(*) AS Total_Livros FROM books_new;

-- 4. Top 10 livros com o menor número de avaliações
SELECT TOP 10 title_book, average_rating FROM books_new
ORDER BY average_rating;

-- 5. Livros sem série