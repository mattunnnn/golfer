class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :microposts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  validates :username, presence: true
  
  def already_favorited?(micropost)
    self.favorites.exists?(micropost_id: micropost.id)
  end
         
end
