class User < ApplicationRecord
  has_many :comments, class_name: 'Comment', foreign_key: 'author_id'
  has_many :posts, class_name: 'Post', foreign_key: 'author_id'
  has_many :likes, class_name: 'Like', foreign_key: 'author_id'

  validates :name, presence: true, length: { in: 3..25 }
  validates :post_counter, numericality: { only_interger: true, greater_than_or_equal_to: 0 }


  def recent_posts(limit = 3)
    posts.order(created_at: :desc).limit(limit)
  end

  def update_posts_counter
    update(post_counter: posts.count)
  end
end