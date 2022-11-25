class Test < ApplicationRecord
  belongs_to :category
  has_many :user_tests
  has_many :games
end
