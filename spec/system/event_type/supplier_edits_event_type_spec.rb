require 'rails_helper'

describe 'Supplier edits event type' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type= EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    visit edit_event_type_path(event_type.id)

    expect(current_path).to eq new_supplier_session_path
  end

  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Ver detalhes'
    click_on 'Editar Evento'

    expect(current_path).to eq edit_event_type_path(event_type.id)
  end


  it 'from company page details' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type= EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
    login_as(supplier, :scope => :supplier)
    visit company_path(company.id)

    click_on 'Ver detalhes'
    click_on 'Editar Evento'

    expect(current_path).to eq edit_event_type_path(event_type.id)
  end

  it 'and sees the fields to edit an event type' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type= EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)

    login_as(supplier, :scope => :supplier)
    visit edit_event_type_path(event_type.id)

    expect(page).to have_content 'Editar Festa Temática de Piratas'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Mínimo de convidados'
    expect(page).to have_field 'Máximo de convidados'
    expect(page).to have_field 'Duração'
    expect(page).to have_field 'Menu'
    expect(page).to have_content 'Bebidas alcoólicas'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Estacionamento'
    expect(page).to have_content 'Local da festa'
    expect(page).to have_content 'Adicionar fotos'
    expect(page).to have_button 'Salvar'
  end

  it 'successfully' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)

    login_as(supplier, :scope => :supplier)
    visit edit_event_type_path(event_type.id)

    fill_in 'Nome', with: 'Festa Encantada do Jardim Secreto'
    fill_in 'Descrição', with: 'Mergulhe em um mundo de fantasia com nossa Festa Encantada do Jardim Secreto. Este evento especial convida crianças e adultos a explorar um jardim mágico, onde flores gigantes, borboletas coloridas e criaturas míticas se tornam parte de uma aventura interativa e encantadora.'
    fill_in 'Mínimo de convidados', with: '15'
    fill_in 'Máximo de convidados', with: '40'
    fill_in 'Duração', with: '180'
    fill_in 'Menu', with: 'Delicie-se com nosso buffet inspirado na natureza, incluindo sanduíches em forma de flor, frutas esculpidas como borboletas, sucos mágicos e um bolo encantador no formato de um grande cogumelo. Opções veganas e sem lactose disponíveis.'
    check 'Estacionamento'
    select 'Salão de festas da empresa'
    attach_file 'Adicionar fotos', Rails.root.join('spec', 'files', 'festa_aniversario_detalhe.jpg')
    click_on 'Salvar'

    expect(current_path).to eq event_type_path(supplier.reload.company.id)
    expect(page).to have_content 'Festa Encantada do Jardim Secreto: Atualizado com sucesso!'
    expect(page).to have_content 'Mergulhe em um mundo de fantasia com nossa Festa Encantada do Jardim Secreto. Este evento especial convida crianças e adultos a explorar um jardim mágico, onde flores gigantes, borboletas coloridas e criaturas míticas se tornam parte de uma aventura interativa e encantadora.'
    expect(page).to have_content 'Número de convidados: 15 - 40'
    expect(page).to have_content 'Duração: 180 minutos'
    expect(page).to have_content 'Delicie-se com nosso buffet inspirado na natureza, incluindo sanduíches em forma de flor, frutas esculpidas como borboletas, sucos mágicos e um bolo encantador no formato de um grande cogumelo. Opções veganas e sem lactose disponíveis.'
    expect(page).to have_content 'Possui estacionamento'
    expect(page).to have_content 'Salão de festas da empresa'
    expect(page).to have_css('img[src*="festa_aniversario_detalhe.jpg"]')
  end

  it 'and add one more photo' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
    company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: company.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
                            event_type.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'festa_aniversario_decoracao.jpg')), filename: 'festa_aniversario_decoracao.jpg')

    login_as(supplier, :scope => :supplier)
    visit edit_event_type_path(event_type.id)

    attach_file('Adicionar fotos', Rails.root.join('spec', 'files', 'festa_aniversario_detalhe.jpg'))
    click_button 'Salvar'

    expect(current_path).to eq event_type_path(supplier.reload.company.id)
    expect(page).to have_css('img[src*="festa_aniversario_detalhe.jpg"]')
    expect(page).to have_css('img[src*="festa_aniversario_decoracao.jpg"]')
  end


  it 'and delete photo' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)
                            event_type.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'festa_aniversario_decoracao.jpg')), filename: 'festa_aniversario_decoracao.jpg')

    login_as(supplier, :scope => :supplier)
    visit edit_event_type_path(event_type.id)

    click_on 'Remover'
    click_on 'Salvar'

    expect(current_path).to eq event_type_path(supplier.reload.company.id)
    expect(page).not_to have_css('img[src*="festa_aniversario_decoracao.jpg"]')
  end

  it 'with incomplete data' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    event_type = EventType.create!(company_id: supplier.id, name: 'Festa Temática de Piratas',
                            description: 'Uma aventura inesquecível pelos Sete Mares! Nossa Festa Temática de Piratas inclui caça ao tesouro, decoração temática completa, e muita diversão para os pequenos aventureiros.',
                            min_attendees: 20, max_attendees: 50, duration: 240,
                            menu_description: 'Cardápio temático com mini-hambúrgueres, batatas em forma de joias, sucos naturais e bolo do tesouro. Opções vegetarianas disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)

    login_as(supplier, :scope => :supplier)
    visit edit_event_type_path(event_type.id)

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Mínimo de convidados', with: ''
    fill_in 'Máximo de convidados', with: ''
    fill_in 'Duração', with: ''
    fill_in 'Menu', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Não foi possível atualizar os dados do evento.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Mínimo de convidados não pode ficar em branco'
    expect(page).to have_content 'Máximo de convidados não pode ficar em branco'
    expect(page).to have_content 'Duração não pode ficar em branco'
    expect(page).to have_content 'Menu não pode ficar em branco'
  end

  it 'has to be the owner' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    priscila = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    pedro = Supplier.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
    company_priscila = Company.create(supplier_id: priscila.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company_priscila.payment_methods << [pix, credito, debito]
    company_pedro = Company.create(supplier_id: pedro.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                            registration_number: '97.159.752/0001-31',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                            address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                            description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.')
                            company_pedro.payment_methods << [pix, debito]
    event_type_pedro = EventType.create!(company_id: company_pedro.id, name: 'Festa Encantada do Jardim Secreto',
                            description: 'Mergulhe em um mundo de fantasia com nossa Festa Encantada do Jardim Secreto. Este evento especial convida crianças e adultos a explorar um jardim mágico, onde flores gigantes, borboletas coloridas e criaturas míticas se tornam parte de uma aventura interativa e encantadora.',
                            min_attendees: 15, max_attendees: 40, duration: 180,
                            menu_description: 'Delicie-se com nosso buffet inspirado na natureza, incluindo sanduíches em forma de flor, frutas esculpidas como borboletas, sucos mágicos e um bolo encantador no formato de um grande cogumelo. Opções veganas e sem lactose disponíveis.',
                            alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 0)

    login_as(priscila, :scope => :supplier)
    visit edit_event_type_path(event_type_pedro.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Apenas o proprietário pode editar esse evento.'
  end
end