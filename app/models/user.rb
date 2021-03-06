class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :poems
         has_many :likes
         has_many :liked_poems, through: :likes, source: :poem
         has_many :poets
end
