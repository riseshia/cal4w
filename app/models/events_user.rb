# frozen_string_literal: true
# EventsUser
class EventsUser < ApplicationRecord
  belongs_to :user
  belongs_to :event
end
