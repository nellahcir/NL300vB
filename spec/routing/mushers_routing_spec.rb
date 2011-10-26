require "spec_helper"

describe MushersController do
  describe "routing" do

    it "recognizes and generates #index" do
      { :get => "/mushers" }.should route_to(:controller => "mushers", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/mushers/new" }.should route_to(:controller => "mushers", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/mushers/1" }.should route_to(:controller => "mushers", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/mushers/1/edit" }.should route_to(:controller => "mushers", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/mushers" }.should route_to(:controller => "mushers", :action => "create")
    end

    it "recognizes and generates #update" do
      { :put => "/mushers/1" }.should route_to(:controller => "mushers", :action => "update", :id => "1")
    end

    it "recognizes and generates #destroy" do
      { :delete => "/mushers/1" }.should route_to(:controller => "mushers", :action => "destroy", :id => "1")
    end

  end
end
