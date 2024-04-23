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
    click_on 'Ver detalhes'
    click_on 'Novo Preço'

    expect(current_path).to eq new_event_type_event_pricing_path(event_type)
  end

  it 'and sees the fields to create an event pricing' do
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
    expect(page).to have_field 'Finais de Semana'
    expect(page).to have_field 'Feriados'
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

    new_event_pricing = EventPricing.last
    expect(current_path).to eq event_type_path(new_event_pricing)
    expect(page).to have_content 'Novo preço criado com sucesso!'
    expect(page).to have_content 'Preços para Festa Temática de Piratas'
    expect(page).to have_content 'Dias Úteis'
    expect(page).to have_content 'Preço Base: 900.0'
    expect(page).to have_content 'Número Base de Convidados: 50'
    expect(page).to have_content 'Preço por Hora Extra: 75.0'
  end

  it 'with incomplete data' do
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

    fill_in 'Preço Base', with: ''
    fill_in 'Preço por Convidado Adicional', with: ''
    fill_in 'Número Base de Convidados', with: ''
    fill_in 'Preço por Hora Extra', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Preço não cadastrado.'
    expect(page).to have_content 'Preço Base não pode ficar em branco'
    expect(page).to have_content 'Preço por Convidado Adicional não pode ficar em branco'
    expect(page).to have_content 'Número Base de Convidados não pode ficar em branco'
    expect(page).to have_content 'Preço por Hora Extra não pode ficar em branco'
  end

  it 'has to be the owner' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    priscila = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    pedro = Supplier.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
    company_priscila = Company.create!(supplier_id: priscila.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company_priscila.payment_methods << [pix, credito, debito]
    priscila_event = EventType.create!(company_id: company_priscila.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    company_pedro = Company.create!(supplier_id: pedro.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                            registration_number: '01.234.567/0001-89',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                            address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                            description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.')
                            company_pedro.payment_methods << [pix, debito]
    pedro_event = EventType.create!(company_id: company_pedro.id, name: 'Casamento Elegante',
                            description: 'Um evento inesquecível com elegância e sofisticação. Oferecemos uma experiência completa de casamento, incluindo cerimônia, recepção, e festa, com detalhes personalizados para tornar seu dia verdadeiramente especial.',
                            min_attendees: 50, max_attendees: 200, duration: 480,
                            menu_description: 'Buffet de alta gastronomia com opções de pratos internacionais, incluindo entradas, pratos principais, sobremesas e uma seleção exclusiva de bebidas.',
                            alcohol_available: true, decoration_available: true, parking_service_available: false, location_type: 1)

    login_as(priscila, :scope => :supplier)
    visit new_event_type_event_pricing_path(pedro_event)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Apenas o proprietário precificar esse evento.'
  end

  it 'tries to create two prices for weekend' do
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
    event_pricing = EventPricing.create!(event_type_id: event_type.id, base_price: 900.0, base_attendees: 50, additional_attendee_price: 50.0,
                                        extra_hour_price: 60.0, day_options: :weekend)

    login_as(supplier, :scope => :supplier)
    visit new_event_type_event_pricing_path(event_type)

    choose 'Finais de Semana'
    fill_in 'Preço Base', with: 900.00
    fill_in 'Preço por Convidado Adicional', with: 30.00
    fill_in 'Número Base de Convidados', with: 50
    fill_in 'Preço por Hora Extra', with: 75.00
    click_on 'Salvar'

    expect(current_path).to eq event_type_event_pricings_path(event_type)
    expect(page).to have_content 'Já existe um preço cadastrado para este tipo de dia.'
  end

  it 'no event pricing registered' do
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
    visit event_type_path(event_type)

    expect(page).to have_content 'Ainda não há preços cadastrados para esse evento.'
  end
end