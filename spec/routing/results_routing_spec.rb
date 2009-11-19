require 'spec_helper'

describe ResultsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/results" }.should route_to(:controller => "results", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/results/new" }.should route_to(:controller => "results", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/results/1" }.should route_to(:controller => "results", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/results/1/edit" }.should route_to(:controller => "results", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/results" }.should route_to(:controller => "results", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/results/1" }.should route_to(:controller => "results", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/results/1" }.should route_to(:controller => "results", :action => "destroy", :id => "1") 
    end
  end
end
