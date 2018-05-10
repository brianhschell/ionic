class SubDetail < ApplicationRecord
  belongs_to :sub
  has_one :image

  def has_image?
    !image.nil?
  end
end
