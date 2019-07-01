class RepositoriesController < ApplicationController
  
  def index
    # retrieve and display the current user's 'login'
    response = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    body = JSON.parse(response.body)
    @login = body["login"]

    # retrieve the current user's repositories
    rep_response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    body = JSON.parse(rep_response.body)
    @repos = body.map{ |r| r["name"] }
  end

end
