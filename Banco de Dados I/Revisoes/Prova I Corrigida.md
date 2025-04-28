
### Parte I – Teórica

**1. Defina o que é um Sistema Gerenciador de Banco de Dados (SGBD) e cite duas de suas principais funções.**

**Resposta:**  
Um **Sistema Gerenciador de Banco de Dados (SGBD)** é um software que permite a criação, manipulação e administração de bancos de dados. Ele proporciona uma interface entre os dados e os usuários, garantindo segurança, integridade e eficiência no acesso aos dados.

Duas funções principais:
- **Controle de acesso e segurança**: Gerencia quem pode acessar e modificar os dados.
- **Garantia de integridade**: Assegura que os dados estejam corretos e consistentes conforme regras definidas.

---

**2. Diferencie os conceitos de modelo conceitual, modelo lógico e modelo físico de banco de dados.**

**Resposta:**  
- **Modelo conceitual**: Representação de alto nível dos dados, focada em entender os requisitos de negócio. Exemplo: Diagrama Entidade-Relacionamento (DER).
- **Modelo lógico**: Tradução do modelo conceitual para um modelo compatível com um SGBD, sem detalhes de implementação física, mas já adaptado ao modelo de dados (relacional, por exemplo).
- **Modelo físico**: Descrição de como os dados serão efetivamente armazenados no sistema, considerando detalhes de performance como índices e particionamento.



---

**3. Explique o que é uma cardinalidade em um diagrama entidade-relacionamento e forneça um exemplo com cardinalidade 1:N.**

**Resposta:**  
A **cardinalidade** em um DER indica a quantidade de ocorrências de uma entidade que se relaciona com outra entidade. Um exemplo de cardinalidade 1:N é:

- **Exemplo**: Um departamento (**1**) pode ter vários funcionários (**N**), mas cada funcionário trabalha em apenas um departamento.

---

**4. O que é um atributo identificador? Qual a sua importância em um modelo conceitual?**

**Resposta:**  
Um **atributo identificador** é aquele capaz de distinguir unicamente cada ocorrência de uma entidade em um banco de dados.  
Sua importância é garantir a unicidade de registros, fundamental para assegurar a integridade dos dados.

**Exemplo:** O número de matrícula de um aluno é um atributo identificador.


---

**5. Descreva o que é um relacionamento ternário em um modelo entidade-relacionamento e forneça um exemplo real que poderia ser modelado com esse tipo de relacionamento.**

**Resposta:**  
Um **relacionamento ternário** envolve três entidades simultaneamente em uma associação. É usado quando uma relação entre três entidades não pode ser decomposta em relações binárias sem perda de informação.

**Exemplo real:**  
Uma empresa que precisa registrar quais **projetos** estão sendo desenvolvidos por quais **funcionários** usando quais **equipamentos**.


---

Claro! Vou continuar resolvendo as questões da Parte II (6 a 10) com base em boas práticas de modelagem de dados, e, como você pediu, citarei fontes confiáveis no final.

---

### Parte II – Prática

**6. (1,0) A partir da descrição abaixo, construa um diagrama entidade-relacionamento (DER):**  
*"Uma universidade possui departamentos. Cada departamento tem um nome e um código. Cada departamento oferece vários cursos. Cada curso possui um nome e uma carga horária. Cada curso pertence a apenas um departamento."*

**Resposta:**  
Modelo Entidade-Relacionamento (descrição textual):

- Entidades:
  - **Departamento**: atributos (Código_Departamento, Nome_Departamento)
  - **Curso**: atributos (Código_Curso, Nome_Curso, Carga_Horária)

- Relacionamento:
  - **Oferece**: entre Departamento (1) e Curso (N)

**Resumo visual:**  
```
Departamento (Código_Departamento, Nome_Departamento)
        |
     (1:N)
        |
Curso (Código_Curso, Nome_Curso, Carga_Horária)
```

---

**7. (0,5) Considerando o DER da questão anterior, indique quais seriam os atributos identificadores das entidades envolvidas.**

**Resposta:**  
- **Departamento**: Código_Departamento (chave primária)
- **Curso**: Código_Curso (chave primária)

Esses códigos garantem a unicidade dos registros.

---

**8. (1,0) Faça a modelagem lógica (relacional) para o DER da questão 6, indicando as tabelas, atributos e chaves primárias e estrangeiras.**

**Resposta:**

**Tabela Departamento:**
```sql
Departamento (
  Codigo_Departamento PRIMARY KEY,
  Nome_Departamento
)
```

