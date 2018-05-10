class Project < ApplicationRecord
  has_many :subs
  has_many :images

  def has_image?
    self.images.count > 0
  end

end
