require 'rails_helper'

describe 'Client creates review' do
  it 'from home page' do
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
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 5.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    travel_to 20.days.from_now do
      login_as(client, :scope => :client)
      visit root_path
      click_on 'Meus Pedidos'
      click_on 'Avaliar Evento'

      expect(current_path).to eq new_order_review_path(order.id)
      expect(page).to have_content "Como foi sua experiência com #{company.brand_name} durante seu evento?"
      expect(page).to have_field 'Nota'
      expect(page).to have_field 'Comentário'
      expect(page).to have_button 'Criar Avaliação'
    end
  end

  it 'sucessfully' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    travel_to 20.days.from_now do
      login_as(client, :scope => :client)
      visit new_order_review_path(order_id: order.id)
      select 5, from: 'Nota'
      fill_in 'Comentário', with: 'O atendimento da equipe é excepcional!'
      click_on 'Criar Avaliação'

      expect(current_path).to eq company_path(company.id)
      expect(page).to have_content 'Avaliação criada com sucesso!'
      expect(page).to have_content 'Avaliações'
      expect(page).to have_content "Avaliação de #{order.client.name}"
      expect(page).to have_content 'O atendimento da equipe é excepcional!'
      expect(page).to have_content "#{event_type.name}"
    end
  end

  it 'with empty fields' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    travel_to 20.days.from_now do
      login_as(client, :scope => :client)
      visit new_order_review_path(order_id: order.id)
      fill_in 'Comentário', with: ''
      click_on 'Criar Avaliação'

      expect(page).to have_content 'Comentário não pode ficar em branco'
    end
  end

  it 'before event date client cant see review form' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    login_as(client, :scope => :client)
    visit root_path
    click_on 'Meus Pedidos'

    expect(page).not_to have_content 'Avaliar Evento'
  end

  it 'unable to review orders made by others' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    client1 = Client.create!(name: 'Priscila', lastname: 'Sabino', document_number: CPF.generate, email: 'priscila@sabino.com', password: '12345678')
    order1 = Order.create!(client_id: client1.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    client2 = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    order2 = Order.create!(client_id: client2.id, company_id: company.id, event_type_id: event_type.id,
                            date: 30.days.from_now, attendees_number: 15, details: 'Gostaríamos de ter uma encenação de história de conto de fadas.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :week_day, status: 2)

    login_as(client1, :scope => :client)
    visit new_order_review_path(order2.id)

    expect(page).to have_content 'Você não tem permissão para realizar essa ação.'
    expect(current_path).to eq my_orders_path
  end

  it 'only one review for each order' do
    client = Client.create!(name: 'Juliana', lastname: 'Dias', document_number: CPF.generate, email: 'ju@dias.com', password: 'senhasenha')
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)
    event_type = EventType.create!(company_id: company.id, name: 'Festa de Contos de Fadas',
                                    description: 'Uma festa mágica inspirada em contos de fadas! Inclui encenação de histórias, decoração temática e muita diversão para os pequenos.',
                                    min_attendees: 10, max_attendees: 40, duration: 180,
                                    menu_description: 'Cardápio encantado com mini-sanduíches, frutas frescas, sucos naturais e bolo de princesa. Opções vegetarianas disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 2.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    travel_to 20.days.from_now do
      review = Review.create!(company_id: company.id, order: order, score: 5, text: 'Os melhores sanduíches, recomendo!')


      login_as(client, :scope => :client)
      visit new_order_review_path(order.id)

      expect(page).to have_content 'Você já criou uma avaliação para esse pedido.'
      expect(current_path).to eq my_orders_path
    end
  end
end
