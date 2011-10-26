require "spec_helper"

describe CheckoutsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/checkouts" }.should route_to(:controller => "checkouts", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/checkouts/new" }.should route_to(:controller => "checkouts", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/checkouts/1" }.should route_to(:controller => "checkouts", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/checkouts/1/edit" }.should route_to(:controller => "checkouts", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/checkouts" }.should route_to(:controller => "checkouts", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/checkouts/1" }.should route_to(:controller => "checkouts", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/checkouts/1" }.should route_to(:controller => "checkouts", :action => "destroy", :id => "1")
    end

  end
end
