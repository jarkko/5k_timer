require 'spec_helper'

describe "/runners/show.html.erb" do
  include RunnersHelper
  before(:each) do
    assigns[:runner] = @runner = stub_model(Runner,
      :first_name => "value for first_name",
      :last_name => "value for last_name"
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ first_name/)
    response.should have_text(/value\ for\ last_name/)
  end
end
