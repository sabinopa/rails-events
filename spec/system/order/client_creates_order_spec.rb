require 'rails_helper'

describe 'Client creates order' do
  it 'must be authenticated' do
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

    visit new_event_type_order_path(event_type.id)

    expect(current_path).to eq new_client_session_path
  end

  it 'through home page' do
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
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit root_path
    click_on 'Estrelas Mágicas'
    click_on 'Ver detalhes'
    click_on 'Fazer reserva'

    expect(current_path).to eq new_event_type_order_path(event_type.id)
  end

  it 'and sees the fields to create an order' do
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
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)

    expect(page).to have_content 'Criar pedido para Festa Temática de Piratas'
    expect(page).to have_field 'Data'
    expect(page).to have_field 'Número de convidados'
    expect(page).to have_field 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir'
    expect(page).to have_content 'Local: Salão de festa da empresa - Alameda dos Sonhos, 404'
    expect(page).to have_button 'Solicitar Orçamento'
  end

  it 'with incomplete data' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: ''
    fill_in 'Número de convidados', with: ''
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: ''
    fill_in 'order_local', with: ''
    click_on 'Solicitar Orçamento'

    expect(page).to have_content 'Pedido não enviado.'
    expect(page).to have_content 'Data do Evento não pode ficar em branco'
    expect(page).to have_content 'Número de convidados não pode ficar em branco'
    expect(page).to have_content 'Localização não pode ficar em branco'
    expect(page).to have_content 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir'
  end

  it 'and date has to be future' do
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
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: 10.days.ago
    find('#day_type_weekend').click
    fill_in 'Número de convidados', with: '35'
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: 'Quero comemorar o aniversário de 5 anos do meu filho com amigos e familia.'
    click_on 'Solicitar Orçamento'

    expect(page).to have_content 'Pedido não enviado.'
    expect(page).to have_content 'Data do Evento deve ser futura.'
  end

  it 'and date cannot be today' do
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
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: Date.today
    find('#day_type_weekend').click
    fill_in 'Número de convidados', with: '35'
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: 'Quero comemorar o aniversário de 5 anos do meu filho com amigos e familia.'
    click_on 'Solicitar Orçamento'

    expect(page).to have_content 'Pedido não enviado.'
    expect(page).to have_content 'Data do Evento deve ser futura.'
  end

  it 'successfully with custom location' do
    pix = PaymentMethod.create!(method: 'PIX')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 2)
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: 10.days.from_now
    find('#day_type_weekend').click
    fill_in 'Número de convidados', with: '35'
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: 'Quero comemorar o aniversário de 5 anos do meu filho com amigos e familia.'
    find('#location_custom').click
    fill_in 'order_local', with: 'Rua das Palmeiras, 10'
    select 'PIX', from: 'Pagamento por'
    click_on 'Solicitar Orçamento'

    order = Order.last
    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Solicitação #{order.code}: Enviado com sucesso!"
    expect(page).to have_content 'Pedido de buffet para Estrelas Mágicas'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content 'Aguardando Análise'
    expect(page).to have_content 'Dados da empresa:'
    expect(page).to have_content '(11) 2233-4455'
    expect(page).to have_content 'festas@estrelasmagicas.com.br'
    expect(page).to have_content 'Alameda dos Sonhos, 404'
    expect(page).to have_content 'Vila Feliz, São Paulo - SP, 05050-050'
    expect(page).to have_content 'Método de pagamento escolhido:'
    expect(page).to have_content 'PIX'
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content "#{order.code}"
    expect(page).to have_content 'Quero comemorar o aniversário de 5 anos do meu filho com amigos e familia.'
    expect(page).to have_content 'Data:'
    date = I18n.localize 10.days.from_now.to_date
    expect(page).to have_content "#{date} - Final de Semana"
    expect(page).to have_content 'Número de convidados:'
    expect(page).to have_content '35'
    expect(page).to have_content 'Localização:'
    expect(page).to have_content 'Rua das Palmeiras, 10'
  end

  it 'successfuly with company location' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 2)
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: 10.days.from_now
    find('#day_type_holiday').click
    fill_in 'Número de convidados', with: '35'
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: 'Quero comemorar o aniversário de 5 anos do meu filho com amigos e familia.'
    find('#location_company').click
    select 'Cartão de Crédito', from: 'Pagamento por'
    click_on 'Solicitar Orçamento'

    order = Order.last
    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Solicitação #{order.code}: Enviado com sucesso!"
    expect(page).to have_content 'Pedido de buffet para Estrelas Mágicas'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content 'Aguardando Análise'
    expect(page).to have_content 'Dados da empresa:'
    expect(page).to have_content '(11) 2233-4455'
    expect(page).to have_content 'Método de pagamento escolhido:'
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).to have_content 'festas@estrelasmagicas.com.br'
    expect(page).to have_content 'Alameda dos Sonhos, 404'
    expect(page).to have_content 'Vila Feliz, São Paulo - SP, 05050-050'
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content "#{order.code}"
    expect(page).to have_content 'Quero comemorar o aniversário de 5 anos do meu filho com amigos e familia.'
    expect(page).to have_content 'Data:'
    date = I18n.localize 10.days.from_now.to_date
    expect(page).to have_content "#{date} - Feriado"
    expect(page).to have_content 'Número de convidados:'
    expect(page).to have_content '35'
    expect(page).to have_content 'Localização:'
    expect(page).to have_content 'Alameda dos Sonhos, 404'
  end

  it 'and value is calculated based on excess attendees' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 2)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 20, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: 10.days.from_now
    find('#day_type_holiday').click
    fill_in 'Número de convidados', with: '22'
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: 'Tenho muitos amigos.'
    find('#location_company').click
    select 'Cartão de Crédito', from: 'Pagamento por'
    click_on 'Solicitar Orçamento'

    order = Order.last
    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Solicitação #{order.code}: Enviado com sucesso!"
    expect(page).to have_content 'Pedido de buffet para Estrelas Mágicas'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content 'Aguardando Análise'
    expect(page).to have_content 'Preço final:'
    expect(page).to have_content 'R$ 1.000,00'
  end

  it 'and attendees number is below the minimum limit' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 2)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 20, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: 10.days.from_now
    find('#day_type_holiday').click
    fill_in 'Número de convidados', with: '5'
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: 'Tenho muitos amigos.'
    find('#location_company').click
    select 'Cartão de Crédito', from: 'Pagamento por'
    click_on 'Solicitar Orçamento'

    expect(page).to have_content "Número de convidados deve estar entre #{event_type.min_attendees} e #{event_type.max_attendees}"
  end

  it 'and attendees number is above the maximum limit' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 2)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 20, additional_attendee_price: 50.0,
                            extra_hour_price: 60.0, day_options: :weekend)

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: 10.days.from_now
    find('#day_type_holiday').click
    fill_in 'Número de convidados', with: '5'
    fill_in 'Compartilhe conosco os detalhes do seu evento e como podemos contribuir', with: 'Tenho muitos amigos.'
    find('#location_company').click
    select 'Cartão de Crédito', from: 'Pagamento por'
    click_on 'Solicitar Orçamento'

    expect(page).to have_content "Número de convidados deve estar entre #{event_type.min_attendees} e #{event_type.max_attendees}"
  end
end
