class BotController < ApplicationController

  def index
    render json: {
      result: 'success'
    }
  end

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      status = :bad_request
    end

    events = client.parse_events_from(body)
    events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          type, message = process_text(event.message['text'])

          case type
          when 'giphy'
            message = {
              type: 'image',
              originalContentUrl: message
            }

            client.reply_message(event['replyToken'], message)
          end
        end
      end
    end

    render json: {
      result: 'callback response'
    }, status: status
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token  = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def process_text(message)
    if message.start_with?('giphy')
      message = message.tr('giphy', '').strip
      giphy = Giphy.search(message)

      ['giphy', JSON.parse(giphy)['data'].first['images']['original']['url']]
    end
  end
end
