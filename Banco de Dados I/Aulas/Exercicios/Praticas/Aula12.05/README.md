Claro! Aqui está um **resumo confiável e organizado** do conteúdo sobre **Banco de Dados Relacional**:

---

### 📚 **Banco de Dados Relacional – Resumo**

1. **Estrutura e Gerência**

   * Dados organizados em **tabelas relacionadas entre si**.
   * Utiliza um **SGBD (Sistema Gerenciador de Banco de Dados)** e uma **linguagem de manipulação**.

2. **Linguagens Usadas**

   * **DDL (Data Definition Language):** criação e exclusão de estruturas (`CREATE`, `DROP`).
   * **DML (Data Manipulation Language):** manipulação dos dados (`SELECT`, `INSERT`, `UPDATE`, `DELETE`).

3. **Fases de Modelagem**

   * **Conceitual:** define **entidades**, **atributos** e **relacionamentos** de forma gráfica.
   * **Lógica:** converte entidades em tabelas com **chaves primárias e estrangeiras** e define os **tipos de relacionamento**.
   * **Física:** implementa em SQL, cuidando de **tipos de dados**, **restrições** e **regras de integridade**.

4. **Boas Práticas**

   * Minimizar o número de tabelas sem comprometer o modelo.
   * Evitar atributos nulos.
   * Reduzir a quantidade de colunas em chaves primárias.

5. **Álgebra Relacional (teoria das consultas)**

   * **Projeção (π):** seleção de colunas.

     ```sql
     SELECT nome, email FROM Usuario;
     ```
   * **Seleção (σ):** filtro com condição.

     ```sql
     SELECT nome, email FROM Usuario WHERE sexo = 'Masculino';
     ```
   * **União:** lógica OR.

     ```sql
     WHERE sexo = 'Masculino' OR dataNascimento < '1974-03-10';
     ```
   * **Interseção:** lógica AND.

     ```sql
     WHERE sexo = 'Masculino' AND dataNascimento < '1974-03-10';
     ```
   * **Produto cartesiano:** combinação entre tabelas.
   * **Junção (JOIN):** substitui o produto cartesiano com maior eficiência.

     ```sql
     SELECT A.nome, A.tipo
     FROM Aeroporto A
     JOIN Cidade C ON C.idCidade = A.idCidade
     WHERE C.nome = 'São Paulo' AND A.tipo = 'Internacional';
     ```

---

📌 **Fontes confiáveis para aprofundamento:**

* Elmasri, R. & Navathe, S. B. (2010). *Fundamentals of Database Systems.*
* Korth, H. F., & Silberschatz, A. (2011). *Sistemas de Banco de Dados.*
* [W3Schools SQL Tutorial](https://www.w3schools.com/sql/)
* [Oracle SQL Documentation](https://docs.oracle.com/en/database/)
* [PostgreSQL Documentation](https://www.postgresql.org/docs/)

Quer que eu também gere um esquema visual com as fases da modelagem?
