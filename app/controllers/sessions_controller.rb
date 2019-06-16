require 'pry'
class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': ENV['GITHUB_CLIENT_ID'], 'client_secret': ENV['GITHUB_CLIENT_SECRET'], 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
    end
    #body = JSON.parse(response.body)
    #binding.pry
    session[:token] = JSON.parse(response.body)['access_token']

    get_user = Faraday.get "https://api.github.com/user" do |req|
      req.headers = {'Authorization':"token #{session[:token]}"}
    end

    session[:user] = JSON.parse(get_user.body)['login']
    
    #binding.pry
    

    redirect_to '/'
  end
end
