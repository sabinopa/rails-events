Order.destroy_all
EventPricing.destroy_all
EventType.destroy_all
Company.destroy_all
Owner.destroy_all
PaymentMethod.destroy_all
Client.destroy_all

# Métodos de Pagamento
pix = PaymentMethod.create!(method: 'PIX')
credito = PaymentMethod.create!(method: 'Cartão de Crédito')
debito = PaymentMethod.create!(method: 'Cartão de Débito')
dinheiro = PaymentMethod.create!(method: 'Dinheiro')

p "Created #{PaymentMethod.count} payment methods"

# Proprietários
priscila = Owner.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
pedro = Owner.create!(name: 'Pedro', lastname: 'Araujo', email: 'pedro@email.com', password: 'senhasenha')
guilherme = Owner.create!(name: 'Guilherme', lastname: 'Alvares', email: 'guilherme@email.com', password: 'password')
isabel = Owner.create!(name: 'Isabel', lastname: 'Maria', email: 'isabel@email.com', password: 'secret123')
livia = Owner.create!(name: 'Livia', lastname: 'Alves', email: 'livia@email.com', password: '09876543')

p "Created #{Owner.count} owners"

# Clientes
joao = Client.create!(name: 'João', lastname: 'Silva', email: 'joao@email.com', document_number: '926.020.550-69', password: 'senha123')
maria = Client.create!(name: 'Maria', lastname: 'Fernandes', email: 'maria@email.com', document_number: '607.560.260-75', password: 'senha321')
carlos = Client.create!(name: 'Carlos', lastname: 'Machado', email: 'carlos@email.com', document_number: '954.511.300-60', password: 'senha456')
ana = Client.create!(name: 'Ana', lastname: 'Pereira', email: 'ana@email.com', document_number: '496.830.670-93', password: 'senha654')
lucas = Client.create!(name: 'Lucas', lastname: 'Costa', email: 'lucas@email.com', document_number: '194.917.200-74', password: 'senha234')

p "Created #{Client.count} clients"

# Empresas
celebracao_alegre = Company.create!(owner_id: priscila.id, brand_name: 'Celebração Alegre', corporate_name: 'Celebração Alegre Buffet Ltda',
                                  registration_number: '58.934.722/0001-01',  phone_number: '(11) 98765-4321', email: 'contato@celebracaoalegre.com.br',
                                  address: 'Rua das Flores, 123', neighborhood: 'Jardim Primavera', city: 'São Paulo', state: 'SP', zipcode: '01234-567',
                                  description: 'Especializados em casamentos e eventos corporativos, oferecemos um serviço completo de buffet com uma vasta opção de cardápios personalizados.',
                                  status: :active)
                                  celebracao_alegre.payment_methods << [pix, debito]

festim_sonhos = Company.create!(owner_id: pedro.id, brand_name: 'Festim dos Sonhos', corporate_name: 'Festim dos Sonhos Eventos S.A.',
                              registration_number: '63.112.924/0001-08',  phone_number: '(21) 4444-5555', email: 'sonhos@festim.com.br',
                              address: 'Avenida Central, 456', neighborhood: 'Centro', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                              description: 'Com uma equipe de chefs renomados, proporcionamos uma experiência culinária inesquecível para seu evento.',
                              status: :active)
                              festim_sonhos.payment_methods << [credito, debito]

gastronomia_estelar = Company.create!(owner_id: guilherme.id, brand_name: 'Gastronomia Estelar', corporate_name: 'Gastronomia Estelar Ltda',
                              registration_number: '54.457.025/0001-48',  phone_number: '(31) 6666-7777', email: 'contato@gastronomiaestelar.com.br',
                              address: 'Praça da Liberdade, 789', neighborhood: 'Savassi', city: 'Belo Horizonte', state: 'MG', zipcode: '30140-010',
                              description: 'Oferecemos um serviço exclusivo de buffet e catering com foco em ingredientes orgânicos e sustentáveis.',
                              status: :active)
                              gastronomia_estelar.payment_methods << [pix, credito, debito]

banquete_real = Company.create!(owner_id: isabel.id, brand_name: 'Banquete Real', corporate_name: 'Banquete Real Buffet S.A.',
                              registration_number: '26.876.789/0001-32',  phone_number: '(41) 8888-9999', email: 'real@banquetebuffet.com.br',
                              address: 'Rua Majestosa, 1010', neighborhood: 'Batel', city: 'Curitiba', state: 'PR', zipcode: '80420-000',
                              description: 'Transformamos seu evento em um verdadeiro banquete real, com serviços de buffet e decoração de alto padrão',
                              status: :active)
                              banquete_real.payment_methods << [credito, debito]

sabores_mundo = Company.create!(owner_id: livia.id, brand_name: 'Sabores do Mundo', corporate_name: 'Sabores do Mundo Buffet Internacional Eireli',
                              registration_number: '24.282.155/0001-26',  phone_number: '(51) 1010-2020', email: 'contato@saboresdomundo.com.br',
                              address: 'Rua da Paz, 1313', neighborhood: 'Moinhos de Vento', city: 'Porto Alegre', state: 'RS', zipcode: '90500-000',
                              description: 'Especializados em culinária internacional, nosso buffet traz sabores únicos de diferentes partes do mundo para seu evento.',
                              status: :active)
                              sabores_mundo.payment_methods << [credito, debito]

p "Created #{Company.count} companies"

# Para a empresa Celebração Alegre
casamento = EventType.create!(company_id: celebracao_alegre.id, name: 'Casamento dos Sonhos',
                            description: 'O nosso pacote "Casamento dos Sonhos" é o ápice da sofisticação e do romance. Com um serviço de buffet personalizado, decoração floral deslumbrante e uma equipe dedicada a tornar cada detalhe perfeito, garantimos que seu dia especial seja inesquecível.',
                            min_attendees: 50, max_attendees: 300, duration: 480,
                            menu_description: 'Uma seleção gourmet que inclui entradas frias e quentes, pratos principais sofisticados com opções vegetarianas, veganas e sem glúten, além de uma estação de sobremesas com doces finos e um bolo de casamento personalizado.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 1, status: :active)
                            casamento.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'casamento_2.jpg')), filename: 'casamento_2.jpg')
                            casamento.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'casamento_1.jpg')), filename: 'casamento_1.jpg')
                            casamento.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'casamento_3.jpg')), filename: 'casamento_3.jpg')

