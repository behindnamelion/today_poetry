class Poem < ApplicationRecord
    belongs_to :user
    has_one_attached :picture
    has_many :likes
    has_many :liked_users, through: :likes, source: :user
end
