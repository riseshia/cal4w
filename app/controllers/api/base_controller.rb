# frozen_string_literal: true

module Api
  # Api::BaseController
  class BaseController < ActionController::Base
    before_action :authenticate_user!
    protect_from_forgery with: :null_session
  end
end
