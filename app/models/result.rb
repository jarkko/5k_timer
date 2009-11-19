class Result < ActiveRecord::Base
  belongs_to :runner
  belongs_to :timer
  
  def name
    runner ? runner.full_name : nil
  end
end
