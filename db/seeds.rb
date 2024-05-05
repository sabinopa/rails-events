Order.destroy_all
EventPricing.destroy_all
EventType.destroy_all
Company.destroy_all
Supplier.destroy_all
PaymentMethod.destroy_all
Client.destroy_all

# Métodos de Pagamento
pix = PaymentMethod.create!(method: 'PIX')
credito = PaymentMethod.create!(method: 'Cartão de Crédito')
debito = PaymentMethod.create!(method: 'Cartão de Débito')
dinheiro = PaymentMethod.create!(method: 'Dinheiro')

p "Created #{PaymentMethod.count} payment methods"

# Fornecedores
priscila = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
pedro = Supplier.create!(name: 'Pedro', lastname: 'Araujo', email: 'pedro@email.com', password: 'senhasenha')
guilherme = Supplier.create!(name: 'Guilherme', lastname: 'Alvares', email: 'guilherme@email.com', password: 'password')
isabel = Supplier.create!(name: 'Isabel', lastname: 'Maria', email: 'isabel@lagoaserena.com', password: 'secret123')
livia = Supplier.create!(name: 'Livia', lastname: 'Alves', email: 'livia@email.com', password: '09876543')

p "Created #{Supplier.count} suppliers"

# Clientes
joao = Client.create!(name: 'João', lastname: 'Silva', email: 'joao@email.com', document_number: '926.020.550-69', password: 'senha123')
maria = Client.create!(name: 'Maria', lastname: 'Fernandes', email: 'maria@email.com', document_number: '607.560.260-75', password: 'senha321')
carlos = Client.create!(name: 'Carlos', lastname: 'Machado', email: 'carlos@email.com', document_number: '954.511.300-60', password: 'senha456')
ana = Client.create!(name: 'Ana', lastname: 'Pereira', email: 'ana@email.com', document_number: '496.830.670-93', password: 'senha654')
lucas = Client.create!(name: 'Lucas', lastname: 'Costa', email: 'lucas@email.com', document_number: '194.917.200-74', password: 'senha234')

p "Created #{Client.count} clients"

# Empresas
celebracao_alegre = Company.create!(supplier_id: priscila.id, brand_name: 'Celebração Alegre', corporate_name: 'Celebração Alegre Buffet Ltda',
                                  registration_number: '58.934.722/0001-01',  phone_number: '(11) 98765-4321', email: 'contato@celebracaoalegre.com.br',
                                  address: 'Rua das Flores, 123', neighborhood: 'Jardim Primavera', city: 'São Paulo', state: 'SP', zipcode: '01234-567',
                                  description: 'Especializados em casamentos e eventos corporativos, oferecemos um serviço completo de buffet com uma vasta opção de cardápios personalizados.')
                                  celebracao_alegre.payment_methods << [pix, debito]

festim_sonhos = Company.create!(supplier_id: pedro.id, brand_name: 'Festim dos Sonhos', corporate_name: 'Festim dos Sonhos Eventos S.A.',
                              registration_number: '63.112.924/0001-08',  phone_number: '(21) 4444-5555', email: 'sonhos@festim.com.br',
                              address: 'Avenida Central, 456', neighborhood: 'Centro', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                              description: 'Com uma equipe de chefs renomados, proporcionamos uma experiência culinária inesquecível para seu evento.')
                              festim_sonhos.payment_methods << [credito, debito]

gastronomia_estelar = Company.create!(supplier_id: guilherme.id, brand_name: 'Gastronomia Estelar', corporate_name: 'Gastronomia Estelar Ltda',
                              registration_number: '54.457.025/0001-48',  phone_number: '(31) 6666-7777', email: 'contato@gastronomiaestelar.com.br',
                              address: 'Praça da Liberdade, 789', neighborhood: 'Savassi', city: 'Belo Horizonte', state: 'MG', zipcode: '30140-010',
                              description: 'Oferecemos um serviço exclusivo de buffet e catering com foco em ingredientes orgânicos e sustentáveis.')
                              gastronomia_estelar.payment_methods << [pix, credito, debito]

