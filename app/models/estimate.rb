class Estimate < ApplicationRecord
  belongs_to :sub
  has_one :image
end
