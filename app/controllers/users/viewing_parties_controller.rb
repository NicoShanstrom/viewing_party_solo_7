class Users::ViewingPartiesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @viewing_parties = @user.viewing_parties
  end

  def new
    @user = User.find(params[:user_id])
    @movie_id = params[:movie_id]
    moviedb_service = MoviedbService.new
    response = moviedb_service.get("/3/movie/#{@movie_id}")
    @movie = response
    @viewing_party = ViewingParty.new
  end

  def create
    @user = User.find(params[:user_id])
    @viewing_party = ViewingParty.new(viewing_party_params)
    # @viewing_party.host = true
    if @viewing_party.save
      redirect_to user_movie_viewing_parties_path(@user, movie_id: params[:movie_id]), notice: 'Viewing party was successfully created.'
    else
      render :new
    end
  end

  private

  def viewing_party_params
    params.permit(:duration, :date, :start_time, :guest_email, :guest_email2, :guest_email3)
  end
end