corporativo = EventType.create!(company_id: celebracao_alegre.id, name: 'Gala Corporativa Elegante',
                            description: 'Nossa Gala Corporativa Elegante é a escolha perfeita para empresas que desejam impressionar. Oferecemos um ambiente sofisticado, com serviço de buffet de alto padrão, apresentações audiovisuais de última geração e uma equipe pronta para atender todas as necessidades empresariais.',
                            min_attendees: 100, max_attendees: 500, duration: 300,
                            menu_description: 'Um buffet exclusivo que inclui canapés gourmet, estações de comida ao vivo, pratos internacionais elaborados e uma ampla seleção de bebidas holiday, incluindo coquetéis personalizados e vinhos selecionados.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 2, status: :active)
                            corporativo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'corporativo_1.jpg')), filename: 'corporativo_1.jpg')
                            corporativo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'corporativo_2.jpg')), filename: 'corporativo_2.jpg')
                            corporativo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'corporativo_3.jpg')), filename: 'corporativo_3.jpg')

# Para a empresa Festim dos Sonhos
brunch_network = EventType.create!(company_id: festim_sonhos.id, name: 'Brunch Empresarial de Networking',
                                description: 'Nosso Brunch Empresarial oferece uma atmosfera descontraída e elegante para networking e reuniões de negócios. Com uma variedade de opções gastronômicas que agradam todos os paladares, este evento promove a interação em um ambiente propício ao desenvolvimento de relações profissionais.',
                                min_attendees: 50, max_attendees: 100, duration: 180,
                                menu_description: 'Uma seleção diversificada de itens de brunch, incluindo estações de omeletes, variedades de pães artesanais, frutas frescas, queijos finos, carnes frias, e uma ampla escolha de bebidas, desde cafés especiais até sucos naturais e mimosas.',
                                alcohol_available: true, decoration_available: true, parking_service_available: false, location_type: 2, status: :active)
                                brunch_network.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'brunch_network_2.jpg')), filename: 'brunch_network_2.jpg')
                                brunch_network.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'brunch_network_1.jpg')), filename: 'brunch_network_1.jpg')
                                brunch_network.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'brunch_network_3.jpg')), filename: 'brunch_network_3.jpg')

jantar_gourmet = EventType.create!(company_id: festim_sonhos.id, name: 'Jantar de Gala Gourmet',
                            description: 'O Jantar de Gala Gourmet do Festim dos Sonhos é uma experiência culinária de alto nível, perfeito para ocasiões especiais. Com um menu exclusivo criado por nossos chefs renomados, cada prato é uma obra de arte, acompanhado de uma seleção impecável de vinhos e ambientação sofisticada.',
                            min_attendees: 20, max_attendees: 80, duration: 240,
                            menu_description: 'Menu de cinco pratos, incluindo amuse-bouche, entrada, prato principal, sobremesa e mignardises. Ingredientes frescos e da estação, com opções para necessidades dietéticas específicas.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 1, status: :active)
                            jantar_gourmet.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'jantar_gourmet_1.jpg')), filename: 'jantar_gourmet_1.jpg')
                            jantar_gourmet.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'jantar_gourmet_2.jpg')), filename: 'jantar_gourmet_2.jpg')
                            jantar_gourmet.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'jantar_gourmet_3.jpg')), filename: 'jantar_gourmet_3.jpg')

# Para a empresa Gastronomia Estelar
noite_organica = EventType.create!(company_id: gastronomia_estelar.id, name: 'Noite de Degustação Orgânica',
                            description: ' Uma experiência culinária única onde os convidados têm a oportunidade de degustar uma variedade de pratos feitos exclusivamente com ingredientes orgânicos e sustentáveis. Acompanhado de uma seleção de vinhos naturais e orgânicos, este evento é uma celebração dos sabores autênticos e da culinária consciente.',
                            min_attendees: 20, max_attendees: 100, duration: 180,
                            menu_description: 'Cardápio degustação em cinco etapas, com pratos que destacam os ingredientes da estação. Inclui aperitivos, entradas, prato principal, sobremesa e uma seleção especial de queijos artesanais locais.',
                            alcohol_available: true, decoration_available: true, parking_service_available: false, location_type: 1, status: :active)
                            noite_organica.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'noite_organica_1.jpg')), filename: 'noite_organica_1.jpg')
                            noite_organica.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'noite_organica_2.jpg')), filename: 'noite_organica_2.jpg')
                            noite_organica.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'noite_organica_3.jpg')), filename: 'noite_organica_3.jpg')

piquenique = EventType.create!(company_id: gastronomia_estelar.id, name: 'Piquenique Gourmet Sustentável',
                            description: 'Um evento ao ar livre que combina o prazer de comer ao fresco com a consciência ecológica. Ideal para grupos que buscam uma experiência gastronômica diferente, nosso piquenique gourmet inclui cestas repletas de delícias orgânicas, cobertores e jogos de campo, tudo com o menor impacto ambiental possível.',
                            min_attendees: 10, max_attendees: 50, duration: 240,
                            menu_description: 'Cestas de piquenique individuais com sanduíches gourmet, saladas frescas, frutas da estação, sucos prensados a frio e sobremesas naturais. Todos os itens são preparados com ingredientes orgânicos e embalados de forma ecológica.',
                            alcohol_available: false, decoration_available: true, parking_service_available: false, location_type: 1, status: :active)
                            piquenique.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'pic_nic_1.jpg')), filename: 'pic_nic_1.jpg')
                            piquenique.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'pic_nic_2.jpg')), filename: 'pic_nic_2.jpg')

