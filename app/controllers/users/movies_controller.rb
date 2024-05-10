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
  end

  def show
    @user = User.find(params[:user_id])
    moviedb_service = MoviedbService.new

    details_response = moviedb_service.get("/3/movie/#{params[:id]}")
    @movie = details_response

    cast_response = moviedb_service.get("/3/movie/#{params[:id]}/credits")
    @cast = cast_response[:cast].first(10)

    reviews_response = moviedb_service.get("/3/movie/#{params[:id]}/reviews")
    @reviews = reviews_response[:results]
  end
end
