require 'spec_helper'

describe TimersController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/timers" }.should route_to(:controller => "timers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/timers/new" }.should route_to(:controller => "timers", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/timers/1" }.should route_to(:controller => "timers", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/timers/1/edit" }.should route_to(:controller => "timers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/timers" }.should route_to(:controller => "timers", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/timers/1" }.should route_to(:controller => "timers", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/timers/1" }.should route_to(:controller => "timers", :action => "destroy", :id => "1") 
    end
  end
end
