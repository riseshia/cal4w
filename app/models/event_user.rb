# frozen_string_literal: true
# EventUser
class EventUser < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
