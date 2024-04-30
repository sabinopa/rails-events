require 'rails_helper'

RSpec.describe Client, type: :model do
  describe '#description' do
    it 'show name, lastname and email' do
      client = Client.new(name: 'Sabrina', lastname: 'Oliveira',document_number: '525.202.290-98',
                              email: 'sabrina@email.com', password: '12345678')

      result = client.description

      expect(result).to eq 'Sabrina Oliveira - sabrina@email.com'
    end
  end

  describe '#valid?' do
    it 'returns false when name is empty' do
      client = Client.new(name: '', lastname: 'Oliveira', document_number: '525.202.290-98',
                              email: 'sabrina@email.com', password: '12345678')

      result = client.valid?

      expect(result).to eq false
    end

    it 'returns false when lastname is empty' do
      client = Client.new(name: 'Sabrina', lastname: '', document_number: '525.202.290-98',
                              email: 'sabrina@email.com', password: '12345678')

      result = client.valid?

      expect(result).to eq false
    end

    it 'returns false when document number is empty' do
      client = Client.new(name: 'Sabrina', lastname: 'Oliveira', document_number: '',
                              email: 'sabrina@email.com', password: '12345678')

      result = client.valid?

      expect(result).to eq false
    end

    it 'returns false when email is empty' do
      client = Client.new(name: 'Sabrina', lastname: 'Oliveira',document_number: '525.202.290-98',
                              email: '', password: '12345678')

      result = client.valid?

      expect(result).to eq false
    end

    it 'returns false when password is empty' do
      client = Client.new(name: 'Sabrina', lastname: 'Oliveira',document_number: '525.202.290-98',
                              email: 'sabrina@email.com', password: '')

      result = client.valid?

      expect(result).to eq false
    end

    it 'returns false when document number is not valid' do
      client = Client.new(name: 'Sabrina', lastname: 'Oliveira',document_number: '525202998',
                              email: 'sabrina@email.com', password: '12345678')

      result = client.valid?

      expect(result).to eq false
    end
  end
end
