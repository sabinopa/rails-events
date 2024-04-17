require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#description' do
    it 'show name, lastname and email' do
      supplier = Supplier.new(name: 'Julia', lastname: 'Almeida', email: 'julia@yahoo.com')

      result = supplier.description

      expect(result).to eq 'Julia Almeida - julia@yahoo.com'
    end
  end

  describe '#valid?' do
    it 'returns false when name is empty' do
      supplier = Supplier.new(name: '', lastname: 'Xavier', email: 'paulo@email.com', password: 'password')

      result = supplier.valid?

      expect(result).to eq false
    end

    it 'returns false when lastname is empty' do
      supplier = Supplier.new(name: 'Paulo', lastname: '', email: 'paulo@email.com', password: 'password')

      result = supplier.valid?

      expect(result).to eq false
    end

    it 'returns false when email is empty' do
      supplier = Supplier.new(name: 'Paulo', lastname: 'Xavier', email: '', password: 'password')

      result = supplier.valid?

      expect(result).to eq false
    end

    it 'returns false when password is empty' do
      supplier = Supplier.new(name: 'Paulo', lastname: 'Xavier', email: 'paulo@email.com', password: '')

      result = supplier.valid?

      expect(result).to eq false
    end
  end
end
