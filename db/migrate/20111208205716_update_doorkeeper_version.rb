class UpdateDoorkeeperVersion < ActiveRecord::Migration
  def up
    add_column :oauth_access_grants, :scopes, :string

    # If you are upgrading from version 0.1.0, uncomment the line below
    # add_column :oauth_access_grants, :revoked_at, :datetime

    add_column    :oauth_access_tokens, :refresh_token, :string
    add_column    :oauth_access_tokens, :scopes,        :string
    add_column    :oauth_access_tokens, :expires_in,    :integer
    remove_column :oauth_access_tokens, :expires_at
  end

  def down
  end
end
