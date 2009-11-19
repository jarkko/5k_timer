require 'spec_helper'

describe "/results/index.html.erb" do
  include ResultsHelper

  before(:each) do
    assigns[:results] = [
      stub_model(Result,
        :bib_number => 1,
        :first_name => "value for first_name",
        :last_name => "value for last_name",
        :result => 1
      ),
      stub_model(Result,
        :bib_number => 1,
        :first_name => "value for first_name",
        :last_name => "value for last_name",
        :result => 1
      )
    ]
  end

  it "renders a list of results" do
    render
    response.should have_tag("tr>td", 1.to_s, 2)
    response.should have_tag("tr>td", "value for first_name".to_s, 2)
    response.should have_tag("tr>td", "value for last_name".to_s, 2)
    response.should have_tag("tr>td", 1.to_s, 2)
  end
end
