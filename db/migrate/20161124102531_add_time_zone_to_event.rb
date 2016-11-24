class AddTimeZoneToEvent < ActiveRecord::Migration[5.0]
  def up
    add_column :events, :timezone, :string, default: "Seoul", null: false

    Event.find_each do |event|
      value = \
        case event.timezone_offset
        when -600 then "Melbourne"
        when -540 then "Seoul"
        when 420 then "Mountain Time (US & Canada)"
        when 480 then "Mountain Time (US & Canada)"
        end
      event.update_attribute(:timezone, value)
    end
  end

  def down
    remove_column :events, :timezone, :string
  end
end
