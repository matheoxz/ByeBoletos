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
#### 3.1 Diagrama de casos de uso
<br>

![alt text](https://github.com/matheoxz/ByeBoletos/blob/main/.images%20readme/C%C3%B3pia%20de%20ByeBoletos%20Caso%20de%20Uso.png)

<br>

#### 3.2 Diagrama de classes
<br>

![picture alt](https://github.com/matheoxz/ByeBoletos/blob/main/.images%20readme/classes.png)

<br>

#### 3.3 Modelo Conceitual
<br>

![picture alt](https://github.com/matheoxz/ByeBoletos/blob/main/.images%20readme/conceitual.png)

<br>

#### 3.4 Modelo de Dados
<br>

![picture alt](https://github.com/matheoxz/ByeBoletos/blob/main/.images%20readme/Dados.png)

<br>

### 4 Descrição das tecnologia escolhidas (ex: linguagens de programação, ferramentas de desenvolvimento, APIs, ferramentas de teste, gerenciador de banco de dados, sistemas operacionais alvo, etc)
<br>
As tecnologias escolhidas para o projeto são a linguagem de programação Dart e o SDK Flutter, o gerenciador de banco de dados será o SQLite3, com os sistemas operacionais alvo sendo Android e iOS. <br>
O SDK Flutter permite o desenvolvimento simultâneo em Android e iOS, gerando uma aplicação capaz de rodar de forma nativa em ambos sem alterações no código de uma plataforma para outra. O SDK é para a linguagem Dart, ambos são desenvolvidos pela Google e iniciativas Open Source. O SDK permite o desenvolvimento de UI flexível e de forma rápida e simples. <br>
O SGBD escolhido é o SQLite3 pois trata-se de um gerenciador local para esquemas simples, assim, as informações ficam armazenadas no celular do usuário em primeiro momento, sem necessidade de configurar um servidor para o banco de dados. Para funcionalidades que não serão demonstradas, como a de cadastro de usuário e divisão de contas, seria necessário um servidor para a aplicação, mas para simplificação, foi escolhido o armazenamento local. A interface entre o SGBD e a linguagem de programação escolhida é feita pelo pacote sqflite. <br>
Para a fácil programação e exibição das notificações foi escolhido o uso do pacote  flutter_local_notifications.
O editor de código escolhido é o VSCode, para trabalhar em grupo utilizaremos a extensão LiveShare. O versionamento do código será feito através do GitHub. <br>

### 7 Projeto de interface com o usuário
<br>

![picture alt](https://github.com/matheoxz/ByeBoletos/blob/main/.images%20readme/1_Home.png)

<br>

![picture alt](https://github.com/matheoxz/ByeBoletos/blob/main/.images%20readme/2_Configura%C3%A7%C3%B5es.png)

<br>

![picture alt](https://github.com/matheoxz/ByeBoletos/blob/main/.images%20readme/3_Adicionar_Boleto.png)

<br>

