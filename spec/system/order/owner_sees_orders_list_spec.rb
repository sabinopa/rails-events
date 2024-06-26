require 'rails_helper'

describe 'Owner sees order list' do
  it 'must be authenticated' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now, attendees_number: 30,
                          details: 'Por favor, inclua uma sessão de caça ao tesouro interativa.', local: 'Salão de festas XYZ - Rua das Bananeiras, 44',
                          day_type: :weekend, status: 0 )

    visit my_company_orders_path

    expect(current_path).to eq new_owner_session_path
  end

  it 'from home page' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: owner.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now, attendees_number: 30,
                          details: 'Por favor, inclua uma sessão de caça ao tesouro interativa.', local: 'Salão de festas XYZ - Rua das Bananeiras, 44',
                          day_type: :weekend, status: 0 )

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end

    expect(current_path).to eq my_company_orders_path(owner.id)
  end

  it 'and sees every orders' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type1 = EventType.create!(company_id: company.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_type2 = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order1 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type1.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.', day_type: :weekend,
                           local: 'Salão de festas XYZ - Rua das Bananeiras, 44', status: 2)
    order2 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type2.id, date: 45.days.from_now,
                          attendees_number: 15, details: 'Gostaríamos de ter uma encenação de história de conto de fadas.', day_type: :week_day,
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', status: 1)
    order3 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type1.id, date: 90.days.from_now,
                           attendees_number: 20, details: 'Preciso de opções veganas no cardápio.', day_type: :holiday,
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', status: 0)
    order_approval1 = OrderApproval.create!(order_id: order1.id, owner_id: company.owner_id,
                            validity_date: 2.days.from_now, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order1.default_price + 0 - 100.0)
    order_approval2 = OrderApproval.create!(order_id: order2.id, owner_id: company.owner_id,
                            validity_date: 2.days.from_now, extra_charge: 0, discount: 100.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order2.default_price + 0 - 100.0)

    login_as(owner, :scope => :owner)
    visit my_company_orders_path

    expect(page).to have_content 'Pedidos'
    expect(page).to have_link order1.code
    expect(page).to have_link order2.code
    expect(page).to have_link order3.code
    expect(page).to have_content 'Aguardando Análise'
    expect(page).to have_content 'Em Negociação'
    expect(page).to have_content 'Pedido Confirmado'
    expect(page).to have_content "#{30.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "#{45.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "#{90.days.from_now.strftime('%d/%m/%Y')}"
  end

  it 'and return to home page' do
    owner = Owner.create!(name: 'Juliana', lastname: 'Dias', email: 'ju@dias.com', password: 'senhasenha')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

    login_as(owner, :scope => :owner)
    visit my_company_orders_path
    click_on 'Voltar'

    expect(root_path).to eq root_path
  end
end
