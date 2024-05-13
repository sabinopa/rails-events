require 'rails_helper'

describe 'Owner updates the status of his company' do
  it 'must be authenticated to active' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :inactive)

    post active_company_path(company)

    expect(response).to redirect_to new_owner_session_path
  end

  it 'must be authenticated to inactive' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)

    post active_company_path(company)

    expect(response).to redirect_to new_owner_session_path
  end

  it 'and sees the button to active' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :inactive)

    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_on 'Minha Empresa'
    end

    expect(page).to have_button 'Ativar Empresa'
  end

  it 'and sees the button to inactive' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)

    login_as(owner, :scope => :owner)
    visit root_path
    within 'main' do
      click_on 'Minha Empresa'
    end

    expect(page).to have_button 'Desativar Empresa'
  end

  it 'and turn the company inactive' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :active)

    login_as(owner, :scope => :owner)
    visit company_path(company.id)
    click_on 'Desativar Empresa'

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Sua empresa foi desativada!'
    expect(page).to have_button 'Ativar Empresa'
    expect(page).to have_content 'Status: Desativada'
  end

  it 'and turn the company active' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company = Company.create!(owner_id: owner.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                        registration_number: '58.934.722/0001-01',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                        address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                        description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.', status: :inactive)

    login_as(owner, :scope => :owner)
    visit company_path(company.id)
    click_on 'Ativar Empresa'

    expect(current_path).to eq company_path(company)
    expect(page).to have_content 'Sua empresa foi ativada!'
    expect(page).to have_button 'Desativar Empresa'
    expect(page).to have_content 'Status: Ativa'
  end
end