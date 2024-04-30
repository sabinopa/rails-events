require 'rails_helper'

describe 'Supplier creates company' do
  it 'must be authenticated' do
    visit new_company_path

    expect(current_path).to eq new_supplier_session_path
  end

  it 'by being redirected after registration' do
    visit root_path
    click_on 'Seja um Fornecedor'
    within 'main form' do
      fill_in 'Nome', with: 'Priscila'
      fill_in 'Sobrenome', with: 'Sabino'
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Criar conta'
    end

    expect(current_path).to eq new_company_path
  end

  it 'and sees the fields to create a company' do
    PaymentMethod.create!(method: 'PIX')
    PaymentMethod.create!(method: 'Cartão de Crédito')
    PaymentMethod.create!(method: 'Cartão de Débito')
    PaymentMethod.create!(method: 'Dinheiro')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')

    login_as(supplier, :scope => :supplier)
    visit new_company_path

    expect(page).to have_content 'Cadastre sua empresa'
    expect(page).to have_field 'Nome Fantasia'
    expect(page).to have_field 'Razão Social'
    expect(page).to have_field 'CNPJ'
    expect(page).to have_field 'Telefone'
    expect(page).to have_field 'E-mail'
    expect(page).to have_field 'Endereço'
    expect(page).to have_field 'Bairro'
    expect(page).to have_field 'Cidade'
    expect(page).to have_field 'Estado'
    expect(page).to have_field 'CEP'
    expect(page).to have_field 'Descrição'
    expect(page).to have_content 'Métodos de pagamentos aceitos'
    expect(page).to have_content 'PIX'
    expect(page).to have_content 'Cartão de Crédito'
    expect(page).to have_content 'Cartão de Débito'
    expect(page).to have_content 'Dinheiro'
    expect(page).to have_button 'Salvar'
  end

  it 'with incomplete data' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')

    login_as(supplier, :scope => :supplier)
    visit new_company_path
    fill_in 'Nome Fantasia', with: ''
    fill_in 'Razão Social', with: ''
    fill_in 'CNPJ', with: ''
    fill_in 'Telefone', with: ''
    fill_in 'E-mail', with: ''
    fill_in 'Endereço', with: ''
    fill_in 'Bairro', with: ''
    fill_in 'Cidade', with: ''
    fill_in 'Estado', with: ''
    fill_in 'CEP', with: ''
    fill_in 'Descrição', with: ''
    click_on 'Salvar'

    expect(page).to have_content 'Empresa não cadastrada.'
    expect(page).to have_content 'Nome Fantasia não pode ficar em branco'
    expect(page).to have_content 'Razão Social não pode ficar em branco'
    expect(page).to have_content 'CNPJ não pode ficar em branco'
    expect(page).to have_content 'Telefone não pode ficar em branco'
    expect(page).to have_content 'E-mail não pode ficar em branco'
    expect(page).to have_content 'Endereço não pode ficar em branco'
    expect(page).to have_content 'Bairro não pode ficar em branco'
    expect(page).to have_content 'Cidade não pode ficar em branco'
    expect(page).to have_content 'Estado não pode ficar em branco'
    expect(page).to have_content 'CEP não pode ficar em branco'
    expect(page).to have_content 'Descrição não pode ficar em branco'
  end

  it 'and cant visit homepage before registering a company' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')

    login_as(supplier, :scope => :supplier)
    visit root_path

    expect(current_path).to eq new_company_path
    expect(page).to have_content 'Você deve criar uma empresa antes de acessar outras páginas.'
  end

  it 'successfully' do
    PaymentMethod.create!(method: 'PIX')
    PaymentMethod.create!(method: 'Cartão de Crédito')
    PaymentMethod.create!(method: 'Cartão de Débito')
    PaymentMethod.create!(method: 'Dinheiro')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')

    login_as(supplier, :scope => :supplier)
    visit new_company_path
    fill_in 'Nome Fantasia', with: 'Eternos Laços'
    fill_in 'Razão Social', with: 'Eternos Laços Cerimônias Especiais Ltda'
    fill_in 'CNPJ', with: '58.934.722/0001-01'
    fill_in 'Telefone', with: '(11) 99876-5432'
    fill_in 'E-mail', with: 'contato@eternoslacos.com.br'
    fill_in 'Endereço', with: 'Rua das Oliveiras, 5678'
    fill_in 'Bairro', with: 'Jardim Amor'
    fill_in 'Cidade', with: 'Rio de Janeiro'
    fill_in 'Estado', with: 'RJ'
    fill_in 'CEP', with: '21000-000'
    fill_in 'Descrição', with: 'O Eternos Laços é especialista em transformar sonhos de casamento em realidade. '
    check 'PIX'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'
    click_on 'Salvar'

    expect(current_path).to eq company_path(supplier.reload.company.id)
    expect(page).to have_content 'Eternos Laços: Criado com sucesso!'
    expect(page).to have_content '(11) 99876-5432'
    expect(page).to have_content 'contato@eternoslacos.com.br'
    expect(page).to have_content 'Rua das Oliveiras, 5678'
    expect(page).to have_content 'Jardim Amor, Rio de Janeiro - RJ, 21000-000'
    expect(page).to have_content 'Pagamentos por:'
    expect(page).to have_content 'PIX | Cartão de Crédito | Cartão de Débito'
  end

  it 'already has a company registered' do
    pix = PaymentMethod.create!(method: 'PIX')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                              company.payment_methods << [pix, debito]
    login_as(supplier, :scope => :supplier)
    visit new_company_path

    expect(current_path).to eq root_path
    expect(page).to have_content 'Você já possui uma empresa cadastrada.'
  end
end