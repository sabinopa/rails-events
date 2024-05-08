require 'rails_helper'

describe 'Supplier edits company' do
  it 'must be authenticated' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    visit edit_company_path(company.id)

    expect(current_path).to eq new_supplier_session_path
  end

  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end
    click_on 'Editar Empresa'

    expect(current_path).to eq edit_company_path(company.id)
  end

  it 'from company page details' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    login_as(supplier, :scope => :supplier)
    visit company_path(company.id)
    click_on 'Editar Empresa'

    expect(current_path).to eq edit_company_path(company.id)
  end

  it 'and sees the fields to edit a company' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]

    login_as(supplier, :scope => :supplier)
    visit edit_company_path(company.id)

    expect(page).to have_content 'Editar Empresa'
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
    expect(page).to have_button 'Salvar'
  end

  it 'successfully' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    login_as(supplier, :scope => :supplier)
    visit edit_company_path(company.id)

    fill_in 'Nome Fantasia', with: 'Fantasia Aventura'
    fill_in 'Razão Social', with: 'Fantasia Aventura Entretenimento Infantil S.A.'
    fill_in 'CNPJ', with: '48.881.973/0001-03'
    fill_in 'Telefone', with: '(11) 5566-7788'
    fill_in 'E-mail', with: 'contato@fantasiaaventura.com.br'
    fill_in 'Endereço', with: 'Caminho do Arco-Íris, 88'
    fill_in 'Bairro', with: 'Terra dos Sonhos'
    fill_in 'Cidade', with: 'Salvador'
    fill_in 'Estado', with: 'BA'
    fill_in 'CEP', with: '41700-000'
    fill_in 'Descrição', with: 'Na Fantasia Aventura, especializamo-nos em criar festas infantis inesquecíveis, cheias de aventura e fantasia.'
    uncheck 'PIX'
    check 'Cartão de Crédito'
    check 'Cartão de Débito'
    click_on 'Salvar'

    expect(current_path).to eq company_path(supplier.reload.company.id)
    expect(page).to have_content 'Fantasia Aventura: Atualizado com sucesso!'
    expect(page).to have_content 'Na Fantasia Aventura, especializamo-nos em criar festas infantis inesquecíveis, cheias de aventura e fantasia.'
    expect(page).to have_content '48.881.973/0001-03'
    expect(page).to have_content '(11) 5566-7788'
    expect(page).to have_content 'contato@fantasiaaventura.com.br'
    expect(page).to have_content 'Caminho do Arco-Íris, 88'
    expect(page).to have_content 'Terra dos Sonhos, Salvador - BA, 41700-000'
    expect(page).to have_content 'Cartão de Crédito | Cartão de Débito'
  end

  it 'with incomplete data' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company.payment_methods << [pix, credito, debito]
    login_as(supplier, :scope => :supplier)
    visit edit_company_path(company.id)

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

    expect(page).to have_content 'Não foi possível atualizar os dados da empresa.'
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

  it 'cant edit others company' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    priscila = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    pedro = Supplier.create!(name: 'Pedro', lastname: 'Souza', email: 'pedro@email.com', password: 'password')
    company_priscila = Company.create!(supplier_id: priscila.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                            registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                            address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                            description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')
                            company_priscila.payment_methods << [pix, credito, debito]
    company_pedro = Company.create!(supplier_id: pedro.id, brand_name: 'Luzes da Cidade', corporate_name: 'Luzes da Cidade Eventos Ltda',
                            registration_number: '82.462.797/0001-03',  phone_number: '(21) 3344-8899', email: 'eventos@luzesdacidade.com.br',
                            address: 'Rua dos Iluminados, 212', neighborhood: 'Alto Brilho', city: 'Belo Horizonte', state: 'MG', zipcode: '31000-000',
                            description: 'Oferecemos serviços completos para casamentos, formaturas e eventos corporativos, incluindo buffets personalizados e decoração temática.')
                            company_pedro.payment_methods << [pix, debito]

    login_as(priscila, :scope => :supplier)
    visit edit_company_path(company_pedro.id)

    expect(current_path).to eq root_path
    expect(page).to have_content 'Apenas o proprietário pode editar essa empresa.'
  end
end