class Post < ActiveRecord::Base
  attr_accessible :content, :name
  belongs_to :user

  validates :user_id, presence: true
end
