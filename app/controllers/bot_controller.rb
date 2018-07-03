class BotController < ApplicationController
  include LineBotConnectable

  def index
    render_success
  end

  def callback
    reply_token, message = process_event
    client.reply_message(reply_token, message)

    render_success
  end

  private

  def process_event
    message_events.each do |event|
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          gif_url = search_gif(event.message['text'])
          message = { type: 'text', text: gif_url }

          return [event['replyToken'], message]
        end
      end
    end
  end

  def search_gif(message)
    message = message.downcase
    return unless message.start_with?('giphy')

    message = message.tr('giphy', '').strip
    giphy = Bot::ExternalServices::Giphy.search(message)

    giphy['data']['image_url']
  end
end
