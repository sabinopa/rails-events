require 'rails_helper'

describe 'User searches for a company' do
  it 'see field in navbar' do
    visit root_path

    within 'nav' do
      expect(page).to have_field 'Busque aqui...'
      expect(page).to have_button 'Buscar'
    end
  end

  it 'and finds several companies by brand name' do
    owner1 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company1 = Company.create!(owner_id: owner1.id, brand_name: 'Buffet dos Sonhos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '58.934.722/0001-01', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    owner2 = Owner.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet do Casamento', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '14.429.522/0001-18', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    owner3 = Owner.create!(name: 'Luciana', lastname: 'Melo', email: 'luciana@email.com', password: 'password123')
    company3 = Company.create!(owner_id: owner3.id, brand_name: 'Casamento e Festa', corporate_name: 'Alegrias e Festas Eventos Ltda',
                              registration_number: '07.746.011/0001-64', phone_number: '(11) 4455-6677', email: 'alegrias@festas.com.br',
                              address: 'Avenida da Alegria, 750', neighborhood: 'Cidade Feliz', city: 'Curitiba', state: 'PR', zipcode: '07070-070',
                              description: 'Especializados em eventos corporativos e sociais, Alegrias e Festas oferece experiências gastronômicas únicas.')

    owner4 = Owner.create!(name: 'Carlos', lastname: 'Pereira', email: 'carlos@email.com', password: '1234abcd')
    company4 = Company.create!(owner_id: owner4.id, brand_name: 'Gourmet Celebration', corporate_name: 'Gourmet Celebration Buffet Ltda',
                              registration_number: '81.145.049/0001-34', phone_number: '(11) 5566-7788', email: 'contato@gourmetcelebration.com',
                              address: 'Praça dos Eventos, 300', neighborhood: 'Gourmet Ville', city: 'Salvador', state: 'BA', zipcode: '08080-080',
                              description: 'Gourmet Celebration é sinônimo de elegância e sofisticação em buffets para casamentos e eventos corporativos.')

    owner5 = Owner.create!(name: 'Fernanda', lastname: 'Gomes', email: 'fernanda@email.com', password: 'abcd1234')
    company5 = Company.create!(owner_id: owner5.id, brand_name: 'Buffet Casamento Encantado', corporate_name: 'Buffet Encantado Eventos Ltda',
                              registration_number: '97.159.752/0001-31', phone_number: '(11) 6677-8899', email: 'contato@buffetencantado.com.br',
                              address: 'Alameda dos Eventos, 200', neighborhood: 'Festa no Parque', city: 'Belo Horizonte', state: 'MG', zipcode: '09090-090',
                              description: 'Buffet Encantado oferece um serviço completo de buffet para festas infantis, com temas personalizados e muita diversão.')
    expect(Company.count).to eq(5)
    visit root_path
    within 'nav' do
      fill_in 'Busque aqui...', with: 'Casamento'
      click_on 'Buscar'
    end

    expect(page).to have_content 'Resultados da busca por: Casamento'
    expect(page).to have_content '3 empresas encontradas!'
    expect(page).to have_link 'Buffet do Casamento'
    expect(page).to have_link 'Casamento e Festa'
    expect(page).to have_link 'Buffet Casamento Encantado'
    expect(page).not_to have_link 'Buffet dos Sonhos'
    expect(page).not_to have_link 'Gourmet Celebration'
  end

  it 'and finds several companies by city' do
    owner1 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company1 = Company.create!(owner_id: owner1.id, brand_name: 'Buffet dos Sonhos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '58.934.722/0001-01', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    owner2 = Owner.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet dos Casamentos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '14.429.522/0001-18', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    owner3 = Owner.create!(name: 'Luciana', lastname: 'Melo', email: 'luciana@email.com', password: 'password123')
    company3 = Company.create!(owner_id: owner3.id, brand_name: 'Casamento e Festa', corporate_name: 'Alegrias e Festas Eventos Ltda',
                              registration_number: '07.746.011/0001-64', phone_number: '(11) 4455-6677', email: 'alegrias@festas.com.br',
                              address: 'Avenida da Alegria, 750', neighborhood: 'Cidade Feliz', city: 'Curitiba', state: 'PR', zipcode: '07070-070',
                              description: 'Especializados em eventos corporativos e sociais, Alegrias e Festas oferece experiências gastronômicas únicas.')

    owner4 = Owner.create!(name: 'Carlos', lastname: 'Pereira', email: 'carlos@email.com', password: '1234abcd')
    company4 = Company.create!(owner_id: owner4.id, brand_name: 'Gourmet Celebration', corporate_name: 'Gourmet Celebration Buffet Ltda',
                              registration_number: '81.145.049/0001-34', phone_number: '(11) 5566-7788', email: 'contato@gourmetcelebration.com',
                              address: 'Praça dos Eventos, 300', neighborhood: 'Gourmet Ville', city: 'Salvador', state: 'BA', zipcode: '08080-080',
                              description: 'Gourmet Celebration é sinônimo de elegância e sofisticação em buffets para casamentos e eventos corporativos.')

    owner5 = Owner.create!(name: 'Fernanda', lastname: 'Gomes', email: 'fernanda@email.com', password: 'abcd1234')
    company5 = Company.create!(owner_id: owner5.id, brand_name: 'Buffet Casamento Encantado', corporate_name: 'Buffet Encantado Eventos Ltda',
                              registration_number: '97.159.752/0001-31', phone_number: '(11) 6677-8899', email: 'contato@buffetencantado.com.br',
                              address: 'Alameda dos Eventos, 200', neighborhood: 'Festa no Parque', city: 'Belo Horizonte', state: 'MG', zipcode: '09090-090',
                              description: 'Buffet Encantado oferece um serviço completo de buffet para festas infantis, com temas personalizados e muita diversão.')

    visit root_path
    fill_in 'Busque aqui...', with: 'Rio de Janeiro'
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da busca por: Rio de Janeiro'
    expect(page).to have_content '2 empresas encontradas!'
    expect(page).to have_link 'Buffet dos Sonhos'
    expect(page).to have_link 'Buffet dos Casamentos'
    expect(page).not_to have_link 'Casamento e Festa'
    expect(page).not_to have_link 'Gourmet Celebration'
    expect(page).not_to have_link 'Buffet Casamento Encantado'
  end

  it 'and finds several companies by event type name' do
    owner1 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company1 = Company.create!(owner_id: owner1.id, brand_name: 'Buffet dos Sonhos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '58.934.722/0001-01', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')
    event_type1 = EventType.create!(company_id: company1.id, name: 'Aniversário Super Heróis',
                                    description: 'Celebre um dia de herói com nossa festa temática de super heróis. Desfrute de decorações vibrantes, atividades interativas e um buffet que deixará todos com super poderes.',
                                    min_attendees: 20, max_attendees: 60, duration: 180,
                                    menu_description: 'Buffet inclui mini-pizzas, cupcakes temáticos, sucos energéticos e bolo espetacular em forma de capa de herói. Opções sem glúten disponíveis.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: true, location_type: 1)

    owner2 = Owner.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet dos Casamentos', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '14.429.522/0001-18', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')
    event_type2 = EventType.create!(company_id: company2.id,  name: 'Casamento Clássico Elegante',
                                    description: 'Um casamento clássico com um toque de elegância moderna. Oferecemos tudo que é necessário para um dia memorável, desde a cerimônia até a recepção com um buffet luxuoso.',
                                    min_attendees: 50, max_attendees: 200, duration: 360,
                                    menu_description: 'Desfrute de uma seleção de canapés finos, pratos principais sofisticados e uma variedade de sobremesas deliciosas. Serviço de bar completo disponível.',
                                    alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 1)


    owner3 = Owner.create!(name: 'Luciana', lastname: 'Melo', email: 'luciana@email.com', password: 'password123')
    company3 = Company.create!(owner_id: owner3.id, brand_name: 'Casamento e Festa', corporate_name: 'Alegrias e Festas Eventos Ltda',
                              registration_number: '07.746.011/0001-64', phone_number: '(11) 4455-6677', email: 'alegrias@festas.com.br',
                              address: 'Avenida da Alegria, 750', neighborhood: 'Cidade Feliz', city: 'Curitiba', state: 'PR', zipcode: '07070-070',
                              description: 'Especializados em eventos corporativos e sociais, Alegrias e Festas oferece experiências gastronômicas únicas.')
    event_type3 = EventType.create!(company_id: company3.id, name: 'Gala Corporativa',
                                    description: 'Organize seu evento corporativo conosco e garanta uma noite de sucesso com entretenimento de primeira linha, culinária requintada e decoração impecável.',
                                    min_attendees: 100, max_attendees: 500, duration: 240,
                                    menu_description: 'Buffet internacional com opções de pratos da culinária italiana, francesa e japonesa, além de uma seleção exclusiva de vinhos e espumantes.',
                                    alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 2)


    owner4 = Owner.create!(name: 'Carlos', lastname: 'Pereira', email: 'carlos@email.com', password: '1234abcd')
    company4 = Company.create!(owner_id: owner4.id, brand_name: 'Gourmet Celebration', corporate_name: 'Gourmet Celebration Buffet Ltda',
                              registration_number: '81.145.049/0001-34', phone_number: '(11) 5566-7788', email: 'contato@gourmetcelebration.com',
                              address: 'Praça dos Eventos, 300', neighborhood: 'Gourmet Ville', city: 'Salvador', state: 'BA', zipcode: '08080-080',
                              description: 'Gourmet Celebration é sinônimo de elegância e sofisticação em buffets para casamentos e eventos corporativos.')
    event_type4 = EventType.create!(company_id: company4.id, name: 'Noite de Vinhos e Jantar de Aniversário',
                                    description: 'Experimente uma noite de degustação de vinhos acompanhada por um jantar gourmet, perfeita para os amantes de boa comida e bebida.',
                                    min_attendees: 20, max_attendees: 100, duration: 180,
                                    menu_description: 'Jantar de cinco pratos com harmonização de vinhos cuidadosamente selecionados para complementar cada prato.',
                                    alcohol_available: true, decoration_available: false, parking_service_available: false, location_type: 1)


    owner5 = Owner.create!(name: 'Fernanda', lastname: 'Gomes', email: 'fernanda@email.com', password: 'abcd1234')
    company5 = Company.create!(owner_id: owner5.id, brand_name: 'Buffet Encantado', corporate_name: 'Buffet Encantado Eventos Ltda',
                              registration_number: '97.159.752/0001-31', phone_number: '(11) 6677-8899', email: 'contato@buffetencantado.com.br',
                              address: 'Alameda dos Eventos, 200', neighborhood: 'Festa no Parque', city: 'Belo Horizonte', state: 'MG', zipcode: '09090-090',
                              description: 'Buffet Encantado oferece um serviço completo de buffet para festas infantis, com temas personalizados e muita diversão.')
    event_type5 = EventType.create!(company_id: company5.id, name: 'Aniversário do Pijama Encantada',
                                    description: 'Uma festa do pijama mágica para as crianças, cheia de atividades divertidas, contação de histórias e um buffet de dar água na boca.',
                                    min_attendees: 10, max_attendees: 30, duration: 480,
                                    menu_description: 'Snacks leves, sanduíches de formas divertidas, sucos naturais e uma variedade de bolos e doces temáticos.',
                                    alcohol_available: false, decoration_available: true, parking_service_available: false, location_type: 0)


    visit root_path
    fill_in 'Busque aqui...', with: 'Aniversário'
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da busca por: Aniversário'
    expect(page).to have_content '3 empresas encontradas!'
    expect(page).to have_link 'Buffet dos Sonhos'
    expect(page).to have_link 'Gourmet Celebration'
    expect(page).to have_link 'Buffet Encantado'
    expect(page).not_to have_link 'Buffet dos Casamentos'
    expect(page).not_to have_link 'Casamento e Festa'
  end

  it 'returns companies in alphabetical order by brand_name' do
    owner1 = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
    company1 = Company.create!(owner_id: owner1.id, brand_name: 'Sonhos de Casamento', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '58.934.722/0001-01', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    owner2 = Owner.create!(name: 'Roberto', lastname: 'Carvalho', email: 'roberto@email.com', password: '87654321')
    company2 = Company.create!(owner_id: owner2.id, brand_name: 'Buffet do Casamento', corporate_name: 'Buffet dos Sonhos Ltda',
                              registration_number: '14.429.522/0001-18', phone_number: '(11) 3344-5566', email: 'contato@buffetdossonhos.com',
                              address: 'Rua das Festas, 500', neighborhood: 'Jardim das Flores', city: 'Rio de Janeiro', state: 'RJ', zipcode: '06060-060',
                              description: 'Buffet dos Sonhos transforma sua festa em um evento inesquecível, com cardápios personalizados para todas as idades.')

    owner3 = Owner.create!(name: 'Luciana', lastname: 'Melo', email: 'luciana@email.com', password: 'password123')
    company3 = Company.create!(owner_id: owner3.id, brand_name: 'Casamento e Festa', corporate_name: 'Alegrias e Festas Eventos Ltda',
                              registration_number: '07.746.011/0001-64', phone_number: '(11) 4455-6677', email: 'alegrias@festas.com.br',
                              address: 'Avenida da Alegria, 750', neighborhood: 'Cidade Feliz', city: 'Curitiba', state: 'PR', zipcode: '07070-070',
                              description: 'Especializados em eventos corporativos e sociais, Alegrias e Festas oferece experiências gastronômicas únicas.')

    owner4 = Owner.create!(name: 'Carlos', lastname: 'Pereira', email: 'carlos@email.com', password: '1234abcd')
    company4 = Company.create!(owner_id: owner4.id, brand_name: 'Gourmet Celebration e Casamentos', corporate_name: 'Gourmet Celebration Buffet Ltda',
                              registration_number: '81.145.049/0001-34', phone_number: '(11) 5566-7788', email: 'contato@gourmetcelebration.com',
                              address: 'Praça dos Eventos, 300', neighborhood: 'Gourmet Ville', city: 'Salvador', state: 'BA', zipcode: '08080-080',
                              description: 'Gourmet Celebration é sinônimo de elegância e sofisticação em buffets para casamentos e eventos corporativos.')

    visit root_path
    fill_in 'Busque aqui...', with: 'Casamento'
    click_on 'Buscar'

    results = Company.search('Casamento').map(&:brand_name)
    expected_results = [company1, company3, company2, company4].map(&:brand_name).sort

    expect(results).to eq(expected_results)
  end

  it 'and does not find any company' do
    visit root_path
    fill_in 'Busque aqui...', with: 'Salvador'
    click_on 'Buscar'

    expect(page).to have_content 'Resultados da busca por: Salvador'
    expect(page).to have_content 'Nenhuma empresa encontrada.'
  end

  it 'and returns to home page' do
    visit root_path
    fill_in 'Busque aqui...', with: 'Salvador'
    click_on 'Buscar'
    click_on 'Voltar'

    expect(current_path).to eq root_path
  end
end