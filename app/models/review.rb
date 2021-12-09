class Review < ApplicationRecord
  belongs_to :user
  belongs_to :shop
  validates :rating, presence: true, inclusion: { in: (1..5).to_a }
  # validates :user_id, uniqueness: { scope: :review_id }
end
