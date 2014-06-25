google = {'client_key' => ENV['GOOGLE_CLIENT_KEY'],
          'client_secret' =>  ENV['GOOGLE_CLIENT_SECRET']}

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, google["client_key"], google["client_secret"], {
    :scope => "userinfo.email,userinfo.profile",
    :image_aspect_ratio => "square",
    :image_size => 50
  }
end

OmniauthService.configure do |config|
  # provider :providername, :callback_path => "/auth/providername/mobile/callback"
  config.user_attributes = Proc.new { |omniauth|
    {
      :name  => omniauth["info"]["name"]
    }
  }
end