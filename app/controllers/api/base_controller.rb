# frozen_string_literal: true
require "application_responder"

module Api
  # Api::BaseController
  class BaseController < ApplicationController
    protect_from_forgery with: :null_session
  end
end
