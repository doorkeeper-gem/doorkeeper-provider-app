# frozen_string_literal: true

owner = User.find_or_create_by!(email: 'user@example.com') do |user|
  user.password = 'doorkeeper'
  user.password_confirmation = 'doorkeeper'
end

# The demo database is reset daily, so the credentials of the demo clients
# are fixed here to keep their configuration valid across resets.
applications = [
  {
    # DOORKEEPER_APP_ID / DOORKEEPER_APP_SECRET in doorkeeper-devise-client
    name: 'Doorkeeper Devise Client',
    uid: 'qwSORu1xM9bJZwBlqG78n1iXmgKqMY-0j27pygxn4uQ',
    secret: '4ZLOQx7DlfhGO8yCG9QSoiLDf3q7P3xcV1-hsd8LHO8',
    redirect_uri: 'https://doorkeeper-devise-client-isb8p.eu-east-1.migetapp.com/users/auth/doorkeeper/callback',
    confidential: true
  },
  {
    # CONFIDENTIAL_CLIENT_ID / CONFIDENTIAL_CLIENT_SECRET in doorkeeper-sinatra-client
    name: 'Doorkeeper Sinatra Client (confidential)',
    uid: 'LaWQQP8imaHbhCkhsylVXoV7Lq0NAR3GmPTWWpiViHE',
    secret: 'NSD6Jc49tk-5_FzXgdqmUoJgJ9du_n70Qpn00nXyUhM',
    redirect_uri: 'https://doorkeeper-sinatra-client-knzb2.eu-east-1.migetapp.com/callback',
    confidential: true
  },
  {
    # PUBLIC_CLIENT_ID in doorkeeper-sinatra-client
    name: 'Doorkeeper Sinatra Client (public)',
    uid: 'fG8SBwX1FhtYGuxlOn97Chs5VD01uoTwBLErOQPv2YE',
    redirect_uri: 'https://doorkeeper-sinatra-client-knzb2.eu-east-1.migetapp.com/callback',
    confidential: false
  }
]

applications.each do |attributes|
  app = Doorkeeper::Application.find_or_create_by!(uid: attributes[:uid]) do |application|
    application.assign_attributes(attributes.except(:uid).merge(owner: owner))
  end

  puts 'Application: '
  puts "name: #{app.name}"
  puts "redirect_uri: #{app.redirect_uri}"
  puts "uid: #{app.uid}"
  puts "secret: #{app.secret}"
  puts "confidential: #{app.confidential}"
end
