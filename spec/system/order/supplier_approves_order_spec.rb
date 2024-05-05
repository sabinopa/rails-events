require 'rails_helper'

describe 'Supplier approves order' do
  it 'must be authenticated' do
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
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0)

    visit approve_order_path(order.id)

    expect(current_path).to eq new_supplier_session_path
  end

  it 'from home page' do
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
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0)
    login_as(supplier, :scope => :supplier)
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Revisar Pedido'

    expect(current_path).to eq approve_order_path(order.id)
  end


  it 'and sees every information about the order and prices' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 40, additional_attendee_price: 50.0,
                                    extra_hour_price: 60.0, day_options: :weekend)
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(supplier, :scope => :supplier)
    visit root_path
    click_on 'Pedidos'
    click_on order.code
    click_on 'Revisar Pedido'

    expect(current_path).to eq approve_order_path(order.id)
    expect(page).to have_content 'Aguardando Análise'
    expect(page).to have_content order.code
    expect(page).to have_content 'Por favor, inclua uma sessão de caça ao tesouro.'
    expect(page).to have_content 'Data:'
    expect(page).to have_content "#{30.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content 'Número de convidados:'
    expect(page).to have_content '25'
    expect(page).to have_content 'Localização:'
    expect(page).to have_content 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404'
    expect(page).to have_content 'Preço final:'
    expect(page).to have_content 'R$ 900,00'
    expect(page).to have_content 'Método de pagamento escolhido:'
    expect(page).to have_content 'Cartão de Débito'
    expect(page).to have_content 'Deseja alterar método de pagamento? Para alterar, selecione:'
    expect(page).to have_field 'Taxa extra'
    expect(page).to have_field 'Desconto'
    expect(page).to have_field 'Descrição da cobrança'
    expect(page).to have_button 'Enviar para Confirmação'
  end

  it 'and forget to select an validity date' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                                    extra_hour_price: 60.0, day_options: :weekend)
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(supplier, :scope => :supplier)
    visit approve_order_path(order.id)
    click_on 'Enviar para Confirmação'

    expect(current_path).to eq approve_order_path(order)
    expect(page).to have_content 'Erro ao aprovar o pedido.'
    expect(page).to have_content 'Verifique os erros abaixo:'
    expect(page).to have_content 'Validade da proposta não pode ficar em branco'
  end

  it 'and approves without taxes or discount' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                                    extra_hour_price: 60.0, day_options: :weekend)
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(supplier, :scope => :supplier)
    visit approve_order_path(order.id)
    fill_in 'Validade da proposta', with: 10.days.from_now
    click_on 'Enviar para Confirmação'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}: Está em negociação."
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content 'Em Negociação'
    expect(page).to have_content order.code
    expect(page).to have_content 'Por favor, inclua uma sessão de caça ao tesouro.'
    expect(page).to have_content 'Data:'
    event_date = "#{30.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "#{event_date} - Final de Semana"
    expect(page).to have_content 'Número de convidados:'
    expect(page).to have_content '25'
    expect(page).to have_content 'Localização:'
    expect(page).to have_content 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404'
    expect(page).to have_content 'Preço final:'
    expect(page).to have_content 'R$ 900,00'
    expect(page).to have_content 'Método de pagamento escolhido:'
    expect(page).to have_content 'Cartão de Débito'
    validity_date = "#{10.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "Prazo para resposta desta negociação: #{validity_date}"
  end

  it 'and approves with taxes' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                                    extra_hour_price: 60.0, day_options: :weekend)
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(supplier, :scope => :supplier)
    visit approve_order_path(order.id)
    fill_in 'Taxa extra', with: 300.0
    fill_in 'Validade da proposta', with: 10.days.from_now
    click_on 'Enviar para Confirmação'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}: Está em negociação."
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content 'Em Negociação'
    expect(page).to have_content order.code
    expect(page).to have_content 'Preço final:'
    expect(page).to have_content 'R$ 1.200,00'
  end

  it 'and approves with discount' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                                    extra_hour_price: 60.0, day_options: :weekend)
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(supplier, :scope => :supplier)
    visit approve_order_path(order.id)
    fill_in 'Desconto', with: 300.0
    fill_in 'Validade da proposta', with: 10.days.from_now
    click_on 'Enviar para Confirmação'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}: Está em negociação."
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content 'Em Negociação'
    expect(page).to have_content order.code
    expect(page).to have_content 'Preço final:'
    expect(page).to have_content 'R$ 600,00'
  end

  it 'and approves with tax, discount, and provides an explanation in the charge description' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                                    extra_hour_price: 60.0, day_options: :weekend)
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(supplier, :scope => :supplier)
    visit approve_order_path(order.id)
    fill_in 'Taxa extra', with: 600.0
    fill_in 'Desconto', with: 125.0
    fill_in 'Descrição da cobrança', with: 'Para o caça ao tesouro será cobraço R$ 600.00 e apliquei R$ 125,00 de desconto pois estou com balões azuis em falta.'
    fill_in 'Validade da proposta', with: 10.days.from_now
    click_on 'Enviar para Confirmação'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}: Está em negociação."
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content 'Em Negociação'
    expect(page).to have_content order.code
    expect(page).to have_content 'Preço final:'
    expect(page).to have_content 'R$ 1.375,00'
    expect(page).to have_content 'Descrição da cobrança'
    expect(page).to have_content 'Para o caça ao tesouro será cobraço R$ 600.00 e apliquei R$ 125,00 de desconto pois estou com balões azuis em falta.'
  end

  it 'and approves only writing a charge description' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                                    extra_hour_price: 60.0, day_options: :weekend)
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(supplier, :scope => :supplier)
    visit approve_order_path(order.id)
    fill_in 'Descrição da cobrança', with: 'Obrigada pelo pedido, sua festa será inesquecível.'
    fill_in 'Validade da proposta', with: 10.days.from_now
    click_on 'Enviar para Confirmação'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}: Está em negociação."
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content 'Em Negociação'
    expect(page).to have_content order.code
    expect(page).to have_content 'Preço final:'
    expect(page).to have_content 'R$ 900,00'
    expect(page).to have_content 'Descrição da cobrança'
    expect(page).to have_content 'Obrigada pelo pedido, sua festa será inesquecível.'
  end
end