banquete_real = Company.create!(supplier_id: isabel.id, brand_name: 'Banquete Real', corporate_name: 'Banquete Real Buffet S.A.',
                              registration_number: '26.876.789/0001-32',  phone_number: '(41) 8888-9999', email: 'real@banquetebuffet.com.br',
                              address: 'Rua Majestosa, 1010', neighborhood: 'Batel', city: 'Curitiba', state: 'PR', zipcode: '80420-000',
                              description: 'Transformamos seu evento em um verdadeiro banquete real, com serviços de buffet e decoração de alto padrão')
                              banquete_real.payment_methods << [credito, debito]

sabores_mundo = Company.create!(supplier_id: livia.id, brand_name: 'Sabores do Mundo', corporate_name: 'Sabores do Mundo Buffet Internacional Eireli',
                              registration_number: '24.282.155/0001-26',  phone_number: '(51) 1010-2020', email: 'contato@saboresdomundo.com.br',
                              address: 'Rua da Paz, 1313', neighborhood: 'Moinhos de Vento', city: 'Porto Alegre', state: 'RS', zipcode: '90500-000',
                              description: 'Especializados em culinária internacional, nosso buffet traz sabores únicos de diferentes partes do mundo para seu evento.')
                              sabores_mundo.payment_methods << [credito, debito]

p "Created #{Company.count} companies"

# Para a empresa Celebração Alegre
casamento = EventType.create!(company_id: celebracao_alegre.id, name: 'Casamento dos Sonhos',
                            description: 'O nosso pacote "Casamento dos Sonhos" é o ápice da sofisticação e do romance. Com um serviço de buffet personalizado, decoração floral deslumbrante e uma equipe dedicada a tornar cada detalhe perfeito, garantimos que seu dia especial seja inesquecível.',
                            min_attendees: 50, max_attendees: 300, duration: 480,
                            menu_description: 'Uma seleção gourmet que inclui entradas frias e quentes, pratos principais sofisticados com opções vegetarianas, veganas e sem glúten, além de uma estação de sobremesas com doces finos e um bolo de casamento personalizado.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 1)
                            casamento.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'casamento_1.jpg')), filename: 'casamento_1.jpg')
                            casamento.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'casamento_2.jpg')), filename: 'casamento_2.jpg')
                            casamento.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'casamento_3.jpg')), filename: 'casamento_3.jpg')

corporativo = EventType.create!(company_id: celebracao_alegre.id, name: 'Gala Corporativa Elegante',
                            description: 'Nossa Gala Corporativa Elegante é a escolha perfeita para empresas que desejam impressionar. Oferecemos um ambiente sofisticado, com serviço de buffet de alto padrão, apresentações audiovisuais de última geração e uma equipe pronta para atender todas as necessidades empresariais.',
                            min_attendees: 100, max_attendees: 500, duration: 300,
                            menu_description: 'Um buffet exclusivo que inclui canapés gourmet, estações de comida ao vivo, pratos internacionais elaborados e uma ampla seleção de bebidas holiday, incluindo coquetéis personalizados e vinhos selecionados.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 2)
                            corporativo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'corporativo_1.jpg')), filename: 'corporativo_1.jpg')
                            corporativo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'corporativo_2.jpg')), filename: 'corporativo_2.jpg')
                            corporativo.photos.attach(io: File.open(Rails.root.join('spec', 'files', 'corporativo_3.jpg')), filename: 'corporativo_3.jpg')

