# Users::SessionsController
class Users::SessionsController < Devise::SessionsController
  # before_filter :configure_sign_in_params, only: [:create]
  skip_before_action :authenticate_user!

  rescue_from Slack::Web::Api::Error, with: :fail_to_post_im

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    if params[:nickname].present?
      send_token params[:nickname]
      redirect_to user_session_path, notice: 'link is sent to verify you! please check WeirdSlack!'
    else
      redirect_to user_session_path
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def send_token(nickname)
    user = User.create_via_slack(nickname)
    Slack::Web::Client.new.chat_postMessage(
      channel: nickname,
      text: "Please click next link. This token only valid 10 minutes!\
      #{callbacks_slack_url(name: user.nickname, token: user.token)}",
      as_user: true,
      username: 'Cal4Weirdx'
    )
  end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.for(:sign_in) << :attribute
  # end

  def fail_to_post_im
    redirect_to user_session_path, notice: 'Nickname is not valid!'
  end
end
