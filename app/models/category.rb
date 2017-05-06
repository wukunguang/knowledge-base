class Category < ApplicationRecord
  has_many :knowledge
  belongs_to :user
  validates :name, presence: true, uniqueness: true, on: [:create, :update]

end
