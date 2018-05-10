class Image < ApplicationRecord
  validates :file, :presence => true, :on => :update

  mount_uploader :file, ImageUploader

  has_one :sub_detail
  has_one :estimate
  has_one :project

end
