require 'rails_helper'

RSpec.describe Post, type: :model do
  describe '#title'
  context 'when title is nil' do
    it 'returns false without a title' do
      author = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends')
      post = Post.new(title: 'Example title', text: 'Example body', author:)

      post.title = nil
      expect(post).to_not be_valid
    end
  end

  context 'when title is valid' do
    it 'return false when title is too long' do
      author = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends')
      post = Post.new(title: 'Example title', text: 'Example body', author:)

      post.title = 'a' * 251
      expect(post).to_not be_valid
    end

    it 'returns true' do
      author = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends')
      post = Post.new(title: 'Example title', text: 'Example body', author:)

      expect(post).to be_valid
    end
  end
end

describe '#comments_counter' do
  it 'is valid with an integer comments_counter' do
    author = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends')
    post = Post.new(title: 'Example title', text: 'Example body', comments_counter: 5, author:)

    expect(post).to be_valid
  end

  it 'is invalid with a non-integer comments_counter' do
    author = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends')
    post = Post.new(title: 'Example title', text: 'Example body', comments_counter: 'not_an_integer', author:)

    expect(post).to_not be_valid
    expect(post.errors[:comments_counter]).to include('is not a number')
  end
end

describe '#likes_counter' do
  it 'is valid with an integer likes_counter' do
    author = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends')
    post = Post.new(title: 'Example title', text: 'Example body', likes_counter: 5, author:)

    expect(post).to be_valid
  end

  it 'is invalid with a non-integer likes_counter' do
    author = User.create(name: 'Tom & Jerry', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'Best friends')
    post = Post.new(title: 'Example title', text: 'Example body', likes_counter: 'not_an_integer', author:)

    expect(post).to_not be_valid
    expect(post.errors[:likes_counter]).to include('is not a number')
  end
end

describe '#update_post_counter' do
  it 'increments the user post_counter attribute by 1' do
    author = User.create!(name: 'John Doe', post_counter: 1)
    post = Post.new(title: 'Title', comments_counter: 0, likes_counter: 0, author:) # Set the author attribute

    expect { post.save! }.to change { author.reload.post_counter }.by(1)
  end
end
