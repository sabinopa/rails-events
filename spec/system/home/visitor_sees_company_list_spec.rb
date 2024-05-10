require 'rails_helper'

describe 'Visitor sees companies list' do
  it 'from home page' do
    owner1 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company1 = Company.create!(owner_id: owner1.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                              registration_number: '58.934.722/0001-01', phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                              address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                              description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

    owner2 = Owner.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet dos Sonhos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '82.462.797/0001-03', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    owner3 = Owner.create!(name: 'Luciana', lastname: 'Melo', email: 'luciana@email.com', password: 'password123')
    company3 = Company.create!(owner_id: owner3.id, brand_name: 'Alegrias e Festas', corporate_name: 'Alegrias e Festas Eventos Ltda',
                              registration_number: '45.038.098/0001-04', phone_number: '(11) 4455-6677', email: 'alegrias@festas.com.br',
                              address: 'Avenida da Alegria, 750', neighborhood: 'Cidade Feliz', city: 'Curitiba', state: 'PR', zipcode: '07070-070',
                              description: 'Especializados em eventos corporativos e sociais, Alegrias e Festas oferece experiências gastronômicas únicas.')

    owner4 = Owner.create!(name: 'Carlos', lastname: 'Pereira', email: 'carlos@email.com', password: '1234abcd')
    company4 = Company.create!(owner_id: owner4.id, brand_name: 'Gourmet Celebration', corporate_name: 'Gourmet Celebration Buffet Ltda',
                              registration_number: '33.649.961/0001-80', phone_number: '(11) 5566-7788', email: 'contato@gourmetcelebration.com',
                              address: 'Praça dos Eventos, 300', neighborhood: 'Gourmet Ville', city: 'Salvador', state: 'BA', zipcode: '08080-080',
                              description: 'Gourmet Celebration é sinônimo de elegância e sofisticação em buffets para casamentos e eventos corporativos.')

    owner5 = Owner.create!(name: 'Fernanda', lastname: 'Gomes', email: 'fernanda@email.com', password: 'abcd1234')
    company5 = Company.create!(owner_id: owner5.id, brand_name: 'Buffet Encantado', corporate_name: 'Buffet Encantado Eventos Ltda',
                              registration_number: '14.429.522/0001-18', phone_number: '(11) 6677-8899', email: 'contato@buffetencantado.com.br',
                              address: 'Alameda dos Eventos, 200', neighborhood: 'Festa no Parque', city: 'Belo Horizonte', state: 'MG', zipcode: '09090-090',
                              description: 'Buffet Encantado oferece um serviço completo de buffet para festas infantis, com temas personalizados e muita diversão.')

    visit root_path

    expect(page).to have_link 'Estrelas Mágicas'
    expect(page).to have_content 'São Paulo, SP'
    expect(page).to have_link 'Buffet dos Sonhos'
    expect(page).to have_content 'Rio de Janeiro, RJ'
    expect(page).to have_link 'Alegrias e Festas'
    expect(page).to have_content 'Curitiba, PR'
    expect(page).to have_link 'Gourmet Celebration'
    expect(page).to have_content 'Salvador, BA'
    expect(page).to have_link 'Buffet Encantado'
    expect(page).to have_content 'Belo Horizonte, MG'
  end
end