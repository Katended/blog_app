require 'rails_helper'

RSpec.describe Like, type: :model do
  describe '#update_likes_counter' do
    it 'updates the likes_counter attribute' do
      user = User.create(name: 'David')
      post = Post.create(title: 'Hello', author: user)
      like = Like.create(author: user, post:)

      like.update_likes_counter

      expect(post.reload.likes_counter).to eq(1)
    end
  end
end
