class Typekit
  def initialize(token)
    @token = token
    @conn = Faraday.new(:url => "https://typekit.com") do |builder|
      builder.adapter :net_http
    end
    nil
  end

  def get_kit_info(id)
    path = "/api/v1/json/kits/#{id}"
    begin
      response = @conn.get(path) do |req|
        req.headers['X-Typekit-Token'] = @token
        req.options.timeout = 5
      end
      JSON.parse(response.body)
    rescue Faraday::Error::ClientError
      nil
    end
  end
end