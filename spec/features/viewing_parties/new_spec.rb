require 'rails_helper'

RSpec.describe "new viewing party page" do
  before(:each) do
    @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
    @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
  
    visit new_user_movie_viewing_party_path(@user2, 238)
  end
  describe 'US4' do
    it 'renders the name of the movie title rendered above a form with fields to fill out' do
      # When I visit the new viewing party page ('/users/:user_id/movies/:movie_id/viewing_party/new', where :user_id is a valid user's id and :movie_id is a valid Movie id from the API),
      # I should see the name of the movie title rendered above a form with the following fields:
      expect(page).to have_content("Create a viewing party for The Godfather")
      # - Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
      expect(page).to have_field("Viewing party[duration]")
      # - When: field to select date
      expect(page).to have_field('Viewing party[date]')
      # - Start Time: field to select time
      expect(page).to have_field('Viewing party[start_time]')
      # - Guests: three (optional) text fields for guest email addresses
      expect(page).to have_field('Viewing party[guest_email]')
      # - Button to create a party
      expect(page).to have_button('Create a party')
      end
    end
  end
end