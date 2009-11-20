class Runner < ActiveRecord::Base
  validates_uniqueness_of :bib_number
  
  def full_name
    "#{first_name} #{last_name}"
  end
end
