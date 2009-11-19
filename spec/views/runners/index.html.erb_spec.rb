require 'spec_helper'

describe "/runners/index.html.erb" do
  include RunnersHelper

  before(:each) do
    assigns[:runners] = [
      stub_model(Runner,
        :first_name => "value for first_name",
        :last_name => "value for last_name"
      ),
      stub_model(Runner,
        :first_name => "value for first_name",
        :last_name => "value for last_name"
      )
    ]
  end

  it "renders a list of runners" do
    render
    response.should have_tag("tr>td", "value for first_name".to_s, 2)
    response.should have_tag("tr>td", "value for last_name".to_s, 2)
  end
end
