class Users::ViewingPartiesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @viewing_parties = ViewingParty.all
  end

  def new
    @user = User.find(params[:user_id])
    @movie_id = params[:movie_id]
    moviedb_service = MoviedbService.new
    response = moviedb_service.get("/3/movie/#{@movie_id}")
    @movie = response
    @viewing_party = ViewingParty.new
    # require 'pry'; binding.pry
  end
end