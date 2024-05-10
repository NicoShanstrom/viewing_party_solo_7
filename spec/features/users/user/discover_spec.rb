require 'rails_helper'

RSpec.describe 'User Discover Page', type: :feature do
  describe "When the User visits '/users/:id/discover'" do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
  
      visit discover_user_path(@user1)
    end
    
    it 'US1 - renders a button to discover top rated movies' do
      # save_and_open_page
      expect(page).to have_button('Discover top rated movies')
    end

    it 'US1 - renders a text field to enter keyword(s) to search by movie title' do
      expect(page).to have_field("Enter keyword(s) to search by movie title")
    end

    it 'US1 - renders a button to search by movie title' do
      expect(page).to have_button('Search by movie title')
      # save_and_open_page
    end

    it 'US2 - takes the user to the movies results page when clicking discover top rated movies', :vcr do
      # When I visit the discover movies page ('/users/:id/discover')
      # and click on the Discover Top Rated Movies button
      click_button("Discover top rated movies")
      # I should be taken to the movies results page (`users/:user_id/movies`) where I see: 
      expect(current_path).to eq(user_movies_path(@user1))
      # - Title (As a Link to the Movie Details page (see story #3))
      expect(page).to have_link("The Shawshank Redemption", href: user_movie_path(@user1, 278))
      # - Vote Average of the movie
      within('#vote_average_278') do
        expect(page).to have_content('Vote Average: 8.7')
      end
      # I should also see a button to return to the Discover Page.
      expect(page).to have_button("Back to Discover Page")
      # Notes:
      # There should only be a maximum of 20 results. The above details should be listed for each movie.
      expect(page).to have_css('.vote_average', maximum: 20)
    end

    it 'US2 - takes the user to the movies results page after filling out and submitting movie title search', :vcr do
      # When I visit the discover movies page ('/users/:id/discover')
      # fill out the movie title search and click the Search button
      # require 'pry'; binding.pry
      fill_in 'search_keyword', with: "Shaw"
      click_button("Search by movie title")
      # I should be taken to the movies results page (`users/:user_id/movies`) where I see:
      expect(current_path).to eq(user_movies_path(@user1))
      # - Title (As a Link to the Movie Details page (see story #3))
      expect(page).to have_link("Fast & Furious Presents: Hobbs & Shaw", href: user_movie_path(@user1, 384018))
      # - Vote Average of the movie
      within('#vote_average_384018') do
        expect(page).to have_content('Vote Average: 6.861')
      end
      # I should also see a button to return to the Discover Page.
      expect(page).to have_button("Back to Discover Page")
      #     Notes:
      # There should only be a maximum of 20 results. The above details should be listed for each movie.
      expect(page).to have_css('.vote_average', maximum: 20)
    end
  end
end
    