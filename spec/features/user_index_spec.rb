require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before :each do
    @user = User.create(
      name: 'Batman',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Superhero',
      post_counter: 10
    )
    @user2 = User.create(
      name: 'Superman',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Superhero',
      post_counter: 5
    )
    @user3 = User.create(
      name: 'Spiderman',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Superhero',
      post_counter: 15
    )
  end

  before(:each) { visit users_path }

  describe 'User index page display' do
    it 'displays a container for the users' do
      expect(page).to have_css('section.all_users_container')
      expect(page).to have_content(@user.name)
      expect(page).to have_content(@user2.name)
      expect(page).to have_content(@user3.name)
    end

    it 'displays the username of each user' do
      User.all.each do |user|
        expect(page).to have_content(user.name)
      end
    end

    it 'displays the photos of each user' do
      User.all.each do |user|
        expect(page.has_xpath?("//img[@src = '#{user.photo}' ]"))
      end
    end

    it 'shows the number of posts of each user' do
      User.all.each do |user|
        expect(page).to have_content("Number of posts: #{user.post_counter}")
      end
    end
  end

  describe 'User index page links' do
    it "when user clicks on user's name is redirected to that user's show page" do
      click_link(@user.name)
      expect(page).to have_current_path(user_path(@user.id))
    end
  end
end
