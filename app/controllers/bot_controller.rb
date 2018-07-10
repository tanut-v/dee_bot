class BotController < ApplicationController
  include LineBotConnectable
  include EventProcessable

  def index
    render_success
  end

  def callback
    reply_token, message = process_event(events)
    client.reply_message(reply_token, message)

    render_success
  end
end
