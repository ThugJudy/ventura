class Idea < ApplicationRecord
  belongs_to :user
  validates :title, presence:  {message: "cant be empty"}
  validates :decription, presence:  {message: "cant be empty"}
  validates :domain, presence:  {message: "cant be empty"}
  validates :stake, presence: {message: "Stake cant be empty"}
  validates :stake,  numericality: {  message: " should be a real number"}
  validates :stake, numericality: { greater_than: 0, message: " should lie between 0 and 100"}
  validates :stake, numericality: { less_than: 100, message: " should lie between 0 and 100"}
  has_one_attached :thumbnail, :dependent => :destroy
  validate :correct_image_type
  
  after_commit :add_default_cover, on: [:create, :update]

  private
  
  def add_default_cover
    unless thumbnail.attached?
      self.thumbnail.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.png")), filename: 'default.png' , content_type: "image/png")
    end
  end

  def correct_image_type
    if thumbnail.attached? && !thumbnail.content_type.in?(%w(image/jpeg image/png))
      errors.add(:thumbnail, "must be jpg or png")
    end
  end
end
