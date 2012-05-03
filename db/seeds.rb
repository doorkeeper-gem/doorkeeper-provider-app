25.times do
  Profile.create! :name => Faker::Name.name, :email => Faker::Internet.email, :username => Faker::Internet.user_name
end

User.create! :email => "user@example.com", :password => "doorkeeper", :password_confirmation => "doorkeeper"

app = Doorkeeper::Application.create! :name => "Doorkeeper Sinatra Client", :redirect_uri => "http://doorkeeper-sinatra.herokuapp.com/callback"

puts "Application: "
puts "name: #{app.name}"
puts "redirect_uri: #{app.redirect_uri}"
puts "uid: #{app.uid}"
puts "secret: #{app.secret}"
