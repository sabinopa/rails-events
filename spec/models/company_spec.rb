require 'rails_helper'

RSpec.describe Company, type: :model do
  describe '#valid?' do
    context 'incomplete datas' do
      it 'false when brand name is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: '', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when corporate name is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: '',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when regristration number is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when phone number is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when email is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: '',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when address is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: '', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when neighborhood is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: '', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when city is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: '', state: 'SP', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end
      it 'false when state is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: '', zipcode: '05050-050',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when zipcode is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '',
                                  description: 'O Estrelas Mágicas é especializado em trazer alegria e diversão para festas infantis.')

        result = company.valid?

        expect(result).to eq false
      end

      it 'false when description is empty' do
        supplier = Supplier.create!(name: 'Priscila', lastname: 'Sabino', email: 'priscila@email.com', password: '12345678')
        company = Company.create(supplier_id: supplier.id, brand_name: 'Estrelas Mágicas', corporate_name: 'Estrelas Mágicas Buffet Infantil Ltda',
                                  registration_number: '12.333.456/0001-78',  phone_number: '(11) 2233-4455', email: 'festas@estrelasmagicas.com.br',
                                  address: 'Alameda dos Sonhos, 404', neighborhood: 'Vila Feliz', city: 'São Paulo', state: 'SP', zipcode: '05050-050',
                                  description: '')

        result = company.valid?

        expect(result).to eq false
      end
    end
  end
end
