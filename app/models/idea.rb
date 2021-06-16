class Idea < ApplicationRecord
  belongs_to :user
  validates :title, presence: true
  validates :decription, presence: true
  validates :domain, presence: true
  validates :stake, presence: true
  validates :stake, numericality: {in: 0..100}
  has_one_attached :thumbnail

end
