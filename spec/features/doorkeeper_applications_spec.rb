require 'rails_helper'

RSpec.feature "Accessing the OAuth provider page" do

  scenario 'public user' do
    visit "/oauth/applications"
    expect(page).to have_content 'OAuth2'
  end

end
