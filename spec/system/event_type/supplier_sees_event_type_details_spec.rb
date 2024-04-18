require 'rails_helper'

describe 'Owner sees event type details' do
  it 'from any page through the navigation bar' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type_one = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_type_two = EventType.create!(company_id: supplier.id, name: 'Festa Encantada do Jardim Secreto',
                            description: 'Mergulhe em um mundo de fantasia com nossa Festa Encantada do Jardim Secreto. Este evento especial convida crianças e adultos a explorar um jardim mágico, onde flores gigantes, borboletas coloridas e criaturas míticas se tornam parte de uma aventura interativa e encantadora.',
                            min_attendees: 15, max_attendees: 40, duration: 180,
                            menu_description: 'Delicie-se com nosso buffet inspirado na natureza, incluindo sanduíches em forma de flor, frutas esculpidas como borboletas, sucos mágicos e um bolo encantador no formato de um grande cogumelo. Opções veganas e sem lactose disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)

    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end

    expect(current_path).to eq company_path(company.id)
    expect(page).to have_content 'Festa Temática de Piratas'
    expect(page).to have_content 'Festa Encantada do Jardim Secreto'
    expect(page).to have_content 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.'
    expect(page).to have_content 'Mergulhe em um mundo de fantasia com nossa Festa Encantada do Jardim Secreto. Este evento especial convida crianças e adultos a explorar um jardim mágico, onde flores gigantes, borboletas coloridas e criaturas míticas se tornam parte de uma aventura interativa e encantadora.'
    expect(page).to have_content 'Número de convidados: 20 - 50'
    expect(page).to have_content 'Número de convidados: 15 - 40'
    expect(page).to have_content 'Duração: 240 minutos'
    expect(page).to have_content 'Duração: 180 minutos'
    expect(page).to have_content 'Alameda dos Sonhos, 404'
    expect(page).to have_content 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.'
    expect(page).to have_content 'Delicie-se com nosso buffet inspirado na natureza, incluindo sanduíches em forma de flor, frutas esculpidas como borboletas, sucos mágicos e um bolo encantador no formato de um grande cogumelo. Opções veganas e sem lactose disponíveis.'
    expect(page).to have_content 'Fornece decoração'
    expect(page).to have_content 'Possui estacionamento'
    expect(page).to have_content 'Realizado no próprio salão de festas da empresa'
  end

  it 'and returns to homepage' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type_one = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_type_two = EventType.create!(company_id: supplier.id, name: 'Festa Encantada do Jardim Secreto',
                            description: 'Mergulhe em um mundo de fantasia com nossa Festa Encantada do Jardim Secreto. Este evento especial convida crianças e adultos a explorar um jardim mágico, onde flores gigantes, borboletas coloridas e criaturas míticas se tornam parte de uma aventura interativa e encantadora.',
                            min_attendees: 15, max_attendees: 40, duration: 180,
                            menu_description: 'Delicie-se com nosso buffet inspirado na natureza, incluindo sanduíches em forma de flor, frutas esculpidas como borboletas, sucos mágicos e um bolo encantador no formato de um grande cogumelo. Opções veganas e sem lactose disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)

    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end