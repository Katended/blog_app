require 'rails_helper'

RSpec.describe 'User Show Page', type: :feature do
  before :each do
    @user = User.create(
      name: 'Batman',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Superhero',
      post_counter: 6
    )
  end

  before :each do
    @post1 = Post.create(
      title: 'The Dark Night',
      text: 'This is not my first post',
      comments_counter: 15,
      likes_counter: 18,
      author: @user
    )
    @post2 = Post.create(
      title: 'The bright morning',
      text: 'This is my second post',
      comments_counter: 11,
      likes_counter: 8,
      author: @user
    )
    @post3 = Post.create(
      title: 'The grey evening',
      text: 'This is my third post',
      comments_counter: 5,
      likes_counter: 3,
      author: @user
    )
    @post4 = Post.create(
      title: 'The black castle',
      text: 'This is my fourth post',
      comments_counter: 1,
      likes_counter: 1,
      author: @user
    )
    @posts = [@post1, @post2, @post3, @post4]
  end

  before(:each) { visit user_path(id: @user.id) }

  describe 'User show page' do
    it 'displays a container for the users' do
      expect(page).to have_css('section.single_users_container')
    end

    it "displays the user's profile picture" do
      expect(page.has_xpath?("//img[@src = '#{@user.photo}' ]"))
    end

    it "displays the user's username" do
      expect(page).to have_content(@user.name)
      expect(page).to have_link(@user.name, href: user_path(id: @user.id))
    end

    it 'shows the number of posts the user has written' do
      expect(page).to have_content('Number of posts: 10')
    end

    it "shows the user's bio" do
      expect(page).to have_content('Bio')
      expect(page).to have_content(@user.bio)
    end

    it 'shows the first 3 posts of the user' do
      expect(@user.recent_posts).to eq(@posts[1..3].reverse)
      @user.recent_posts.each do |post|
        expect(page).to have_content(post.text)
      end
    end

    it 'does not show more than 3 posts' do
      expect(page).not_to have_content(@post1.text)
    end

    it 'has a button to view all user posts' do
      expect(page).to have_link('See all Posts', href: user_posts_path(user_id: @user.id))
    end

    it 'has a button to return to the users index page' do
      expect(page).to have_link('Go back to users', href: users_path)
    end
  end

  describe 'User show page links' do
    it 'redirects to the post show page on clicking a user post' do
      click_link(@post2.text)
      expect(page).to have_current_path(user_post_path(@user, @post2))
    end

    it 'when user clicks on the add post button, it redirects to the new post page' do
      click_link('Create Post')
      expect(page).to have_current_path(new_user_post_path(@user))
    end

    it 'redirects to open all posts of a user' do
      click_link('See all Posts')
      expect(page).to have_current_path(user_posts_path(@user))
    end

    it 'redirects to the users index page' do
      click_link('Go back to users')
      expect(page).to have_current_path(users_path)
    end
  end
end
