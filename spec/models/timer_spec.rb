require 'spec_helper'

describe Timer do
  before(:each) do
    @valid_attributes = {
      :start_time => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Timer.create!(@valid_attributes)
  end
end
