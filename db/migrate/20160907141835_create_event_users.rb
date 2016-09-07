class CreateEventUsers < ActiveRecord::Migration[5.0]
  def up
    create_table :event_users do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end
  end

  def down
    drop_table :event_users
  end
end
