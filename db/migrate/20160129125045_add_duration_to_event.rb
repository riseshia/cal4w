class AddDurationToEvent < ActiveRecord::Migration
  def change
    add_column :events, :start_time, :datetime
    add_column :events, :finish_time, :datetime
  end
end
