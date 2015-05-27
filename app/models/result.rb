class Result < ActiveRecord::Base
  belongs_to :runner
  belongs_to :timer
  
  named_scope :newer_than, lambda {|id|
    {:conditions => ['id > ?', id]}
  }
  
  def name
    runner ? runner.full_name : nil
  end
  
  def formatted_time
    return "00:00:00.00" unless result
  
    hrs = result / (1000 * 60 * 60)
    left = result % (1000 * 60 * 60)
    
    mins = left / (1000 * 60)
    left = left % (1000 * 60)
    
    secs = left / 1000
    left = left % 1000
    
    parts = (left % 1000) / 10
    
    res = [hrs, mins, secs].map{|num| pad(num)}.join(":")
    res += ".#{pad(parts)}"
  end
  
  def bib_number
    runner ? runner.bib_number : read_attribute(:bib_number)
  end
  
  def bib_number=(num)
    runner = Runner.find_by_bib_number(num)
    self.runner = runner if runner
    write_attribute(:bib_number, num)
    save
  end
    
  private
  
    def pad(num)
      num.to_i < 10 ? "0#{num}" : "#{num}"
    end
end
