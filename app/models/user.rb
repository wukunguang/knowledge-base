class User < ApplicationRecord

  attr_accessor :remember_token
  has_many :knowledges
  has_many :categories
  has_secure_password

  validates :username, presence: true, :length => { in: 4..30 }, on: [:create], uniqueness: true
  validates :password, presence:true, :length => { :minimum => 6 }, on: [:create, :update]

end
