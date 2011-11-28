25.times do
  Profile.create! :name => Faker::Name.name, :email => Faker::Internet.email, :username => Faker::Internet.user_name
end
