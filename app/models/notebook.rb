class Notebook < ApplicationRecord
  has_many :cells, dependent: :destroy
end
