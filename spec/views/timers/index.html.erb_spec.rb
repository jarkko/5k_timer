require 'spec_helper'

describe "/timers/index.html.erb" do
  include TimersHelper

  before(:each) do
    assigns[:timers] = [
      stub_model(Timer,
        :start_time => 1
      ),
      stub_model(Timer,
        :start_time => 1
      )
    ]
  end

  it "renders a list of timers" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
