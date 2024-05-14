require 'rails_helper'

describe 'Visitor sees event type details' do
  it 'from home page' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
    visit root_path
    click_on 'Estrelas Mágicas'
    click_on 'Ver detalhes'

    expect(current_path).to eq event_type_path(event_type)
  end

  it 'and sees a list of events available on the companys page' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type1 = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
                            event_type1.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'festa_pirata.jpg')), filename: 'festa_pirata.jpg')
    event_type2 = EventType.create!(company: company, name: 'Festa Espacial',
                                  description: 'Explore as estrelas e aventure-se pelo universo com nossa Festa Espacial! Inclui atividades intergalácticas, decoração temática e diversão cósmica para todos.',
                                  min_attendees: 15, max_attendees: 40, duration: 180,
                                  menu_description: 'Cardápio espacial com mini-pizzas em formato de planetas, estrelas de queijo e sucos cósmicos. Opções veganas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1, status: :active)
                                  event_type2.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'festa_espacial.jpg')), filename: 'festa_espacial.jpg')
    event_type3 = EventType.create!(company: company, name: 'Festa de Super-Heróis',
                                  description: 'Desperte seu herói interior e junte-se à nossa Festa de Super-Heróis! Inclui atividades emocionantes, fantasias e diversão heroica para todos.',
                                  min_attendees: 10, max_attendees: 60, duration: 180,
                                  menu_description: 'Cardápio de super-herói com hambúrgueres poderosos, batatas em formato de capas e sucos de energia. Opções veganas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1, status: :active)
                                  event_type3.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'festa_super_heroi.jpg')), filename: 'festa_super_heroi.jpg')
    visit root_path
    click_on 'Estrelas Mágicas'

    event_types = [event_type1, event_type2, event_type3]
    event_types.each do |event_type|
      expect(page).to have_link('Ver detalhes', href: event_type_path(event_type))
    end
    expect(current_path).to eq company_path(company.id)
    expect(page).to have_content 'Festa Temática de Piratas'
    expect(page).to have_content 'Festa Espacial'
    expect(page).to have_content 'Festa de Super-Heróis'
    expect(page).to have_content 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.'
    expect(page).to have_content 'Explore as estrelas e aventure-se pelo universo com nossa Festa Espacial! Inclui atividades intergalácticas, decoração temática e diversão cósmica para todos.'
    expect(page).to have_content 'Desperte seu herói interior e junte-se à nossa Festa de Super-Heróis! Inclui atividades emocionantes, fantasias e diversão heroica para todos.'
    expect(page).to have_css('img[src*="festa_pirata.jpg"]')
    expect(page).to have_css('img[src*="festa_espacial.jpg"]')
    expect(page).to have_css('img[src*="festa_super_heroi.jpg"]')
  end

  it 'and sees only active event types' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type1 = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :inactive)
    event_type2 = EventType.create!(company: company, name: 'Festa Espacial',
                                  description: 'Explore as estrelas e aventure-se pelo universo com nossa Festa Espacial! Inclui atividades intergalácticas, decoração temática e diversão cósmica para todos.',
                                  min_attendees: 15, max_attendees: 40, duration: 180,
                                  menu_description: 'Cardápio espacial com mini-pizzas em formato de planetas, estrelas de queijo e sucos cósmicos. Opções veganas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1, status: :active)
    event_type3 = EventType.create!(company: company, name: 'Festa de Super-Heróis',
                                  description: 'Desperte seu herói interior e junte-se à nossa Festa de Super-Heróis! Inclui atividades emocionantes, fantasias e diversão heroica para todos.',
                                  min_attendees: 10, max_attendees: 60, duration: 180,
                                  menu_description: 'Cardápio de super-herói com hambúrgueres poderosos, batatas em formato de capas e sucos de energia. Opções veganas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1, status: :active)
    visit root_path
    click_on 'Estrelas Mágicas'

    event_types = [event_type2, event_type3]
    event_types.each do |event_type|
      expect(page).to have_link('Ver detalhes', href: event_type_path(event_type))
    end
    expect(current_path).to eq company_path(company.id)
    expect(page).not_to have_content 'Festa Temática de Piratas'
    expect(page).to have_content 'Festa Espacial'
    expect(page).to have_content 'Festa de Super-Heróis'
    expect(page).not_to have_content 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.'
    expect(page).to have_content 'Explore as estrelas e aventure-se pelo universo com nossa Festa Espacial! Inclui atividades intergalácticas, decoração temática e diversão cósmica para todos.'
    expect(page).to have_content 'Desperte seu herói interior e junte-se à nossa Festa de Super-Heróis! Inclui atividades emocionantes, fantasias e diversão heroica para todos.'
  end

  it 'and tries to access inactive event type page' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :inactive)
    visit event_type_path(event_type.id)

    expect(current_path).to eq company_path(company.id)
    expect(page).not_to have_content 'Festa Temática de Piratas'
    expect(page).to have_content 'Este tipo evento não está disponível no momento.'
  end

  it 'and company has no events' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)

    visit root_path
    click_on 'Estrelas Mágicas'

    expect(page).not_to have_content 'Ver detalhes'
    expect(page).to have_content 'Essa empresa ainda não possui eventos cadastrados.'
  end

  it 'and sees details event page' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
                            event_type.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'festa_pirata.jpg')), filename: 'festa_pirata.jpg')
    visit root_path
    click_on 'Estrelas Mágicas'
    click_on 'Ver detalhes'

    expect(current_path).to eq event_type_path(event_type)
    expect(page).to have_content 'Festa Temática de Piratas'
    expect(page).to have_content 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.'
    expect(page).to have_content 'Duração: 240 minutos'
    expect(page).to have_content 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.'
    expect(page).to have_content 'Fornece decoração'
    expect(page).to have_content 'Possui estacionamento'
    expect(page).to have_content 'Salão de festas da empresa'
    expect(page).to have_css('img[src*="festa_pirata.jpg"]')
  end

  it 'and return to company page' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
    visit event_type_path(event_type)
    click_on 'Voltar'

    expect(current_path).to eq company_path(company)
  end
end