require 'spec_helper'

describe "/runners/edit.html.erb" do
  include RunnersHelper

  before(:each) do
    assigns[:runner] = @runner = stub_model(Runner,
      :new_record? => false,
      :first_name => "value for first_name",
      :last_name => "value for last_name"
    )
  end

  it "renders the edit runner form" do
    render

    response.should have_tag("form[action=#{runner_path(@runner)}][method=post]") do
      with_tag('input#runner_first_name[name=?]', "runner[first_name]")
      with_tag('input#runner_last_name[name=?]', "runner[last_name]")
    end
  end
end
