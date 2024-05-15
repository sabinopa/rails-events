# 🎂🥂 Cadê Buffet? - Plataforma de contratação de buffets

![Static Badge](https://img.shields.io/badge/Ruby_3.3.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white)
![Static Badge](https://img.shields.io/badge/Ruby_on_Rails_7.1.3-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white)
![Bootstrap](https://img.shields.io/badge/bootstrap-%238511FA.svg?style=for-the-badge&logo=bootstrap&logoColor=white)

![Static Badge](https://img.shields.io/badge/COBERTURA_DE_TESTES-100%25-blue)
![Static Badge](https://img.shields.io/badge/STATUS-EM_DESENVOLVIMENTO-green)

## 📑 Tópicos

▶️ [Descrição do projeto](#descrição-do-projeto)

▶️ [Funcionalidades](#funcionalidades)

▶️ [Gems utilizadas](#gems-utilizadas)

▶️ [APIs](#apis)

▶️ [Pré-requisitos](#pré-requisitos)

▶️ [Como executar a aplicação](#como-executar-a-aplicação)

▶️ [Como executar os testes](#como-executar-os-testes)

▶️ [Navegação](#navegação)

▶️ [Criação de Contas Fictícias](#criação-de-contas-fictícias)


## Descrição do Projeto
📍 Cadê Buffet? é uma plataforma desenvolvida em Rails que facilita a busca e contratação de empresas especializadas em buffets para eventos diversos, como festas, casamentos e eventos corporativos. A aplicação oferece uma série de funcionalidades para donos de empresas e clientes, visando proporcionar uma experiência completa e eficiente na organização de eventos.


## Funcionalidades

### Para Donos de Empresas: 🏢
- [x]  **Cadastro de Conta:** Os donos de empresas podem criar uma conta informando seu e-mail e senha.
- [x]  **Cadastro de Empresa:** Após criar uma conna partta, o dono de empresa deve cadastrar sua empresa com informações detalhadas, incluindo nome fantasia, razão social, CNPJ, telefone para contato, e-mail para contato, endereço completo, descrição e meios de pagamento aceitos.
- [x]  **Cadastro de Tipos de Eventos:** Os donos de empresas podem cadastrar os tipos de eventos que realizam, incluindo nome, descrição, quantidade mínima e máxima de pessoas, duração padrão do evento, cardápio, disponibilidade de bebidas alcoólicas, decoração e serviço de estacionamento. Também podem indicar se o evento deve ser realizado exclusivamente no endereço da empresa ou em um endereço indicado pelo contratante.
- [x]  **Definição de Preços por Tipo de Evento:** Para cada tipo de evento, o dono de empresa pode definir os preços-base, incluindo valor mínimo e valor adicional por pessoa. Também pode cadastrar valores de hora extra do evento e diferenciar os preços para dias da semana, fins de semana e feriados.
- [x]  **Avaliação de Pedidos:** Os dono podem visualizar e avaliar os pedidos recebidos, decidindo se aceitam ou não a execução do evento, podendo aplicar taxas extras ou desconto.
- [x]  **Acompanhamento de Pedidos:** Os donos de empresas podem acompanhar todos os pedidos realizados através da tela "Pedidos", onde podem ver detalhes dos pedidos e aprovar sua execução.
- [x] **Gerenciamento de Status da Empresa:** Os donos de empresas podem alterar o status de suas empresas para ativo ou inativo. Empresas inativas não são listadas nas buscas e não podem receber novos pedidos.
- [x] **Gerenciamento de Status dos Tipos de Eventos:** Donos de empresas podem alterar o status dos tipos de eventos para ativo ou inativo. Tipos de eventos inativos não são exibidos para os clientes e não podem receber novos pedidos.

### Para Clientes: 🚶‍♂️🚶‍♀️🚶
- [x]  **Cadastro de Conta:** Os clientes podem criar uma conta informando nome, CPF, e-mail e senha.
- [x]  **Busca de Buffets:** Os visitantes podem buscar buffets pelo nome fantasia da empresa, cidade ou tipos de festas realizadas.
- [x]  **Visualização de Detalhes das empresas:** Os visitantes podem visualizar detalhes das empresas, incluindo todas as informações cadastradas, exceto a razão social.
- [x]  **Visualização de Tipos de Eventos:** Os visitantes podem ver os tipos de eventos oferecidos por um empresa, incluindo todas as informações cadastradas, incluindo os preços.
- [x]  **Realização de Pedidos:** Os clientes podem fazer pedidos para uma empresa, incluindo informações como tipo de evento, data desejada, quantidade estimada de convidados e detalhes adicionais sobre o evento.
- [x]  **Acompanhamento de Pedidos:** Os clientes podem acompanhar todos os pedidos realizados através da tela "Meus Pedidos", onde podem ver detalhes dos pedidos e confirmar sua execução.

### Comunicação entre Dono de Buffet e Cliente: 📬
- [x]  **Troca de Mensagens:** O dono de empresa pode enviar mensagens para o cliente para tirar dúvidas em relação ao evento, e o cliente pode responder a essas mensagens.
- [x]  **Exibição de Mensagens:** Todas as mensagens trocadas entre o dono de emoresa e o cliente são exibidas nas respectivas telas de visualização de detalhes de um pedido.
- [x]  **Exibição de Data e Hora:** As mensagens exibem a data e hora em que foram enviadas.

## Avaliações e Feedbacks: 🌟
- [x] **Avaliações de Eventos:** Clientes que tiveram pedidos confirmados podem avaliar a empresa após a data de realização do evento. A avaliação deve conter uma nota de 0 a 5, um texto e, opcionalmente, pode conter fotos.
- [x] **Nota Média de Avaliação:** A partir das notas obtidas, deve ser exibida a nota média de avaliação da empresa em sua página.
- [x] **Visualização de Avaliações:** Visitantes e clientes podem ver as últimas 3 avaliações cadastradas por outros usuários. Existem a opção de acessar uma página com todas as avaliações daquela empresa.

### Gems utilizadas

- [Devise](https://github.com/heartcombo/devise)
- [Rspec](https://github.com/rspec/rspec-rails)
- [Simplecov](https://github.com/simplecov-ruby/simplecov)
- [Capybara](https://github.com/teamcapybara/capybara)
- [CPF/CNPJ](https://github.com/fnando/cpf_cnpj)
- [Validators](https://github.com/fnando/validators)

### APIS

🔐 Acesse a documentação de APIS presentes no projeto [aqui](https://github.com/sabinopa/rails-events/blob/main/docs/api_routes.md).

### Pré-requisitos

🚨 [Ruby v3.3.0](https://www.ruby-lang.org/pt/)

🚨 [Rails v7.1.3.2](https://guides.rubyonrails.org/)

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

>Se você encontrar algum erro ao executar o `rails db:seed`, siga estes passos para resolver:
>
>- Abra o Rails console para verificar se há problemas específicos com o ambiente ou as dependências:
>```
>rails console
>```
>
>- Dentro do console, simplesmente digite `exit` para sair.
>
>- Tente executar o `rails db:seed` novamente
>```
>rails db:seed
>```
>
>- Este processo pode ajudar a resolver questões de inicialização ou cache que possam >estar interferindo com a população inicial do banco de dados.
>

- Execute a aplicação
```
rails server
```

- Acesse a aplicação no link http://localhost:3000/

### Como executar os testes

Se o servidor Rails estiver rodando, será necessário pará-lo para evitar interferências durante a execução dos testes. Siga os passos detalhados abaixo:

- Interrompa o servidor Rails:

Se o servidor estiver em execução, você pode interrompê-lo pressionando `Ctrl + C` no terminal onde o servidor está ativo. Isso irá parar o processo do servidor, liberando o terminal para outras tarefas.

- Instale as dependências:

Certifique-se de que todas as dependências necessárias estão instaladas antes de iniciar os testes. Caso ainda não tenha feito isso, execute o comando:
```
bundle install
```

Este comando irá instalar todas as gems listadas no Gemfile, garantindo que nada falte para a execução dos testes.

- Execute os testes:

Com as dependências instaladas e o servidor interrompido, execute o comando abaixo para iniciar os testes:
```
rspec
```

Este comando irá rodar todos os testes definidos nos seus arquivos de teste RSpec.

- Verifique a cobertura de testes:

Após a execução dos testes, você pode verificar a cobertura de testes do projeto. A plataforma Cadê Buffet? mantém uma cobertura de 100%, e o relatório detalhado pode ser visualizado executando:
```
open coverage/index.html
```
Este comando abrirá o relatório de cobertura no seu navegador padrão, permitindo visualizar quais linhas de código foram cobertas pelos testes.

### Navegação

🧭 Para acessar páginas que requerem autenticação, utilize as contas abaixo:

|     Usuário      |          E-mail         |    Senha    |
|------------------|-------------------------|-------------|
|  Dono de Empresa |   priscila@email.com    |   12345678  |
|     Cliente      |      joao@email.com     |   senha123  |

### Criação de Contas Fictícias

🧑‍💻 **Testando a Plataforma:**

Para testar a plataforma Cadê Buffet? como dono de empresa ou cliente, é necessário criar contas com CPFs ou CNPJs válidos. Recomendamos a utilização de serviços de geração de números de CPF e CNPJ válidos para garantir que a experiência de teste reflita com precisão o comportamento esperado em um cenário de uso real.

#### Recomendação de Ferramentas para Geração de CPF/CNPJ:

**Gerador de CPF/CNPJ:** Você pode usar sites como [4Devs](https://www.4devs.com.br/) para gerar números válidos que podem ser usados para cadastro na plataforma.