# Para a empresa Banquete Real
debutante_luxo = EventType.create!(company_id: banquete_real.id, name: 'Cerimônia de Debutante Luxuosa',
                            description: 'Nossa Cerimônia de Debutante Luxuosa é o epítome da elegância e sofisticação. Com um serviço de buffet exclusivo, decoração opulenta e atenção meticulosa a todos os detalhes, garantimos que sua comemoração seja uma ocasião verdadeiramente real e inesquecível.',
                            min_attendees: 100, max_attendees: 500, duration: 480,
                            menu_description: 'Um banquete digno da realeza, incluindo uma vasta seleção de canapés finos, pratos principais gourmet, uma deslumbrante torre de sobremesas e um bar completo com as melhores bebidas.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 2, status: :active)
                            debutante_luxo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'debutante_luxo_1.jpg')), filename: 'debutante_luxo_1.jpg')
                            debutante_luxo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'debutante_luxo_2.jpg')), filename: 'debutante_luxo_2.jpg')
                            debutante_luxo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'debutante_luxo_3.jpg')), filename: 'debutante_luxo_3.jpg')

gala_premiacao = EventType.create!(company_id: banquete_real.id, name: 'Gala de Premiação Estelar',
                            description: 'Ideal para eventos de premiação e celebrações corporativas, a Gala de Premiação Estelar oferece um ambiente sofisticado e serviços de primeira linha. Nosso buffet de gala é acompanhado de uma decoração impecável, criando um cenário perfeito para homenagear os conquistadores da noite.',
                            min_attendees: 150, max_attendees: 1000, duration: 360,
                            menu_description: 'Um esplêndido buffet composto por estações de comida internacional, pratos assinados por chefs renomados, e uma extensa carta de vinhos e coquetéis holiday.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 2, status: :active)
                            gala_premiacao.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'gala_premiacao_1.jpg')), filename: 'gala_premiacao_1.jpg')
                            gala_premiacao.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'gala_premiacao_2.jpg')), filename: 'gala_premiacao_2.jpg')

# Para a empresa Sabores do Mundo
noite_gastronomica = EventType.create!(company_id: sabores_mundo.id, name: 'Volta ao Mundo em 80 Pratos',
                            description: 'Uma experiência gastronômica inesquecível que leva seus convidados a uma jornada culinária ao redor do globo. Este evento oferece uma degustação de pratos típicos de diversos países, cada um cuidadosamente preparado para representar sua região de origem.',
                            min_attendees: 50, max_attendees: 200, duration: 400,
                            menu_description: 'Uma seleção diversificada que inclui desde tapas espanholas, sushi japonês, até pratos tradicionais brasileiros e sobremesas francesas. Acompanha uma seleção de bebidas internacionais.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 0, status: :active)
                            noite_gastronomica.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'noite_gastronomica_1.jpg')), filename: 'noite_gastronomica_1.jpg')
                            noite_gastronomica.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'noite_gastronomica_2.jpg')), filename: 'noite_gastronomica_2.jpg')

food_truck = EventType.create!(company_id: sabores_mundo.id, name: 'Festival Internacional de Food Trucks',
                            description: 'Levamos a diversidade culinária das ruas do mundo para o seu evento. Este festival apresenta uma série de food trucks, cada um oferecendo uma especialidade internacional diferente, criando uma atmosfera casual e interativa para os convidados explorarem.',
                            min_attendees: 100, max_attendees: 500, duration: 240,
                            menu_description: 'Food trucks especializados em uma variedade de cozinhas, incluindo italiana, mexicana, indiana, e tailandesa. Opções para todos os gostos, desde pratos picantes até sobremesas geladas e refrescantes.',
                            alcohol_available: true, decoration_available: false, parking_service_available: false, location_type: 1, status: :active)
                            food_truck.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'food_truck_1.jpg')), filename: 'food_truck_1.jpg')
                            food_truck.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'food_truck_2.jpg')), filename: 'food_truck_2.jpg')

p "Created #{EventType.count} event types"

# Pricing para Casamentos no Fim de Semana
weekend_pricing = EventPricing.create!(event_type_id: casamento.id, base_price: 1200.0, base_attendees: 50,
                                      additional_attendee_price: 100.0, extra_hour_price: 100.0, day_options: :weekend)

# Pricing para Casamentos durante a Semana
weekday_pricing = EventPricing.create!(event_type_id: casamento.id, base_price: 800.0, base_attendees: 50,
                                      additional_attendee_price: 75.0,extra_hour_price: 80.0, day_options: :weekday)

# Pricing Premium para Casamentos em Feriados
holiday_pricing = EventPricing.create!(event_type_id: casamento.id, base_price: 1500.0, base_attendees: 50,
                                      additional_attendee_price: 150.0, extra_hour_price: 120.0, day_options: :holiday)

# Pricing para Galas Corporativas durante a Semana
weekday_corporate_pricing = EventPricing.create!(event_type_id: corporativo.id, base_price: 2000.0, base_attendees: 100,
                                                additional_attendee_price: 80.0,extra_hour_price: 150.0, day_options: :weekday)

# Pricing para Galas Corporativas no Fim de Semana
weekend_corporate_pricing = EventPricing.create!(event_type_id: corporativo.id, base_price: 2500.0, base_attendees: 100,
                                                additional_attendee_price: 100.0,extra_hour_price: 200.0, day_options: :weekend)

# Pricing Premium para Galas Corporativas em Feriados
holiday_corporate_pricing = EventPricing.create!(event_type_id: corporativo.id,base_price: 3000.0, base_attendees: 100,
                                                additional_attendee_price: 120.0, extra_hour_price: 250.0,day_options: :holiday)

# Pricing para Jantares Gourmet durante a Semana
weekday_gourmet_pricing = EventPricing.create!(event_type_id: jantar_gourmet.id, base_price: 1800.0, base_attendees: 20,
                                              additional_attendee_price: 90.0, extra_hour_price: 100.0, day_options: :weekday)

# Pricing para Jantares Gourmet no Fim de Semana
weekend_gourmet_pricing = EventPricing.create!(event_type_id: jantar_gourmet.id, base_price: 2200.0, base_attendees: 20,
                                              additional_attendee_price: 110.0, extra_hour_price: 150.0, day_options: :weekend)

