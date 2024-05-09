class Users::ViewingPartiesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @viewing_parties = ViewingParty.all
  end

  def new
    # require 'pry'; binding.pry
    @user = User.find(params[:user_id])
    @viewing_party = ViewingParty.new
  end
end