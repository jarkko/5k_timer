require 'spec_helper'

describe "/results/new.html.erb" do
  include ResultsHelper

  before(:each) do
    assigns[:result] = stub_model(Result,
      :new_record? => true,
      :bib_number => 1,
      :first_name => "value for first_name",
      :last_name => "value for last_name",
      :result => 1
    )
  end

  it "renders new result form" do
    render

    response.should have_tag("form[action=?][method=post]", results_path) do
      with_tag("input#result_bib_number[name=?]", "result[bib_number]")
      with_tag("input#result_first_name[name=?]", "result[first_name]")
      with_tag("input#result_last_name[name=?]", "result[last_name]")
      with_tag("input#result_result[name=?]", "result[result]")
    end
  end
end
