require 'rails_helper'

describe 'Supplier creates event type' do
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
    visit new_company_event_type_path(company)

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
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Novo Tipo de Evento'

    expect(current_path).to eq new_company_event_type_path(company.id)
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
    login_as(supplier, :scope => :supplier)
    visit new_company_event_type_path(company)

    expect(page).to have_content 'Criar novo tipo de evento para Estrelas Mágicas'
    expect(page).to have_field 'Nome'
    expect(page).to have_field 'Descrição'
    expect(page).to have_field 'Mínimo de convidados'
    expect(page).to have_field 'Máximo de convidados'
    expect(page).to have_field 'Duração'
    expect(page).to have_field 'Menu'
    expect(page).to have_content 'Bebidas alcoólicas'
    expect(page).to have_content 'Decoração'
    expect(page).to have_content 'Estacionamento'
    expect(page).to have_content 'Local'
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
    login_as(supplier, :scope => :supplier)
    visit new_company_event_type_path(company)

    fill_in 'Nome', with: 'Festa de Aniversário Temática'
    fill_in 'Descrição', with: 'Uma festa de aniversário inesquecível com decoração temática à escolha do cliente. Inclui animação, jogos, e um bolo personalizado conforme o tema.'
    fill_in 'Mínimo de convidados', with: '20'
    fill_in 'Máximo de convidados', with: '100'
    fill_in 'Duração', with: '180'
    fill_in 'Menu', with: 'Buffet completo com opções de salgadinhos, doces tradicionais e personalizados conforme o tema, além de bebidas não alcoólicas.'
    uncheck 'Bebidas alcoólicas'
    check 'Decoração'
    check 'Estacionamento'
    select 'Salão de festas da empresa', from: 'Local'
    click_on 'Salvar'

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Festa de Aniversário Temática: Criado com sucesso!'
    expect(page).to have_content 'Número de convidados: 20 - 100'
    expect(page).to have_content 'Duração: 180 minutos'
    expect(page).to have_content 'Menu: Buffet completo com opções de salgadinhos, doces tradicionais e personalizados conforme o tema, além de bebidas não alcoólicas.'
    expect(page).to have_content 'Fornece decoração'
    expect(page).to have_content 'Possui estacionamento'
    expect(page).to have_content 'Salão de festas da empresa'
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
    login_as(supplier, :scope => :supplier)
    visit new_company_event_type_path(company)

    fill_in 'Nome', with: ''
    fill_in 'Descrição', with: ''
    fill_in 'Mínimo de convidados', with: ''
    fill_in 'Máximo de convidados', with: ''
    fill_in 'Duração', with: ''
    fill_in 'Menu', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Tipo de evento não cadastrado.'
    expect(page).to have_content 'Nome não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
    expect(page).to have_content 'Mínimo de convidados não pode ficar em branco'
    expect(page).to have_content 'Máximo de convidados não pode ficar em branco'
    expect(page).to have_content 'Menu não pode ficar em branco'
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
    company_pedro = Company.create!(supplier_id: pedro.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                            registration_number: '01.234.567/0001-89',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                            address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                            description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.')
                            company_pedro.payment_methods << [pix, debito]

    login_as(priscila, :scope => :supplier)
    visit new_company_event_type_path(company_pedro.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Apenas o proprietário pode criar tipos de evento para essa empresa.'
  end
end