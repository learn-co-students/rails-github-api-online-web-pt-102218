class RepositoriesController < ApplicationController
  
  def index
    @username = session[:username]
    users_repos = Faraday.get "https://api.github.com/user/repos" do |req| 
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(users_repos.body)
  end

end
