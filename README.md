# ByeBoletos

Implementaão do trabalho prático da Matéria de Engenharia de Software II do curso de Bacharelado em Ciência da Computação da UNESP Bauru.

### 1 Informações sobre o trabalho
#### 1.1 Título do trabalho
Aplicativo de organização de contas e boletos

#### 1.2 Membros da equipe
Gabriel de Mello Cruz, Matheus Sinto Novaes, Sarah Rodrigues Campos.

#### 1.3 Problema e justificativa
A vida adulta chega e com ela muitas responsabilidades, tantas que ficamos até perdidos nos dias. O app ByeBoletos vem para ajudar o usuário a organizar suas contas, de forma simples e rápida, para não se esquecer de pagar nenhuma e dividir os valores devidamente entre as pessoas que com ele moram.

### 2 Requisitos do sistema
#### 2.1 Requisitos funcionais
* Objeto boleto, que deve possuir os atributos: categoria, título, data de chegada, data de vencimento, valor, código, arquivo e descrição; <br>
* Cadastrar boletos de forma manual: 
  * Usuário deve inserir: Categoria, Título, Data de Chegada, Data de Vencimento e valor em reais; 
  * Usuário pode opcionalmente inserir: código do boleto, descrição;
  * Upload do arquivo do boleto (PDF ou imagem);
* Cadastrar boletos através de assistente virtual (Exemplo: “Alexa, cadastrar boleto”);
* Cadastrar boletos pelo reconhecimento de imagem ou PDF (uso de OCR e Regex);
* Cadastrar boleto de forma automática através de cadastro de e-mail (utilização de modelo de machine learning para entender que tipo de e-mail acompanha um boleto ou uma conta);
* Consultar boletos
  * Os boletos serão ordenados pela data de vencimento em ordem crescente;
  * Filtrar os boletos por data de vencimento, categoria, código.
* Objeto usuário, que deve possuir os atributos: nome, e-mail, senha, telefone;
* Cadastrar usuário;
* Existência de categorias, que serão atreladas aos boletos (Água, Luz/ Energia, Aluguel, Condomínio, IPVA, IPTU, Internet);
* Permitir o cadastro de novas categorias, alteração e exclusão de categorias existentes;
* Gerar notificação push para 
  * alguns dias antes do vencimento, definido pelo usuário;
    * Exemplo: “Faltam %Dias_Faltantes dias para seu boleto de %Categoria vencer!”
  * dia do vencimento, num horário definido pelo usuário;
    * Exemplo: “Seu boleto de %Categoria vence hoje, não se esqueça de pagar!”
  * dia da chegada do boleto, mantendo o dia e horário em que o boleto foi cadastrado.
    * Exemplo: “Ei! Seu boleto de %Categoria já chegou? Não se esqueça de cadastrá-lo.”
* Dividir contas que devem ser pagas em conjunto:
  * Definir quantidade de pessoas com quem a conta deve ser dividida.
  * Cadastrar os usuários que devem pagar a conta para que esta fique disponível em seu aplicativo também;
  * Não obrigar o cadastro de usuário para divisão de conta, podendo definir somente um número de pessoas

#### 2.2 Requisitos não funcionais
* O sistema deverá ser um aplicativo mobile;
* O sistema deverá executar em iOS e Android;
* Utilização de um Kit de desenvolvimento de interface do usuário que permita a criação de aplicativos compilados nativamente para diversos sistemas. No caso, utilizará o framework Flutter e a linguagem de programação Dart;
* A usabilidade deve ser imediata, facilitada por uma interface simples;
* O sistema deve ter alta disponibilidade, o usuário deve conseguir usá-lo a qualquer momento;
* O banco utilizado será SQLite;
* Cadastro de boletos e notificações independentes de conexão com a Internet;
* O sistema deverá assegurar as informações pessoais do usuário.

### 3 Modelos de análise

