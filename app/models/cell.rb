class Cell < ApplicationRecord
  belongs_to :notebook

  validates :content, presence: true
  validates :cell_type, inclusion: { in: [0, 1, 2], message: "%{value} is invalid." }
end
