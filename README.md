# Limpeza e Tratamento de Dados com SQL: Base de Livros

Este repositório contém a etapa de tratamento, limpeza e padronização de uma base de dados de livros. O objetivo principal do projeto foi transformar dados brutos e inconsistentes em uma estrutura organizada e confiável para futuras análises e criação de dashboards.

---

## Tecnologias Utilizadas
* **Python:** Utilizado para gerar a coluna de gêneros literários e identificar quais obras possuem adaptações para filmes ou séries.
* **SQL (SQL Server):** Utilizado para todo o processo de limpeza, padronização e eliminação de registros duplicados.
* **Power BI:** Utilizado para a etapa final de modelagem, criação de métricas em DAX e desenvolvimento do dashboard interativo.

---

## Estrutura do Tratamento (Arquivos SQL)

Para garantir uma melhor organização, o processo de manipulação dos dados foi dividido em três arquivos principais:

### 1. Limpeza e Padronização (`01_limpeza.sql`)
O foco desta etapa foi organizar a estrutura dos textos e remover registros que prejudicariam as análises individuais.
* **Isolamento de Autores:** Tratamento da coluna para manter apenas o autor principal, removendo coautores e ilustradores listados após o caractere `/`.
* **Separação de Títulos e Sagas:** Criação das colunas `title_books` e `series`. Utilizando as funções de texto `SUBSTRING` e `CHARINDEX`, isolei o nome do livro e removi a numeração dos volumes (como `#2`), padronizando o nome das sagas.
* **Remoção de Coleções e Boxes:** Exclusão de registros de *Box Sets* e coleções completas, evitando distorções nas métricas de obras individuais.

### 2. Remoção de Duplicados (`02_duplicados.sql`)
Esta etapa resolveu o problema de livros idênticos cadastrados em diferentes idiomas ou edições, o que gerava duplicidade na base.
* **Critério de Seleção:** Criação de uma coluna auxiliar (`SerieChave`) para agrupar as obras por autor e título.
* **Deduplicação com CTE:** Aplicação de uma **CTE** junto com a função `ROW_NUMBER()`. O critério para definir o registro principal foi o volume de avaliações (`ratings_count`), mantendo no banco de dados apenas a edição mais popular de cada obra.

### 3. Correção de Métricas (`03_metricas.sql`)
Ajustes realizados para garantir a consistência e integridade dos dados numéricos.
* **Correção da Escala Decimal:** Identificação de registros na coluna `average_rating` que foram armazenados sem a separação decimal (apresentando notas maiores que 5).
* **Tratamento com CASE WHEN:** Aplicação de lógica condicional para reescalar e dividir esses valores, garantindo que todas as notas ficassem no padrão correto de até 5 estrelas.

---

## Próximos Passos
* [X] Gerar a coluna de gêneros literários com Python
* [X] Executar a limpeza de textos e padronização com SQL
* [X] Eliminar registros duplicados utilizando CTE
* [ ] Mapear e identificar quais livros possuem adaptação para série ou filme (via Python)
* [ ] Desenvolver as consultas em SQL para extração dos primeiros insights
* [ ] Conectar a base tratada ao Power BI e construir o dashboard

---
