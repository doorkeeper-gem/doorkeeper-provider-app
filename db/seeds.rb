# frozen_string_literal: true
#
# PROVIDER doorkeeper-provider.herokuapp.com
# CLIENT   doorkeeper-sinatra.herokuapp.com

owner = User.create!(
  email: 'user@example.com',
  password: 'doorkeeper',
  password_confirmation: 'doorkeeper'
)

app = Doorkeeper::Application.create!(
  name: 'Doorkeeper Sinatra Client',
  redirect_uri: 'https://doorkeeper-sinatra.herokuapp.com/callback',
  owner: owner
)

puts 'Application: '
puts "name: #{app.name}"
puts "redirect_uri: #{app.redirect_uri}"
puts "uid: #{app.uid}"
puts "secret: #{app.secret}"

owner = User.create!(
  email: 'zapier@example.com',
  password: 'zapier',
  password_confirmation: 'zapier'
)

app = Doorkeeper::Application.create!(
  name: 'Zapier Sinatra Client',
  redirect_uri: 'https://zapier.com/dashboard/auth/oauth/return/App156338CLIAPI/',
  owner: owner
)

puts 'Application: '
puts "name: #{app.name}"
puts "redirect_uri: #{app.redirect_uri}"
puts "uid: #{app.uid}"