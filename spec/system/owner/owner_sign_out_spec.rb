require 'rails_helper'

describe 'Supplier sign out' do
  it 'successfully' do
    supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    login_as(supplier, :scope => :supplier)
    visit root_path
    within 'nav' do
      click_button 'Sair'
    end

    within 'nav' do
      expect(page).to have_link 'Entrar como Fornecedor'
      expect(page).not_to have_button 'Sair'
      expect(page).not_to have_content 'Priscila Sabino - priscila@email.com'
    end
    expect(page).to have_content 'Logout efetuado com sucesso.'
  end
end