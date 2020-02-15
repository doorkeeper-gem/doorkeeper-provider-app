class IftttController < ApplicationController
  def user_info
    data = {
      name: Faker::Name.name,
      id:   Faker::IDNumber.valid,
      url:  Faker::Internet.url
    }
    render plain: { data: data }.to_json
  end
end
