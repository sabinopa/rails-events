require 'rails_helper'

describe 'Supplier creates event pricing' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa Temática de Piratas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)

    visit new_event_type_event_pricing_path(event_type)

    expect(current_path).to eq new_supplier_session_path
  end

  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa Temática de Piratas',
                              description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                              min_attendees: 20, max_attendees: 50, duration: 240,
                              menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                              alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Novo Preço'

    expect(current_path).to eq new_event_type_event_pricing_path(event_type)
  end

  it 'and sees the fields to create an event type' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa Temática de Piratas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
    login_as(supplier, :scope => :supplier)
    visit new_event_type_event_pricing_path(event_type)

    expect(page).to have_content 'Defina os valores de Festa Temática de Piratas'
    expect(page).to have_field 'Preço Base'
    expect(page).to have_field 'Número Base de Convidados'
    expect(page).to have_field 'Preço por Convidado Adicional'
    expect(page).to have_field 'Preço por Hora Extra'
    expect(page).to have_field 'Finais de Semana ou Feriados'
    expect(page).to have_field 'Dias Úteis'
    expect(page).to have_button 'Salvar'
  end

  it 'successfully' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa Temática de Piratas',
                                  description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                                  min_attendees: 20, max_attendees: 50, duration: 240,
                                  menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                                  alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)
    login_as(supplier, :scope => :supplier)
    visit new_event_type_event_pricing_path(event_type)

    choose 'Dias Úteis'
    fill_in 'Preço Base', with: 900.00
    fill_in 'Preço por Convidado Adicional', with: 30.00
    fill_in 'Número Base de Convidados', with: 50
    fill_in 'Preço por Hora Extra', with: 75.00
    click_on 'Salvar'

    expect(current_path).to eq event_pricing_path(event_type)
    expect(page).to have_content 'Novo preço criado com sucesso!'
    expect(page).to have_content 'Preço para Dias Úteis'
    expect(page).to have_content 'Preço Base: 900.0'
    expect(page).to have_content 'Número Base de Convidados: 50'
    expect(page).to have_content 'Preço por Hora Extra: 75.0'
  end
end