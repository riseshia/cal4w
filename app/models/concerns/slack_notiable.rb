# SlackNotiable
module SlackNotiable
  def notify_to_slack(channel, text)
    return unless Rails.env.production?
    Slack::Web::Client.new.chat_postMessage(
      channel: channel,
      text: text,
      as_user: true,
      username: 'Cal4Weirdx'
    )
  end
end