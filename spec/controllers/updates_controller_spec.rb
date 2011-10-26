require 'spec_helper'

describe UpdatesController do

  def mock_update(stubs={})
    (@mock_update ||= mock_model(Update).as_null_object).tap do |update|
      update.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all updates as @updates" do
      Update.stub(:all) { [mock_update] }
      get :index
      assigns(:updates).should eq([mock_update])
    end
  end

  describe "GET show" do
    it "assigns the requested update as @update" do
      Update.stub(:find).with("37") { mock_update }
      get :show, :id => "37"
      assigns(:update).should be(mock_update)
    end
  end

  describe "GET new" do
    it "assigns a new update as @update" do
      Update.stub(:new) { mock_update }
      get :new
      assigns(:update).should be(mock_update)
    end
  end

  describe "GET edit" do
    it "assigns the requested update as @update" do
      Update.stub(:find).with("37") { mock_update }
      get :edit, :id => "37"
      assigns(:update).should be(mock_update)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created update as @update" do
        Update.stub(:new).with({'these' => 'params'}) { mock_update(:save => true) }
        post :create, :update => {'these' => 'params'}
        assigns(:update).should be(mock_update)
      end

      it "redirects to the created update" do
        Update.stub(:new) { mock_update(:save => true) }
        post :create, :update => {}
        response.should redirect_to(update_url(mock_update))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved update as @update" do
        Update.stub(:new).with({'these' => 'params'}) { mock_update(:save => false) }
        post :create, :update => {'these' => 'params'}
        assigns(:update).should be(mock_update)
      end

      it "re-renders the 'new' template" do
        Update.stub(:new) { mock_update(:save => false) }
        post :create, :update => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested update" do
        Update.should_receive(:find).with("37") { mock_update }
        mock_update.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :update => {'these' => 'params'}
      end

      it "assigns the requested update as @update" do
        Update.stub(:find) { mock_update(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:update).should be(mock_update)
      end

      it "redirects to the update" do
        Update.stub(:find) { mock_update(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(update_url(mock_update))
      end
    end

    describe "with invalid params" do
      it "assigns the update as @update" do
        Update.stub(:find) { mock_update(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:update).should be(mock_update)
      end

      it "re-renders the 'edit' template" do
        Update.stub(:find) { mock_update(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested update" do
      Update.should_receive(:find).with("37") { mock_update }
      mock_update.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the updates list" do
      Update.stub(:find) { mock_update }
      delete :destroy, :id => "1"
      response.should redirect_to(updates_url)
    end
  end

end
