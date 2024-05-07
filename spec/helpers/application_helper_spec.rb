require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_currency' do
    it 'formats the number into Brazilian currency format' do
      expect(helper.format_currency(1234.50)).to eq("R$ 1.234,50")
    end

    it 'formats negative numbers correctly' do
      expect(helper.format_currency(-1234.50)).to eq("-R$ 1.234,50")
    end

    it 'formats zero value correctly' do
      expect(helper.format_currency(0)).to eq("R$ 0,00")
    end
  end
end
