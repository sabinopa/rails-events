require 'rails_helper'

describe 'Event Type Availability API', type: :request do
  context 'GET /api/v1/companies/:company_id/event_types/:id/availability' do
    it 'successfully when number of attendees, date, and day type are valid' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: 20.days.from_now.to_s, number_attendees: 20, day_type: 'weekend' }

      expect(response).to have_http_status(200)
      json_response = JSON.parse(response.body)
      expect(json_response['available']).to be true
      expect(json_response['estimated_price']).to be_present
    end

    it 'returns error when attendees number below the minimum limit' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: 20.days.from_now.to_s, number_attendees: 5, day_type: 'weekend' }

      expect(response).to have_http_status(406)
      json_response = JSON.parse(response.body)
      expected_error = I18n.t('errors.messages.attendees_out_of_range')
      expect(json_response['error']).to include expected_error
    end

    it 'returns error when attendees number above the maximum limit' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: 20.days.from_now.to_s, number_attendees: 42, day_type: 'weekend' }

      expect(response).to have_http_status(406)
      json_response = JSON.parse(response.body)
      expected_error = I18n.t('errors.messages.attendees_out_of_range')
      expect(json_response['error']).to include expected_error
    end

    it 'returns error when date is in past' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: 10.days.ago, number_attendees: 10, day_type: 'weekend' }

      expect(response).to have_http_status(406)
      json_response = JSON.parse(response.body)
      expected_error = I18n.t('errors.messages.invalid_date_format')
      expect(json_response['error']).to include expected_error
    end

    it 'returns error when date is in invalid format' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: 'invalid_date', number_attendees: 10, day_type: 'weekend' }

      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)
      expected_error = I18n.t('errors.messages.invalid_date_format')
      expect(json_response['error']).to include expected_error
    end

    it 'returns error when date, number of attendees, or day type is missing' do
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: '', number_attendees: '', day_type: '' }

      expect(response).to have_http_status(400)
      json_response = JSON.parse(response.body)
      expected_error = I18n.t('errors.messages.missing_date_attendees_day_type')
      expect(json_response['error']).to include expected_error
    end

    it 'returns error when event type is already negotiating for the date' do
      client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)
      order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: 30.days.from_now.to_s, number_attendees: 20, day_type: 'weekend' }

      expect(response).to have_http_status(406)
      json_response = JSON.parse(response.body)
      expected_error = I18n.t('errors.messages.no_availability_for_date')
      expect(json_response['error']).to include expected_error
    end

    it 'returns error when event type is already confirmed for the date' do
      client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
      supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
      company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
      event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                     description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                     min_attendees: 10, max_attendees: 40, duration: 180,
                                     menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                     alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: "on_site")
      event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10, additional_attendee_price: 50.0,
                                           extra_hour_price: 60.0, day_options: :weekend)
      order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

      get "/api/v1/companies/#{company.id}/event_types/#{event_type.id}/availability", params: { date: 30.days.from_now.to_s, number_attendees: 20, day_type: 'weekend' }

      expect(response).to have_http_status(406)
      json_response = JSON.parse(response.body)
      expected_error = I18n.t('errors.messages.no_availability_for_date')
      expect(json_response['error']).to include expected_error
    end
  end
end