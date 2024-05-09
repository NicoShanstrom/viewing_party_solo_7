require 'rails_helper'

RSpec.describe 'Movie show(detail) page', type: :feature do
  describe "When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`)" do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
      # As a user, 
      # When I visit a movie's detail page (`/users/:user_id/movies/:movie_id`) where :id is a valid user id,
      visit user_movie_path(@user1, 384018)
    end

    describe "US3" do
        # I should see
       
        # - a button to return to the Discover Page

        # I should also see the following information about the movie:

        # - Movie Title
        # - Vote Average of the movie
        # - Runtime in hours & minutes
        # - Genre(s) associated to movie
        # - Summary description
        # - List the first 10 cast members (characters & actress/actors)
        # - Count of total reviews
        # - Each review's author and information
      it 'has a button to create a viewing party' do
        # - a button to Create a Viewing Party
        expect(page).to have_button("Create a Viewing Party", href: create_user_viewing_party_path(@user1))
      end

      it 'has a button to return to the discover page' do
        expect(page).to have_button("Back to Discover Page", href: discover_user_path(@user1))
      end

      it 'renders movie title, vote average, vote count, runtime in hours & minutes, genre(s), summary description' do
        within('#movie_attrs') do
          expect(page).to have_content('Movie title: Fast & Furious Presents: Hobbs & Shaw')
          expect(page).to have_content('Vote Average: 6.861')
          expect(page).to have_content('Vote Count: 6933')
          expect(page).to have_content('Movie runtime: 2 hours, 17 minutes')
          expect(page).to have_content('Movie genre(s): Action, Adventure, Comedy')
          expect(page).to have_content("Movie summary description: Ever since US Diplomatic Security Service Agent Hobbs and lawless outcast Shaw first faced off, they just have traded smack talk and body blows. But when cyber-genetically enhanced anarchist Brixton's ruthless actions threaten the future of humanity, they join forces to defeat him.")
        end
      end

      it 'lists the first 10 cast members (characters & actress/actors)' do
        within('#movie_cast') do
          expect(page).to have_content('Actor/Actress: Dwayne Johnson - as character: Luke Hobbs')
          expect(page).to have_content('Actor/Actress: Jason Statham - as character: Deckard Shaw')
          expect
        end
      end

      it "lists each review's author and information" do

      end

    end 
  end
end