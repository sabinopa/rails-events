require 'rails_helper'

describe 'Owner updates the status of his event type' do
  it 'must be authenticated to active' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                        description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui decoração temática completa e muita diversão para os pequenos aventureiros.',
                        min_attendees: 20, max_attendees: 50, duration: 240,
                        menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :inactive)

    post active_event_type_path(event_type)

    expect(response).to redirect_to new_owner_session_path
  end

  it 'must be authenticated to inactive' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                        description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui decoração temática completa e muita diversão para os pequenos aventureiros.',
                        min_attendees: 20, max_attendees: 50, duration: 240,
                        menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)

    post inactive_event_type_path(company)

    expect(response).to redirect_to new_owner_session_path
  end

  it 'and sees the button to active' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :inactive)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                        description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui decoração temática completa e muita diversão para os pequenos aventureiros.',
                        min_attendees: 20, max_attendees: 50, duration: 240,
                        menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :inactive)

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Ver detalhes'

    expect(page).to have_button 'Ativar Evento'
  end

  it 'and sees the button to inactive' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                        description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui decoração temática completa e muita diversão para os pequenos aventureiros.',
                        min_attendees: 20, max_attendees: 50, duration: 240,
                        menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)

    login_as(owner, :scope => :owner)
    visit root_path
    within 'main' do
      click_on 'Minha Empresa'
    end
    click_on 'Ver detalhes'

    expect(page).to have_button 'Desativar Evento'
  end

  it 'and turn the event type inactive' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                        description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui decoração temática completa e muita diversão para os pequenos aventureiros.',
                        min_attendees: 20, max_attendees: 50, duration: 240,
                        menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)

    login_as(owner, :scope => :owner)
    visit event_type_path(event_type.id)
    click_on 'Desativar Evento'

    expect(current_path).to eq event_type_path(event_type)
    expect(page).to have_content 'Seu evento foi desativado!'
    expect(page).to have_button 'Ativar Evento'
    expect(page).to have_content 'Status: Desativado'
  end

  it 'and turn the event type active' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :inactive)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                        description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui decoração temática completa e muita diversão para os pequenos aventureiros.',
                        min_attendees: 20, max_attendees: 50, duration: 240,
                        menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                        alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :inactive)

    login_as(owner, :scope => :owner)
    visit event_type_path(event_type.id)
    click_on 'Ativar Evento'

    expect(current_path).to eq event_type_path(event_type)
    expect(page).to have_content 'Seu evento foi ativado!'
    expect(page).to have_button 'Desativar Evento'
    expect(page).to have_content 'Status: Ativo'
  end
end