module Bot
  module ExternalServices
    class Giphy
      include HTTParty
      base_uri 'http://api.giphy.com'

      def self.search(query)
        query = query.tr(' ', '+')

        get("/v1/gifs/random?tag=#{query}&api_key=dc6zaTOxFJmzC")
      end
    end
  end
end
