require 'rails_helper'

RSpec.describe Order, type: :model do
  describe '#valid?' do
    context 'incomplete datas' do
      it 'returns false when date is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
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
        order = Order.new(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: '',
                                attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when attendees number is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
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
        order = Order.new(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: '', details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when details is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
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
        order = Order.new(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 25, details: '',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when local is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                        description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                        min_attendees: 10, max_attendees: 40, duration: 180,
                                        menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 2)
        order = Order.new(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: '', day_type: :weekend, status: 1)

        result = order.valid?

        expect(result).to eq false
      end

      it 'returns false when name is empty' do
        client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
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
        order = Order.new(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                                attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: '', status: 1)

        result = order.valid?

        expect(result).to eq false
      end
    end
  end
end
