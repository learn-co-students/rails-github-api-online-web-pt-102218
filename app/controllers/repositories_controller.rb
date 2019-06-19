class RepositoriesController < ApplicationController
  
  def index
    repos = Faraday.get "https://api.github.com/user/repos" do |req| 
      req.headers["Authorization"] = "token #{session[:token]}"
    end 
    @repos = JSON.parse(repos.body)
    @username = session[:username]
  end

end
