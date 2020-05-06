class Poet < ApplicationRecord
    belongs_to :user
    has_one_attached :portrait
end
