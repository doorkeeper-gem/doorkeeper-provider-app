class AddRevokedAtToOauthAccessGrants < ActiveRecord::Migration
  def change
    add_column :oauth_access_grants, :revoked_at, :datetime
  end
end
