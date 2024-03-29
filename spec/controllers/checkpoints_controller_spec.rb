require 'spec_helper'

describe CheckpointsController do

  def mock_checkpoint(stubs={})
    (@mock_checkpoint ||= mock_model(Checkpoint).as_null_object).tap do |checkpoint|
      checkpoint.stub(stubs) unless stubs.empty?
    end
  end

  describe "GET index" do
    it "assigns all checkpoints as @checkpoints" do
      Checkpoint.stub(:all) { [mock_checkpoint] }
      get :index
      assigns(:checkpoints).should eq([mock_checkpoint])
    end
  end

  describe "GET show" do
    it "assigns the requested checkpoint as @checkpoint" do
      Checkpoint.stub(:find).with("37") { mock_checkpoint }
      get :show, :id => "37"
      assigns(:checkpoint).should be(mock_checkpoint)
    end
  end

  describe "GET new" do
    it "assigns a new checkpoint as @checkpoint" do
      Checkpoint.stub(:new) { mock_checkpoint }
      get :new
      assigns(:checkpoint).should be(mock_checkpoint)
    end
  end

  describe "GET edit" do
    it "assigns the requested checkpoint as @checkpoint" do
      Checkpoint.stub(:find).with("37") { mock_checkpoint }
      get :edit, :id => "37"
      assigns(:checkpoint).should be(mock_checkpoint)
    end
  end

  describe "POST create" do

    describe "with valid params" do
      it "assigns a newly created checkpoint as @checkpoint" do
        Checkpoint.stub(:new).with({'these' => 'params'}) { mock_checkpoint(:save => true) }
        post :create, :checkpoint => {'these' => 'params'}
        assigns(:checkpoint).should be(mock_checkpoint)
      end

      it "redirects to the created checkpoint" do
        Checkpoint.stub(:new) { mock_checkpoint(:save => true) }
        post :create, :checkpoint => {}
        response.should redirect_to(checkpoint_url(mock_checkpoint))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved checkpoint as @checkpoint" do
        Checkpoint.stub(:new).with({'these' => 'params'}) { mock_checkpoint(:save => false) }
        post :create, :checkpoint => {'these' => 'params'}
        assigns(:checkpoint).should be(mock_checkpoint)
      end

      it "re-renders the 'new' template" do
        Checkpoint.stub(:new) { mock_checkpoint(:save => false) }
        post :create, :checkpoint => {}
        response.should render_template("new")
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested checkpoint" do
        Checkpoint.should_receive(:find).with("37") { mock_checkpoint }
        mock_checkpoint.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :checkpoint => {'these' => 'params'}
      end

      it "assigns the requested checkpoint as @checkpoint" do
        Checkpoint.stub(:find) { mock_checkpoint(:update_attributes => true) }
        put :update, :id => "1"
        assigns(:checkpoint).should be(mock_checkpoint)
      end

      it "redirects to the checkpoint" do
        Checkpoint.stub(:find) { mock_checkpoint(:update_attributes => true) }
        put :update, :id => "1"
        response.should redirect_to(checkpoint_url(mock_checkpoint))
      end
    end

    describe "with invalid params" do
      it "assigns the checkpoint as @checkpoint" do
        Checkpoint.stub(:find) { mock_checkpoint(:update_attributes => false) }
        put :update, :id => "1"
        assigns(:checkpoint).should be(mock_checkpoint)
      end

      it "re-renders the 'edit' template" do
        Checkpoint.stub(:find) { mock_checkpoint(:update_attributes => false) }
        put :update, :id => "1"
        response.should render_template("edit")
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested checkpoint" do
      Checkpoint.should_receive(:find).with("37") { mock_checkpoint }
      mock_checkpoint.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the checkpoints list" do
      Checkpoint.stub(:find) { mock_checkpoint }
      delete :destroy, :id => "1"
      response.should redirect_to(checkpoints_url)
    end
  end

end