# Pricing Premium para Jantares Gourmet em Feriados
holiday_gourmet_pricing = EventPricing.create!(event_type_id: jantar_gourmet.id, base_price: 2500.0, base_attendees: 20,
                                              additional_attendee_price: 120.0, extra_hour_price: 200.0, day_options: :holiday)

# Pricing para Brunch Empresarial durante a Semana
weekday_brunch_networking_pricing = EventPricing.create!(event_type_id: brunch_network.id, base_price: 1500.0, base_attendees: 50,
                                                        additional_attendee_price: 30.0, extra_hour_price: 70.0, day_options: :weekday)

# Pricing para Brunch Empresarial no Fim de Semana
weekend_brunch_networking_pricing = EventPricing.create!(event_type_id: brunch_network.id, base_price: 1800.0, base_attendees: 50,
                                                        additional_attendee_price: 40.0,extra_hour_price: 90.0, day_options: :weekend)

# Pricing Premium para Brunch Empresarial em Feriados
holiday_brunch_networking_pricing = EventPricing.create!(event_type_id: brunch_network.id, base_price: 2000.0, base_attendees: 50,
                                                        additional_attendee_price: 50.0, extra_hour_price: 100.0, day_options: :holiday)

# Pricing para Noite de Degustação Orgânica durante a Semana
weekday_organic_tasting_pricing = EventPricing.create!(event_type_id: noite_organica.id, base_price: 1600.0, base_attendees: 20,
                                                      additional_attendee_price: 80.0, extra_hour_price: 100.0, day_options: :weekday)

# Pricing para Noite de Degustação Orgânica no Fim de Semana
weekend_organic_tasting_pricing = EventPricing.create!(event_type_id: noite_organica.id, base_price: 2000.0, base_attendees: 20,
                                                      additional_attendee_price: 100.0,extra_hour_price: 120.0, day_options: :weekend)

# Pricing Premium para Noite de Degustação Orgânica em Feriados
holiday_organic_tasting_pricing = EventPricing.create!(event_type_id: noite_organica.id,base_price: 2400.0,base_attendees: 20,
                                                      additional_attendee_price: 120.0, extra_hour_price: 150.0,day_options: :holiday)

# Pricing para Piquenique Gourmet durante a Semana
weekday_picnic_pricing = EventPricing.create!(event_type_id: piquenique.id, base_price: 1200.0, base_attendees: 10,
                                              additional_attendee_price: 50.0,extra_hour_price: 50.0, day_options: :weekday)

# Pricing para Piquenique Gourmet no Fim de Semana
weekend_picnic_pricing = EventPricing.create!(event_type_id: piquenique.id, base_price: 1500.0, base_attendees: 10,
                                              additional_attendee_price: 70.0,extra_hour_price: 75.0, day_options: :weekend)

# Pricing Premium para Piquenique Gourmet em Feriados
holiday_picnic_pricing = EventPricing.create!(event_type_id: piquenique.id, base_price: 1800.0, base_attendees: 10,
                                              additional_attendee_price: 100.0,extra_hour_price: 100.0, day_options: :holiday)

# Pricing para Cerimônia de Casamento Luxuosa durante a Semana
weekday_luxury_wedding_pricing = EventPricing.create!(event_type_id: debutante_luxo.id, base_price: 5000.0, base_attendees: 100,
                                                      additional_attendee_price: 150.0,extra_hour_price: 200.0, day_options: :weekday)

# Pricing para Cerimônia de Casamento Luxuosa no Fim de Semana
weekend_luxury_wedding_pricing = EventPricing.create!(event_type_id: debutante_luxo.id, base_price: 7000.0, base_attendees: 100,
                                                      additional_attendee_price: 200.0,extra_hour_price: 250.0, day_options: :weekend)

# Pricing Premium para Cerimônia de Casamento Luxuosa em Feriados
holiday_luxury_wedding_pricing = EventPricing.create!(event_type_id: debutante_luxo.id, base_price: 9000.0, base_attendees: 100,
                                                      additional_attendee_price: 250.0,extra_hour_price: 300.0, day_options: :holiday)

# Pricing para Gala de Premiação durante a Semana
weekday_award_gala_pricing = EventPricing.create!(event_type_id: gala_premiacao.id, base_price: 8000.0, base_attendees: 150,
                                                  additional_attendee_price: 100.0,extra_hour_price: 500.0, day_options: :weekday)

# Pricing para Gala de Premiação no Fim de Semana
weekend_award_gala_pricing = EventPricing.create!(event_type_id: gala_premiacao.id, base_price: 10000.0, base_attendees: 150,
                                                  additional_attendee_price: 150.0,extra_hour_price: 600.0, day_options: :weekend)

# Pricing Premium para Gala de Premiação em Feriados
holiday_award_gala_pricing = EventPricing.create!(event_type_id: gala_premiacao.id, base_price: 12000.0, base_attendees: 150,
                                                  additional_attendee_price: 200.0,extra_hour_price: 700.0, day_options: :holiday)

# Pricing para Noite Gastronômica durante a Semana
weekday_global_dining_pricing = EventPricing.create!(event_type_id: noite_gastronomica.id, base_price: 3000.0, base_attendees: 50,
                                                    additional_attendee_price: 80.0,extra_hour_price: 200.0, day_options: :weekday)

# Pricing para Noite Gastronômica no Fim de Semana
weekend_global_dining_pricing = EventPricing.create!(event_type_id: noite_gastronomica.id, base_price: 3500.0, base_attendees: 50,
                                                    additional_attendee_price: 100.0,extra_hour_price: 250.0, day_options: :weekend)

# Pricing Premium para Noite Gastronômica em Feriados
holiday_global_dining_pricing = EventPricing.create!(event_type_id: noite_gastronomica.id,base_price: 4000.0,base_attendees: 50,
                                                    additional_attendee_price: 120.0,extra_hour_price: 300.0,day_options: :holiday)

# Pricing para Festival de Food Trucks durante a Semana
weekday_food_truck_festival_pricing = EventPricing.create!(event_type_id: food_truck.id, base_price: 2500.0, base_attendees: 100,
                                                          additional_attendee_price: 20.0,extra_hour_price: 150.0, day_options: :weekday)

