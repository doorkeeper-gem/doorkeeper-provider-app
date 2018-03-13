require 'rails_helper'

RSpec.feature "Accessing the OAuth provider page" do

  scenario 'public user' do
    visit "/oauth/applications"
    expect(page).to have_content 'OAuth2'
  end

end

RSpec.feature "Create a new application" do

  scenario 'public user' do
    visit "/oauth/applications/new"
    expect(page).to have_content 'New application'
    fill_in "Name", with: 'Sean'
    fill_in "Redirect URI", with: 'urn:ietf:wg:oauth:2.0:oob'
    click_on 'Submit'
    expect(page).to have_content 'Application created.'
  end

end
