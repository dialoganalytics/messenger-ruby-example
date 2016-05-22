require 'dotenv'
Dotenv.load

require 'http' # https://github.com/httprb/http

module Dialog
  # @param message [Facebook::Messenger::Incoming::Message, Hash]
  def track(message)
    payload = if message.is_a?(Hash)
      # Outbound
      {
        message: {
          platform: 'messenger',
          type: 'text',
          to: message[:to],
          sent_at: message[:sent_at],
          distinct_id: message[:id],
          properties: {
            text: message[:properties][:text]
          }
        }
      }

    # Inbound
    # @note Only track text messages for the moment
    elsif message.text
      {
        message: {
          platform: 'messenger',
          type: 'text',
          to: message.sender['id'],
          sent_at: message.sent_at,
          distinct_id: message.id,
          properties: {
            text: message.text
          }
        }
      }
    end

    HTTP.post("https://api.dialoganalytics.com/v1/messages?token=#{ENV['DIALOG_TOKEN']}", json: payload)
  end
  module_function :track
end
