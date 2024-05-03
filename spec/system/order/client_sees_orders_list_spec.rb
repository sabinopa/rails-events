require 'rails_helper'

describe 'Client sees orders list' do
  it 'must be authenticated' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
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
    order = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type.id, date: 30.days.from_now, attendees_number: 30,
                          details: 'Por favor, inclua uma sessão de caça ao tesouro interativa.', local: 'Salão de festas XYZ - Rua das Bananeiras, 44',
                          code: 'ORD-123456', status: 0 )

    visit my_orders_path

    expect(current_path).to eq new_client_session_path
  end

  it 'from home page' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit root_path
    click_on 'Meus Pedidos'

    expect(current_path).to eq my_orders_path
  end

  it 'and sees every order requested' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
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
    order1 = Order.create!(client_id: client.id, company_id: supplier.id, event_type_id: event_type1.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas XYZ - Rua das Bananeiras, 44', status: 0)
    order2 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type2.id,
                           date: 45.days.from_now, attendees_number: 15, details: 'Gostaríamos de ter uma encenação de história de conto de fadas.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', status: 0)

    login_as(client, :scope => :client)
    visit my_orders_path

    expect(page).to have_content 'Meus Pedidos'
    expect(page).to have_content order1.code
    expect(page).to have_content order2.code
    expect(page).to have_content 'Festa Temática de Piratas'
    expect(page).to have_content 'Festa de Contos de Fadas'
    expect(page).to have_content 'Estrelas Mágicas'
    expect(page).to have_content 'Aguardando Confirmação'
    expect(page).to have_content "#{30.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content "#{45.days.from_now.strftime('%d/%m/%Y')}"
    expect(page).to have_content 'Número de convidados: 25'
    expect(page).to have_content 'Número de convidados: 15'
    expect(page).to have_content 'Localização: Salão de festas XYZ - Rua das Bananeiras, 44'
    expect(page).to have_content 'Localização: Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404'
  end

  it 'and sees only his own orders' do
    juliana = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    paulo = Client.create!(name: 'Paulo', lastname: 'Andrade', document_number: CPF.generate, email: 'paulo@email.com', password: 'password')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
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
    order1 = Order.create!(client_id: juliana.id, company_id: supplier.id, event_type_id: event_type1.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas XYZ - Rua das Bananeiras, 44', status: 0)
    order2 = Order.create!(client_id: juliana.id, company_id: company.id, event_type_id: event_type2.id,
                           date: 45.days.from_now, attendees_number: 15, details: 'Gostaríamos de ter uma encenação de história de conto de fadas.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', status: 0)

    login_as(paulo, :scope => :client)
    visit my_orders_path

    expect(page).to have_content 'Você ainda não tem pedidos.'
  end

  it 'and return to home page' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit my_orders_path
    click_on 'Voltar'

    expect(root_path).to eq root_path
  end
end