# Para a empresa Festim dos Sonhos
jantar_gourmet = EventType.create!(company_id: festim_sonhos.id, name: 'Jantar de Gala Gourmet',
                            description: 'O Jantar de Gala Gourmet do Festim dos Sonhos é uma experiência culinária de alto nível, perfeito para ocasiões especiais. Com um menu exclusivo criado por nossos chefs renomados, cada prato é uma obra de arte, acompanhado de uma seleção impecável de vinhos e ambientação sofisticada.',
                            min_attendees: 20, max_attendees: 80, duration: 240,
                            menu_description: 'Menu de cinco pratos, incluindo amuse-bouche, entrada, prato principal, sobremesa e mignardises. Ingredientes frescos e da estação, com opções para necessidades dietéticas específicas.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 1)

brunch_network = EventType.create!(company_id: festim_sonhos.id, name: 'Brunch Empresarial de Networking',
                            description: 'Nosso Brunch Empresarial oferece uma atmosfera descontraída e elegante para networking e reuniões de negócios. Com uma variedade de opções gastronômicas que agradam todos os paladares, este evento promove a interação em um ambiente propício ao desenvolvimento de relações profissionais.',
                            min_attendees: 50, max_attendees: 100, duration: 180,
                            menu_description: 'Uma seleção diversificada de itens de brunch, incluindo estações de omeletes, variedades de pães artesanais, frutas frescas, queijos finos, carnes frias, e uma ampla escolha de bebidas, desde cafés especiais até sucos naturais e mimosas.',
                            alcohol_available: true, decoration_available: true, parking_service_available: false, location_type: 2)

# Para a empresa Gastronomia Estelar
noite_organica = EventType.create!(company_id: gastronomia_estelar.id, name: 'Noite de Degustação Orgânica',
                            description: ' Uma experiência culinária única onde os convidados têm a oportunidade de degustar uma variedade de pratos feitos exclusivamente com ingredientes orgânicos e sustentáveis. Acompanhado de uma seleção de vinhos naturais e orgânicos, este evento é uma celebração dos sabores autênticos e da culinária consciente.',
                            min_attendees: 20, max_attendees: 100, duration: 180,
                            menu_description: 'Cardápio degustação em cinco etapas, com pratos que destacam os ingredientes da estação. Inclui aperitivos, entradas, prato principal, sobremesa e uma seleção especial de queijos artesanais locais.',
                            alcohol_available: true, decoration_available: true, parking_service_available: false, location_type: 1)

piquenique = EventType.create!(company_id: gastronomia_estelar.id, name: 'Piquenique Gourmet Sustentável',
                            description: 'Um evento ao ar livre que combina o prazer de comer ao fresco com a consciência ecológica. Ideal para grupos que buscam uma experiência gastronômica diferente, nosso piquenique gourmet inclui cestas repletas de delícias orgânicas, cobertores e jogos de campo, tudo com o menor impacto ambiental possível.',
                            min_attendees: 10, max_attendees: 50, duration: 240,
                            menu_description: 'Cestas de piquenique individuais com sanduíches gourmet, saladas frescas, frutas da estação, sucos prensados a frio e sobremesas naturais. Todos os itens são preparados com ingredientes orgânicos e embalados de forma ecológica.',
                            alcohol_available: false, decoration_available: true, parking_service_available: false, location_type: 1)

# Para a empresa Banquete Real
casamento_luxo = EventType.create!(company_id: banquete_real.id, name: 'Cerimônia de Casamento Luxuosa',
                            description: 'Nossa Cerimônia de Casamento Luxuosa é o epítome da elegância e sofisticação. Com um serviço de buffet exclusivo, decoração opulenta e atenção meticulosa a todos os detalhes, garantimos que seu casamento seja uma ocasião verdadeiramente real e inesquecível.',
                            min_attendees: 100, max_attendees: 500, duration: 480,
                            menu_description: 'Um banquete digno da realeza, incluindo uma vasta seleção de canapés finos, pratos principais gourmet, uma deslumbrante torre de sobremesas e um bar completo com as melhores bebidas.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 2)

gala_premiacao = EventType.create!(company_id: banquete_real.id, name: 'Gala de Premiação Estelar',
                            description: 'Ideal para eventos de premiação e celebrações corporativas, a Gala de Premiação Estelar oferece um ambiente sofisticado e serviços de primeira linha. Nosso buffet de gala é acompanhado de uma decoração impecável, criando um cenário perfeito para homenagear os conquistadores da noite.',
                            min_attendees: 150, max_attendees: 1000, duration: 360,
                            menu_description: 'Um esplêndido buffet composto por estações de comida internacional, pratos assinados por chefs renomados, e uma extensa carta de vinhos e coquetéis holiday.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 2)

# Para a empresa Sabores do Mundo
noite_gastronomica = EventType.create!(company_id: sabores_mundo.id, name: 'Volta ao Mundo em 80 Pratos',
                            description: 'Uma experiência gastronômica inesquecível que leva seus convidados a uma jornada culinária ao redor do globo. Este evento oferece uma degustação de pratos típicos de diversos países, cada um cuidadosamente preparado para representar sua região de origem.',
                            min_attendees: 50, max_attendees: 200, duration: 400,
                            menu_description: 'Uma seleção diversificada que inclui desde tapas espanholas, sushi japonês, até pratos tradicionais brasileiros e sobremesas francesas. Acompanha uma seleção de bebidas internacionais.',
                            alcohol_available: true, decoration_available: true, parking_service_available: true, location_type: 0)

food_truck = EventType.create!(company_id: sabores_mundo.id, name: 'Festival Internacional de Food Trucks',
                            description: 'Levamos a diversidade culinária das ruas do mundo para o seu evento. Este festival apresenta uma série de food trucks, cada um oferecendo uma especialidade internacional diferente, criando uma atmosfera casual e interativa para os convidados explorarem.',
                            min_attendees: 100, max_attendees: 500, duration: 240,
                            menu_description: 'Food trucks especializados em uma variedade de cozinhas, incluindo italiana, mexicana, indiana, e tailandesa. Opções para todos os gostos, desde pratos picantes até sobremesas geladas e refrescantes.',
                            alcohol_available: true, decoration_available: false, parking_service_available: false, location_type: 1)

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
weekday_luxury_wedding_pricing = EventPricing.create!(event_type_id: casamento_luxo.id, base_price: 5000.0, base_attendees: 100,
                                                      additional_attendee_price: 150.0,extra_hour_price: 200.0, day_options: :weekday)

# Pricing para Cerimônia de Casamento Luxuosa no Fim de Semana
weekend_luxury_wedding_pricing = EventPricing.create!(event_type_id: casamento_luxo.id, base_price: 7000.0, base_attendees: 100,
                                                      additional_attendee_price: 200.0,extra_hour_price: 250.0, day_options: :weekend)

# Pricing Premium para Cerimônia de Casamento Luxuosa em Feriados
holiday_luxury_wedding_pricing = EventPricing.create!(event_type_id: casamento_luxo.id, base_price: 9000.0, base_attendees: 100,
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
                            date: 60.days.from_now, attendees_number: 25, details: 'Evento corporativo com apresentação de projetos.',
                            local: 'Rua das Flores, 123', status: 2, payment_method_id: debito.id, day_type: :weekend)

order_joao3 = Order.create!(client_id: joao.id, company_id: banquete_real.id, event_type_id: casamento_luxo.id,
                            date: 90.days.from_now, attendees_number: 300, details: 'Casamento luxuoso com decoração extravagante.',
                            local: 'Palácio Real - Rua da Realeza, 456',status: 1, payment_method_id: credito.id, day_type: :week_day)

order_joao4 = Order.create!(client_id: joao.id, company_id: sabores_mundo.id, event_type_id: food_truck.id,
                            date: 120.days.from_now, attendees_number: 100, details: 'Jantar temático com pratos de várias culturas.',
                            local: 'Rua da Paz, 1313', status: 0, payment_method_id: credito.id, day_type: :holiday)

# Pedidos de Maria
order_maria1 = Order.create!(client_id: maria.id, company_id: festim_sonhos.id, event_type_id: jantar_gourmet.id,
                             date: 20.days.from_now, attendees_number: 50, details: 'Jantar formal com música instrumental.',
                             local: 'Restaurante Elegante - Avenida do Luxo, 456', status: 0, payment_method_id: credito.id, day_type: :weekend)

order_maria2 = Order.create!(client_id: maria.id, company_id: gastronomia_estelar.id, event_type_id: noite_organica.id,
                             date: 40.days.from_now, attendees_number: 80, details: 'Jantar de degustação orgânica com amigos.',
                             local: 'Restaurante Orgânico - Alameda Verde, 789', status: 1, payment_method_id: pix.id, day_type: :weekend)

order_maria3 = Order.create!(client_id: maria.id, company_id: sabores_mundo.id, event_type_id: noite_gastronomica.id,
                             date: 70.days.from_now, attendees_number: 120, details: 'Evento temático com pratos internacionais.',
                             local: 'Rua da Paz, 1313',status: 2, payment_method_id: credito.id, day_type: :week_day)

order_maria4 = Order.create!(client_id: maria.id, company_id: banquete_real.id, event_type_id: gala_premiacao.id,
                             date: 130.days.from_now, attendees_number: 250, details: 'Evento de gala para homenagear parceiros.',
                             local: 'Centro de Eventos - Rua da Cerimônia, 909', status: 0, payment_method_id: debito.id, day_type: :holiday)


# Pedidos de Carlos
order_carlos1 = Order.create!(client_id: carlos.id, company_id: banquete_real.id, event_type_id: gala_premiacao.id,
                              date: 60.days.from_now, attendees_number: 300, details: 'Evento de premiação para funcionários.',
                              local: 'Teatro Magnífico - Rua do Esplendor, 789', status: 2, payment_method_id: debito.id, day_type: :weekend)

order_carlos2 = Order.create!(client_id: carlos.id, company_id: festim_sonhos.id, event_type_id: brunch_network.id,
                              date: 35.days.from_now, attendees_number: 60, details: 'Brunch empresarial para networking.',
                              local: 'Salão Empresarial - Avenida dos Negócios, 202',status: 0, payment_method_id: credito.id, day_type: :weekend)

order_carlos3 = Order.create!(client_id: carlos.id, company_id: celebracao_alegre.id, event_type_id: casamento.id,
                              date: 30.days.from_now, attendees_number: 20, details: 'Casamento dos sonhos com buffet personalizado.',
                              local: 'Salão de festas Alegria - Rua da Felicidade, 303',status: 1, payment_method_id: debito.id, day_type: :week_day)

order_carlos4 = Order.create!(client_id: carlos.id, company_id: festim_sonhos.id, event_type_id: jantar_gourmet.id,
                              date: 90.days.from_now, attendees_number: 60, details: 'Jantar gourmet com degustação especial.',
                              local: 'Restaurante de Luxo - Avenida Gourmet, 1010', status: 0, payment_method_id: credito.id, day_type: :holiday)

# Pedidos de Ana
order_ana1 = Order.create!(client_id: ana.id, company_id: gastronomia_estelar.id, event_type_id: noite_organica.id,
                           date: 15.days.from_now, attendees_number: 25, details: 'Evento familiar com menu vegetariano.',
                           local: 'Restaurante Verde Vida - Alameda do Bem-Estar, 101',status: 1, payment_method_id: pix.id, day_type: :weekend)

order_ana2 = Order.create!(client_id: ana.id, company_id: sabores_mundo.id, event_type_id: food_truck.id,
                           date: 45.days.from_now, attendees_number: 100, details: 'Festival de food trucks com culinária internacional.',
                           local: 'Rua da Paz, 1313', status: 0, payment_method_id: credito.id, day_type: :weekend)

order_ana3 = Order.create!(client_id: ana.id, company_id: gastronomia_estelar.id, event_type_id: piquenique.id,
                           date: 80.days.from_now, attendees_number: 30, details: 'Piquenique sustentável ao ar livre.',
                           local: 'Parque Natural - Rua do Sol, 505', status: 2, payment_method_id: credito.id, day_type: :week_day)

order_ana4 = Order.create!(client_id: ana.id, company_id: gastronomia_estelar.id, event_type_id: noite_organica.id,
                           date: 75.days.from_now, attendees_number: 35, details: 'Noite de degustação orgânica ao ar livre.',
                           local: 'Restaurante Ecológico - Alameda Verde, 1111',status: 0, payment_method_id: credito.id, day_type: :holiday)

# Pedidos de Lucas
order_lucas1 = Order.create!(client_id: lucas.id, company_id: sabores_mundo.id, event_type_id: food_truck.id,
                             date: 50.days.from_now, attendees_number: 200, details: 'Festival gastronômico com várias cozinhas.',
                             local: 'Rua da Paz, 1313',status: 0, payment_method_id: credito.id, day_type: :weekend)

order_lucas2 = Order.create!(client_id: lucas.id, company_id: festim_sonhos.id, event_type_id: jantar_gourmet.id,
                             date: 30.days.from_now, attendees_number: 70, details: 'Jantar gourmet com música ao vivo.',
                             local: 'Restaurante Luxuoso - Avenida da Elegância, 606',status: 1, payment_method_id: credito.id, day_type: :weekend)

order_lucas3 = Order.create!(client_id: lucas.id, company_id: banquete_real.id, event_type_id: gala_premiacao.id,
                             date: 110.days.from_now, attendees_number: 500, details: 'Evento de gala para premiação anual.',
                             local: 'Teatro Real - Rua dos Campeões, 707', status: 2, payment_method_id: credito.id, day_type: :week_day)

order_lucas4 = Order.create!(client_id: lucas.id, company_id: celebracao_alegre.id, event_type_id: gala_premiacao.id,
                             date: 150.days.from_now, attendees_number: 20, details: 'Evento corporativo com apresentações.',
                             local: 'Centro de Convenções - Rua da Negócios, 1212',status: 0, payment_method_id: pix.id, day_type: :holiday)

p "Created #{Order.count} orders"


p "All done! :)"