**Tabela Curso:**
```sql
Curso (
  Codigo_Curso PRIMARY KEY,
  Nome_Curso,
  Carga_Horaria,
  Codigo_Departamento FOREIGN KEY REFERENCES Departamento(Codigo_Departamento)
)
```

Aqui, `Codigo_Departamento` na tabela `Curso` é uma chave estrangeira que referencia `Departamento`.

---

**9. (1,0) Considere o seguinte cenário e crie o DER correspondente:**  
*"Um funcionário pode supervisionar outros funcionários, mas é supervisionado por apenas um outro funcionário. Cada funcionário possui um código, nome e salário."*

**Resposta:**

- Entidade:
  - **Funcionario**: atributos (Codigo, Nome, Salario)

- Relacionamento:
  - Auto-relacionamento: Um funcionário **supervisiona** outros funcionários.

**Resumo visual:**
```
Funcionario (Codigo, Nome, Salario)
    |
(supervisiona) (1:N)
    |
Funcionario
```

Cada funcionário pode supervisionar muitos, mas ser supervisionado por apenas um.

---

**10. (1,0) Com base no DER da questão anterior, apresente o modelo lógico correspondente (tabelas com chaves primária e estrangeira).**

**Resposta:**

**Tabela Funcionario:**
```sql
Funcionario (
  Codigo PRIMARY KEY,
  Nome,
  Salario,
  Supervisor_Codigo FOREIGN KEY REFERENCES Funcionario(Codigo)
)
```
Aqui, `Supervisor_Codigo` é uma chave estrangeira que referencia o `Codigo` do próprio funcionário, permitindo o auto-relacionamento.


---
Ótimo! Vamos resolver então a **questão 11** e a **questão 12** (apesar que a prova enviada só mostrou até a 11 — vou criar a 12 de forma consistente, como uma possível continuação, tudo bem?).

Vou seguir o que foi pedido, com fontes confiáveis ao final:

---

## **Questão 11 — Resolução**

### **Construção do DER (Diagrama Entidade-Relacionamento)**

Entidades:
- **Médico** (código_médico, nome, especialidade)
- **Paciente** (código_paciente, nome, data_nascimento)
- **Consulta** (código_consulta, data, código_médico, código_paciente)

Relacionamentos:
- **Consulta** associa **Paciente** e **Médico**.

**DER simplificado:**

```
Médico (código_médico, nome, especialidade)
Paciente (código_paciente, nome, data_nascimento)
Consulta (código_consulta, data, código_médico [FK], código_paciente [FK])
```

- FK = Foreign Key (chave estrangeira)

**Explicação:**
- Cada **Consulta** está ligada a **um** Médico e a **um** Paciente.
- Portanto, Consulta possui duas chaves estrangeiras: uma referenciando Médico e outra Paciente.

---

### **Modelagem Lógica**

Criação das tabelas:

```sql
CREATE TABLE Medico (
    codigo_médico INT PRIMARY KEY,
    nome VARCHAR(100),
    especialidade VARCHAR(100)
);

CREATE TABLE Paciente (
    codigo_paciente INT PRIMARY KEY,
    nome VARCHAR(100),
    data_nascimento DATE
);

CREATE TABLE Consulta (
    codigo_consulta INT PRIMARY KEY,
    data DATE,
    codigo_médico INT,
    codigo_paciente INT,
    FOREIGN KEY (codigo_médico) REFERENCES Medico(codigo_médico),
    FOREIGN KEY (codigo_paciente) REFERENCES Paciente(codigo_paciente)
);
```

---

**Questão 12**

**Questão 12:**  
"Liste as principais diferenças entre um relacionamento 1:N e um relacionamento N:N em um banco de dados relacional, dando um exemplo prático para cada um."

- **Resposta:**

- **Relacionamento 1:N (Um para Muitos):**
  - **Definição:** Um registro em uma tabela A pode estar associado a muitos registros em uma tabela B, mas cada registro da tabela B está associado a apenas um da tabela A.
  - **Exemplo:** Um **Médico** atende **vários** Pacientes. (Cada Paciente é atendido por apenas **um** Médico fixo.)

- **Relacionamento N:N (Muitos para Muitos):**
  - **Definição:** Um registro na tabela A pode estar relacionado com vários registros na tabela B, e vice-versa.
  - **Exemplo:** Estudantes e Cursos. Um estudante pode se matricular em vários cursos e um curso pode ter vários estudantes.  
    (Para representar N:N, é necessária uma tabela intermediária — ex: Matricula.)
