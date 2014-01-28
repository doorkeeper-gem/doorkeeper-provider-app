# migrate doorkeeper tables from 0.5.0.rc1 to master as of date
class DoorkeeperMaster < ActiveRecord::Migration
  def up
    change_column :oauth_access_grants, :redirect_uri, :text, :null => false
    change_column :oauth_access_tokens, :application_id, :integer, :null => true
    change_column :oauth_applications, :redirect_uri, :text, :null => false
    change_column :oauth_applications, :created_at, :datetime, :null => true
    change_column :oauth_applications, :updated_at, :datetime, :null => true
    change_table :oauth_applications do |t|
      t.integer :owner_id
      t.string :owner_type
      t.index ['owner_id', 'owner_type'], :name => 'index_oauth_applications_on_owner_id_and_owner_type'
    end
  end

  def down
    change_column :oauth_access_grants, :redirect_uri, :string, :null => false
    change_column :oauth_access_tokens, :application_id, :integer, :null => false
    change_column :oauth_applications, :redirect_uri, :string, :null => false
    change_column :oauth_applications, :created_at, :datetime, :null => true
    change_column :oauth_applications, :created_at, :datetime, :null => false
    change_column :oauth_applications, :updated_at, :datetime, :null => false
    change_table :oauth_applications do |t|
      t.remove :owner_id
      t.remove :owner_type
      t.remove_index :name => 'index_oauth_applications_on_owner_id_and_owner_type'
    end
  end
end
