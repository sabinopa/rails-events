PaymentMethod.destroy_all
Supplier.destroy_all
Company.destroy_all

# Métodos de Pagamento
pix = PaymentMethod.create(method: 'PIX')
credito = PaymentMethod.create(method: 'Cartão de Crédito')
debito = PaymentMethod.create(method: 'Cartão de Débito')
dinheiro = PaymentMethod.create(method: 'Dinheiro')

p "Created #{PaymentMethod.count} payment methods"

# Fornecedores
priscila = Supplier.create(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
pedro = Supplier.create(name: 'Pedro', lastname: 'Araujo', email: 'pedro@email.com', password: 'senhasenha')
guilherme = Supplier.create(name: 'Guilherme', lastname: 'Alvares', email: 'guilherme@email.com', password: 'password')
isabel = Supplier.create(name: 'Isabel', lastname: 'Maria', email: 'isabel@lagoaserena.com', password: 'secret123')
livia = Supplier.create(name: 'Livia', lastname: 'Alves', email: 'livia@email.com', password: '09876543')

p "Created #{Supplier.count} suppliers"

# Empresas
celebracao_alegre = Company.create(supplier_id: priscila.id, brand_name: 'Celebração Alegre', corporate_name: 'Celebração Alegre Buffet Ltda',
                              registration_number: '12.345.678/0001-99',  phone_number: '(11) 98765-4321', email: 'contato@celebracaoalegre.com.br',
                              address: 'Rua das Flores, 123', neighborhood: 'Jardim Primavera', city: 'São Paulo', state: 'SP', zipcode: '01234-567',
                              description: 'Especializados em casamentos e eventos corporativos, oferecemos um serviço completo de buffet com uma vasta opção de cardápios personalizados.')
                              celebracao_alegre.payment_methods << [pix, debito]

festim_sonhos = Company.create(supplier_id: pedro.id, brand_name: 'Festim dos Sonhos', corporate_name: 'Festim dos Sonhos Eventos S.A.',
                              registration_number: '11.000.222/0001-33',  phone_number: '(21) 4444-5555', email: 'sonhos@festim.com.br',
                              address: 'Avenida Central, 456', neighborhood: 'Centro', city: 'Rio de Janeiro', state: 'RJ', zipcode: '21000-000',
                              description: 'Com uma equipe de chefs renomados, proporcionamos uma experiência culinária inesquecível para seu evento.')
                              festim_sonhos.payment_methods << [credito, debito]

gastronomia_estelar = Company.create(supplier_id: guilherme.id, brand_name: 'Gastronomia Estelar', corporate_name: 'Gastronomia Estelar Ltda',
                              registration_number: '99.888.777/0001-66',  phone_number: '(31) 6666-7777', email: 'contato@gastronomiaestelar.com.br',
                              address: 'Praça da Liberdade, 789', neighborhood: 'Savassi', city: 'Belo Horizonte', state: 'MG', zipcode: '30140-010',
                              description: 'Oferecemos um serviço exclusivo de buffet e catering com foco em ingredientes orgânicos e sustentáveis.')
                              gastronomia_estelar.payment_methods << [pix, credito, debito]

banquete_real = Company.create(supplier_id: isabel.id, brand_name: 'Banquete Real', corporate_name: 'Banquete Real Buffet S.A.',
                              registration_number: '12.345.678/0001-90',  phone_number: '(41) 8888-9999', email: 'real@banquetebuffet.com.br',
                              address: 'Rua Majestosa, 1010', neighborhood: 'Batel', city: 'Curitiba', state: 'PR', zipcode: '80420-000',
                              description: 'Transformamos seu evento em um verdadeiro banquete real, com serviços de buffet e decoração de alto padrão')
                              banquete_real.payment_methods << [credito, debito]

sabores_mundo = Company.create(supplier_id: livia.id, brand_name: 'Sabores do Mundo', corporate_name: 'Sabores do Mundo Buffet Internacional Eireli',
                              registration_number: '30.333.333/0001-33',  phone_number: '(51) 1010-2020', email: 'contato@saboresdomundo.com.br',
                              address: 'Rua da Paz, 1313', neighborhood: 'Moinhos de Vento', city: 'Porto Alegre', state: 'RS', zipcode: '90500-000',
                              description: 'Especializados em culinária internacional, nosso buffet traz sabores únicos de diferentes partes do mundo para seu evento.')
                              sabores_mundo.payment_methods << [credito, debito]

p "Created #{Company.count} companies"
p "All done! :)"