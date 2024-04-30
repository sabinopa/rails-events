require 'rails_helper'

RSpec.describe EventPricing, type: :model do
  describe '#valid?' do
    context 'incomplete datas' do
      it 'returns false when base price is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Estrelas Mágicas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        event_pricing = EventPricing.new(event_type_id: event_type.id, base_price: '', base_attendees: 50,
                                            additional_attendee_price: 50.0, extra_hour_price: 60.0, day_options: :weekend)
        result = event_pricing.valid?

        expect(result).to eq false
      end

      it 'returns false when base attendees is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Estrelas Mágicas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        event_pricing = EventPricing.new(event_type_id: event_type.id, base_price: 900.0, base_attendees: '',
                                            additional_attendee_price: 50.0, extra_hour_price: 60.0, day_options: :weekend)
        result = event_pricing.valid?

        expect(result).to eq false
      end

      it 'returns false when additional attendee price is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Estrelas Mágicas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        event_pricing = EventPricing.new(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50,
                                            additional_attendee_price: '', extra_hour_price: 60.0, day_options: :weekend)
        result = event_pricing.valid?

        expect(result).to eq false
      end

      it 'returns false when extra hour price is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Estrelas Mágicas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        event_pricing = EventPricing.new(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50,
                                            additional_attendee_price: 50.0, extra_hour_price: '', day_options: :weekend)
        result = event_pricing.valid?

        expect(result).to eq false
      end

      it 'returns false when day options is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.create!(company_id: company.id, name: 'Estrelas Mágicas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        event_pricing = EventPricing.new(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50,
                                            additional_attendee_price: 50.0, extra_hour_price: 60.0, day_options: '')
        result = event_pricing.valid?

        expect(result).to eq false
      end
    end
  end
end
