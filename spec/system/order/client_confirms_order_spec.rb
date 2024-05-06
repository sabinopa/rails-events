require 'rails_helper'

describe 'Client confirms order' do
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
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)

    post confirm_order_path(order)

    expect(response).to redirect_to new_client_session_path
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
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
    order_approval = OrderApproval.create!(order_id: order.id, supplier_id: company.supplier_id,
                            validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order.default_price + 0 - 100.0)

    login_as(client, :scope => :client)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).to have_button 'Confirmar Pedido'
  end

  it 'and the supplier has not yet approved the order' do
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
    order_approval = OrderApproval.create!(order_id: order.id, supplier_id: company.supplier_id,
                            validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order.default_price + 0 - 100.0)

    login_as(client, :scope => :client)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(page).not_to have_button 'Confirmar Pedido'
  end

  it 'and sees validity date' do
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
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
    order_approval = OrderApproval.create!(order_id: order.id, supplier_id: company.supplier_id,
                            validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order.default_price + 0 - 100.0)

    login_as(client, :scope => :client)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code

    expect(current_path).to eq order_path(order)
    validity = order_approval.validity_date.strftime('%d/%m/%Y')
    expect(page).to have_content "Prazo para resposta desta negociação: #{validity}"
  end

  it 'successfully' do
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
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
    order_approval = OrderApproval.create!(order_id: order.id, supplier_id: company.supplier_id,
                            validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order.default_price + 0 - 100.0)

    login_as(client, :scope => :client)
    visit root_path
    click_on 'Meus Pedidos'
    click_on order.code
    click_on 'Confirmar Pedido'

    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Pedido #{order.code}: Está confirmado!"
    expect(page).to have_content "Pedido Confirmado"
  end

  it 'and the validity date has expired' do
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
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
    order_approval = OrderApproval.create!(order_id: order.id, supplier_id: company.supplier_id,
                            validity_date: 2.days.ago, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order.default_price + 0 - 100.0)
    Order.check_date_and_update_status

    login_as(client, :scope => :client)
    visit order_path(order.id)

    expect(page).to have_content 'Pedido Cancelado'
    expect(page).to have_content 'O prazo para confirmação deste pedido expirou e ele foi automaticamente cancelado.'
    expect(page).not_to have_button 'Confirmar Pedido'
  end

  it 'and the validity date has expired, attempting to forcibly update the order status' do
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
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
    order_approval = OrderApproval.create!(order_id: order.id, supplier_id: company.supplier_id,
                            validity_date: 2.days.ago, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order.default_price + 0 - 100.0)

    login_as(client, :scope => :client)
    visit order_path(order.id)
    click_on 'Confirmar Pedido'

    expect(page).to have_content 'O prazo para confirmação deste pedido expirou.'
    expect(page).not_to have_button 'Confirmar Pedido'
    expect(page).not_to have_content 'Pedido Confirmado'
    expect(page).to have_content 'Pedido Cancelado'
    order.reload
    expect(order.status).to eq 'order_cancelled'
  end
end