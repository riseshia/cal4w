# CallbacksController
class CallbacksController < Devise::OmniauthCallbacksController
  def weirdx
    @user = User.from_omniauth(request.env['omniauth.auth'])
    sign_in_and_redirect @user
  end

  def slack
    @user = User.from_slack(params[:name], params[:token])
    if @user
      sign_in_and_redirect @user
    else
      redirect_to user_session_path
    end
  end
end
