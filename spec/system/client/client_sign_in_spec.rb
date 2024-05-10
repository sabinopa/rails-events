require 'rails_helper'

describe 'Client authenticates' do
  it 'successfully' do
    client = Client.create!(name: 'Priscila', lastname: 'Sabino', document_number: '525.202.290-98',
                            email: 'priscila@email.com', password: '12345678')

    visit root_path
    within 'nav' do
      click_on 'Entrar como Cliente'
    end
    within 'main form' do
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      click_on 'Entrar'
    end

    within 'nav' do
      expect(page).not_to have_link 'Entrar como Cliente'
      expect(page).not_to have_link 'Cadastre sua empresa'
      expect(page).to have_button 'Sair'
      expect(page).to have_content 'Priscila Sabino - priscila@email.com'
    end
    expect(page).to have_content 'Login efetuado com sucesso.'
  end
end