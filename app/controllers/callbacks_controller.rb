# frozen_string_literal: true
# CallbacksController
class CallbacksController < Devise::OmniauthCallbacksController
  def slack_signin
    auth = request.env["omniauth.auth"]
    raise User::DifferentGroup \
      if auth.info.team.id != Rails.application.secrets.slack_team_id

    uid = auth.info.user.id.downcase
    nickname = SlackWrapper.user_name(uid)
    user = User.from_omniauth("slack_signin", uid, nickname)

    sign_in_and_redirect_with(user)

  rescue User::DifferentGroup
    message = "그 팀으로는 로그인하실 수 없습니다. 이상한 모임으로 로그인해주세요!"
    redirect_to new_user_session_path, notice: message
  end

  def weirdx
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth("weirdx", auth.uid, auth.username)
    raise User::NotFound if user.nil?

    sign_in_and_redirect_with(user)
  end

  private

  def sign_in_and_redirect_with(user)
    user.remember_me = true
    sign_in_and_redirect user
  end
end
