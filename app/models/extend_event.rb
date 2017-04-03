# frozen_string_literal: true
# Event
class ExtendEvent < ApplicationRecord
  self.table_name = "events"
  belongs_to :user

  default_scope do
    joins(:user).select("id", "title", "place", "users.uid", "users.provider")
  end

  def attr
    uid + provider
  end
end
