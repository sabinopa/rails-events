require 'rails_helper'

describe 'Supplier creates company' do
  it 'must be authenticated' do
    visit new_company_path

    expect(current_path).to eq new_supplier_session_path
  end

  it 'by being redirected after registration' do
    visit root_path
    click_on 'Criar conta'
    within 'form' do
      fill_in 'Nome', with: 'Priscila'
      fill_in 'Sobrenome', with: 'Sabino'
      fill_in 'E-mail', with: 'priscila@email.com'
      fill_in 'Senha', with: '12345678'
      fill_in 'Confirme sua senha', with: '12345678'
      click_on 'Criar conta'
    end

    expect(current_path).to eq new_company_path
  end
end