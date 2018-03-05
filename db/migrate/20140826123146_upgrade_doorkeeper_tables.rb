class UpgradeDoorkeeperTables < ActiveRecord::Migration[5.1]
  def up
    change_column :oauth_applications, :redirect_uri, :text, null: false
    change_column :oauth_access_grants, :redirect_uri, :text, null: false
    change_column :oauth_access_tokens, :application_id, :integer, null: false
  end

  def down
    change_column :oauth_applications, :redirect_uri, :string, null: false
    change_column :oauth_access_grants, :redirect_uri, :string, null: false
    change_column :oauth_access_tokens, :application_id, :integer
  end
end
