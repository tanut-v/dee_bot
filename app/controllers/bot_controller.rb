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
          message = build_reply_message(gif_url)

          return [event['replyToken'], message]
        end
      end
    end
  end

  def search_gif(message)
    message = message.downcase
    return unless message.slice!('gif')

    Bot::ExternalServices::Giphy.new(message.strip).search
  end

  def build_reply_message(gif_url)
    {
      type: 'video',
      originalContentUrl: gif_url['mp4'],
      previewImageUrl: gif_url['url']
    }
  end
end