# Pricing para Festival de Food Trucks no Fim de Semana
weekend_food_truck_festival_pricing = EventPricing.create!(event_type_id: food_truck.id, base_price: 3000.0, base_attendees: 100,
                                                          additional_attendee_price: 25.0,extra_hour_price: 200.0, day_options: :weekend)

# Pricing Premium para Festival de Food Trucks em Feriados
holiday_food_truck_festival_pricing = EventPricing.create!(event_type_id: food_truck.id, base_price: 3500.0, base_attendees: 100,
                                                          additional_attendee_price: 30.0,extra_hour_price: 250.0, day_options: :holiday)
p "Created #{EventPricing.count} event pricings"

# Pedidos de João
order_joao1 = Order.create!(client_id: joao.id, company_id: celebracao_alegre.id, event_type_id: casamento.id,
                            date: 30.days.from_now, attendees_number: 50, details: 'Decoração clássica e banda ao vivo.',
                            local: 'Salão de festas Beleza Infinita - Rua das Flores, 123',
                            status: 0, payment_method_id: pix.id, day_type: :weekend)

order_joao2 = Order.create!(client_id: joao.id, company_id: celebracao_alegre.id, event_type_id: corporativo.id,
                            date: 60.days.from_now, attendees_number: 120, details: 'Evento corporativo com apresentação de projetos.',
                            local: 'Rua das Flores, 123', status: 1, payment_method_id: debito.id, day_type: :weekend)
                            OrderApproval.create!(order_id: order_joao2.id, owner_id: celebracao_alegre.owner_id,
                                                  validity_date: 5.days.from_now, extra_charge: 500.0, discount: 50.0,
                                                  charge_description: 'Custos adicionais por serviços extras',
                                                  final_price: order_joao2.default_price + 500.0 - 50.0)

order_joao3 = Order.new(client_id: joao.id, company_id: banquete_real.id, event_type_id: debutante_luxo.id,
                            date: 20.days.ago, attendees_number: 300, details: 'Aniversário luxuoso com decoração extravagante.',
                            local: 'Palácio Real - Rua da Realeza, 456', status: 2, payment_method_id: credito.id, day_type: :week_day,
                            code: 'ABCD1234')
                            order_joao3.save(validate: false)
                            OrderApproval.create(order_id: order_joao3.id, owner_id: banquete_real.owner_id,
                            validity_date: 30.days.ago, extra_charge: 100.0, discount: 0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order_joao3.default_price + 100.0 - 0)

order_joao4 = Order.create!(client_id: joao.id, company_id: sabores_mundo.id, event_type_id: food_truck.id,
                            date: 120.days.from_now, attendees_number: 100, details: 'Jantar temático com pratos de várias culturas.',
                            local: 'Rua da Paz, 1313', status: 0, payment_method_id: credito.id, day_type: :holiday)

# Pedidos de Maria
order_maria1 = Order.create!(client_id: maria.id, company_id: festim_sonhos.id, event_type_id: jantar_gourmet.id,
                             date: 20.days.from_now, attendees_number: 50, details: 'Jantar formal com música instrumental.',
                             local: 'Restaurante Elegante - Avenida do Luxo, 456', status: 0, payment_method_id: credito.id, day_type: :weekend)

order_maria2 = Order.new(client_id: maria.id, company_id: gastronomia_estelar.id, event_type_id: noite_organica.id,
                             date: 10.days.ago, attendees_number: 80, details: 'Jantar de degustação orgânica com amigos.',
                             local: 'Restaurante Orgânico - Alameda Verde, 789', status: 2, payment_method_id: pix.id, day_type: :weekend,
                             code: 'QWER1234')
                             order_maria2.save(validate: false)
                             OrderApproval.create!(order_id: order_maria2.id, owner_id: gastronomia_estelar.owner_id,
                             validity_date: 15.days.ago, extra_charge: 1000.0, discount: 550.0,
                             charge_description: 'Taxas adicionais por serviços especiais',
                             final_price: order_maria2.default_price + 1000.0 - 550.0)

order_maria3 = Order.create!(client_id: maria.id, company_id: sabores_mundo.id, event_type_id: noite_gastronomica.id,
                             date: 70.days.from_now, attendees_number: 120, details: 'Evento temático com pratos internacionais.',
                             local: 'Rua da Paz, 1313',status: 2, payment_method_id: credito.id, day_type: :week_day)
                             OrderApproval.create!(order_id: order_maria3.id, owner_id: sabores_mundo.owner_id,
                             validity_date: 7.days.from_now, extra_charge: 600.0, discount: 200.0,
                             charge_description: 'Taxas adicionais por serviços especiais',
                             final_price: order_maria3.default_price + 600.0 - 200.0)

order_maria4 = Order.create!(client_id: maria.id, company_id: banquete_real.id, event_type_id: gala_premiacao.id,
                             date: 130.days.from_now, attendees_number: 250, details: 'Evento de gala para homenagear parceiros.',
                             local: 'Centro de Eventos - Rua da Cerimônia, 909', status: 0, payment_method_id: debito.id, day_type: :holiday)


# Pedidos de Carlos
order_carlos1 = Order.create!(client_id: carlos.id, company_id: banquete_real.id, event_type_id: gala_premiacao.id,
                              date: 60.days.from_now, attendees_number: 300, details: 'Evento de premiação para funcionários.',
                              local: 'Teatro Magnífico - Rua do Esplendor, 789', status: 2, payment_method_id: debito.id, day_type: :weekend)
                              OrderApproval.create!(order_id: order_carlos1.id, owner_id: banquete_real.owner_id,
                              validity_date: 3.days.from_now, extra_charge: 0, discount: 0,
                              charge_description: 'Taxas adicionais por serviços especiais',
                              final_price: order_carlos1.default_price + 0 - 0)

