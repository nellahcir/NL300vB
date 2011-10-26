require "spec_helper"

describe CheckinsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/checkins" }.should route_to(:controller => "checkins", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/checkins/new" }.should route_to(:controller => "checkins", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/checkins/1" }.should route_to(:controller => "checkins", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/checkins/1/edit" }.should route_to(:controller => "checkins", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/checkins" }.should route_to(:controller => "checkins", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/checkins/1" }.should route_to(:controller => "checkins", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/checkins/1" }.should route_to(:controller => "checkins", :action => "destroy", :id => "1")
    end

  end
end
