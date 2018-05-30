class Runner < ActiveRecord::Base
  validates_uniqueness_of :bib_number
  belongs_to :category
  has_many :results

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.import(runners)
    runners.each do |runner|
      Runner.create! runner
    end
  end

  def category_name
    category.name
  end

  def category_name=(name)
    self.category = Category.find_or_create_by_name(name)
  end
end