order_carlos2 = Order.create!(client_id: carlos.id, company_id: festim_sonhos.id, event_type_id: brunch_network.id,
                              date: 35.days.from_now, attendees_number: 60, details: 'Brunch empresarial para networking.',
                              local: 'Salão Empresarial - Avenida dos Negócios, 202',status: 0, payment_method_id: credito.id, day_type: :weekend)

order_carlos3 = Order.new(client_id: carlos.id, company_id: celebracao_alegre.id, event_type_id: casamento.id,
                              date: 30.days.ago, attendees_number: 60, details: 'Casamento dos sonhos com buffet personalizado.',
                              local: 'Salão de festas Alegria - Rua da Felicidade, 303',status: 2, payment_method_id: debito.id, day_type: :week_day,
                              code: 'POIU0987')
                              order_carlos3.save(validate: false)
                              OrderApproval.create!(order_id: order_carlos3.id, owner_id: celebracao_alegre.owner_id,
                              validity_date: 35.days.ago, extra_charge: 90.0, discount: 200.0,
                              charge_description: 'Taxas adicionais por serviços especiais',
                              final_price: order_carlos3.default_price + 90.0 - 200.0)

order_carlos4 = Order.create!(client_id: carlos.id, company_id: festim_sonhos.id, event_type_id: jantar_gourmet.id,
                              date: 90.days.from_now, attendees_number: 60, details: 'Jantar gourmet com degustação especial.',
                              local: 'Restaurante de Luxo - Avenida Gourmet, 1010', status: 0, payment_method_id: credito.id, day_type: :holiday)

# Pedidos de Ana
order_ana1 = Order.new(client_id: ana.id, company_id: gastronomia_estelar.id, event_type_id: noite_organica.id,
                           date: 15.days.ago, attendees_number: 25, details: 'Evento familiar com menu vegetariano.',
                           local: 'Restaurante Verde Vida - Alameda do Bem-Estar, 101',status: 2, payment_method_id: pix.id, day_type: :weekend,
                            code: 'ASDF1234')
                            order_ana1.save(validate: false)
                            OrderApproval.create!(order_id: order_ana1.id, owner_id: gastronomia_estelar.owner_id,
                            validity_date: 20.days.ago, extra_charge: 95.0, discount: 115.0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order_ana1.default_price + 95.0 - 115.0)

order_ana2 = Order.create!(client_id: ana.id, company_id: sabores_mundo.id, event_type_id: food_truck.id,
                           date: 45.days.from_now, attendees_number: 100, details: 'Festival de food trucks com culinária internacional.',
                           local: 'Rua da Paz, 1313', status: 0, payment_method_id: credito.id, day_type: :weekend)

order_ana3 = Order.create!(client_id: ana.id, company_id: gastronomia_estelar.id, event_type_id: piquenique.id,
                           date: 80.days.from_now, attendees_number: 30, details: 'Piquenique sustentável ao ar livre.',
                           local: 'Parque Natural - Rua do Sol, 505', status: 2, payment_method_id: credito.id, day_type: :week_day)
                            OrderApproval.create!(order_id: order_ana3.id, owner_id: gastronomia_estelar.owner_id,
                            validity_date: 10.days.from_now, extra_charge: 0, discount: 0,
                            charge_description: 'Taxas adicionais por serviços especiais',
                            final_price: order_ana3.default_price + 0 - 0)

order_ana4 = Order.create!(client_id: ana.id, company_id: gastronomia_estelar.id, event_type_id: noite_organica.id,
                           date: 75.days.from_now, attendees_number: 35, details: 'Noite de degustação orgânica ao ar livre.',
                           local: 'Restaurante Ecológico - Alameda Verde, 1111',status: 0, payment_method_id: credito.id, day_type: :holiday)

# Pedidos de Lucas
order_lucas1 = Order.create!(client_id: lucas.id, company_id: sabores_mundo.id, event_type_id: food_truck.id,
                             date: 50.days.from_now, attendees_number: 200, details: 'Festival gastronômico com várias cozinhas.',
                             local: 'Rua da Paz, 1313',status: 0, payment_method_id: credito.id, day_type: :weekend)

order_lucas2 = Order.new(client_id: lucas.id, company_id: festim_sonhos.id, event_type_id: jantar_gourmet.id,
                             date: 20.days.ago, attendees_number: 70, details: 'Jantar gourmet com música ao vivo.',
                             local: 'Restaurante Luxuoso - Avenida da Elegância, 606',status: 2, payment_method_id: credito.id, day_type: :weekend,
                             code: 'A1B2C3D4')
                             order_lucas2.save(validate: false)
                             OrderApproval.create!(order_id: order_lucas2.id, owner_id: festim_sonhos.owner_id,
                             validity_date: 30.days.ago, extra_charge: 200.0, discount: 0,
                             charge_description: 'Taxas adicionais por serviços especiais',
                             final_price: order_lucas2.default_price + 0 - 0)

order_lucas3 = Order.create!(client_id: lucas.id, company_id: banquete_real.id, event_type_id: gala_premiacao.id,
                             date: 110.days.from_now, attendees_number: 500, details: 'Evento de gala para premiação anual.',
                             local: 'Teatro Real - Rua dos Campeões, 707', status: 1, payment_method_id: credito.id, day_type: :week_day)
                             OrderApproval.create!(order_id: order_lucas3.id, owner_id: banquete_real.owner_id,
                             validity_date: 12.days.from_now, extra_charge: 0, discount: 100.0,
                             charge_description: 'Taxas adicionais por serviços especiais',
                             final_price: order_lucas3.default_price + 0 - 100.0)

order_lucas4 = Order.create!(client_id: lucas.id, company_id: celebracao_alegre.id, event_type_id: gala_premiacao.id,
                             date: 150.days.from_now, attendees_number: 230, details: 'Evento corporativo com apresentações.',
                             local: 'Centro de Convenções - Rua da Negócios, 1212',status: 0, payment_method_id: pix.id, day_type: :holiday)

p "Created #{Order.count} orders"

# Seed de mensagens ajustadas

