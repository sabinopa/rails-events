require 'rails_helper'

describe 'Company API', type: :request do
  context 'GET /api/v1/companies/1' do
    it 'success' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

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

    it 'list all companies filtered by name if parameter is given' do
      owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      owner2 = Owner.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
      company2 = Company.create!(owner_id: owner2.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                                 registration_number: '82.462.797/0001-03',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                                 address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                                 description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.')

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
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      owner2 = Owner.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
      company2 = Company.create!(owner_id: owner2.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                                 registration_number: '82.462.797/0001-03',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                                 address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                                 description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.')

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
    end
  end

  context 'GET /api/v1/companies' do
    it 'list all companies' do
      owner1 = Owner.create!(name: 'Lucas', lastname: 'Ferreira', email: 'lucas@empresa.com', password: 'senha123')
      company1 = Company.create!(owner_id: owner1.id, brand_name: 'Buffet Alegria', corporate_name: 'Buffet Alegria Eventos Ltda',
                           registration_number: CNPJ.generate, phone_number: '(11) 5567-8901', email: 'contato@buffetalegria.com.br',
                           address: 'Rua das Festas, 321', neighborhood: 'Vila Festa', city: 'Rio de Janeiro', state: 'RJ', zipcode: '20031-007',
                           description: 'Buffet Alegria é especializado em eventos corporativos e festas temáticas.')


      owner2 = Owner.create!(name: 'Mariana', lastname: 'Costa', email: 'mariana@doces.com', password: 'docepass123')
      company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet Estrela', corporate_name: 'Buffet Estrela Ltda',
                                registration_number: CNPJ.generate, phone_number: '(21) 3344-5566', email: 'vendas@buffetestrela.com.br',
                                address: 'Avenida dos Eventos, 123', neighborhood: 'Bairro Estrela', city: 'Belo Horizonte', state: 'MG', zipcode: '30120-110',
                                description: 'Buffet Estrela oferece uma experiência única com serviços completos para casamentos e eventos empresariais.')

      owner3 = Owner.create!(name: 'Carlos', lastname: 'Silva', email: 'carlos@tech.com', password: 'tech7890')
      company3 = Company.create!(owner_id: owner3.id, brand_name: 'Buffet Horizonte', corporate_name: 'Buffet Horizonte Festas Ltda',
                                registration_number: CNPJ.generate, phone_number: '(31) 99876-5432', email: 'suporte@buffethorizonte.com.br',
                                address: 'Praça dos Convidados, 100', neighborhood: 'Centro Eventos', city: 'Curitiba', state: 'PR', zipcode: '80020-300',
                                description: 'Buffet Horizonte especializado em grandes eventos sociais e festividades de grande porte.')

      owner4 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company4 = Company.create!(owner_id: owner4.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: CNPJ.generate,  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

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

    it 'return empty if there is no companies' do
      get '/api/v1/companies'

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response).to eq []
    end

    it 'and raise internal error' do
      allow(Company).to receive(:all).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/companies'

      expect(response).to have_http_status(500)
      expect(response.body).to include 'Ocorreu um erro no servidor.'
    end
  end
end