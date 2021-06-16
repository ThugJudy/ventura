class User < ApplicationRecord
has_person_name

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
                
  has_many :ideas, dependent: :destroy
  has_many :favourites
  has_many :conversations, foreign_key: :sender_id
end
