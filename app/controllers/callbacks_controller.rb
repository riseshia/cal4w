# frozen_string_literal: true
# CallbacksController
class CallbacksController < Devise::OmniauthCallbacksController
  def slack_signin
    @user = User.from_omniauth(request.env["omniauth.auth"])
    raise User::NotFound if @user.nil?

    @user.remember_me = true
    sign_in_and_redirect @user

  rescue User::DifferentGroup
    message = "그 팀으로는 로그인하실 수 없습니다. 이상한 모임으로 로그인해주세요!"
    redirect_to new_user_session_path, notice: message
  rescue User::NotFound
    message = "해당하는 사용자를 찾을 수 없습니다. 운영팀에게 문의해주세요."
    redirect_to new_user_session_path, notice: message
  end

  def weirdx
    @user = User.from_omniauth(request.env["omniauth.auth"])
    raise User::NotFound if @user.nil?

    @user.remember_me = true
    sign_in_and_redirect @user

  rescue User::NotFound
    message = "해당하는 사용자를 찾을 수 없습니다. 운영팀에게 문의해주세요."
    redirect_to new_user_session_path, notice: message
  end
end
