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

# Helpers to handle tracking with Dialog
class DialogMessenger

  def initialize(client)
    @client = client
  end

  # @param message [Facebook::Messenger::Incoming]
  def incoming(message)
    payload = {
      message: {
        distinct_id: message.id,
        sent_at: message.sent_at.to_f,
        properties: {
          text: message.text
        },
      },
      creator: {
        distinct_id: message.sender['id'],
        type: 'interlocutor'
      }
    }.deep_merge(dialog_attributes(message))

    @client.track(payload)
  end

  # @param message [Facebook::Messenger::Incoming]
  def outgoing(message)
    payload = {
      message: {
        distinct_id: message.ids,
        sent_at: message.at.to_f,
        properties: {
          text: message.text
        },
      },
      creator: {
        distinct_id: message.sender['id'],
        type: 'bot'
      }
    }.deep_merge(dialog_attributes(message))

    @client.track(payload)
  end

  private

  # @param message []
  def dialog_attributes(message)
    {
      message: {
        platform: 'messenger',
        provider: 'messenger',
        mtype: 'text'
      },
      conversation: {
        distinct_id: params.sender['id'] # Assumes 1 to 1 conversations
      }
    }
  end
end

# Create a Dialog API client
client = Dialog.new({
  api_token: ENV.fetch('DIALOG_API_TOKEN'),
  bot_id: ENV.fetch('DIALOG_BOT_ID'),
  on_error: Proc.new do |status, message, detail|
    p [status, message, detail]
  end
})

# Create a Dialog tracking helper
dialog = DialogMessenger.new(client)

Bot.on :message do |message|
  dialog.incoming(message)

  message.reply(text: 'Hello, human!')
end

Bot.on :delivery do |message|
  dialog.outgoing(message)
end
