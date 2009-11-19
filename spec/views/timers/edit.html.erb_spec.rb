require 'spec_helper'

describe "/timers/edit.html.erb" do
  include TimersHelper

  before(:each) do
    assigns[:timer] = @timer = stub_model(Timer,
      :new_record? => false,
      :start_time => 1
    )
  end

  it "renders the edit timer form" do
    render

    response.should have_tag("form[action=#{timer_path(@timer)}][method=post]") do
      with_tag('input#timer_start_time[name=?]', "timer[start_time]")
    end
  end
end
