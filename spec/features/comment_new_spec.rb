require 'rails_helper'

RSpec.describe 'Comment New Page', type: :feature do
  before :each do
    @user = User.create(
      name: 'Batman',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Superhero',
      post_counter: 10
    )
    @post = Post.create(
      title: 'Hello',
      text: 'World',
      comments_counter: 0,
      likes_counter: 0,
      author: @user
    )
  end

  before(:each) { visit new_user_post_comment_path(@user, @post) }

  describe 'Comment new page display' do
    it 'displays a container for the new comment' do
      expect(page).to have_css('section.new_comment_container')
    end

    it 'displays a form for the new comment' do
      expect(page).to have_css('form')
    end

    it 'displays a text field' do
      expect(page).to have_css('input.comment_field')
    end

    it 'displays a submit button' do
      expect(page).to have_css('.submit-btn')
    end
  end

  describe 'Comment new page functionality' do
    it "when user clicks on 'Submit' button is redirected to the post's show page" do
      fill_in 'comment_text', with: 'Example text'
      click_button 'Add comment'
      expect(page).to have_current_path(user_post_path(@user, @post.id))
    end

    it 'when user clicks on the submit button, a new comment is created' do
      fill_in 'comment_text', with: 'Example text'
      click_button 'Add comment'
      expect(page).to have_content('Example text')
    end
  end
end
