class Chef < ApplicationRecord
	before_save {self.email = email.downcase }
	validates :chefname, presence: true, length: {maximum: 30}
	VALID_EMAIL_REGEX =  /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, presence: true, length: {maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, 
                    uniqueness: { case_sensitive: false}

  has_many :recipes, dependent: :destroy
  #validates :chef_id, presence: true
  has_secure_password
  validates :password, presence: true, length: {minimum: 5}, allow_nil: true
  has_many :comments, dependent: :destroy
  has_many :messages, dependent: :destroy
end	