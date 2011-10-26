require "spec_helper"

describe StandingsController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/standings" }.should route_to(:controller => "standings", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/standings/new" }.should route_to(:controller => "standings", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/standings/1" }.should route_to(:controller => "standings", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/standings/1/edit" }.should route_to(:controller => "standings", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/standings" }.should route_to(:controller => "standings", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/standings/1" }.should route_to(:controller => "standings", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/standings/1" }.should route_to(:controller => "standings", :action => "destroy", :id => "1")
    end

  end
end
