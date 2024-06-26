require 'rails_helper'

describe 'Company API', type: :request do
  context 'GET /api/v1/companies/1' do
    it 'success' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)

      get "/api/v1/companies/#{company.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Estrelas Mágicas'
      json_response = JSON.parse(response.body)
      expect(json_response["brand_name"]).to eq 'Estrelas Mágicas'
      expect(json_response["city"]).to eq 'São Paulo'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'registration_number'
    end

    it 'list all active companies filtered by name if parameter is given' do
      owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
      owner2 = Owner.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
      company2 = Company.create!(owner_id: owner2.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                                 registration_number: '82.462.797/0001-03',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                                 address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                                 description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.',
                                 status: :inactive)
      owner3 = Owner.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@tech.com', password: 'tech7890')
      company3 = Company.create!(owner_id: owner3.id, brand_name: 'Buffet Horizonte', corporate_name: 'Buffet Horizonte Festas Ltda',
                                registration_number: CNPJ.generate, phone_number: '(31) 99876-5432', email: 'suporte@buffethorizonte.com.br',
                                address: 'Praça dos Convidados, 100', neighborhood: 'Centro Eventos', city: 'Curitiba', state: 'PR', zipcode: '80020-300',
                                description: 'Buffet Horizonte especializado em grandes eventos sociais e festividades de grande porte.', status: :inactive)

      get "/api/v1/companies/search", params: { query: 'Estrelas' }

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 1
      expect(json_response.first['brand_name']).to eq 'Estrelas Mágicas'
      expect(json_response.first['phone_number']).to eq '(11) 2233-4455'
      expect(json_response.first['city']).to eq 'São Paulo'
      expect(json_response.first['registration_number']).not_to eq '58.934.722/0001-01'
      expect(json_response.first['corporate_name']).not_to eq 'Estrelas Mágicas Buffet Infantil Ltda'
    end

    it 'lists all companies if no search parameter is given' do
      owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
      owner2 = Owner.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
      company2 = Company.create!(owner_id: owner2.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                                 registration_number: '82.462.797/0001-03',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                                 address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                                 description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.',
                                 status: :active)
      owner3 = Owner.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@tech.com', password: 'tech7890')
      company3 = Company.create!(owner_id: owner3.id, brand_name: 'Buffet Horizonte', corporate_name: 'Buffet Horizonte Festas Ltda',
                                registration_number: CNPJ.generate, phone_number: '(31) 99876-5432', email: 'suporte@buffethorizonte.com.br',
                                address: 'Praça dos Convidados, 100', neighborhood: 'Centro Eventos', city: 'Curitiba', state: 'PR', zipcode: '80020-300',
                                description: 'Buffet Horizonte especializado em grandes eventos sociais e festividades de grande porte.', status: :inactive)

      get "/api/v1/companies/search"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2

      expect(json_response.first['brand_name']).to eq 'Estrelas Mágicas'
      expect(json_response.first['phone_number']).to eq '(11) 2233-4455'
      expect(json_response.first['city']).to eq 'São Paulo'
      expect(json_response.first['registration_number']).not_to eq '58.934.722/0001-01'
      expect(json_response.first['corporate_name']).not_to eq 'Estrelas Mágicas Buffet Infantil Ltda'

      expect(json_response.second['brand_name']).to eq 'Luzes da Cidade'
      expect(json_response.second['phone_number']).to eq '(21) 3344-8899'
      expect(json_response.second['city']).to eq 'Belo Horizonte'
      expect(json_response.second['registration_number']).not_to eq '82.462.797/0001-03'
      expect(json_response.second['corporate_name']).not_to eq 'Luzes da Cidade Eventos Ltda'
    end

    it 'fails if company was not found' do
      get '/api/v1/companies/999'

      expect(response.status).to eq 404
      expect(response.body).to include 'não encontrado'
    end
  end

  context 'GET /api/v1/companies' do
    it 'list all companies' do
      owner1 = Owner.create!(name: 'Lucas', lastname: 'Ferreira', email: 'lucas@empresa.com', password: 'senha123')
      company1 = Company.create!(owner_id: owner1.id, brand_name: 'Buffet Alegria', corporate_name: 'Buffet Alegria Eventos Ltda',
                           registration_number: CNPJ.generate, phone_number: '(11) 5567-8901', email: 'contato@buffetalegria.com.br',
                           address: 'Rua das Festas, 321', neighborhood: 'Vila Festa', city: 'Rio de Janeiro', state: 'RJ', zipcode: '20031-007',
                           description: 'Buffet Alegria é especializado em eventos corporativos e festas temáticas.', status: :active)


      owner2 = Owner.create!(name: 'Mariana', lastname: 'Costa', email: 'mariana@doces.com', password: 'docepass123')
      company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet Estrela', corporate_name: 'Buffet Estrela Ltda',
                                registration_number: CNPJ.generate, phone_number: '(21) 3344-5566', email: 'vendas@buffetestrela.com.br',
                                address: 'Avenida dos Eventos, 123', neighborhood: 'Bairro Estrela', city: 'Belo Horizonte', state: 'MG', zipcode: '30120-110',
                                description: 'Buffet Estrela oferece uma experiência única com serviços completos para casamentos e eventos empresariais.',
                                status: :active)

      owner3 = Owner.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@tech.com', password: 'tech7890')
      company3 = Company.create!(owner_id: owner3.id, brand_name: 'Buffet Horizonte', corporate_name: 'Buffet Horizonte Festas Ltda',
                                registration_number: CNPJ.generate, phone_number: '(31) 99876-5432', email: 'suporte@buffethorizonte.com.br',
                                address: 'Praça dos Convidados, 100', neighborhood: 'Centro Eventos', city: 'Curitiba', state: 'PR', zipcode: '80020-300',
                                description: 'Buffet Horizonte especializado em grandes eventos sociais e festividades de grande porte.', status: :active)

      owner4 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company4 = Company.create!(owner_id: owner4.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: CNPJ.generate,  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)

      get '/api/v1/companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 4
      expect(json_response[0]["brand_name"]).to eq 'Buffet Alegria'
      expect(json_response[1]["brand_name"]).to eq 'Buffet Estrela'
      expect(json_response[2]["brand_name"]).to eq 'Buffet Horizonte'
      expect(json_response[3]["brand_name"]).to eq 'Estrelas Mágicas'
    end

    it 'only active companies' do
      owner1 = Owner.create!(name: 'Lucas', lastname: 'Ferreira', email: 'lucas@empresa.com', password: 'senha123')
      company1 = Company.create!(owner_id: owner1.id, brand_name: 'Buffet Alegria', corporate_name: 'Buffet Alegria Eventos Ltda',
                           registration_number: CNPJ.generate, phone_number: '(11) 5567-8901', email: 'contato@buffetalegria.com.br',
                           address: 'Rua das Festas, 321', neighborhood: 'Vila Festa', city: 'Rio de Janeiro', state: 'RJ', zipcode: '20031-007',
                           description: 'Buffet Alegria é especializado em eventos corporativos e festas temáticas.', status: :inactive)


      owner2 = Owner.create!(name: 'Mariana', lastname: 'Costa', email: 'mariana@doces.com', password: 'docepass123')
      company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet Estrela', corporate_name: 'Buffet Estrela Ltda',
                                registration_number: CNPJ.generate, phone_number: '(21) 3344-5566', email: 'vendas@buffetestrela.com.br',
                                address: 'Avenida dos Eventos, 123', neighborhood: 'Bairro Estrela', city: 'Belo Horizonte', state: 'MG', zipcode: '30120-110',
                                description: 'Buffet Estrela oferece uma experiência única com serviços completos para casamentos e eventos empresariais.',
                                status: :active)

      owner3 = Owner.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@tech.com', password: 'tech7890')
      company3 = Company.create!(owner_id: owner3.id, brand_name: 'Buffet Horizonte', corporate_name: 'Buffet Horizonte Festas Ltda',
                                registration_number: CNPJ.generate, phone_number: '(31) 99876-5432', email: 'suporte@buffethorizonte.com.br',
                                address: 'Praça dos Convidados, 100', neighborhood: 'Centro Eventos', city: 'Curitiba', state: 'PR', zipcode: '80020-300',
                                description: 'Buffet Horizonte especializado em grandes eventos sociais e festividades de grande porte.', status: :active)

      owner4 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company4 = Company.create!(owner_id: owner4.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: CNPJ.generate,  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :inactive)

      get '/api/v1/companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq 2
      expect(json_response.map { |c| c["brand_name"] }).to include('Buffet Estrela', 'Buffet Horizonte')
      expect(json_response.map { |c| c["brand_name"] }).not_to include('Buffet Alegria', 'Estrelas Mágicas')
    end

    it 'return empty if there is no companies' do
      get '/api/v1/companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response).to eq []
    end

    it 'return empty if company is inactive' do
      owner = Owner.create!(name: 'Lucas', lastname: 'Ferreira', email: 'lucas@empresa.com', password: 'senha123')
      company = Company.create!(owner_id: owner.id, brand_name: 'Buffet Alegria', corporate_name: 'Buffet Alegria Eventos Ltda',
                           registration_number: CNPJ.generate, phone_number: '(11) 5567-8901', email: 'contato@buffetalegria.com.br',
                           address: 'Rua das Festas, 321', neighborhood: 'Vila Festa', city: 'Rio de Janeiro', state: 'RJ', zipcode: '20031-007',
                           description: 'Buffet Alegria é especializado em eventos corporativos e festas temáticas.', status: :inactive)

      get "/api/v1/companies/#{company.id}"

      expect(response).to have_http_status(404)
      expect(response.body).to include 'não encontrado'
    end

    it 'and raise internal error' do
      allow(Company).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/companies'

      expect(response).to have_http_status(500)
      expect(response.body).to include 'Ocorreu um erro no servidor.'
    end

    it 'returns company details with average review score' do
      client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
      owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                      description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                      min_attendees: 10, max_attendees: 40, duration: 180,
                                      menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
      order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 5.days.from_now,
                              attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                              local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
      order2 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                              attendees_number: 25, details: 'Por favor, inclua comidas veganas',
                              local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
      order3 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 15.days.from_now,
                              attendees_number: 25, details: 'Por favor, inclua comidas goiabas!',
                              local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
      order4 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 20.days.from_now,
                              attendees_number: 25, details: 'Será o aniversário do meu filho de 05 anos, teremos muitas crianças.',
                              local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
      order5 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 22.days.from_now,
                              attendees_number: 25, details: 'Quais tipos de guardanapo você disponibiliza?',
                              local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

      travel_to 50.days.from_now do
        review1 = Review.create!(company_id: company.id, order: order, score: 5, text: 'Os melhores sanduíches, recomendo!')
        review2 = Review.create!(company_id: company.id, order: order2, score: 4, text: 'Foi lindo!')
        review3 = Review.create!(company_id: company.id, order: order3, score: 4, text: 'A decoração me impressionou, estava tudo perfeito!')
        review4 = Review.create!(company_id: company.id, order: order4, score: 3, text: 'As crianças se divertiram, porém faltou refrigerante!')
        review5 = Review.create!(company_id: company.id, order: order5, score: 3, text: 'Infelizmente a festa atrasou 2 horas.')

        get "/api/v1/companies/#{company.id}"

        expect(response).to have_http_status(200)
        json_response = JSON.parse(response.body)
        expect(json_response['average_score']).to eq(3.8)
      end
    end
  end
end