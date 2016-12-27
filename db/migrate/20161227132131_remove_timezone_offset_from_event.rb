class RemoveTimezoneOffsetFromEvent < ActiveRecord::Migration[5.0]
  def change
    remove_column :events, :timezone_offset, :integer, default: -540, null: false
  end
end
