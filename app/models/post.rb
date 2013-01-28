class Post < ActiveRecord::Base
  attr_accessible :content, :name
  belongs_to :user
  has_many :comments#, dependent: :destroy

  validates :user_id, presence: true
  validates :name, presence: true, length: { minimum: 5 }
  validates :content, presence: true, length: { minimum: 20 }

  default_scope order: 'posts.created_at DESC'
end
