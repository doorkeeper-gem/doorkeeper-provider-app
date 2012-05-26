class ChangeResourceOwnerIdToNull < ActiveRecord::Migration
  def up
    change_column :oauth_access_tokens, :resource_owner_id, :integer, :null => true
  end

  def down
    change_column :oauth_access_tokens, :resource_owner_id, :integer, :null => false
  end
end
