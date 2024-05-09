require 'rails_helper'

RSpec.describe 'Movie show(detail) page', type: :feature do
  describe "When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`)" do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
    end

    describe "US3" do
      it 'has a button to create a viewing party' do

      end

      it 'has a button to return to the discover page' do

      end

      it 'renders movie title, vote average, vote count, runtime in hours & minutes, genre(s), summary description' do

      end

      # it 'lists the first 10 cast members (characters & actress/actors)' do

      # end

      it "lists each review's author and information" do

      end

    end 
  end
end