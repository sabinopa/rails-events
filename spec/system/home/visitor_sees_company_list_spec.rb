require 'rails_helper'

describe 'Visitor sees companies list' do
  it 'from home page' do
    supplier1 = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company1 = Company.create!(supplier_id: supplier1.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: '12.333.456/0001-78', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

    supplier2 = Supplier.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company2 = Company.create!(supplier_id: supplier2.id, brand_name: 'Buffet dos Sonhos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '23.444.567/0001-89', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    supplier3 = Supplier.create!(name: 'Luciana', lastname: 'Melo', email: 'luciana@email.com', password: 'password123')
    company3 = Company.create!(supplier_id: supplier3.id, brand_name: 'Alegrias e Festas', corporate_name: 'Alegrias e Festas Eventos Ltda',
                              registration_number: '34.555.678/0001-90', phone_number: '(11) 4455-6677', email: 'alegrias@festas.com.br',
                              address: 'Avenida da Alegria, 750', neighborhood: 'Cidade Feliz', city: 'Curitiba', state: 'PR', zipcode: '07070-070',
                              description: 'Especializados em eventos corporativos e sociais, Alegrias e Festas oferece experiências gastronômicas únicas.')

    supplier4 = Supplier.create!(name: 'Carlos', lastname: 'Pereira', email: 'carlos@email.com', password: '1234abcd')
    company4 = Company.create!(supplier_id: supplier4.id, brand_name: 'Gourmet Celebration', corporate_name: 'Gourmet Celebration Buffet Ltda',
                              registration_number: '45.666.789/0001-01', phone_number: '(11) 5566-7788', email: 'contato@gourmetcelebration.com',
                              address: 'Praça dos Eventos, 300', neighborhood: 'Gourmet Ville', city: 'Salvador', state: 'BA', zipcode: '08080-080',
                              description: 'Gourmet Celebration é sinônimo de elegância e sofisticação em buffets para casamentos e eventos corporativos.')

    supplier5 = Supplier.create!(name: 'Fernanda', lastname: 'Gomes', email: 'fernanda@email.com', password: 'abcd1234')
    company5 = Company.create!(supplier_id: supplier5.id, brand_name: 'Buffet Encantado', corporate_name: 'Buffet Encantado Eventos Ltda',
                              registration_number: '56.777.890/0001-12', phone_number: '(11) 6677-8899', email: 'contato@buffetencantado.com.br',
                              address: 'Alameda dos Eventos, 200', neighborhood: 'Festa no Parque', city: 'Belo Horizonte', state: 'MG', zipcode: '09090-090',
                              description: 'Buffet Encantado oferece um serviço completo de buffet para festas infantis, com temas personalizados e muita diversão.')

    visit root_path

    expect(page).to have_content 'Estrelas Mágicas'
    expect(page).to have_content 'São Paulo, SP'
    expect(page).to have_content 'Buffet dos Sonhos'
    expect(page).to have_content 'Rio de Janeiro, RJ'
    expect(page).to have_content 'Alegrias e Festas'
    expect(page).to have_content 'Curitiba, PR'
    expect(page).to have_content 'Gourmet Celebration'
    expect(page).to have_content 'Salvador, BA'
    expect(page).to have_content 'Buffet Encantado'
    expect(page).to have_content 'Belo Horizonte, MG'
  end
end