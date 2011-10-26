require 'spec_helper'

describe CheckinsController do

  def mock_checkin(stubs={})
    (@mock_checkin ||= mock_model(Checkin).as_null_object).tap do |checkin|
      checkin.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all checkins as @checkins" do
      Checkin.stub(:all) { [mock_checkin] }
      get :index
      assigns(:checkins).should eq([mock_checkin])
    end
  end

  describe "GET show" do
    it "assigns the requested checkin as @checkin" do
      Checkin.stub(:find).with("37") { mock_checkin }
      get :show, :id => "37"
      assigns(:checkin).should be(mock_checkin)
    end
  end

  describe "GET new" do
    it "assigns a new checkin as @checkin" do
      Checkin.stub(:new) { mock_checkin }
      get :new
      assigns(:checkin).should be(mock_checkin)
    end
  end

  describe "GET edit" do
    it "assigns the requested checkin as @checkin" do
      Checkin.stub(:find).with("37") { mock_checkin }
      get :edit, :id => "37"
      assigns(:checkin).should be(mock_checkin)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created checkin as @checkin" do
        Checkin.stub(:new).with({'these' => 'params'}) { mock_checkin(:save => true) }
        post :create, :checkin => {'these' => 'params'}
        assigns(:checkin).should be(mock_checkin)
      end

      it "redirects to the created checkin" do
        Checkin.stub(:new) { mock_checkin(:save => true) }
        post :create, :checkin => {}
        response.should redirect_to(checkin_url(mock_checkin))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved checkin as @checkin" do
        Checkin.stub(:new).with({'these' => 'params'}) { mock_checkin(:save => false) }
        post :create, :checkin => {'these' => 'params'}
        assigns(:checkin).should be(mock_checkin)
      end

      it "re-renders the 'new' template" do
        Checkin.stub(:new) { mock_checkin(:save => false) }
        post :create, :checkin => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested checkin" do
        Checkin.should_receive(:find).with("37") { mock_checkin }
        mock_checkin.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :checkin => {'these' => 'params'}
      end

      it "assigns the requested checkin as @checkin" do
        Checkin.stub(:find) { mock_checkin(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:checkin).should be(mock_checkin)
      end

      it "redirects to the checkin" do
        Checkin.stub(:find) { mock_checkin(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(checkin_url(mock_checkin))
      end
    end

    describe "with invalid params" do
      it "assigns the checkin as @checkin" do
        Checkin.stub(:find) { mock_checkin(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:checkin).should be(mock_checkin)
      end

      it "re-renders the 'edit' template" do
        Checkin.stub(:find) { mock_checkin(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested checkin" do
      Checkin.should_receive(:find).with("37") { mock_checkin }
      mock_checkin.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the checkins list" do
      Checkin.stub(:find) { mock_checkin }
      delete :destroy, :id => "1"
      response.should redirect_to(checkins_url)
    end
  end

end
