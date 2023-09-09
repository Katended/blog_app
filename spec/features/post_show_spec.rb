require 'rails_helper'

RSpec.describe 'Post Show', type: :feature do
  before :each do
    @user = User.create(name: 'Batman', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Superhero',
                        post_counter: 6)
    @post = Post.create(title: 'The Dark Night', text: 'This is my first post', comments_counter: 15,
                        likes_counter: 18, author: @user)
    @comment1 = Comment.create!(author: @user, post: @post, text: 'This is my first comment')
    @comment2 = Comment.create!(author: @user, post: @post, text: 'This is my second comment')
    @comment3 = Comment.create!(author: @user, post: @post, text: 'This is my third comment')
    @like = Like.create(author: @user, post: @post)

    visit user_post_path(@user, @post.id)
  end

  describe 'Post show page display' do
    it 'displays the post title' do
      expect(page).to have_content(@post.title)
    end

    it 'displays the post author' do
      expect(page).to have_content(@post.author.name)
    end

    it 'displays the post text' do
      expect(page).to have_content(@post.text)
    end

    it 'displays the comments counter' do
      expect(page).to have_content('Comments: 18')
    end

    it 'displays the likes counter' do
      expect(page).to have_content('Likes: 1')
    end

    it 'displays the user name of each commentor' do
      expect(page).to have_content(@post.author.name)
    end

    it 'displays the comment text' do
      expect(page).to have_content(@comment1.text)
      expect(page).to have_content(@comment2.text)
      expect(page).to have_content(@comment3.text)
    end

    it 'displays the add comment button' do
      expect(page).to have_content('Add a new comment')
    end

    it 'displays the like button' do
      expect(page).to have_content('Like')
    end

    it 'displays Go back to posts page button' do
      expect(page).to have_content('Go back to posts page')
    end
  end

  describe 'Post show page functionality' do
    it 'when user clicks on the add comment button, it redirects to the new comment page' do
      click_link 'Add a new comment'
      expect(page).to have_current_path(new_user_post_comment_path(@user, @post))
    end

    it 'when user clicks on the like button, it increases the likes counter' do
      click_link 'Like'
      expect(page).to have_content('Likes: 19')
    end

    it 'when user clicks on the Go back to posts page button, it redirects to the posts page' do
      click_link 'Go back to posts page'
      expect(page).to have_current_path(user_posts_path(@user))
    end
  end
end
