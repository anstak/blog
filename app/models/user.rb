# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  remember_token  :string(255)
#  autor           :boolean          default(FALSE)
#  admin           :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password
  before_save { |user| user.email = email.downcase } # это для уникальности email, вместе с добавлением индекса в миграцию ["email"], unique:true

  validates :name, presence: true, length: { minimum: 4, maximum: 25}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:true, format: { with: VALID_EMAIL_REGEX}, uniqueness: { case_sensitive:false }
  validates :password, length:{ minimum:6 }
  validates :password_confirmation, presence:true

end
