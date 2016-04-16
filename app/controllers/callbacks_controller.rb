# frozen_string_literal: true
# CallbacksController
class CallbacksController < Devise::OmniauthCallbacksController
  def weirdx
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

  def slack
    @user = User.find_by(nickname: params[:name], token: params[:token])
    if @user
      @user.remember_me = true
      sign_in_and_redirect @user
    else
      redirect_to user_session_path
    end
  end
end
