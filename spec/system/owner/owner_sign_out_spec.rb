require 'rails_helper'

describe 'Owner sign out' do
  it 'successfully' do
    owner = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    login_as(owner, :scope => :owner)
    visit root_path
    within 'nav' do
      click_button 'Sair'
    end

    within 'nav' do
      expect(page).to have_link 'Entrar'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'Priscila Sabino - priscila@email.com'
    end
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end