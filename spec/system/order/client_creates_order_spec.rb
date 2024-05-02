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
    expect(page).to have_field 'Conte-nos detalhes do seu evento e como podemos ajudar'
    expect(page).to have_content 'Local: Salão de festa da empresa - Alameda dos Sonhos, 404'
    expect(page).to have_button 'Verificar disponibilidade com fornecedor'
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
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')

    login_as(client, :scope => :client)
    visit new_event_type_order_path(event_type.id)
    fill_in 'Data', with: ''
    fill_in 'Número de convidados', with: ''
    fill_in 'Conte-nos detalhes do seu evento e como podemos ajudar', with: ''
    click_on 'Verificar disponibilidade com fornecedor'

    expect(page).to have_content 'Pedido não enviado.'
    expect(page).to have_content 'Data não pode ficar em branco'
    expect(page).to have_content 'Número de convidados não pode ficar em branco'
    expect(page).to have_content 'Conte-nos detalhes do seu evento e como podemos ajudar não pode ficar em branco'
  end

  it 'successfully' do
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
    fill_in 'Número de convidados', with: '35'
    fill_in 'Conte-nos detalhes do seu evento e como podemos ajudar', with: 'Quero comemorar o aniversário de 5 anos do meu filho com amigo e familia.'
    find('#location_custom').click
    fill_in 'order_local', with: 'Rua das Palmeiras, 10'
    click_on 'Verificar disponibilidade com fornecedor'

    order = Order.last
    expect(current_path).to eq order_path(order)
    expect(page).to have_content "Solicitação #{order.code}: Enviado com sucesso!"
    expect(page).to have_content 'Solicitação de buffet para Estrelas Mágicas'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content 'Aguardando Confirmação'
    expect(page).to have_content 'Dados da empresa:'
    expect(page).to have_content '(11) 2233-4455'
    expect(page).to have_content 'festas@estrelasmagicas.com.br'
    expect(page).to have_content 'Alameda dos Sonhos, 404'
    expect(page).to have_content 'Vila Feliz, São Paulo - SP, 05050-050'
    expect(page).to have_content 'Pagamentos por: PIX'
    expect(page).to have_content 'Detalhes do pedido:'
    expect(page).to have_content "#{order.code}"
    expect(page).to have_content 'Quero comemorar o aniversário de 5 anos do meu filho com amigo e familia.'
    expect(page).to have_content 'Data:'
    date = I18n.localize 10.days.from_now.to_date
    expect(page).to have_content "#{date}"
    expect(page).to have_content 'Número de convidados:'
    expect(page).to have_content '35'
    expect(page).to have_content 'Local:'
    expect(page).to have_content 'Rua das Palmeiras, 10'
  end
end
