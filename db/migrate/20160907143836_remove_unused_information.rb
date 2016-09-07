class RemoveUnusedInformation < ActiveRecord::Migration[5.0]
  def up
    drop_table :events_users
    remove_column :users, :token_valid_until
    remove_column :users, :token
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
