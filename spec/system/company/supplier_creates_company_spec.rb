require 'rails_helper'

describe 'Supplier creates company' do
  it 'must be authenticated' do
    visit new_company_path

    expect(current_path).to eq new_supplier_session_path
  end
end