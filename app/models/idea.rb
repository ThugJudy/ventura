class Idea < ApplicationRecord
  belongs_to :user
  validates :title, presence:  {message: "cant be empty"}
  validates :decription, presence:  {message: "cant be empty"}
  validates :domain, presence:  {message: "cant be empty"}
  validates :stake, presence: {message: "Stake cant be empty"}
  validates :stake,  numericality: { only_integer: true , message: " should be a real number"}
  validates :stake, numericality: { greater_than: 0, message: " should lie between 0 and 100"}
  validates :stake, numericality: { less_than: 100, message: " should lie between 0 and 100"}
  has_one_attached :thumbnail
end