# Pedido de Joao - order_joao1
message1 = Message.create!(body: 'Olá João, qual será a faixa etária das crianças no evento?', sender_id: celebracao_alegre.owner_id, sender_type: 'Owner', receiver_id: joao.id, receiver_type: 'Client', order_id: order_joao1.id)
message2 = Message.create!(body: 'Olá, a maioria das crianças terá entre 4 e 10 anos.', sender_id: joao.id, sender_type: 'Client', receiver_id: celebracao_alegre.owner_id, receiver_type: 'Owner', order_id: order_joao1.id)

# Pedido de Joao - order_joao2
message3 = Message.create!(body: 'João, você precisará de algum equipamento audiovisual para a apresentação de projetos?', sender_id: celebracao_alegre.owner_id, sender_type: 'Owner', receiver_id: joao.id, receiver_type: 'Client', order_id: order_joao2.id)
message4 = Message.create!(body: 'Sim, por favor. Precisamos de um projetor e microfones.', sender_id: joao.id, sender_type: 'Client', receiver_id: celebracao_alegre.owner_id, receiver_type: 'Owner', order_id: order_joao2.id)

# Pedido de Joao - order_joao3
message5 = Message.create!(body: 'João, você gostaria de uma degustação do menu de casamento?', sender_id: banquete_real.owner_id, sender_type: 'Owner', receiver_id: joao.id, receiver_type: 'Client', order_id: order_joao3.id)
message6 = Message.create!(body: 'Sim, seria ótimo. Podemos agendar para a próxima semana?', sender_id: joao.id, sender_type: 'Client', receiver_id: banquete_real.owner_id, receiver_type: 'Owner', order_id: order_joao3.id)

# Pedido de Joao - order_joao4
message7 = Message.create!(body: 'João, você tem alguma preferência de culinária para o jantar temático?', sender_id: sabores_mundo.owner_id, sender_type: 'Owner', receiver_id: joao.id, receiver_type: 'Client', order_id: order_joao4.id)
message8 = Message.create!(body: 'Gostaríamos de pratos mexicanos e italianos.', sender_id: joao.id, sender_type: 'Client', receiver_id: sabores_mundo.owner_id, receiver_type: 'Owner', order_id: order_joao4.id)

# Pedido de Maria - order_maria1
message9 = Message.create!(body: 'Maria, você prefere música instrumental ao vivo ou uma playlist selecionada?', sender_id: festim_sonhos.owner_id, sender_type: 'Owner', receiver_id: maria.id, receiver_type: 'Client', order_id: order_maria1.id)
message10 = Message.create!(body: 'Preferimos música instrumental ao vivo.', sender_id: maria.id, sender_type: 'Client', receiver_id: festim_sonhos.owner_id, receiver_type: 'Owner', order_id: order_maria1.id)

# Pedido de Maria - order_maria2
message11 = Message.create!(body: 'Maria, há alguma restrição alimentar entre seus convidados?', sender_id: gastronomia_estelar.owner_id, sender_type: 'Owner', receiver_id: maria.id, receiver_type: 'Client', order_id: order_maria2.id)
message12 = Message.create!(body: 'Sim, alguns convidados são alérgicos a nozes.', sender_id: maria.id, sender_type: 'Client', receiver_id: gastronomia_estelar.owner_id, receiver_type: 'Owner', order_id: order_maria2.id)

# Pedido de Maria - order_maria3
message13 = Message.create!(body: 'Maria, você gostaria de adicionar um serviço de fotografia ao evento?', sender_id: sabores_mundo.owner_id, sender_type: 'Owner', receiver_id: maria.id, receiver_type: 'Client', order_id: order_maria3.id)
message14 = Message.create!(body: 'Sim, adoraria ter um fotógrafo para capturar os momentos.', sender_id: maria.id, sender_type: 'Client', receiver_id: sabores_mundo.owner_id, receiver_type: 'Owner', order_id: order_maria3.id)

# Pedido de Maria - order_maria4
message15 = Message.create!(body: 'Maria, podemos oferecer um brinde especial aos homenageados?', sender_id: banquete_real.owner_id, sender_type: 'Owner', receiver_id: maria.id, receiver_type: 'Client', order_id: order_maria4.id)
message16 = Message.create!(body: 'Sim, isso seria perfeito.', sender_id: maria.id, sender_type: 'Client', receiver_id: banquete_real.owner_id, receiver_type: 'Owner', order_id: order_maria4.id)

# Pedido de Carlos - order_carlos1
message17 = Message.create!(body: 'Carlos, precisamos de mais alguma infraestrutura para o evento de premiação?', sender_id: banquete_real.owner_id, sender_type: 'Owner', receiver_id: carlos.id, receiver_type: 'Client', order_id: order_carlos1.id)
message18 = Message.create!(body: 'Sim, precisamos de um palco com iluminação especial.', sender_id: carlos.id, sender_type: 'Client', receiver_id: banquete_real.owner_id, receiver_type: 'Owner', order_id: order_carlos1.id)

# Pedido de Carlos - order_carlos2
message19 = Message.create!(body: 'Carlos, você gostaria de incluir uma sessão de networking?', sender_id: festim_sonhos.owner_id, sender_type: 'Owner', receiver_id: carlos.id, receiver_type: 'Client', order_id: order_carlos2.id)
message20 = Message.create!(body: 'Sim, isso seria ótimo para os participantes.', sender_id: carlos.id, sender_type: 'Client', receiver_id: festim_sonhos.owner_id, receiver_type: 'Owner', order_id: order_carlos2.id)

# Pedido de Carlos - order_carlos3
message21 = Message.create!(body: 'Carlos, podemos decorar o salão com flores naturais?', sender_id: celebracao_alegre.owner_id, sender_type: 'Owner', receiver_id: carlos.id, receiver_type: 'Client', order_id: order_carlos3.id)
message22 = Message.create!(body: 'Sim, flores naturais seriam perfeitas.', sender_id: carlos.id, sender_type: 'Client', receiver_id: celebracao_alegre.owner_id, receiver_type: 'Owner', order_id: order_carlos3.id)

