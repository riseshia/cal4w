module SlackWrapper
  module_function

  def notify(channel, message)
    return unless Rails.env.production?
    Slack::Web::Client.new.chat_postMessage(
      channel: channel,
      text: message,
      as_user: true,
      username: 'Cal4Weirdx'
    )
  end
end