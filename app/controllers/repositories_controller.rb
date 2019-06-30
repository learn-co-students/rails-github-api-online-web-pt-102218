class RepositoriesController < ApplicationController
  
  def index
    username = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @body = JSON.parse(username.body)

    repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @usernames_repos = JSON.parse(repos.body)
  end
end
