# frozen_string_literal: true
# Abstract Record
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end
