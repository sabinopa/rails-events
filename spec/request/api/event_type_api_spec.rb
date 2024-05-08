require 'rails_helper'

describe 'Event Type API', type: :request do
  context 'GET /api/v1/companies/:company_id/event_types/' do
    it 'list all event types of an specific company' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                      description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                      min_attendees: 10, max_attendees: 40, duration: 180,
                                      menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
      event_type2 = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                      description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                      min_attendees: 10, max_attendees: 40, duration: 180,
                                      menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
      event_type3 = EventType.create!(company_id: company.id, name: 'Aventura no Espaço',
                                      description: 'Uma jornada intergaláctica com aventuras espaciais para os jovens exploradores! Inclui atividades temáticas, decoração de planetas e estrelas, e muita diversão cósmica.',
                                      min_attendees: 15, max_attendees: 30, duration: 210,
                                      menu_description: 'Cardápio espacial com mini pizzas de queijo, asteroides de chocolate, sucos de frutas galácticas e bolo em forma de nave espacial. Opções veganas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: false,  location_type: 0)
      event_type4 = EventType.create!(company_id: company.id, name: 'Festa de Super-heróis',
                                    description: 'Transforme seu dia em uma missão de super-heróis com atividades emocionantes e heróicas! Inclui jogos, desafios de super-heróis e uma decoração inspirada nos mais famosos defensores da justiça.',
                                    min_attendees: 20, max_attendees: 50, duration: 240,
                                    menu_description: 'Buffet de heróis com sanduíches de super-força, batatas voadores, sucos energéticos e bolo de herói. Opções sem glúten disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)

    get "/api/v1/companies/#{company.id}/event_types/"

    expect(response).to have_http_status(200)
    expect(response.content_type).to include 'application/json'
    json_response = JSON.parse(response.body)
    expect(json_response.class).to eq Array
    expect(json_response.length).to eq 4

    expect(json_response.first['name'])
    expect(json_response.first['description'])
    expect(json_response.first['min_attendess'])
    expect(json_response.first['max_attendess'])
    expect(json_response.first['duration'])
    expect(json_response.first['menu_description'])
    expect(json_response.first['alcohol_available'])
    expect(json_response.first['decoration_available'])
    expect(json_response.first['parking_service_available'])

    expect(json_response.second['name'])
    expect(json_response.second['description'])
    expect(json_response.second['min_attendess'])
    expect(json_response.second['max_attendess'])
    expect(json_response.second['duration'])
    expect(json_response.second['menu_description'])
    expect(json_response.second['alcohol_available'])
    expect(json_response.second['decoration_available'])
    expect(json_response.second['parking_service_available'])

    expect(json_response.first.keys).not_to include 'created_at'
    expect(json_response.first.keys).not_to include 'updated_at'
    end

    it 'returns an empty hash due to the company not having any event types' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

      get "/api/v1/companies/#{company.id}/event_types/"

      expect(response).to have_http_status(200)
      expect(response.content_type).to include 'application/json'
      json_response = JSON.parse(response.body)
      expect(json_response.class).to eq Array
      expect(json_response).to eq []
    end

    it 'fails due to the event type not being found' do
      get '/api/v1/companies/999/event_types'

      expect(response).to have_http_status(404)
      expect(response.body).to include 'O id informado não foi encontrado.'
    end

    it 'and raise internal error' do
      allow(Company).to receive(:find).and_raise(ActiveRecord::QueryCanceled)

      get '/api/v1/companies/1/event_types/'

      expect(response).to have_http_status(500)
      expect(response.body).to include 'Ocorreu um erro no servidor.'
    end
  end
end