require 'rails_helper'

describe 'Owner cancels order' do
  it 'must be authenticated' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                                    attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                                    local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0)

    post cancel_order_path(order.id)

    expect(response).to redirect_to root_path
  end

  it 'from home page' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'rspecSabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0)

    login_as(owner, :scope => :owner)
    visit root_path
    click_on 'Pedidos'
    click_on order.code

    expect(page).to have_button 'Cancelar Pedido'
  end

  it 'succesfully a waiting review order' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'rspecSabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0)

    login_as(owner, :scope => :owner)
    visit order_path(order.id)
    click_on 'Cancelar Pedido'

    expect(current_path).to eq order_path(order.id)
    expect(order.reload.status).to eq 'order_cancelled'
    expect(page).to have_content "Pedido #{order.code}: Está cancelado!"
    expect(page).to have_content 'Pedido Cancelado'
    expect(page).not_to have_content 'Revisar Pedido'
    expect(page).not_to have_content 'Cancelar Pedido'
  end

  it 'succesfully an approved order' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'rspecSabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
    order_approval = OrderApproval.create!(order_id: order.id, owner_id: company.owner_id,
                           validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                           charge_description: 'Taxas adicionais por serviços especiais',
                           final_price: order.default_price + 0 - 100.0)

    login_as(owner, :scope => :owner)
    visit order_path(order.id)
    click_on 'Cancelar Pedido'

    expect(current_path).to eq order_path(order.id)
    expect(order.reload.status).to eq 'order_cancelled'
    expect(page).to have_content "Pedido #{order.code}: Está cancelado!"
    expect(page).to have_content 'Pedido Cancelado'
    expect(page).not_to have_content 'Revisar Pedido'
    expect(page).not_to have_content 'Cancelar Pedido'
  end

  it 'succesfully an confirmed order' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'rspecSabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order_approval = OrderApproval.create!(order_id: order.id, owner_id: company.owner_id,
                           validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                           charge_description: 'Taxas adicionais por serviços especiais',
                           final_price: order.default_price + 0 - 100.0)

    login_as(owner, :scope => :owner)
    visit order_path(order.id)
    click_on 'Cancelar Pedido'

    expect(current_path).to eq order_path(order.id)
    expect(order.reload.status).to eq 'order_cancelled'
    expect(page).to have_content "Pedido #{order.code}: Está cancelado!"
    expect(page).to have_content 'Pedido Cancelado'
    expect(page).not_to have_content 'Revisar Pedido'
    expect(page).not_to have_content 'Cancelar Pedido'
  end

  it 'and dont see cancel button if order is already cancelled' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'rspecSabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order_approval = OrderApproval.create!(order_id: order.id, owner_id: company.owner_id,
                           validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                           charge_description: 'Taxas adicionais por serviços especiais',
                           final_price: order.default_price + 0 - 100.0)

    login_as(owner, :scope => :owner)
    visit order_path(order.id)
    click_on 'Cancelar Pedido'

    expect(current_path).to eq order_path(order.id)
    expect(order.reload.status).to eq 'order_cancelled'
    expect(page).to have_content "Pedido #{order.code}: Está cancelado!"
    expect(page).to have_content 'Pedido Cancelado'
    expect(page).not_to have_content 'Revisar Pedido'
    expect(page).not_to have_content 'Cancelar Pedido'
  end
end