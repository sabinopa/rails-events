require 'rails_helper'

describe 'Visitor sees event pricing details' do
  it 'on event type page' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    visit root_path
    click_on 'Estrelas Mágicas'
    click_on 'Ver detalhes'

    expect(current_path).to eq event_type_path(event_type)
  end

  it 'and sees a list of events available on the companys page' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    pricing_weekend = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)
    pricing_weekday = EventPricing.create!(event_type_id: event_type.id, base_price: 1000.0, base_attendees: 60, additional_attendee_price: 70.0,
                            extra_hour_price: 80.0, day_options: :weekday)
    pricing_holiday = EventPricing.create!(event_type_id: event_type.id, base_price: 1200.0, base_attendees: 80, additional_attendee_price: 80.0,
                            extra_hour_price: 100.0, day_options: :holiday)

    visit event_type_path(event_type)

    expect(page).to have_content 'Preços para Festa Temática de Piratas'
    expect(page).to have_content 'Finais de Semana'
    expect(page).to have_content 'Preço Base: 900.0'
    expect(page).to have_content 'Número Base de Convidados: 50'
    expect(page).to have_content 'Preço por Convidado Adicional: 50.0'
    expect(page).to have_content 'Preço por Hora Extra: 60.0'
    expect(page).to have_content 'Dias Úteis'
    expect(page).to have_content 'Preço Base: 1000.0'
    expect(page).to have_content 'Número Base de Convidados: 60'
    expect(page).to have_content 'Preço por Convidado Adicional: 70.0'
    expect(page).to have_content 'Preço por Hora Extra: 80.0'
    expect(page).to have_content 'Feriados'
    expect(page).to have_content 'Preço Base: 1200.0'
    expect(page).to have_content 'Número Base de Convidados: 80'
    expect(page).to have_content 'Preço por Convidado Adicional: 80.0'
    expect(page).to have_content 'Preço por Hora Extra: 100.0'
  end

  it 'and has no pricings registered' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa Temática de Piratas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)

    visit event_type_path(event_type)

    expect(page).to have_content 'Ainda não há preços cadastrados para esse evento.'
  end

  it 'and return to company page' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    visit event_type_path(event_type)
    click_on 'Voltar'

    expect(current_path).to eq company_path(company)
  end
end