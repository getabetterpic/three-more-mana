class Deck < ApplicationRecord
  validates :name, presence: true
  validates :user, presence: true

  belongs_to :user
end
