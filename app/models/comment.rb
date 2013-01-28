class Comment < ActiveRecord::Base
  attr_accessible :content, :post_id
  belongs_to :post
  belongs_to :user

  validates :content, presence: true, length: { minimum: 10 }

  default_scope order: 'comments.created_at'
end
