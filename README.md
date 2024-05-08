# Cadê Buffet? - Plataforma de contratação de buffets

![Static Badge](https://img.shields.io/badge/Ruby_3.3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Static Badge](https://img.shields.io/badge/Ruby_on_Rails_7.0.6-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)

![Static Badge](https://img.shields.io/badge/COBERTURA_DE_TESTES-98.99%25-blue)

![Static Badge](https://img.shields.io/badge/STATUS-EM_DESENVOLVIMENTO-green)

## Tópicos

:arrow_forward: [Descrição do projeto](#descrição-do-projeto)

:arrow_forward: [Funcionalidades](#funcionalidades)

:arrow_forward: [Gems utilizadas](#gems-utilizadas)

:arrow_forward: [APIs](#apis)

:arrow_forward: [Pré-requisitos](#pré-requisitos)

:arrow_forward: [Como executar a aplicação](#como-executar-a-aplicação)

:arrow_forward: [Como executar os testes](#como-executar-os-testes)

:arrow_forward: [Navegação](#navegação)

## Descrição do Projeto
Cadê Buffet? é uma plataforma desenvolvida em Rails que facilita a busca e contratação de empresa especializadas em buffets para eventos diversos, como festas, casamentos e eventos corporativos. A aplicação oferece uma série de funcionalidades para fornecedores e clientes, visando proporcionar uma experiência completa e eficiente na organização de eventos.

## Funcionalidades

### Para Fornecedores (donos de empresas):
- [x]  **Cadastro de Conta:** Os fornecedores podem criar uma conta informando seu e-mail e senha.
- [x]  **Cadastro de Empresa:** Após criar uma conta, o fornecedor deve cadastrar sua empresa com informações detalhadas, incluindo nome fantasia, razão social, CNPJ, telefone para contato, e-mail para contato, endereço completo, descrição e meios de pagamento aceitos.
- [x]  **Cadastro de Tipos de Eventos:** Os fornecedores podem cadastrar os tipos de eventos que realizam, incluindo nome, descrição, quantidade mínima e máxima de pessoas, duração padrão do evento, cardápio, disponibilidade de bebidas alcoólicas, decoração e serviço de estacionamento. Também podem indicar se o evento deve ser realizado exclusivamente no endereço do buffet ou em um endereço indicado pelo contratante.
- [x]  **Definição de Preços por Tipo de Evento:** Para cada tipo de evento, o fornecedor pode definir os preços-base, incluindo valor mínimo e valor adicional por pessoa. Também pode cadastrar valores de hora extra do evento e diferenciar os preços para dias da semana e fins de semana.
- [x]  **Avaliação de Pedidos:** Os fornecedores podem visualizar e avaliar os pedidos recebidos, decidindo se aceitam ou não a execução do evento.

### Para Clientes:
- [x]  **Cadastro de Conta:** Os clientes podem criar uma conta informando nome, CPF, e-mail e senha.
- [x]  **Busca de Buffets:** Os visitantes podem buscar buffets pelo nome fantasia da empresa, cidade ou tipos de festas realizadas.
- [x]  Visualização de Detalhes das empresas: Os visitantes podem visualizar detalhes das empresas, incluindo todas as informações cadastradas, exceto a razão social.
- [x]  **Visualização de Tipos de Eventos:** Os visitantes podem ver os tipos de eventos oferecidos por um empresa, incluindo todas as informações cadastradas, incluindo os preços.
- [x]  **Realização de Pedidos:** Os clientes podem fazer pedidos para uma empresa, incluindo informações como tipo de evento, data desejada, quantidade estimada de convidados e detalhes adicionais sobre o evento.
- [x]  **Acompanhamento de Pedidos:** Os clientes podem acompanhar todos os pedidos realizados através da tela "Meus Pedidos", onde podem ver detalhes dos pedidos e confirmar sua execução.

### Comunicação entre Dono de Buffet e Cliente:
- [x]  **Troca de Mensagens:** O fornecedor pode enviar mensagens para o cliente para tirar dúvidas em relação ao evento, e o cliente pode responder a essas mensagens.
- [x]  **Exibição de Mensagens:** Todas as mensagens trocadas entre o fornecedor e o cliente são exibidas nas respectivas telas de visualização de detalhes de um pedido.
- [x]  **Exibição de Data e Hora:** As mensagens exibem a data e hora em que foram enviadas.

### Gems utilizadas
- [Devise](https://github.com/heartcombo/devise)
- [Rspec](https://github.com/rspec/rspec-rails)
- [Capybara](https://github.com/teamcapybara/capybara)
- [CPF/CNPJ](https://github.com/fnando/cpf_cnpj)
- [Validators](https://github.com/fnando/validators)
- [Simplecov](https://github.com/simplecov-ruby/simplecov)

### APIS

(...)

### Pré-requisitos

:heavy_exclamation_mark: [Ruby v3.3.0](https://www.ruby-lang.org/pt/)

:heavy_exclamation_mark: [Rails v7.1.3.2](https://guides.rubyonrails.org/)

### Como executar a aplicação
- Clone este repositório
```
git clone https://github.com/sabinopa/rails-events
```

- Abra o diretório pelo terminal
```
cd rails-events
```

- Instale o Bundle pelo terminal
```
bundle install
```

- Crie e popule o banco de dados
```
rails db:migrate
rails db:seed
```

- Execute a aplicação
```
rails server
```

- Acesse a aplicação no link http://localhost:3000/

### Como executar os testes

```
rspec
```

### Navegação
Para acessar páginas que requerem autenticação, utilize as contas abaixo:

|   Usuário   |          E-mail         |    Senha    |
|-------------|-------------------------|-------------|
|  Fornecedor |   priscila@email.com    |   12345678  |
|   Cliente   |      joao@email.com     |   senha123  |



