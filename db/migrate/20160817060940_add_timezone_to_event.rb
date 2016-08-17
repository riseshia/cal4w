class AddTimezoneToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :timezone_offset, :integer, default: -540, null: false
  end
end
