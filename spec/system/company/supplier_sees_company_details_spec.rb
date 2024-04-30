require 'rails_helper'

describe 'Owner sees company details' do
  it 'from any page through the navigation bar' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end

    expect(current_path).to eq company_path(company.id)
    expect(page).to have_content 'Estrelas Mágicas'
    expect(page).to have_content 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.'
    expect(page).to have_content 'Estrelas Mágicas Buffet Infantil Ltda'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content 'Alameda dos Sonhos, 404'
    expect(page).to have_content 'Vila Feliz, São Paulo - SP, 05050-050'
    expect(page).to have_content 'PIX | Cartão de Crédito | Cartão de Débito'
  end

  it 'and see photos from its event types' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end

    expect(current_path).to eq company_path(company.id)
    expect(page).to have_content 'Estrelas 45456456456456Mágicas'
    expect(page).to have_content 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.'
    expect(page).to have_content 'Estrelas Mágicas Buffet Infantil Ltda'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content 'Alameda dos Sonhos, 404'
    expect(page).to have_content 'Vila Feliz, São Paulo - SP, 05050-050'
    expect(page).to have_content 'PIX | Cartão de Crédito | Cartão de Débito'
  end

  it 'and returns to homepage' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end