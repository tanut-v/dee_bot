module Bot
  module ExternalServices
    class Giphy
      include HTTParty
      base_uri 'http://api.giphy.com'

      def self.search(query)
        query = query.tr(' ', '+')
        api_key = ENV['GIPHY_API_KEY']

        get("/v1/gifs/random?tag=#{query}&api_key=#{api_key}")
      end
    end
  end
end
