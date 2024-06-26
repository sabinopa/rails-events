require 'rails_helper'

describe 'Client creates an account' do
  it 'successfully' do
    visit root_path
    click_on 'Seja um Cliente'
    within 'main form' do
      fill_in 'Nome', with: 'Priscila'
      fill_in 'Sobrenome', with: 'Sabino'
      fill_in 'CPF', with: '525.202.290-98'
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Criar conta'
    end

    within 'nav' do
      expect(page).not_to have_link 'Entrar como Cliente'
      expect(page).not_to have_link 'Cadastre sua empresa'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Priscila Sabino - priscila@email.com'
    end
    expect(page).to have_content 'Boas vindas! Você realizou seu registro com sucesso.'
  end

  it 'document number has to be unique' do
    client = Client.create!(name: 'Priscila', lastname: 'Sabino',
                            document_number: '525.202.290-98', email: 'priscila@email.com', password: '12345678')

    visit root_path
    click_on 'Seja um Cliente'
    within 'main form' do
      fill_in 'Nome', with: 'Pri'
      fill_in 'Sobrenome', with: 'Sabino'
      fill_in 'CPF', with: '525.202.290-98'
      fill_in 'E-mail', with: 'pri@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Criar conta'
    end

    expect(page).to have_content 'Não foi possível salvar cliente: 1 erro'
    expect(page).to have_content 'CPF já está em uso'
  end

  it 'document number must follow the specified format' do
    visit root_path
    click_on 'Seja um Cliente'
    within 'main form' do
      fill_in 'Nome', with: 'Priscila'
      fill_in 'Sobrenome', with: 'Sabino'
      fill_in 'CPF', with: '12345678923'
      fill_in 'E-mail', with: 'pri@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Criar conta'
    end

    expect(page).to have_content 'Não foi possível salvar cliente: 1 erro'
    expect(page).to have_content 'CPF não é um CPF válido'
  end
end