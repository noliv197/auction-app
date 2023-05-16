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
## Testes
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
    - Cadastro de um novo lote, fornecendo:
        - código
        - data de inicio
        - data limite
        - lance mínimo
        - diferença mínima entre lances
### Modelo de Itens
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

* Visualização do Usuário
    - Cadastro de um novo item
        - nome
        - descrição
        - categoria
        - imagem
        - peso
        - altura
        - largura
        - profundidade
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

* Visualização do Usuário
    - Cadastro de novo usuário
        - email
        - senha
        - cpf
    - Login de cliente
        - vê lotes disponiveis
        - pode fazer lance
        - vê resultados de lotes que fizeram lances
    - Login de administrador
        - vê e tem permissão para criar lotes
        - vê e tem permissão para criar itens
        - aprova lote
        - adiciona/remove itens de um lote

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
