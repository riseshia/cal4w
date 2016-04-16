# frozen_string_literal: true
# CallbacksController
class CallbacksController < Devise::OmniauthCallbacksController
  def weirdx
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end
end
