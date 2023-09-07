require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe '#update_comments_counter' do
    it 'updates the comments_counter attribute' do
      user = User.create(name: 'Sam')
      post = Post.create(title: 'Hello', author: user)
      Comment.create(author: user, post:)

      expect(post.reload.comments_counter).to eq(1)
    end
  end
end
