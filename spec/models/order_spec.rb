require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'incomplete datas' do
      it 'returns false when date is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: '',
                                attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when attendees number is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: '', details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when details is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 25, details: '',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when local is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 2)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: '', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when name is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: '', status: 1)

        result = order.valid?

        expect(result).to eq false
      end
    end

    describe 'validations' do
      it 'is valid with valid attendees number within limits' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        expect(order).to be_valid
      end

      it 'is not valid with attendees number below the minimum limit' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 8, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        expect(order).not_to be_valid
      end

      it 'is not valid with attendees number above the maximum limit' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 50, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        expect(order).not_to be_valid
      end
    end

    describe 'pricing calculation' do
      it 'calculates the correct default price without extra charges' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10,
                                            additional_attendee_price: 50.0, extra_hour_price: 50.0, day_options: :weekend)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 12, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        expect(order.default_price).to eq(1000.0)
        expect(order).to be_valid
      end

      it 'calculates the correct default price with extra charges and discount' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
        event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 10,
                                            additional_attendee_price: 50.0, extra_hour_price: 50.0, day_options: :weekend)
        order = Order.new(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 12, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
        order_approval = OrderApproval.create!(owner_id: owner.id, order: order, extra_charge: 200.0, discount: 100.0, validity_date: 5.days.from_now)

        expect(order.final_price).to eq(1100.0)
      end
    end
  end
end
