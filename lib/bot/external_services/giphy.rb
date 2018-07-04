module Bot
  module ExternalServices
    class Giphy
      include HTTParty
      base_uri 'http://api.giphy.com'

      def initialize(query)
        @query   = query.tr(' ', '+')
        @api_key = ENV['GIPHY_API_KEY']
      end

      def search
        params = "q=#{@query}&api_key=#{@api_key}"
        result = self.class.get("/v1/gifs/search?#{params}")

        result['data'][0]['images']['original']
      end
    end
  end
end
