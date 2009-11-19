require 'spec_helper'

describe Result do
  before(:each) do
    @valid_attributes = {
      :bib_number => 1,
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :result => 1
    }
  end

  it "should create a new instance given valid attributes" do
    Result.create!(@valid_attributes)
  end
end
