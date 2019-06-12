class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: [:create]

  def create
    response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
      req.body = { 'client_id': '99749e9404eb59033620', 'client_secret': '2c7eb860cbd3e76f88fa8d3fd09a00ba0d2741ba', 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    session[:token] = body['access_token']
    
    user_response = Faraday.get "https://api.github.com/user" do |req| 
      req.body = { 'client_id': '99749e9404eb59033620', 'client_secret': '2c7eb860cbd3e76f88fa8d3fd09a00ba0d2741ba', 'code': params[:code] }
      req.headers['Accept'] = 'application/json'
      req.headers['Authorization'] = "token #{session[:token]}"
    end 
    
    @user_response = JSON.parse(user_response.body)
   session[:username] = @user_response["login"]
  
    redirect_to root_path 
  end
end
