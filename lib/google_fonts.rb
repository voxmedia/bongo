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
      request.options.timeout = 0.01
    end
    JSON.parse(response.body)
  rescue
    JSON.parse(File.read('lib/assets/google_fonts.json'))
  end
end
