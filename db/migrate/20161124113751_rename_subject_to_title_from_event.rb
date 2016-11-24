class RenameSubjectToTitleFromEvent < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :subject, :title
  end
end
