require 'spec_helper'

describe RunnersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/runners" }.should route_to(:controller => "runners", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/runners/new" }.should route_to(:controller => "runners", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/runners/1" }.should route_to(:controller => "runners", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/runners/1/edit" }.should route_to(:controller => "runners", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/runners" }.should route_to(:controller => "runners", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/runners/1" }.should route_to(:controller => "runners", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/runners/1" }.should route_to(:controller => "runners", :action => "destroy", :id => "1") 
    end
  end
end
