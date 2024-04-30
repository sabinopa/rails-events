require 'rails_helper'

describe 'Visitor sees company details' do
  it 'from home page' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Buffet dos Sonhos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '58.934.722/0001-01', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')
                              company.payment_methods << [pix, credito, debito]
    visit root_path
    click_on 'Buffet dos Sonhos'

    expect(current_path).to eq company_path(company.id)
    expect(page).to have_content 'Buffet dos Sonhos'
    expect(page).to have_content 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.'
    expect(page).to have_content '58.934.722/0001-01'
    expect(page).to have_content 'Rua das Festas, 500'
    expect(page).to have_content 'Jardim das Flores, Rio de Janeiro - RJ, 06060-060'
    expect(page).to have_content 'PIX | Cartão de Crédito | Cartão de Débito'
    expect(page).not_to have_content 'Estrelas Mágicas Buffet Infantil Ltda'
  end

  it 'and returns to homepage' do
    pix = PaymentMethod.create!(method: 'PIX')
    credito = PaymentMethod.create!(method: 'Cartão de Crédito')
    debito = PaymentMethod.create!(method: 'Cartão de Débito')
    supplier = Supplier.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company = Company.create!(supplier_id: supplier.id, brand_name: 'Buffet dos Sonhos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '58.934.722/0001-01', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')
                              company.payment_methods << [pix, credito, debito]
    visit company_path(company.id)
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end