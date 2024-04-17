require 'rails_helper'

RSpec.describe Supplier, type: :model do
  describe '#description' do
    it 'show name, lastname and email' do
      supplier = Supplier.new(name: 'Julia', lastname: 'Almeida', email: 'julia@yahoo.com')

      result = host.description

      expect(result).to eq 'Julia Almeida - julia@yahoo.com'
    end
  end
end
