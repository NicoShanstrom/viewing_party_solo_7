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

    if @viewing_party.save
      @user_party = UserParty.create(viewing_party: @viewing_party, user: @user, host: true)

      invited_emails = [viewing_party_params[:guest_email], viewing_party_params[:guest_email2], viewing_party_params[:guest_email3]].reject(&:blank?)
      invited_users = User.where(email: invited_emails)

      invited_users.each do |invited_user|
        UserParty.create(viewing_party: @viewing_party, user: invited_user, host: false)
      end

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