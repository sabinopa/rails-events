require 'rails_helper'

describe 'Client sign out' do
  it 'successfully' do
    client = Client.create!(name: 'Priscila', lastname: 'Sabino',document_number: '525.202.290-98',
                            email: 'priscila@email.com', password: '12345678')

    login_as(client, :scope => :client)
    visit root_path
    within 'nav' do
      click_button 'Sair'
    end

    within 'nav' do
      expect(page).to have_link 'Entrar como Cliente'
      expect(page).to have_link 'Entrar como Fornecedor'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'Priscila Sabino - priscila@email.com'
    end
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end