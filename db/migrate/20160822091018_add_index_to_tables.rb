class AddIndexToTables < ActiveRecord::Migration[5.0]
  def change
    add_index :events_users, :user_id
    add_index :events_users, :event_id
  end
end
