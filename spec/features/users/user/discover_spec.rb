require 'rails_helper'

RSpec.describe 'User Discover Page', type: :feature do
  describe "US1 - When the User visits '/users/:id/discover'" do
    before(:each) do
      @user1 = User.create!(name: 'Tommy', email: 'tommy@email.com')
      @user2 = User.create!(name: 'Sam', email: 'sam@email.com')
  
      visit "/users/#{@user1.id}/discover"
    end
    it 'renders a button to discover top rated movies' do
      # save_and_open_page
      expect(page).to have_button('Discover top rated movies')
    end

    it 'renders a text field to enter keyword(s) to search by movie title' do
      expect(page).to have_field("Enter keyword(s) to search by movie title")
    end

    it 'renders a button to search by movie title' do
      expect(page).to have_button('Search by movie title')
      save_and_open_page
    end
  end
end
    