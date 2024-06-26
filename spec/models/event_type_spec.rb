require 'rails_helper'

RSpec.describe EventType, type: :model do
  describe '#valid?' do
    context 'incomplete datas' do
      it 'returns false when name is empty' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: '',
                                   description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                   min_attendees: 20, max_attendees: 50, duration: 240,
                                   menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                   alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        result = event_type.valid?

        expect(result).to eq false
      end

      it 'returns false when description is empty' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: 'Festa Temática de Piratas',
                                      description: '',
                                      min_attendees: 20, max_attendees: 50, duration: 240,
                                      menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        result = event_type.valid?

        expect(result).to eq false
      end

      it 'returns false when min attendees is empty' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: 'Festa Temática de Piratas',
                                      description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                      min_attendees: '', max_attendees: 50, duration: 240,
                                      menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        result = event_type.valid?

        expect(result).to eq false
      end

      it 'returns false when max attendees is empty' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: 'Festa Temática de Piratas',
                                      description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                      min_attendees: 20, max_attendees: '', duration: 240,
                                      menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        result = event_type.valid?

        expect(result).to eq false
      end

      it 'returns false when duration is empty' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: 'Festa Temática de Piratas',
                                      description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                      min_attendees: 20, max_attendees: 50, duration: '',
                                      menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        result = event_type.valid?

        expect(result).to eq false
      end

      it 'returns false when menu description is empty' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: 'Festa Temática de Piratas',
                                      description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                      min_attendees: 20, max_attendees: 50, duration: 240,
                                      menu_description: '',
                                      alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
        result = event_type.valid?

        expect(result).to eq false
      end
    end

    describe '#has_many_attached' do
      it 'photos' do
        event_type = EventType.new

        expect(event_type.photos).to be_an_instance_of(ActiveStorage::Attached::Many)
      end
    end

    describe '#status' do
      it  'can be activated' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: 'Festa Temática de Piratas',
                                description: 'Uma aventura inesquecível pelos Sete Mares!',
                                min_attendees: 20, max_attendees: 50, duration: 240,
                                menu_description: 'Cardápio temático com mini-hambúrgueres',
                                alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)

      event_type.active!
      expect(event_type.active?).to be true
      end

      it  'can be inactivated' do
        owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
        event_type = EventType.new(company_id: company.id, name: 'Festa Temática de Piratas',
                                description: 'Uma aventura inesquecível pelos Sete Mares!',
                                min_attendees: 20, max_attendees: 50, duration: 240,
                                menu_description: 'Cardápio temático com mini-hambúrgueres',
                                alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)

        event_type.inactive!
        expect(event_type.inactive?).to be true
      end
    end
  end
end
