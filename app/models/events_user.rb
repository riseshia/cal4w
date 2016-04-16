# frozen_string_literal: true
# EventsUser
class EventsUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :event
end
