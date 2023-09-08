require 'rails_helper'

RSpec.describe 'Post New Page', type: :feature do
  before :each do
    @user = User.create(
      name: 'Batman',
      photo: 'https://unsplash.com/photos/F_-0BxGuVvo',
      bio: 'Superhero',
      post_counter: 10
    )
  end

  before(:each) { visit new_user_post_path(@user) }

  describe 'Post new page display' do
    it 'displays a container for the new post' do
      expect(page).to have_css('section.new_post_container')
    end

    it 'displays a form for the new post' do
      expect(page).to have_css('form')
    end

    it 'displays a title field' do
      expect(page).to have_css('input.form_title')
    end

    it 'displays a text field' do
      expect(page).to have_css('textarea.form_text')
    end

    it 'displays a submit button' do
      expect(page).to have_css('.submit-btn')
    end
  end

  describe 'Post new page functionality' do
    describe 'valid post' do
      before(:each) do
        fill_in 'post_title', with: 'Example title'
        fill_in 'post_text', with: 'Example text'
      end

      it "when user clicks on 'Submit' button is redirected to the user's show page" do
        click_button 'Submit'
        expect(page).to have_current_path(user_posts_path(@user.id))
      end

      it 'when user clicks on the submit button, a new post is created' do
        fill_in 'post_title', with: 'Example title'
        fill_in 'post_text', with: 'Example text'
        click_button 'Submit'
        expect(page).to have_content('Example title')
        expect(page).to have_content('Example text')
        expect(page).to have_content('Number of posts: 11')
      end
    end

    describe 'invalid post' do
      before(:each) do
        fill_in 'post_title', with: ''
        fill_in 'post_text', with: ''
      end

      it "when user clicks on 'Submit' button is redirected to the post's new page" do
        click_button 'Submit'
        expect(page).to have_css('section.new_post_container')
      end

      it 'when user clicks on the submit button, a new post is not created' do
        click_button 'Submit'
        expect(@user.post_counter).not_to eq(11)
      end
    end
  end
end
