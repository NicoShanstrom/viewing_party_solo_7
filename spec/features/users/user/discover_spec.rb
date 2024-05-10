require 'rails_helper'

RSpec.describe 'User Discover Page', type: :feature do
  describe "When the User visits '/users/:id/discover'" do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
  
      visit discover_user_path(@user1)
    end
    
    it 'US1 - renders a button to discover top rated movies' do
      expect(page).to have_button('Discover top rated movies')
    end

    it 'US1 - renders a text field to enter keyword(s) to search by movie title' do
      expect(page).to have_field("Enter keyword(s) to search by movie title")
    end

    it 'US1 - renders a button to search by movie title' do
      expect(page).to have_button('Search by movie title')
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

    it 'US2 - takes the user to the movies results page after filling out and submitting movie title search' do
      # When I visit the discover movies page ('/users/:id/discover')
      # fill out the movie title search and click the Search button
      VCR.use_cassette("movie_keyword_search", serialize_with: :json) do |cassette|

        fill_in :search_keyword, with: "Shaw"
        click_button("Search by movie title")

        expect(page).to have_current_path(user_movies_path(@user1),ignore_query: true)

        expect(page.status_code).to eq 200

        body = JSON.parse(
          cassette.serializable_hash.dig("http_interactions", 0, "response", "body", "string"),
          symbolize_names: true)

        movies = body[:results]

        expect(page).to have_link(movies[0][:title], href: user_movie_path(@user1, id: movies[0][:id]))
        expect(page).to have_link(movies[1][:title], href: user_movie_path(@user1, id: movies[1][:id]))
        expect(page).to have_link(movies[2][:title], href: user_movie_path(@user1, id: movies[2][:id]))

        expect(page).to have_content(movies[0][:vote_average])
        expect(page).to have_content(movies[1][:vote_average])
        expect(page).to have_content(movies[2][:vote_average])
        # There should only be a maximum of 20 results. The above details should be listed for each movie.
        expect(page).to have_css('.vote_average', maximum: 20)
        expect(page).to have_css('.vote_average', count: movies.length)
        # I should also see a button to return to the Discover Page.
        expect(page).to have_button("Back to Discover Page")
      end
    end
  end
end
    