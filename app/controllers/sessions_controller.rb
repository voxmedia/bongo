class SessionsController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create, :failure]

  def new
  end

  def create
    omniauth = request.env["omniauth.auth"]
    authorization = OmniauthService.authorize(omniauth, current_user)
    if current_user
      flash[:notice] = "Successfully authenticated from #{provider_display_name(authorization)}."
    else
      self.current_user = authorization.user
      flash[:notice] = "Successfully logged in."
    end
    redirect_to request.env['omniauth.origin'] || root_path
  rescue OmniauthService::AuthorizationError => e
    redirect_to login_path, :alert => e.message
  end

  def failure
    redirect_to login_path, :alert => "There was a problem logging you in: #{params[:message]}."
  end

  def destroy
    self.current_user = nil
    redirect_to login_path, :notice => "You have been logged out."
  end

  private

  def provider_display_name(authorization)
    # convert google_oauth2 into something better looking...
    authorization.provider.split("_").first.to_s.titleize
  end
end