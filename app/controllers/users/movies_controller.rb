class Users::MoviesController < ApplicationController
  
  def index
    @user = User.find(params[:user_id])
    moviedb_service = MoviedbService.new
    if params[:search_keyword].present?
        response = moviedb_service.get("/3/search/movie", { query: params[:search_keyword], limit: 20 })
    else
        response = moviedb_service.get("/3/movie/top_rated?limit=20")
    end
    @movies = response[:results]
    # require 'pry'; binding.pry
  end

  def show
    # require 'pry'; binding.pry
    @user = User.find(params[:user_id])
    moviedb_service = MoviedbService.new
    response = moviedb_service.get("/3/movie/#{params[:movie_id]}")
    # response = moviedb_service.get("/3/movie", {query: params[:movie_id]})
    @movie = response[:results]
  end
end
