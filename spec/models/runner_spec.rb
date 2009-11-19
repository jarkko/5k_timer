require 'spec_helper'

describe Runner do
  before(:each) do
    @valid_attributes = {
      :first_name => "Chad",
      :last_name => "Fowler"
    }
  end

  it "should create a new instance given valid attributes" do
    Runner.create!(@valid_attributes)
  end
  
  describe "full_name" do
    before(:each) do
      @runner = Runner.new(@valid_attributes)
    end
    
    it "should return first + last name" do
      @runner.full_name.should == "Chad Fowler"
    end
  end
end
