require 'pry'
class RepositoriesController < ApplicationController
  
  def index
    response = Faraday.get "https://api.github.com/user/repos" do |req|
      #req.body = 
      req.headers = {'Authorization':"token #{session[:token]}",'Accept':'application/json'}
    end

    @repos = JSON.parse(response.body)

    
    #binding.pry
    

  end

end
