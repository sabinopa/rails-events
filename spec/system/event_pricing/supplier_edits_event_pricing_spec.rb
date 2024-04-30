require 'rails_helper'

describe 'Supplier edits event pricing' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)
    visit edit_event_pricing_path(event_pricing.id)

    expect(current_path).to eq new_supplier_session_path
  end

  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Ver detalhes'
    click_on 'Editar valores'

    expect(current_path).to eq edit_event_pricing_path(event_pricing.id)
  end


  it 'from event page details' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)
    login_as(supplier, :scope => :supplier)
    visit event_type_path(event_type.id)

    click_on 'Editar valores'

    expect(current_path).to eq edit_event_pricing_path(event_pricing.id)
  end

  it 'and sees the fields to edit an event type' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type= EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)

    login_as(supplier, :scope => :supplier)
    visit edit_event_pricing_path(event_pricing.id)

    expect(page).to have_content 'Edite os valores de Festa Temática de Piratas'
    expect(page).to have_field 'Preço Base'
    expect(page).to have_field 'Número Base de Convidados'
    expect(page).to have_field 'Preço por Convidado Adicional'
    expect(page).to have_field 'Preço por Hora Extra'
    expect(page).to have_field 'Finais de Semana'
    expect(page).to have_field 'Feriados'
    expect(page).to have_field 'Dias Úteis'
    expect(page).to have_button 'Salvar'
  end

  it 'successfully' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)

    login_as(supplier, :scope => :supplier)
    visit edit_event_pricing_path(event_pricing.id)

    choose 'Dias Úteis'
    fill_in 'Preço Base', with: 800.00
    fill_in 'Preço por Convidado Adicional', with: 30.0
    fill_in 'Número Base de Convidados', with: 30
    fill_in 'Preço por Hora Extra', with: 75.00
    click_on 'Salvar'

    expect(current_path).to eq event_type_path(supplier.reload.company.id)
    expect(page).to have_content 'Festa Temática de Piratas: Atualizado com sucesso!'
    expect(page).to have_content 'Preços para Festa Temática de Piratas'
    expect(page).to have_content 'Dias Úteis'
    expect(page).to have_content 'Preço Base: 800.0'
    expect(page).to have_content 'Preço por Convidado Adicional: 30.0'
    expect(page).to have_content 'Número Base de Convidados: 30'
    expect(page).to have_content 'Preço por Hora Extra: 75.0'
  end

  it 'with incomplete data' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)

    login_as(supplier, :scope => :supplier)
    visit edit_event_pricing_path(event_pricing.id)

    fill_in 'Preço Base', with: ''
    fill_in 'Preço por Convidado Adicional', with: ''
    fill_in 'Número Base de Convidados', with: ''
    fill_in 'Preço por Hora Extra', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar as precificações do evento.'
    expect(page).to have_content 'Preço Base não pode ficar em branco'
    expect(page).to have_content 'Preço por Convidado Adicional não pode ficar em branco'
    expect(page).to have_content 'Número Base de Convidados não pode ficar em branco'
    expect(page).to have_content 'Preço por Hora Extra não pode ficar em branco'
  end

  it 'has to be the owner' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    priscila = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    pedro = Supplier.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
    company_priscila = Company.create(supplier_id: priscila.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company_priscila.payment_methods << [pix, credito, debito]
    event_type_priscila = EventType.create!(company_id: company_priscila.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing_priscila = EventPricing.create!(event_type_id: event_type_priscila.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)
    company_pedro = Company.create(supplier_id: pedro.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                            registration_number: '97.159.752/0001-31',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                            address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                            description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.')
                            company_pedro.payment_methods << [pix, debito]
    event_type_pedro = EventType.create!(company_id: company_pedro.id, name: 'Festa Encantada do Jardim Secreto',
                            description: 'Mergulhe em um mundo de fantasia com nossa Festa Encantada do Jardim Secreto. Este evento especial convida crianças e adultos a explorar um jardim mágico, onde flores gigantes, borboletas coloridas e criaturas míticas se tornam parte de uma aventura interativa e encantadora.',
                            min_attendees: 15, max_attendees: 40, duration: 180,
                            menu_description: 'Delicie-se com nosso buffet inspirado na natureza, incluindo sanduíches em forma de flor, frutas esculpidas como borboletas, sucos mágicos e um bolo encantador no formato de um grande cogumelo. Opções veganas e sem lactose disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing_pedro = EventPricing.create!(event_type_id: event_type_pedro.id, base_price: 800.0, base_attendees: 60, additional_attendee_price: 30.0,
                          extra_hour_price: 10.0, day_options: :weekday)

    login_as(priscila, :scope => :supplier)
    visit edit_event_pricing_path(event_pricing_pedro.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Apenas o proprietário pode editar as precificações.'
  end
end