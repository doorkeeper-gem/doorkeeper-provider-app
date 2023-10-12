# frozen_string_literal: true

owner = User.create!(
  email: 'user@example.com',
  password: 'doorkeeper',
  password_confirmation: 'doorkeeper'
)

app = Doorkeeper::Application.create!(
  name: "#{ENV["DEFAULT_SERVICE_NAME"]}",
  redirect_uri: "#{ENV["DEFAULT_SERVICE_URI"]}",
  owner: owner
)

puts 'Application: '
puts "name: #{app.name}"
puts "redirect_uri: #{app.redirect_uri}"
puts "uid: #{app.uid}"
puts "secret: #{app.secret}"
