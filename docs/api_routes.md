# Rotas disponíveis e seus retornos

# 📑 Sumário

  1. [Companies]</br>
    * 1.1 - [GET ```/api/v1/companies```]</br>
    * 1.2 - [GET ```/api/v1/companies/:id```]</br>
    * 1.3 - [GET ```/api/v1/companies/:id/event_types```]</br>
    * 1.4 - [GET ```/api/v1/companies?search=palavra_da_busca```]
  2. [Availability]</br>
    * 2.1 [GET ```/api/v1/companies/:company_id/event_types/:id/availability```]</br>

##  🏢 1. Companies

Retorna listas e/ou detalhes de empresas cadastradas.
</br>
### 🏢🏢 1.1 GET ```/api/v1/companies```

Retorna um hash de empresas cadastradas.

```json
[
  {
    "id": 1,
    "brand_name": "Celebração Alegre",
    "phone_number": "(11) 98765-4321",
    "email": "contato@celebracaoalegre.com.br",
    "address": "Rua das Flores, 123",
    "neighborhood": "Jardim Primavera",
    "city": "São Paulo",
    "state": "SP",
    "zipcode": "01234-567",
    "description": "Especializados em casamentos e eventos corporativos, oferecemos um serviço completo de buffet com uma vasta opção de cardápios personalizados.",
    "owner_id": 1
  },
  {
    "id": 2,
    "brand_name": "Festim dos Sonhos",
    "phone_number": "(21) 4444-5555",
    "email": "sonhos@festim.com.br",
    "address": "Avenida Central, 456",
    "neighborhood": "Centro",
    "city": "Rio de Janeiro",
    "state": "RJ",
    "zipcode": "21000-000",
    "description": "Com uma equipe de chefs renomados, proporcionamos uma experiência culinária inesquecível para seu evento.",
    "owner_id": 2
  },
  {
    "id": 3,
    "brand_name": "Gastronomia Estelar",
    "phone_number": "(31) 6666-7777",
    "email": "contato@gastronomiaestelar.com.br",
    "address": "Praça da Liberdade, 789",
    "neighborhood": "Savassi",
    "city": "Belo Horizonte",
    "state": "MG",
    "zipcode": "30140-010",
    "description": "Oferecemos um serviço exclusivo de buffet e catering com foco em ingredientes orgânicos e sustentáveis.",
    "owner_id": 3
  }]
```

</br>

### 🏢 ⬅️  1.2 GET ```/api/v1/companies/:id```

Retorna um hash com todos os detalhes da empresa [:id], exceto CNPJ e Razão Social.

```json
{
  "id": 1,
  "brand_name": "Celebração Alegre",
  "phone_number": "(11) 98765-4321",
  "email": "contato@celebracaoalegre.com.br",
  "address": "Rua das Flores, 123",
  "neighborhood": "Jardim Primavera",
  "city": "São Paulo",
  "state": "SP",
  "zipcode": "01234-567",
  "description": "Especializados em casamentos e eventos corporativos, oferecemos um serviço completo de buffet com uma vasta opção de cardápios personalizados.",
  "owner_id": 1
}
```
</br>

#### 🏢 ⬅️  Possíveis Erros:

404 Not Found: Se o ID da empresa não for encontrado

```json
{
  "errors": "O id informado não foi encontrado."
}
```

### 🎉🔍 1.3 - GET ```/api/v1/companies/:id/event_types```

Retorna um hash com todos os tipos de eventos cadastrados pela empresa especificada pelo ID.

```json
[
  {
    "id": 1,
    "name": "Casamento dos Sonhos",
    "description": "O nosso pacote \"Casamento dos Sonhos\" é o ápice da sofisticação e do romance. Com um serviço de buffet personalizado, decoração floral deslumbrante e uma equipe dedicada a tornar cada detalhe perfeito, garantimos que seu dia especial seja inesquecível.",
    "min_attendees": 50,
    "max_attendees": 300,
    "duration": 480,
    "menu_description": "Uma seleção gourmet que inclui entradas frias e quentes, pratos principais sofisticados com opções vegetarianas, veganas e sem glúten, além de uma estação de sobremesas com doces finos e um bolo de casamento personalizado.",
    "alcohol_available": true,
    "decoration_available": true,
    "parking_service_available": true,
    "location_type": "off_site",
    "company_id": 1
  },
  {
    "id": 2,
    "name": "Gala Corporativa Elegante",
    "description": "Nossa Gala Corporativa Elegante é a escolha perfeita para empresas que desejam impressionar. Oferecemos um ambiente sofisticado, com serviço de buffet de alto padrão, apresentações audiovisuais de última geração e uma equipe pronta para atender todas as necessidades empresariais.",
    "min_attendees": 100,
    "max_attendees": 500,
    "duration": 300,
    "menu_description": "Um buffet exclusivo que inclui canapés gourmet, estações de comida ao vivo, pratos internacionais elaborados e uma ampla seleção de bebidas holiday, incluindo coquetéis personalizados e vinhos selecionados.",
    "alcohol_available": true,
    "decoration_available": true,
    "parking_service_available": true,
    "location_type": "any_site",
    "company_id": 1
  }
]
```

### 🏢🔍 1.4 - GET ```/api/v1/companies/search?query=palavra_da_busca```

Query Params: search - Realiza busca por empresas com base em seus nomes, cidades e tipos de eventos.
O resultado da busca é um hash contendo as empresas encontradas.

Exemplo: Buscar por "Alegre"

```json
{
  "id": 1,
  "brand_name": "Celebração Alegre",
  "phone_number": "(11) 98765-4321",
  "email": "contato@celebracaoalegre.com.br",
  "address": "Rua das Flores, 123",
  "neighborhood": "Jardim Primavera",
  "city": "São Paulo",
  "state": "SP",
  "zipcode": "01234-567",
  "description": "Especializados em casamentos e eventos corporativos, oferecemos um serviço completo de buffet com uma vasta opção de cardápios personalizados.",
  "owner_id": 1
}
```

#### 🏢 ⬅️  Possíveis Erros:

404 Not Found: Se a busca não encontrar nenhuma empresa correspondente.

```json
{
  "errors": "Nenhuma empresa encontrada com os critérios fornecidos."
}
```

##  🎉🆓 2. Availability

Retorna resposta sobre a disponibilidade do tipo evento de uma empresa para a data requisitada, o tipo de dia e a quantidade específica de convidados.

### 2.1 GET ```/api/v1/companies/:company_id/evet_types/:id/availability```

Parâmetros obrigatórios:

- Data do Evento [:date]
- Tipo de dia [:day_type]
- Número de Convidados [:number_attendees]

Exemplos:
```/api/v1/companies/2/event_types/1/availability?date=YYYY-MM-DD&day_type=YYYY-MM-DD&number_attendees=100``` | </br>
```/api/v1/companies/2/event_types/1/availability?date=2024-12-10&day_type=weekend&number_attendees=100```

```json
{
  "available": true,
  "estimated_price": "2500.0"
}
```
#### 🏡⬅️  Possíveis Erros:


_406 Not Acceptable_: Se o número de convidados estiver fora do intervalo permitido.

```json
{
  "errors": "Número de convidados fora do intervalo permitido."
}
```

_406 Not Acceptable_: Se não houver disponibilidade para a data selecionada.
```json
{
  "errors": "Não há disponibilidade para a data selecionada."
}
```
