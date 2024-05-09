class Users::MoviesController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    moviedb_service = MoviedbService.new
    if params[:search_keyword].present?
        response = moviedb_service.get("/3/search/movie", { query: params[:search_keyword], limit: 20 })
    else
        response = moviedb_service.get("/3/movie/top_rated?limit=20")
    end
    @movies = response[:results] if response.present?

    # puts "Movies: #{@movies.inspect}"
    # require 'pry'; binding.pry
  end
end
