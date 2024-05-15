require 'rails_helper'

describe 'Visitor sees reviews' do
  it 'from home page' do
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
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 5.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order2 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua comidas veganas',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    travel_to 50.days.from_now do
      review = Review.create!(company_id: company.id, order: order, score: 5, text: 'Os melhores sanduíches, recomendo!')
      review = Review.create!(company_id: company.id, order: order2, score: 4, text: 'Foi lindo!')

      visit root_path
      click_on 'Estrelas Mágicas'

      expect(current_path).to eq company_path(company.id)
      expect(page).to have_content 'Avaliações'
      expect(page).to have_content "Avaliação de #{order.client.name}", count: 2
      expect(page).to have_content 'Os melhores sanduíches, recomendo!'
      expect(page).to have_content 'Foi lindo!'
      expect(page).to have_content "#{event_type.name}", count: 3
      expect(page).to have_content "#{order.date.strftime('%d/%m/%Y')}"
      expect(page).to have_content "#{order2.date.strftime('%d/%m/%Y')}"
    end
  end

  it 'only 3 recent reviews on companys page' do
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
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 5.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order2 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua comidas veganas',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order3 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 15.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua comidas goiabas!',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order4 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 20.days.from_now,
                            attendees_number: 25, details: 'Será o aniversário do meu filho de 05 anos, teremos muitas crianças.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order5 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 22.days.from_now,
                            attendees_number: 25, details: 'Quais tipos de guardanapo você disponibiliza?',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    travel_to 50.days.from_now do
      review = Review.create!(company_id: company.id, order: order, score: 5, text: 'Os melhores sanduíches, recomendo!')
      review = Review.create!(company_id: company.id, order: order2, score: 4, text: 'Foi lindo!')
      review = Review.create!(company_id: company.id, order: order3, score: 4, text: 'A decoração me impressionou, estava tudo perfeito!')
      review = Review.create!(company_id: company.id, order: order4, score: 3, text: 'As crianças se divertiram, porém faltou refrigerante!')
      review = Review.create!(company_id: company.id, order: order5, score: 3, text: 'Infelizmente a festa atrasou 2 horas.')

      visit root_path
      click_on 'Estrelas Mágicas'

      expect(current_path).to eq company_path(company.id)
      expect(page).to have_content 'Avaliações - Nota geral: 3.8'
      expect(page).to have_content "Avaliação de #{order.client.name}", count: 3
      expect(page).to have_content 'Infelizmente a festa atrasou 2 horas.'
      expect(page).to have_content 'As crianças se divertiram, porém faltou refrigerante!'
      expect(page).to have_content 'A decoração me impressionou, estava tudo perfeito!'
      expect(page).not_to have_content 'Foi lindo!'
      expect(page).not_to have_content 'Os melhores sanduíches, recomendo!'
      expect(page).to have_content "#{event_type.name}", count: 4
      expect(page).to have_content(/Enviado às \d{2}h\d{2} em \d{2}\/\d{2}\/\d{4}/, count: 3)
    end
  end

  it 'and sees every review on reviews page' do
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
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
    order = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 5.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua uma sessão de caça ao tesouro.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order2 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 10.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua comidas veganas',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order3 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 15.days.from_now,
                            attendees_number: 25, details: 'Por favor, inclua comidas goiabas!',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order4 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 20.days.from_now,
                            attendees_number: 25, details: 'Será o aniversário do meu filho de 05 anos, teremos muitas crianças.',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)
    order5 = Order.create!(client_id: client.id, company_id: company.id, event_type_id: event_type.id, date: 22.days.from_now,
                            attendees_number: 25, details: 'Quais tipos de guardanapo você disponibiliza?',
                            local: 'Salão de festas Estrelas Mágicas - Alameda dos Sonhos, 404', day_type: :weekend, status: 2)

    travel_to 50.days.from_now do
      review1 = Review.create!(company_id: company.id, order: order, score: 5, text: 'Os melhores sanduíches, recomendo!')
      review2 = Review.create!(company_id: company.id, order: order2, score: 4, text: 'Foi lindo!')
      review3 = Review.create!(company_id: company.id, order: order3, score: 4, text: 'A decoração me impressionou, estava tudo perfeito!')
      review4 = Review.create!(company_id: company.id, order: order4, score: 3, text: 'As crianças se divertiram, porém faltou refrigerante!')
      review5 = Review.create!(company_id: company.id, order: order5, score: 3, text: 'Infelizmente a festa atrasou 2 horas.')

      visit root_path
      click_on 'Estrelas Mágicas'
      click_on 'Ver todas as avaliações'

      expect(current_path).to eq company_reviews_company_path(company.id)
      expect(page).to have_content 'Avaliações - Nota geral: 3.8'
      expect(page).to have_content "Avaliação de #{order.client.name}", count: 5
      expect(page).to have_content 'Infelizmente a festa atrasou 2 horas.'
      expect(page).to have_content 'As crianças se divertiram, porém faltou refrigerante!'
      expect(page).to have_content 'A decoração me impressionou, estava tudo perfeito!'
      expect(page).to have_content 'Foi lindo!'
      expect(page).to have_content 'Os melhores sanduíches, recomendo!'
      expect(page).to have_content "#{event_type.name}", count: 5
      expect(page).to have_content(/Enviado às \d{2}h\d{2} em \d{2}\/\d{2}\/\d{4}/, count: 5)
    end
  end
end