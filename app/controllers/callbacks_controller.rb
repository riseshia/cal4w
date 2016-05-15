# frozen_string_literal: true
# CallbacksController
class CallbacksController < Devise::OmniauthCallbacksController
  def weirdx
    @user = User.from_omniauth(request.env["omniauth.auth"])
    sign_in_and_redirect @user
  end

  def slack
    @user = User.from_omniauth(request.env["omniauth.auth"])
    if @user
      @user.remember_me = true
      sign_in_and_redirect @user
    else
      message = "그 팀으로는 로그인하실 수 없습니다. 이상한 모임으로 로그인해주세요!"
      redirect_to new_user_session_path, notice: message
    end
  end
end
