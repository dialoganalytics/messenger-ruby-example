require 'dotenv'
Dotenv.load

# Example interface to facilitate sending messages to the Dialog API.
require_relative './dialog'
require 'facebook/messenger' # https://github.com/hyperoslo/facebook-messenger

Facebook::Messenger.configure do |config|
  config.access_token = ENV['FACEBOOK_ACCESS_TOKEN']
  config.verify_token = ENV['FACEBOOK_SECRET_TOKEN']
end

include Facebook::Messenger

Bot.on :message do |message|
  Dialog.track(message)

  text = 'Hello, human!'
  message_id = Bot.deliver(recipient: message.sender, message: { text: text })

  params = {
    to: message.sender,
    sent_at: Time.now,
    distinct_id: message_id,
    properties: {
      text: text
    }
  }
  Dialog.track(params)
end
