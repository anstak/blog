class Tag < ActiveRecord::Base
  attr_accessible :name
  has_many :relationships, foreign_key: "tag_id", dependent: :destroy
  has_many :posts, through: :relationships, source: :post

  validates :name, presence:true, uniqueness: { case_sensitive:false }
end
