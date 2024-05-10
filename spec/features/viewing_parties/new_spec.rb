require 'rails_helper'

RSpec.describe "new viewing party page" do
  describe 'US4' do
    it 'renders the name of the movie title rendered above a form with fields to fill out' do
      # When I visit the new viewing party page ('/users/:user_id/movies/:movie_id/viewing_party/new', where :user_id is a valid user's id and :movie_id is a valid Movie id from the API),
      # I should see the name of the movie title rendered above a form with the following fields:

      # - Duration of Party with a default value of movie runtime in minutes; a viewing party should NOT be created if set to a value less than the duration of the movie
      # - When: field to select date
      # - Start Time: field to select time
      # - Guests: three (optional) text fields for guest email addresses 
      # - Button to create a party
    end
  end
end