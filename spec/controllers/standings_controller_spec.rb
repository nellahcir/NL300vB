require 'spec_helper'

describe StandingsController do

  def mock_standing(stubs={})
    (@mock_standing ||= mock_model(Standing).as_null_object).tap do |standing|
      standing.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all standings as @standings" do
      Standing.stub(:all) { [mock_standing] }
      get :index
      assigns(:standings).should eq([mock_standing])
    end
  end

  describe "GET show" do
    it "assigns the requested standing as @standing" do
      Standing.stub(:find).with("37") { mock_standing }
      get :show, :id => "37"
      assigns(:standing).should be(mock_standing)
    end
  end

  describe "GET new" do
    it "assigns a new standing as @standing" do
      Standing.stub(:new) { mock_standing }
      get :new
      assigns(:standing).should be(mock_standing)
    end
  end

  describe "GET edit" do
    it "assigns the requested standing as @standing" do
      Standing.stub(:find).with("37") { mock_standing }
      get :edit, :id => "37"
      assigns(:standing).should be(mock_standing)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created standing as @standing" do
        Standing.stub(:new).with({'these' => 'params'}) { mock_standing(:save => true) }
        post :create, :standing => {'these' => 'params'}
        assigns(:standing).should be(mock_standing)
      end

      it "redirects to the created standing" do
        Standing.stub(:new) { mock_standing(:save => true) }
        post :create, :standing => {}
        response.should redirect_to(standing_url(mock_standing))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved standing as @standing" do
        Standing.stub(:new).with({'these' => 'params'}) { mock_standing(:save => false) }
        post :create, :standing => {'these' => 'params'}
        assigns(:standing).should be(mock_standing)
      end

      it "re-renders the 'new' template" do
        Standing.stub(:new) { mock_standing(:save => false) }
        post :create, :standing => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested standing" do
        Standing.should_receive(:find).with("37") { mock_standing }
        mock_standing.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :standing => {'these' => 'params'}
      end

      it "assigns the requested standing as @standing" do
        Standing.stub(:find) { mock_standing(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:standing).should be(mock_standing)
      end

      it "redirects to the standing" do
        Standing.stub(:find) { mock_standing(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(standing_url(mock_standing))
      end
    end

    describe "with invalid params" do
      it "assigns the standing as @standing" do
        Standing.stub(:find) { mock_standing(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:standing).should be(mock_standing)
      end

      it "re-renders the 'edit' template" do
        Standing.stub(:find) { mock_standing(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested standing" do
      Standing.should_receive(:find).with("37") { mock_standing }
      mock_standing.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the standings list" do
      Standing.stub(:find) { mock_standing }
      delete :destroy, :id => "1"
      response.should redirect_to(standings_url)
    end
  end

end
