require 'spec_helper'

describe "/timers/new.html.erb" do
  include TimersHelper

  before(:each) do
    assigns[:timer] = stub_model(Timer,
      :new_record? => true,
      :start_time => 1
    )
  end

  it "renders new timer form" do
    render

    response.should have_tag("form[action=?][method=post]", timers_path) do
      with_tag("input#timer_start_time[name=?]", "timer[start_time]")
    end
  end
end
