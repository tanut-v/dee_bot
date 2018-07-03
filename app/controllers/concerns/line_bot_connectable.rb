module LineBotConnectable
  extend ActiveSupport::Concern

  included do
    before_action :validate_signature, only: :callback
  end

  private

  def client
    @client ||= Line::Bot::Client.new do |config|
      config.channel_secret = ENV['LINE_CHANNEL_SECRET']
      config.channel_token  = ENV['LINE_CHANNEL_TOKEN']
    end
  end

  def body
    @body ||= request.body.read
  end

  def message_events
    client.parse_events_from(body)
  end

  def validate_signature
    signature = request.env['HTTP_X_LINE_SIGNATURE']

    render json: {
      result: 'error'
    }, status: :bad_request unless client.validate_signature(body, signature)
  end
end
