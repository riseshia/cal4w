require 'application_responder'

# ApplicationController
class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  self.responder = ApplicationResponder
  respond_to :html

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from User::NoPermission, with: :no_permission

  private

  def no_permission
    redirect_to root_path, notice: 'You don\'t have permission with this action.'
  end
end
