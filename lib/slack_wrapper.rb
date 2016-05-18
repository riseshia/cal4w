# frozen_string_literal: true
module SlackWrapper
  module_function

  def notify(channel, message)
    return if Rails.env.test?
    return if Rails.env.development? && !channel.start_with?("@")
    Slack::Web::Client.new.chat_postMessage(
      channel: channel,
      text: message,
      as_user: true,
      username: "Cal4Weirdx"
    )
  end

  def user_name(uid)
    Slack::Web::Client.new.users_info(user: uid.upcase).user.name
  end
end
