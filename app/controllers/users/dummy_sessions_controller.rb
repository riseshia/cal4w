# frozen_string_literal: true
module Users
  # DummySessionsController
  class DummySessionsController < Devise::SessionsController
    # GET /resource/sign_in
    def new
      render :dummy
    end

    def create
      @user = User
              .where(provider: "slack_signin", nickname: params[:nickname])
              .first_or_create do |user|
                user.uid = Devise.friendly_token[0, 9]
                user.password = Devise.friendly_token[0, 20]
              end

      @user.remember_me = true
      sign_in_and_redirect @user
    end

    # DELETE /resource/sign_out
    def destroy
      super
    end
  end
end
