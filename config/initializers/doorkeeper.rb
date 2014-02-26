Doorkeeper.configure do
  # This block will be called to check whether the
  # resource owner is authenticated or not
  resource_owner_authenticator do |routes|
    # Put your resource owner authentication logic here.
    # If you want to use named routes from your app you need
    # to call them on routes object eg.
    # routes.new_user_session_path
    # current_user || warden.authenticate!(:scope => :user)
    request.env["warden"].user || User.where(:email => request.params[:username]).first
  end

  # If you want to restrict the access to the web interface for
  # adding oauth authorized applications you need to declare the
  # block below
  # admin_authenticator do |routes|
  #   # Put your admin authentication logic here.
  #   # If you want to use named routes from your app you need
  #   # to call them on routes object eg.
  #   # routes.new_admin_session_path
  #   Admin.find_by_id(session[:admin_id]) || redirect_to routes.new_admin_session_path
  # end

  # called for Resource Owner Password Credentials Grant
  resource_owner_from_credentials do
    request.params[:user] = {:email => request.params[:username], :password => request.params[:password]}
    request.env["devise.allow_params_authentication"] = true
    user = request.env["warden"].authenticate!(:scope => :user)
    env['warden'].logout
    user
  end

  # Access token expiration time (default 2 hours)
  # access_token_expires_in 2.hours
  access_token_expires_in 30.seconds

  # Issue access tokens with refresh token (disabled by default)
  use_refresh_token

  # Define access token scopes for your provider
  # For more information go to https://github.com/applicake/doorkeeper/wiki/Using-Scopes
  default_scopes  :public
  optional_scopes :write
end
