require 'spec_helper'

describe "/results/show.html.erb" do
  include ResultsHelper
  before(:each) do
    assigns[:result] = @result = stub_model(Result,
      :bib_number => 1,
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :result => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/1/)
    response.should have_text(/value\ for\ first_name/)
    response.should have_text(/value\ for\ last_name/)
    response.should have_text(/1/)
  end
end
