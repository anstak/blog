class Post < ActiveRecord::Base
  attr_accessible :content, :name
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :relationships, foreign_key: "post_id", dependent: :destroy
  has_many :tags, through: :relationships, source: :tag

  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 20 }

  default_scope order: 'posts.created_at DESC'
end
