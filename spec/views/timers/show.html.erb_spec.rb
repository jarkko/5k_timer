require 'spec_helper'

describe "/timers/show.html.erb" do
  include TimersHelper
  before(:each) do
    assigns[:timer] = @timer = stub_model(Timer,
      :start_time => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
  end
end
