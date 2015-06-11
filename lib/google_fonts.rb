class GoogleFonts
  def initialize
    @url = 'https://www.googleapis.com'
    @key = ENV['GOOGLE_FONTS_API_KEY']
    @conn = Faraday.new(url: @url) do |builder|
      builder.adapter :net_http
    end
  end

  def all
    response = @conn.get('/webfonts/v1/webfonts') do |request|
      request.params[:key] = @key
    end
    JSON.parse(response.body)
  rescue Faraday::Error::ClientError
    nil
  end
end