# Pedido de Carlos - order_carlos4
message23 = Message.create!(body: 'Carlos, há alguma preferência de bebidas para o jantar gourmet?', sender_id: festim_sonhos.owner_id, sender_type: 'Owner', receiver_id: carlos.id, receiver_type: 'Client', order_id: order_carlos4.id)
message24 = Message.create!(body: 'Gostaríamos de uma seleção de vinhos e coquetéis.', sender_id: carlos.id, sender_type: 'Client', receiver_id: festim_sonhos.owner_id, receiver_type: 'Owner', order_id: order_carlos4.id)

# Pedido de Ana - order_ana1
message25 = Message.create!(body: 'Ana, você tem alguma preferência de decoração para o evento?', sender_id: gastronomia_estelar.owner_id, sender_type: 'Owner', receiver_id: ana.id, receiver_type: 'Client', order_id: order_ana1.id)
message26 = Message.create!(body: 'Gostaríamos de uma decoração temática verde.', sender_id: ana.id, sender_type: 'Client', receiver_id: gastronomia_estelar.owner_id, receiver_type: 'Owner', order_id: order_ana1.id)

# Pedido de Ana - order_ana2
message27 = Message.create!(body: 'Ana, você gostaria de incluir música ao vivo no evento de food truck?', sender_id: sabores_mundo.owner_id, sender_type: 'Owner', receiver_id: ana.id, receiver_type: 'Client', order_id: order_ana2.id)
message28 = Message.create!(body: 'Sim, música ao vivo seria ótimo.', sender_id: ana.id, sender_type: 'Client', receiver_id: sabores_mundo.owner_id, receiver_type: 'Owner', order_id: order_ana2.id)

# Pedido de Ana - order_ana3
message29 = Message.create!(body: 'Ana, você prefere um brunch ou almoço para o piquenique?', sender_id: gastronomia_estelar.owner_id, sender_type: 'Owner', receiver_id: ana.id, receiver_type: 'Client', order_id: order_ana3.id)
message30 = Message.create!(body: 'Prefiro um brunch ao ar livre.', sender_id: ana.id, sender_type: 'Client', receiver_id: gastronomia_estelar.owner_id, receiver_type: 'Owner', order_id: order_ana3.id)

# Pedido de Ana - order_ana4
message31 = Message.create!(body: 'Ana, podemos oferecer degustações de bebidas orgânicas?', sender_id: gastronomia_estelar.owner_id, sender_type: 'Owner', receiver_id: ana.id, receiver_type: 'Client', order_id: order_ana4.id)
message32 = Message.create!(body: 'Sim, adoraria incluir degustações de bebidas orgânicas.', sender_id: ana.id, sender_type: 'Client', receiver_id: gastronomia_estelar.owner_id, receiver_type: 'Owner', order_id: order_ana4.id)

# Pedido de Lucas - order_lucas1
message33 = Message.create!(body: 'Lucas, qual é o horário de início do evento?', sender_id: sabores_mundo.owner_id, sender_type: 'Owner', receiver_id: lucas.id, receiver_type: 'Client', order_id: order_lucas1.id)
message34 = Message.create!(body: 'O evento começará às 18h.', sender_id: lucas.id, sender_type: 'Client', receiver_id: sabores_mundo.owner_id, receiver_type: 'Owner', order_id: order_lucas1.id)

# Pedido de Lucas - order_lucas2
message35 = Message.create!(body: 'Lucas, há estacionamento disponível no local?', sender_id: festim_sonhos.owner_id, sender_type: 'Owner', receiver_id: lucas.id, receiver_type: 'Client', order_id: order_lucas2.id)
message36 = Message.create!(body: 'Sim, o local possui um amplo estacionamento.', sender_id: lucas.id, sender_type: 'Client', receiver_id: festim_sonhos.owner_id, receiver_type: 'Owner', order_id: order_lucas2.id)

# Pedido de Lucas - order_lucas3
message37 = Message.create!(body: 'Lucas, qual é o menu para o evento de gala?', sender_id: banquete_real.owner_id, sender_type: 'Owner', receiver_id: lucas.id, receiver_type: 'Client', order_id: order_lucas3.id)
message38 = Message.create!(body: 'Incluímos pratos sofisticados e uma estação de sobremesas.', sender_id: lucas.id, sender_type: 'Client', receiver_id: banquete_real.owner_id, receiver_type: 'Owner', order_id: order_lucas3.id)

# Pedido de Lucas - order_lucas4
message39 = Message.create!(body: 'Lucas, podemos agendar uma reunião para discutir detalhes?', sender_id: celebracao_alegre.owner_id, sender_type: 'Owner', receiver_id: lucas.id, receiver_type: 'Client', order_id: order_lucas4.id)
message40 = Message.create!(body: 'Claro, podemos marcar para a próxima semana.', sender_id: lucas.id, sender_type: 'Client', receiver_id: celebracao_alegre.owner_id, receiver_type: 'Owner', order_id: order_lucas4.id)

p "Created #{Message.count} messages"

review_joao3 = Review.create!(order: order_joao3, company_id: banquete_real.id, score: 5, text: 'Experiência inesquecível! A decoração estava esplêndida e o serviço impecável. Recomendo muito!')

review_maria2 = Review.create!(order: order_maria2, company_id: gastronomia_estelar.id, score: 5, text: "A experiência foi maravilhosa! Os sabores orgânicos foram destacados de maneira elegante e deliciosa.")

review_carlos3 = Review.create!(order: order_carlos3, company_id: celebracao_alegre.id, score: 5, text: "Um dia verdadeiramente mágico! O serviço foi impecável e cada detalhe estava perfeito. Todos os convidados ficaram encantados.")

review_ana1 = Review.create!(order: order_ana1, company_id: gastronomia_estelar.id, score: 4, text: "A experiência foi muito agradável. A comida estava deliciosa e perfeitamente preparada. Ótima escolha para quem aprecia uma refeição saudável e saborosa.")

review_lucas2 = Review.create!(order: order_lucas2, company_id: festim_sonhos.id, score: 5, text: "A noite foi excepcional! A combinação da excelente gastronomia com a música ao vivo criou uma atmosfera inesquecível. Tudo estava perfeito!")

p "Created #{Review.count} reviews"

p "All done! :)"

