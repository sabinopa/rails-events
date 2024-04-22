require 'rails_helper'

describe 'Visitor views homepage' do
  it 'and see the application name' do
    visit root_path

    expect(page).to have_content 'Cadê Buffet?'
    expect(page).to have_link 'Cadê Buffet?', href: root_path
  end
end