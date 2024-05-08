require 'rails_helper'

describe 'Client sees messages' do
  it 'and sees every message sent and reveiced before' do
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
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                          attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                          local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)
    message1 = Message.create!(body: 'Olá, quando convidados são crianças?', sender_id: 1, sender_type: 'Supplier', receiver_id: 1, receiver_type: 'Client', order_id: order.id)
    message2 = Message.create!(body: 'Serão cerca de 15 crianças.', sender_id: 1, sender_type: 'Client', receiver_id: 1, receiver_type: 'Supplier', order_id: order.id)
    message3 = Message.create!(body: 'Ok. Eles tomam refrigerante?', sender_id: 1, sender_type: 'Supplier', receiver_id: 1, receiver_type: 'Client', order_id: order.id)
    message4 = Message.create!(body: 'Apenas 3 tomam, mas no geral preferimos suco.', sender_id: 1, sender_type: 'Client', receiver_id: 1, receiver_type: 'Supplier', order_id: order.id)

    login_as(client, :scope => :client)
    visit order_path(order.id)

    expect(page).to have_content 'Priscila (Fornecedor):', count: 2
    expect(page).to have_content 'Olá, quando convidados são crianças?'
    expect(page).to have_content 'Juliana (Cliente):', count: 2
    expect(page).to have_content 'Serão cerca de 15 crianças.'
    expect(page).to have_content 'Ok. Eles tomam refrigerante?'
    expect(page).to have_content 'Apenas 3 tomam, mas no geral preferimos suco.'
    expect(page).to have_content(/Enviado às \d{2}h\d{2} em \d{2}\/\d{2}\/\d{4}/, count: 4)
  end

  it 'and messages are in ascending order' do
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
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 30.days.from_now,
                          attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                          local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 0, payment_method_id: debito.id)
    message1 = Message.create!(body: 'Olá, quando convidados são crianças?', sender_id: 1, sender_type: 'Supplier', receiver_id: 1, receiver_type: 'Client', order_id: order.id)
    message2 = Message.create!(body: 'Serão cerca de 15 crianças.', sender_id: 1, sender_type: 'Client', receiver_id: 1, receiver_type: 'Supplier', order_id: order.id)
    message3 = Message.create!(body: 'Ok. Eles tomam refrigerante?', sender_id: 1, sender_type: 'Supplier', receiver_id: 1, receiver_type: 'Client', order_id: order.id)
    message4 = Message.create!(body: 'Apenas 3 tomam, mas no geral preferimos suco.', sender_id: 1, sender_type: 'Client', receiver_id: 1, receiver_type: 'Supplier', order_id: order.id)

    login_as(client, :scope => :client)
    visit order_path(order.id)

    results = Message.all.order(created_at: :asc)
    expected_results = [message1, message2, message3, message4]

    expect(results).to eq (expected_results)
  end
end