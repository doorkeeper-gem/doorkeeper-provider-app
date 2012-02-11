class UpdateDoorkeeperTo03 < ActiveRecord::Migration
  def up
    add_index :oauth_applications, :uid, :unique => true
    add_index :oauth_access_grants, :token, :unique => true
    add_index :oauth_access_tokens, :token, :unique => true
    add_index :oauth_access_tokens, :resource_owner_id
    add_index :oauth_access_tokens, :refresh_token, :unique => true
  end

  def down
  end
end
