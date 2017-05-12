require 'net/http'

class Giphy

  def self.search(query)
    url = URI.parse("http://api.giphy.com/v1/gifs/search?q=#{query.tr(' ', '+')}&api_key=dc6zaTOxFJmzC")
    request = Net::HTTP::Get.new(url.to_s)
    response = Net::HTTP.start(url.host, url.port) do |http|
      http.request(request)
    end

    response.body
  end
end
