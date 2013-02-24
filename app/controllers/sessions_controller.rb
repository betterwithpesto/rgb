class SessionsController < ApplicationController
  def new

  end

  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"]) || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url(subdomain: current_user.urlname), :notice => "Signed in!"
  end

  def destroy
    reset_session
    redirect_to root_url, :notice => "Signed out!"
  end

=begin
  def create
  	auth = request.env["omniauth.auth"]
    user = User.where(:provider => auth['provider'], :uid => auth['uid']).first || User.create_with_omniauth(auth)
    session[:user_id] = user.id
    redirect_to root_url, :notice => "Signed in!"
  end
def create
  auth_hash = request.env['omniauth.auth']
  @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
  if @authorization
    render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
  else
    user = User.new :name => auth_hash["user_info"]["name"]
    user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
    user.save
    render :text => "Hi #{user.name}! You've signed up."
  end
end

  def destroy
    reset_session
    redirect_to root_url, :notice => 'Signed out!'
  end
=end 
  def failure
  end
 
end
