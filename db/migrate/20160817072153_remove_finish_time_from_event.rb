class RemoveFinishTimeFromEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :planned_time, :integer, default: 1, null: false

    Event.find_each do |event|
      event.planned_time = (event.finish_time - event.start_time) / 3600
      event.save
    end

    remove_column :events, :finish_time, :datetime
  end
end
