require 'rails_helper'

describe 'Guesthouse API', type: :request do
  context 'GET /api/v1/companies/1' do
    it 'success' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

      get "/api/v1/companies/#{company.id}"

      expect(response.status).to eq 200
      expect(response.content_type).to include 'application/json'
      expect(response.body).to include 'Estrelas Mágicas'
      json_response = JSON.parse(response.body)
      puts "json_response #{json_response}"
      expect(json_response["brand_name"]).to eq 'Estrelas Mágicas'
      expect(json_response["city"]).to eq 'São Paulo'
      expect(json_response.keys).not_to include 'created_at'
      expect(json_response.keys).not_to include 'updated_at'
      expect(json_response.keys).not_to include 'corporate_name'
      expect(json_response.keys).not_to include 'registration_number'
    end
  end
end