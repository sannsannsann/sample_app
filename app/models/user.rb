# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  
  before_save{ |user| user.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 } 
  VALID_EMAIL_REGEX = /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  validates :email, presence:   true, 
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
            
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
end
