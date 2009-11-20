require 'spec_helper'

describe Result do
  before(:each) do
    @valid_attributes = {
      :result => 22722
    }
  end

  it "should create a new instance given valid attributes" do
    Result.create!(@valid_attributes)
  end

  describe "instance_methods" do
    before(:each) do
      @result = Result.new(@valid_attributes)
    end
    
    describe "formatted_time" do
      it "should return correct output" do
        @result.formatted_time.should == "00:00:22.72"
      end

      describe "when result 0" do
        before(:each) do
          @result.result = 0
        end

        it "should return correct output" do
          @result.formatted_time.should == "00:00:00.00"
        end
      end

      describe "when result nil" do
        before(:each) do
          @result.result = nil
        end

        it "should return correct output" do
          @result.formatted_time.should == "00:00:00.00"
        end
      end

      describe "when including minutes" do
        before(:each) do
          @result.result = 1721295
        end

        it "should return correct output" do
          @result.formatted_time.should == "00:28:41.29"
        end
      end
    end
    
    describe "bib_number" do
      describe "when there is no runner" do
        it "should return nil" do
          @result.bib_number.should be_nil
        end
      end
      
      describe "when runner exists" do
        before(:each) do
          @runner = Runner.new(:first_name => "Chad", :last_name => "Fowler", :bib_number => 69)
          @result.runner = @runner
        end
        
        it "should return runner's bib_number" do
          @result.bib_number.should == 69
        end
      end
    end
  
    describe "bib_number=" do
      describe "when corresponding runner exists" do
        before(:each) do
          @runner = stub_model(Runner, :bib_number => 69, :first_name => "Chad", :last_name => "Fowler")
          Runner.should_receive(:find_by_bib_number).
                 with(69).and_return(@runner)
          @result.bib_number = 69
        end
        
        it "should set the runner correctly" do
          @result.runner.should == @runner
        end
      end
      
      describe "when runner doesn't exist" do
        before(:each) do
          Runner.should_receive(:find_by_bib_number).
                 with(69).and_return(nil)
          @result.bib_number = 69
        end
        
        it "should set runner to nil" do
          @result.runner.should be_nil
        end
      end
    end
  end
end
