require 'rails_helper'

describe 'Owner sees orders details' do
  it 'from any page through the navigation bar' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0)


    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on order.code

    expect(current_path).to eq order_path(order.id)
    expect(page).to have_content 'Pedido de buffet para Estrelas Mágicas'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content order.code
    expect(page).to have_content 'Por favor, inclua uma sessão de caça ao tesouro.'
    expect(page).to have_content 'Data:'
    date = I18n.localize 30.days.from_now.to_date
    expect(page).to have_content "#{date}"
    expect(page).to have_content 'Número de convidados:'
    expect(page).to have_content '25'
    expect(page).to have_content 'Localização:'
    expect(page).to have_content 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404'
  end

  it 'and is notified that there is an event on the same day' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    event_type2 = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 1)
    order2 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type2.id,
                           date: 30.days.from_now, attendees_number: 15, details: 'Gostaríamos de ter uma encenação de história de conto de fadas.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :week_day, status: 0)

    login_as(owner, :scope => :owner)
    visit order_path(order2)

    expect(page).to have_content 'Atenção! Existe outro evento agendado para esta data.'
  end

  it 'and returns to orders list page' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: owner.id, event_type_id: event_type.id, date: 30.days.from_now,
                           attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                           local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0)

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Pedidos'
    end
    click_on order.code
    click_on 'Voltar'

    expect(current_path).to eq my_company_orders_path
  end

  it 'and current owner is not the owner of the order' do
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner1 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    owner2 = Owner.create!(name: 'Paula', lastname: 'Cardoso', email: 'paula@cardoso.com', password: 'password')
    company = Company.create!(owner_id: owner2.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
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
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                          attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                          local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)

    login_as(owner1, :scope => :client)
    visit order_path(order.id)

    expect(page).to have_content 'Você não pode acessar essa tela.'
  end
end