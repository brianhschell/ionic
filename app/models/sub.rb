class Sub < ApplicationRecord
  belongs_to :project
  belongs_to :sub_type 
  has_many :sub_details
  has_many :estimates


  def find_photo
    sub_details.each do |s|
      if s.has_image?
        return s.image.file.url(:thumb)
      end
    end
    return 'no-image.png'
  end

  def total_estimate
    tot = 0
    estimates.each do |e|
      tot = tot + (e.amount || 0) 
    end
    return tot
  end
  
  def total_actual
    tot = 0
    sub_details.each do |e|
      if e.invoice > 0 
        tot = tot + (e.amount || 0) 
      end
    end
    return tot
  end

  def total_balance
    tot = 0
    sub_details.each do |e|
      if e.invoice > 0 
        tot = tot + (-1 * e.amount || 0) 
      else
        tot = tot + (e.amount || 0) 
      end
    end
    return tot
  end

end
