# Leilão de Estoque
<img src="http://img.shields.io/static/v1?label=Desenvolvimento&message=Em%20Desenvolvimento&color=blue&style=for-the-badge"/>
<img src="http://img.shields.io/static/v1?label=Code%20Review&message=Nao%20Inicializado&color=red&style=for-the-badge"/>

## Sumário
1. [Premissa do Projeto](#premissa-do-projeto)

2. [Funcionalidades](#funcionalidades)

3. [Testes](#testes)

4. [Configurações](#configurações)

## Premissa do Projeto
Após o [Sistema de Galpões](https://github.com/noliv197/warehouse-app), o cliente agora quer tratar de um novo problema: em todos os galpões existem itens que já saíram de linha ou possuem pequenos defeitos e que, por isso, não podem mais ser comercializados nas redes de varejo e outros estabelecimentos.
Neste projeto será desenvolvido uma aplicação web com Ruby on Rails que servirá para conectar o público em geral com o estoque de itens abandonados, permitindo que estes itens sejam comercializados com preços atrativos e que, ao mesmo tempo, os galpões tenham seus espaços melhor aproveitados. O formato escolhido pelo nosso cliente é o de leilão de itens.

## Funcionalidades
1. CRUD 
    * criação, edição e visualização de lotes
    * criação, edição e visualização de items
    * criação e visualização de lances
    * criação de usuários
2. Autenticação via Login
3. Autorização via credenciais
    * visitantes: só tem acesso a visualização de lotes aprovados em andamento
    * clientes: 
        * podem visualizar lotes aprovados em andamento
        * podem fazer um lance em lotes aprovados em andamento
        * tem acesso ao resultado de lotes encerrados que ganhou
    * administradores
        * podem criar lotes e editá-los se tiverem com status aguradando aprovação
        * podem criar items e editá-los se tiverem com status disponível
        * podem adicionar e/ou deletar itens de lotes aguradando aprovação
        * podem aprovar lotes que tenham pelo menos 1 item, desde que o tenhma criado
        * podem encerrar e cancelar lotes expirados
4. Adição e remoção de itens em lotes
5. Lances feitos apenas por clientes

## Testes
### Usuário
* Modelo
    - testa se campos estão vazios:
        - email
        - senha
        - cpf
    - testa se campos tem um único registro
        - email
        - cpf
    - testa se `senha` tem no mínimo 6 caracteres
    - testa se `cpf` é considerado válido
    - testa se as credenciais certas foram 

* Visualização do Usuário
    - Cadastro de novo usuário com
        - email
        - senha
        - cpf
    - Login de cliente
        - vê navegação do cliente
    - Login de administrador
        - vê navegação do adminsitrador
    - Logout de usuário

### Lotes
* Modelo
    - testa se campos estão vazios: 
        - código
        - data de inicio
        - data limite
        - lance minimo
        - diferença entre lances
    - testa se `lance minimo` é maior que 0 e se a `diferença mínima entre lances` é maior que 1
    - testa se código é único e se ele tem 3 letras e 6 números
    - testa se data inicio não está no passado
    - testa se data limite não é anterior a data de inicio

* Visualização do Usuário
    - Lotes em andamento e futuros na página inicial
    - Ao clicar no link de um lote, vê detalhes do lote e itens
* Visualização do Administrador   
    - Cadastro de um novo lote, fornecendo:
        - código
        - data de inicio
        - data limite
        - lance mínimo
        - diferença mínima entre lances
    - Edição de lotes com status pendente
    - Adição e remoção de itens à lotes
    - Aprovação de lotes
    - Finalizar/Cancelar lotes
* Visualização do Cliente
    - vê se ganhou um lote finalizado que fez lance
    - vê se perdeu um lote finalizado que fez lance

### Itens
* Modelo
    - testa se campos estão vazios: 
        - nome
        - descrição
        - imagem
        - peso
        - altura
        - largura
        - profundidade
        - categoria
    - testa se `peso` , `altura`, `largura`, `profundidade` é maior que 0
    - testa se código é único e se não é alterado após mudanças no objeto

* Visualização do Administrador
    - Cadastro de um novo item com 
        - nome
        - descrição
        - categoria
        - imagem
        - peso
        - altura
        - largura
        - profundidade
    - Edição de itens com status disponível

### Associação entre item e lote
* Modelo
    - testa se o item só está associado a um lote

### Lances
* Modelo
    - teste se valor do lance está em branco
    - testa se só clientes podem fazer o lance
    - testa se lance é maior ou igual ao lance mínimo
    - testa se o cliente não está fazendo vários lances seguidos
    - testa se lance é menor que a diferença entre lances
    - testa se o lance está sendo feito em lotes encerrados/cancelados
    - testa se o lance está sendo feito para um lote expirado

* Visualização do Cliente
    - formulário só está disponível para usuários autenticados
    - contabilização do primeiro lance é feito com sucesso
    - contabilização do segundo lance é feito com sucesso

## Configurações
### Como Rodar a Aplicação
0. Verifique se o ruby e rails estão instalados na sua máquina
1. Primerio faça o clone do repositório na sua máquina
    
    ```
    git clone https://github.com/noliv197/auction-app.git 
    ```
2. Rode o comando a baixo para baixar todos as gems usadas na aplicação
    
    ```
    bundle install
    ```
3. Para configurar o banco de dados inicial rode o comando
    
    ```
    rails db:seed
    ``` 
4. Rode o comando abaixo para subir a aplicação no modo de desenvolvimento
   
    ```
    rails server
    ```
5. Existem três usuários previamente cadastrados para facilitar a navegação
    * `creator@leilaodogalpao.com.br` é uma conta de administrador que fez os cadastros de lotes que já estão cadastrados no sistema;
    * `admin@leilaodogalpao.com.br` é outra conta de administrador para testes de aprovação de lotes;
    * `client@email.com.br` é uma conta de cliente que pode fazer lances;
    * A senha de todas as contas é `12345678`;

### Ferramentas
* Ruby -> versão 3.0.2 
* Rails -> versão 7.0.4 
### Gems
* Sqlite -> banco de dados
* Rspec -> para testes
* Capybara -> para testes
* Devise -> para autenticação
* ActiveStorage -> para armazenamento e anexo de imagens
