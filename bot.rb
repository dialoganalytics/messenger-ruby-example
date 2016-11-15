require 'active_support/core_ext/hash'

require 'dialog-api'
require 'facebook/messenger'


# Load environment variables from .env
require 'dotenv'
Dotenv.load

Facebook::Messenger.configure do |config|
  config.access_token = ENV.fetch('FACEBOOK_ACCESS_TOKEN')
  config.verify_token = ENV.fetch('FACEBOOK_SECRET_TOKEN')
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
