class Shop < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  has_many_attached :photos
  validates :name, presence: true
  # include PgSearch::Model
  # pg_search_scope :search_by_name_and_details,
  #   against: [:name, :address, :details],
  #   using: {
  #     tsearch: { prefix: true }
  #   }
  def set_rating
    reviews = self.reviews
    total = 0
    reviews.each do |review|
      total += review.rating
    end
    average = total / reviews.count.to_f.round(1)
    unless average.nan?
      self.rating = average
    else
      self.rating = 1.0
    end
    self.rating = 1.0 if self.rating.nil?
  end
end
